-- Statistiques Utilisateurs
-- --- --- Nombre total d'utilisateurs :
SELECT COUNT(*) AS total_utilisateurs
FROM users;
-- --- --- Liste des utilisateurs avec leur nombre d’inscriptions
SELECT u.id, u.name, u.email, COUNT(e.id) AS nb_inscriptions
FROM users u
LEFT JOIN enrollments e ON u.id = e.user_id
GROUP BY u.id, u.name, u.email
ORDER BY nb_inscriptions DESC;
-- --- --- Moyenne d’inscriptions par utilisateur
SELECT AVG(nb_inscriptions) AS moyenne_inscriptions
FROM (
    SELECT u.id, COUNT(e.id) AS nb_inscriptions
    FROM users u
    LEFT JOIN enrollments e ON u.id = e.user_id
    GROUP BY u.id
) AS sous_requete;
-- --- --- Liste des utilisateurs avec leur date d'inscription la plus ancienne
SELECT id, name, email, MIN(created_at) AS date_inscription
FROM users
GROUP BY id, name, email
ORDER BY date_inscription ASC;
-- --- ---  Nombre d’inscription par date
SELECT DATE(enrolled_at) AS date_inscription, COUNT(*) AS nb_inscriptions
FROM enrollments
GROUP BY DATE(enrolled_at)
ORDER BY date_inscription ASC;