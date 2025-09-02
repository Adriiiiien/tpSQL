-- Création des tables

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category ENUM('Dev', 'Marketing', 'Photo', 'Design', 'Business') NOT NULL,
    price DECIMAL(8,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP NULL,
    UNIQUE (user_id, course_id),
    CONSTRAINT fk_enroll_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT completed_check CHECK (
        (completed = TRUE AND completed_at IS NOT NULL) OR
        (completed = FALSE AND completed_at IS NULL)
    )
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    UNIQUE (user_id, course_id),
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_review_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);


-- Insertion des données

-- Utilisateurs
INSERT INTO users (name, email) VALUES
('Alice Martin', 'alice.martin@example.com'),
('Bob Dupont', 'bob.dupont@example.com'),
('Claire Durand', 'claire.durand@example.com'),
('David Leroy', 'david.leroy@example.com'),
('Emma Petit', 'emma.petit@example.com'),
('François Lambert', 'francois.lambert@example.com'),
('Gaëlle Morel', 'gaelle.morel@example.com'),
('Hugo Lefevre', 'hugo.lefevre@example.com'),
('Inès Caron', 'ines.caron@example.com'),
('Julien Robert', 'julien.robert@example.com'),
('Karim Bouchard', 'karim.bouchard@example.com'),
('Laura Gauthier', 'laura.gauthier@example.com'),
('Marc Olivier', 'marc.olivier@example.com'),
('Nadia Bernard', 'nadia.bernard@example.com'),
('Olivier Simon', 'olivier.simon@example.com'),
('Pauline Blanchard', 'pauline.blanchard@example.com'),
('Quentin Fabre', 'quentin.fabre@example.com'),
('Rania Chevalier', 'rania.chevalier@example.com'),
('Sophie Dubois', 'sophie.dubois@example.com'),
('Thomas Marchand', 'thomas.marchand@example.com');

-- Cours
INSERT INTO courses (title, category, price) VALUES
('Introduction au Développement Web', 'Dev', 99.00),
('JavaScript Avancé', 'Dev', 149.00),
('Bases du Marketing Digital', 'Marketing', 89.00),
('SEO pour Débutants', 'Marketing', 59.00),
('Photographie de Portrait', 'Photo', 120.00),
('Retouche Photo avec Lightroom', 'Photo', 75.00),
('UI/UX Design Fundamentals', 'Design', 130.00),
('Illustrator pour Débutants', 'Design', 110.00),
('Créer son Entreprise', 'Business', 200.00),
('Gestion du Temps et Productivité', 'Business', 70.00),
('Python pour la Data Science', 'Dev', 180.00),
('Rédaction Publicitaire', 'Marketing', 95.00),
('Photographie de Voyage', 'Photo', 150.00);

-- Inscriptions (50 réparties)
INSERT INTO enrollments (user_id, course_id, completed, completed_at) VALUES
(1, 1, TRUE, '2024-03-15'),
(1, 3, FALSE, NULL),
(2, 2, TRUE, '2024-05-01'),
(2, 5, FALSE, NULL),
(3, 7, TRUE, '2024-06-10'),
(4, 10, FALSE, NULL),
(5, 11, TRUE, '2024-07-02'),
(6, 4, FALSE, NULL),
(7, 8, TRUE, '2024-04-18'),
(8, 9, FALSE, NULL),
(9, 12, TRUE, '2024-05-21'),
(10, 6, FALSE, NULL),
(11, 2, TRUE, '2024-03-30'),
(12, 13, TRUE, '2024-06-25'),
(13, 1, FALSE, NULL),
(14, 3, TRUE, '2024-07-11'),
(15, 7, FALSE, NULL),
(16, 11, TRUE, '2024-04-05'),
(17, 9, FALSE, NULL),
(18, 5, TRUE, '2024-06-01'),
(19, 10, FALSE, NULL),
(20, 8, TRUE, '2024-06-15'),
(5, 2, FALSE, NULL),
(7, 11, TRUE, '2024-05-14'),
(9, 1, TRUE, '2024-04-22'),
(10, 3, FALSE, NULL),
(11, 5, TRUE, '2024-07-01'),
(12, 7, FALSE, NULL),
(13, 9, TRUE, '2024-06-07'),
(14, 11, TRUE, '2024-07-12'),
(15, 12, FALSE, NULL),
(16, 4, TRUE, '2024-05-17'),
(17, 6, FALSE, NULL),
(18, 8, TRUE, '2024-06-30'),
(19, 2, FALSE, NULL),
(20, 13, TRUE, '2024-07-20'),
(3, 10, TRUE, '2024-06-21'),
(4, 11, FALSE, NULL),
(6, 12, TRUE, '2024-07-10'),
(8, 1, FALSE, NULL),
(9, 3, TRUE, '2024-05-29'),
(10, 7, FALSE, NULL),
(11, 13, TRUE, '2024-06-19'),
(12, 2, TRUE, '2024-06-05'),
(13, 5, FALSE, NULL),
(14, 6, TRUE, '2024-06-14'),
(15, 8, FALSE, NULL),
(16, 9, TRUE, '2024-07-08'),
(17, 12, FALSE, NULL),
(18, 13, TRUE, '2024-07-11');

-- Avis (15 environ)
INSERT INTO reviews (user_id, course_id, rating, comment) VALUES
(1, 1, 5, 'Super cours, très clair et complet !'),
(2, 2, 4, 'Un peu dense mais très intéressant.'),
(3, 7, 5, 'J’ai adoré le contenu pratique.'),
(5, 11, 5, 'Excellent pour débuter en Data Science.'),
(7, 8, 3, 'Bien mais manque d’exemples concrets.'),
(9, 12, 4, 'Très utile pour le marketing de contenu.'),
(12, 13, 5, 'Magnifiques conseils photo.'),
(14, 3, 2, 'Pas assez approfondi.'),
(16, 11, 5, 'Super prof, explications claires.'),
(18, 5, 4, 'Bon équilibre entre théorie et pratique.'),
(19, 10, 3, 'Correct mais trop général.'),
(20, 9, 5, 'Parfait pour les entrepreneurs.'),
(4, 6, 4, 'Bonne introduction à la retouche photo.'),
(6, 4, 3, 'Peut être amélioré.'),
(10, 1, 5, 'Un des meilleurs cours que j’ai suivis.');
