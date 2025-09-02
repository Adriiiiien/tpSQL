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






-------> BONUS <--------

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