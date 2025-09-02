

-- 1
SELECT SUM(c.price) AS "revenues total" FROM courses c
JOIN enrollments e ON c.id = e.course_id
WHERE e.completed = TRUE;

-- 2
SELECT c.title, SUM(c.price) AS "revenu total par cours" FROM courses c
JOIN enrollments e ON c.id = e.course_id
WHERE e.completed = TRUE
GROUP BY c.id, c.title
ORDER BY SUM(c.price) DESC;

-- 3
SELECT c.category, SUM(c.price) AS "revenu total par catégorie" FROM courses c
JOIN enrollments e ON c.id = e.course_id
WHERE e.completed = TRUE
GROUP BY c.category
ORDER BY SUM(c.price) DESC;

-- 4
SELECT u.id AS user_id, u.name, ROUND(AVG(c.price),2) AS "revenu moyen par utilisateur" FROM users u
JOIN enrollments e ON u.id = e.user_id
JOIN courses c ON e.course_id = c.id
WHERE e.completed = TRUE
GROUP BY u.id, u.name
ORDER BY ROUND(AVG(c.price),2) DESC;


-- BONUS 
-- 5
SELECT c.title, SUM(c.price) AS "revenu total par cours" FROM courses c
JOIN enrollments e ON c.id = e.course_id
WHERE e.completed = TRUE
GROUP BY c.id, c.title
ORDER BY SUM(c.price) DESC LIMIT 5;

-- 6 
-- Pourcentage des cours gratuits (prix = 0) par rapport au nombre total de cours suivis pour chaques utilisateurs
SELECT u.id AS user_id, u.name, ROUND((SUM(CASE WHEN c.price = 0 THEN 1 ELSE 0 END) / COUNT(e.id)) * 100, 2) AS "pourcentage cours gratuits"
FROM users u
JOIN enrollments e ON u.id = e.user_id
JOIN courses c ON e.course_id = c.id
GROUP BY u.id, u.name
HAVING COUNT(e.id) > 0
ORDER BY ROUND((SUM(CASE WHEN c.price = 0 THEN 1 ELSE 0 END) / COUNT(e.id)) * 100, 2) DESC;


