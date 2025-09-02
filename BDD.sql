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