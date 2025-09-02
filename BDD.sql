/* Partie 2 */ 


/* Nombre de cours pas catégorie */
SELECT category, COUNT(*) AS nb_courses
FROM courses
GROUP BY category;

/* Pris moyen par catégorie */
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM courses
GROUP BY category;


/* Cours le plus cher et le moins cher */
SELECT title, price
FROM courses
ORDER BY price DESC
LIMIT 1;

SELECT title, price
FROM courses
ORDER BY price ASC
LIMIT 1;

/* Nombre d'inscriptions par cours */
SELECT 
    c.title, 
    COUNT(e.id) AS nb_enrollments
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
ORDER BY nb_enrollments DESC;

/* BONUS */
/* Cours sans aucune inscription */
SELECT c.title
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
WHERE e.id IS NULL;

/* Cours ayant un taux de complétion de 80% */
SELECT 
    c.title,
    COUNT(e.id) AS total_enrollments,
    SUM(CASE WHEN e.completed = TRUE THEN 1 ELSE 0 END) AS completed_count,
    ROUND(100.0 * SUM(CASE WHEN e.completed = TRUE THEN 1 ELSE 0 END) / COUNT(e.id), 2) AS completion_rate
FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
HAVING completion_rate > 80;


/* PARTIE 3 */
/* Revenu total généré */
SELECT 
    ROUND(SUM(c.price), 2) AS total_revenue
FROM enrollments e
JOIN courses c ON e.course_id = c.id;

/* Revenu total par cours */
SELECT 
    c.title,
    COUNT(e.id) AS nb_enrollments,
    ROUND(SUM(c.price), 2) AS total_revenue
FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
ORDER BY total_revenue DESC;

/* Revenu total par catégorie */
SELECT 
    c.category,
    ROUND(SUM(c.price), 2) AS total_revenue
FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.category
ORDER BY total_revenue DESC;

/* Revenu moyen par utilisateur inscrit */
SELECT 
    ROUND(SUM(c.price) / COUNT(DISTINCT e.user_id), 2) AS avg_revenue_per_user
FROM enrollments e
JOIN courses c ON e.course_id = c.id;

----------------------------------------------------------
-- NOTES ET AVIS :
-- 1 - Moyenne des notes par cours
SELECT crs.id AS course_id, crs.title AS course_title,
ROUND(AVG(rev.rating), 2) AS moyenne_notes FROM reviews AS rev 
JOIN courses AS crs ON rev.course_id = crs.id GROUP BY crs.id, crs.title 
ORDER BY moyenne_notes DESC;
-- 2 - Moyenne des notes par l'utilisateur
SELECT usr.id AS user_id, usr.name AS user_name, ROUND(AVG(rev.rating), 2) 
AS moyenne_notes FROM reviews AS rev JOIN users AS usr ON rev.user_id = usr.id
GROUP BY usr.id, usr.name ORDER BY moyenne_notes DESC;
-- 3 - Top 3 des cours les mieux notés
SELECT crs.title AS course_title, ROUND(AVG(rev.rating), 2) AS moyenne_notes,
COUNT(rev.id) AS nb_avis FROM reviews AS rev JOIN courses AS crs ON rev.course_id = crs.id
GROUP BY crs.id, crs.title ORDER BY moyenne_notes DESC, nb_avis DESC LIMIT 3;
-- 4 - Nombre d'avis par cours
SELECT crs.title AS course_title, COUNT(rev.id) AS nb_avis FROM courses AS crs LEFT JOIN reviews 
AS rev ON crs.id = rev.course_id GROUP BY crs.id, crs.title ORDER BY nb_avis DESC;
---> BONUS <---
-- 1 - Identifier les utilisateurs critiques (notes <= 2)
SELECT usr.name AS user_name, rev.rating, crs.title AS course_title FROM reviews AS rev 
JOIN users AS usr ON rev.user_id = usr.id JOIN courses AS crs ON rev.course_id = crs.id
WHERE rev.rating <= 2 ORDER BY rev.rating ASC;
-- 2 - Corrélation prix d'un cours VS sa note moyenne
SELECT crs.title AS course_title, crs.price, (SELECT ROUND(AVG(rev.rating), 2) FROM reviews AS rev 
WHERE rev.course_id = crs.id) AS moyenne_notes FROM courses AS crs ORDER BY crs.price DESC;
-- 3 - Corrélation note VS temps pour compléter le cours
SELECT usr.name AS user_name, crs.title AS course_title, rev.rating, 
TIMESTAMPDIFF(DAY, enr.enrolled_at, enr.completed_at) AS temps_complet_jours FROM reviews AS rev
JOIN enrollments AS enr ON rev.user_id = enr.user_id AND rev.course_id = enr.course_id JOIN users AS usr
ON usr.id = rev.user_id  JOIN courses AS crs ON crs.id = rev.course_id WHERE enr.completed = TRUE 
ORDER BY temps_complet_jours;
----------------------------------------------------------


----------------------------------------------------------
-- Bonus collectifs - Créer une vue SQL course_statistics

CREATE OR REPLACE VIEW course_statistics AS
SELECT c.title AS Titre, c.category AS Catégorie, 
COUNT(e.id) AS Nombre_d_inscriptions,
ROUND(AVG(r.rating), 2) AS Moyenne_des_notes,
ROUND(100.0 * SUM(CASE WHEN e.completed = TRUE THEN 1 ELSE 0 END) / COUNT(e.id), 2) AS Taux_de_completion,
SUM(c.price) AS Revenu_total FROM courses c LEFT JOIN enrollments e ON c.id = e.course_id
LEFT JOIN reviews r ON c.id = r.course_id GROUP BY c.id, c.title, c.category;

-- Pour voir la vue -> SELECT * FROM course_statistics;
----------------------------------------------------------