# 📚 Plateforme de Cours en Ligne – Analyse Statistique SQL

Projet de data analyse réalisé dans le cadre d’un TP SQL. L’objectif est de modéliser une base de données pour une plateforme de e-learning, de l’alimenter avec des données réalistes, puis d’en extraire des statistiques pertinentes à l’aide de requêtes SQL avancées.

---

## 🧩 1. Modèle de Données

Le schéma relationnel repose sur **4 tables principales**, avec des contraintes d’intégrité fortes :

### Tables :

- **users**
  - `id` (PK)
  - `name`, `email`, `created_at`

- **courses**
  - `id` (PK)
  - `title`, `category` (ENUM), `price`

- **enrollments**
  - `id` (PK)
  - `user_id` (FK)
  - `course_id` (FK)
  - `enrolled_at`, `completed`, `completed_at`

- **reviews**
  - `id` (PK)
  - `user_id` (FK)
  - `course_id` (FK)
  - `rating` (1 à 5), `comment`

### Contraintes et intégrité :

- Clés étrangères avec `ON DELETE CASCADE`
- Contrainte d’unicité sur `(user_id, course_id)` dans `enrollments` et `reviews`
- Check sur le `rating` (entre 1 et 5)
- Contrainte logique sur la complétion (si `completed = TRUE`, `completed_at` doit être renseigné)

---

## 💾 2. Jeu de Données

### Données insérées :

- **20 utilisateurs**
- **13 cours** répartis dans les catégories : Dev, Marketing, Photo, Design, Business
- **50 inscriptions** avec des statuts variés (complétés / non complétés)
- **15 avis** avec des notes de 1 à 5

Les données sont réalistes, cohérentes, et visent à simuler une activité réelle sur une plateforme de formation en ligne.

---

## 📊 3. Analyses Réalisées

### 🔍 A. Statistiques Utilisateurs

---

### 🔍 B. Analyse des Cours

| Analyse | Description |
|--------|-------------|
| Nombre de cours par catégorie | Regroupe les cours selon leur domaine |
| Prix moyen par catégorie | Indique le positionnement tarifaire moyen |
| Cours le plus cher / moins cher | Repère les extrêmes de tarification |
| Nombre d'inscriptions par cours | Évalue la popularité des formations |
| 🔹 Bonus : Cours sans inscription | Détecte les formations non consultées |
| 🔹 Bonus : Cours avec taux de complétion > 80% | Met en évidence les formations efficaces |

---

### 💰 C. Revenu de la Plateforme

| Analyse | Description |
|--------|-------------|
| Revenu total généré | Somme des revenus des cours ayant des inscriptions |
| Revenu total par cours | Détail des performances financières de chaque formation |
| Revenu total par catégorie | Évalue les filières les plus rentables |
| Revenu moyen par utilisateur inscrit | Indique la valeur moyenne d’un client |
| 🔹 Bonus : Top 5 des cours les plus rentables | Classement des cours à plus fort ROI |
| 🔹 Bonus : % de cours gratuits suivis | Part des cours à 0€ dans la consommation |

---

## 📎 4. Fichiers du Projet

- `init.sql` → Création des tables et insertion des données
- `BDD.sql` → Ensemble des requêtes pour les analyses statistiques
- `README.md` → Documentation et explications du projet