-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 12 nov. 2025 à 04:52
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `sporthub_db`
--
CREATE DATABASE IF NOT EXISTS sporthub_db;
USE sporthub_db;
-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id_article` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` int UNSIGNED NOT NULL,
  `sport` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `image_url` text,
  `featured` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_article`),
  KEY `idx_sport` (`sport`),
  KEY `idx_category` (`category`),
  KEY `idx_featured` (`featured`)
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`id_article`, `name`, `description`, `price`, `sport`, `category`, `stock`, `image_url`, `featured`, `created_at`, `updated_at`) VALUES
(1, 'Maillot CAMEROUN', 'Maillot de football domicile CAMEROUN', 20000, 'football', 'maillots', 15, 'img/football/maillots/IMG-20250405-WA0016.jpg', 1, '2025-10-26 01:54:56', '2025-11-02 23:45:01'),
(2, 'Adidas Predator', 'Godasse ADIDAS PREDATOR Jude Bellingham GOLD', 35000, 'football', 'chaussures', 5, 'img/football/crampons/adidas predator JB gold.webp', 1, '2025-10-26 01:54:56', '2025-11-02 23:26:50'),
(3, 'Ballon ADIDAS CHAMPIONS LEAGUE', 'Ballon de football adidas UEFA Champions League', 15000, 'football', 'accessoires', 8, 'img\\football\\ballons\\ballon adidas champions league.webp\"', 0, '2025-10-26 01:54:56', '2025-11-02 22:22:24'),
(4, 'Gants Adidas Predator', 'Gants de gardien avec grip Adidas Predator GL PRO', 15000, 'football', 'accessoires', 6, 'img/football/equipement/gants adidas predator GL PRO.jpg', 0, '2025-10-26 01:54:56', '2025-11-05 02:13:51'),
(5, 'Maillot Lakers ', 'Maillot de basketball Lakers noir Kobe BRYANT', 15000, 'basketball', 'maillots', 11, 'img\\basketball\\maillots\\kobe.jpg', 1, '2025-10-26 01:54:56', '2025-11-12 04:27:02'),
(6, 'Basket UNDER ARMOR CURRY', 'Baskets UNDER ARMOR CURRY, plusieurs couleurs', 40000, 'basketball', 'chaussures', 7, 'img/basketball/baskets/under armor curry.jpg\n', 1, '2025-10-26 01:54:56', '2025-11-12 04:27:02'),
(7, 'Ballon de Basketball Official WILSON NBA', 'Ballon de basketball taille officielle WILSON NBA', 20000, 'basketball', 'accessoires', 12, 'img/basketball/accessoires/wilson.jpg', 1, '2025-10-26 01:54:56', '2025-11-05 02:11:45'),
(8, 'Genouillères Basketball', 'Protection genoux pour basketball', 7000, 'basketball', 'accessoires', 18, 'img/basketball/accessoires/genouillères.jpg', 0, '2025-10-26 01:54:56', '2025-11-05 02:20:31'),
(9, 'Maillot de Bain femme', 'Maillot de natation haute performance', 6000, 'natation', 'maillots', 10, 'img/natation/maillot/maillot femme1.jpg', 1, '2025-11-03 01:03:04', '2025-11-05 16:05:26'),
(10, 'Lunettes de Natation Pro', 'Lunettes de natation anti-buée professionnelles couleur bleu ciel', 5000, 'natation', 'accessoires', 35, 'img/natation/accessoires/WhatsApp Image 2025-11-01 à 02.13.40_e2c256f7.jpg', 1, '2025-11-03 01:03:04', '2025-11-05 16:07:50'),
(11, 'Short Venum ', 'Short de boxe professionnel et confortable VENUM noir-jaune', 14000, 'boxe', 'maillots', 12, 'img/boxe/Maillots/Short Venum.jpg', 1, '2025-11-03 03:29:07', '2025-11-05 16:09:03'),
(12, 'Gants de Boxe Everlast', 'Gants de boxe professionnels EVERLAST couleur marron', 12000, 'boxe', 'maillots', 13, 'img/boxe/Maillots/gants everlast.jpg', 1, '2025-11-03 03:29:07', '2025-11-05 16:09:13'),
(17, 'Polo de Tennis Lacoste', 'Polo de tennis élégant et technique', 10000, 'tennis', 'maillots', 10, 'img/tennis/maillots/Polo Lacoste Tennis Rouge.webp', 1, '2025-10-26 01:54:56', '2025-11-12 03:26:48'),
(18, 'Chaussures de Tennis HEAD', 'Chaussures de tennis pour surface dure', 16000, 'tennis', 'chaussures', 12, 'img/tennis/maillots/tennis head.jpg', 0, '2025-10-26 01:54:56', '2025-11-09 02:45:25'),
(19, 'Raquette de Tennis HEAD', 'Raquette de tennis Head Radical mp 2023', 23000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Head Radical mp 2023.jpg', 1, '2025-10-26 01:54:56', '2025-11-09 00:16:06'),
(20, 'Balles de Tennis Pack', 'Pack de 3 balles de tennis officielles', 5000, 'tennis', 'accessoires', 50, 'img/tennis/Raquettes et balles/3 balles de tennis head.webp', 1, '2025-10-26 01:54:56', '2025-11-09 00:12:31'),
(21, 'T-shirt Running Technique', 'T-shirt de running avec évacuation de transpiration', 6000, 'running', 'maillots', 28, 'img/running/maillot/T-shirt running.jpg', 0, '2025-10-26 01:54:56', '2025-11-12 04:07:23'),
(22, 'Chaussures de Running Elite', 'Chaussures de course avec amorti avancé', 16000, 'running', 'chaussures', 20, 'img/running/chaussure/tennis.jpg', 1, '2025-10-26 01:54:56', '2025-11-12 03:58:32'),
(23, 'Montre GPS Running', 'Montre connectée avec GPS pour running', 10000, 'running', 'accessoires', 8, 'img/running/accessoires/montre gps.jpg', 0, '2025-10-26 01:54:56', '2025-11-12 03:59:33'),
(24, 'Ceinture Running Hydratation', 'Ceinture de running avec porte-bidon', 15000, 'running', 'accessoires', 20, 'img/running/accessoires/ceinture.jpg', 0, '2025-10-26 01:54:56', '2025-11-12 04:00:24'),
(25, 'Débardeur Fitness Compression', 'Débardeur de fitness avec compression musculaire', 10000, 'fitness', 'maillots', 24, 'img/fitness/maillot/téléchargement.jpg', 0, '2025-10-26 01:54:56', '2025-11-12 04:01:43'),
(26, 'Chaussures Cross Training', 'Chaussures polyvalentes pour cross-training', 18000, 'fitness', 'chaussures', 10, 'img/fitness/chaussure/téléchargement (2).jpg', 0, '2025-10-26 01:54:56', '2025-11-12 04:02:34'),
(27, 'Kit Bandes de Résistance', 'Set de 5 bandes de résistance avec différentes forces', 12000, 'fitness', 'accessoires', 35, 'img/fitness/accessoires/images.jpg', 1, '2025-10-26 01:54:56', '2025-11-12 04:03:23'),
(28, 'Tapis de Yoga Premium', 'Tapis de yoga extra épais avec sac de transport', 7000, 'fitness', 'accessoires', 20, 'img/fitness/accessoires/tapis.jpg', 0, '2025-10-26 01:54:56', '2025-11-12 04:03:56'),
(29, 'Haltères Réglables Set', 'Set d\'haltères réglables 2-10kg', 20000, 'fitness', 'accessoires', 12, 'img/fitness/accessoires/haltères.jpg', 0, '2025-10-26 01:54:56', '2025-11-12 04:04:42'),
(30, 'Débardeur ', 'Débardeur ', 4000, 'fitness', 'maillots', 23, 'img/fitness/maillot/téléchargement (1).jpg', 0, '2025-10-26 01:54:56', '2025-11-12 04:05:37'),
(31, 'Ballon NIKE pro', 'Ballon de football NIKE pour tous les terrains', 12000, 'football', 'accessoires', 15, 'img\\football\\ballons\\ballon nike.jpg\"', 1, '2025-10-26 01:54:56', '2025-11-02 22:23:55'),
(32, 'Maillot Chelsea', 'Maillot de football domicile Chelsea', 10000, 'football', 'maillots', 12, 'img/football/maillots/maillot chelsea.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 23:43:13'),
(33, 'Maillot PSG', 'Maillot de football 3rd Paris Saint-germain', 15000, 'football', 'maillots', 20, 'img/football/maillots/IMG-20251102-WA0167.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(34, 'Maillot OM', 'Maillot de football domicile Olympique de Marseille', 12000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20250823-WA0293.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(35, 'Maillot Barcelone', 'Maillot de football 3rd Barcelone', 15000, 'football', 'maillots', 20, 'img/football/maillots/IMG-20250823-WA0866.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(36, 'Maillot Real Madrid', 'Maillot de football domicile Vini jr Real Madrid', 15000, 'football', 'maillots', 15, 'img/football/maillots/IMG-20250913-WA0038.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(37, 'Maillot Real Madrid', 'Maillot de football domicile Kylian Mbappe Real Madrid', 15000, 'football', 'maillots', 15, 'img/football/maillots/IMG-20250913-WA0039.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(38, 'Maillot Barcelone', 'Maillot de football domicile Lamine Yamal Barcelone', 15000, 'football', 'maillots', 20, 'img/football/maillots/IMG-20251023-WA0285.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(39, 'Maillot Santos', 'Maillot de football professionnel Santos Neymar Junior', 18000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20250913-WA0043.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(40, 'Maillot Arsenal', 'Maillot de football domicile Arsenal', 12000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20251022-WA0012.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(41, 'Maillot Liverpool', 'Maillot de football domicile Liverpool', 12000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20251101-WA0052.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(42, 'Maillot Bayern Munich', 'Maillot de football domicile Bayern Munich', 12000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20251102-WA0162.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(43, 'Maillot Man city', 'Maillot de football domicile Man city', 12000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20251102-WA0163.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(44, 'Maillot Inter Miami', 'Maillot de football domicile Inter Miami', 12000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20251102-WA0164.jpg', 0, '2025-11-02 22:08:12', '2025-11-02 22:13:13'),
(45, 'Maillot Tottenham', 'Maillot de football professionnel Tottenham', 12000, 'football', 'maillots', 10, 'img/football/maillots/IMG-20250823-WA0294.jpg', 1, '2025-11-02 22:08:12', '2025-11-02 22:08:12'),
(46, 'Ballon nike première league academy', 'Ballon nike première league academy pour tous les terrains', 12000, 'football', 'accessoires', 10, 'img\\football\\ballons\\nike première league academy.avif\"', 0, '2025-10-26 01:54:56', '2025-11-02 22:23:55'),
(47, 'Adidas F50', 'Godasse ADIDAS F50 spécial Lamine Yamal rose ', 30000, 'football', 'chaussures', 7, 'img/football/crampons/adidas F50 Lamine Yamal.jpg', 1, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(48, 'Adidas Predator', 'Godasse ADIDAS PREDATOR ELITE BELLINGHAM ', 18000, 'football', 'chaussures', 10, 'img/football/crampons/ADIDAS PREDATOR ELITE BELLINGHAM.jpeg', 0, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(49, 'Adidas F50', 'Godasse ADIDAS F50 spécial LIONEL MESSI ', 35000, 'football', 'chaussures', 5, 'img/football/crampons/adidas predator JB gold.webp', 1, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(50, 'Adidas Predator', 'Godasse ADIDAS PREDATOR JB BLUE ', 28000, 'football', 'chaussures', 8, 'img/football/crampons/adidas-predator-JB-blue.jpg', 0, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(51, 'Adidas Crazyfast', 'Godasse ADIDAS CRAZYFAST ROYAL BLUE', 25000, 'football', 'chaussures', 15, 'img/football/crampons/Godasse-Royal-Crazyfast.png', 0, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(52, 'Puma Future', 'Godasse PUMA FUTURE PRO BLACK ', 18000, 'football', 'chaussures', 10, 'img/football/crampons/puma future pro.jpg', 0, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(53, 'Puma Future', 'Godasse PUMA FUTURE NEYMAR WHITE ', 18000, 'football', 'chaussures', 9, 'img/football/crampons/PUMA future Neymar.jpg', 1, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(54, 'Nike Zoom Vapor', 'Godasse NIKE ZOOM VAPOR 15 KM', 25000, 'football', 'chaussures', 12, 'img/football/crampons/Nike Zoom Vapor 15 Pro.jpg', 1, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(55, 'Nike Mercurial', 'Godasse NIKE MERCURIAL SUPERFLY CR7 WHITE ', 45000, 'football', 'chaussures', 3, 'img/football/crampons/Nike Mercurial Superfly CR7 Vitorias.jpg', 1, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(56, 'Nike Mercurial', 'Godasse NIKE MERCURIAL SUPERFLY V CR7 ', 35000, 'football', 'chaussures', 6, 'img/football/crampons/Nike Mercurial Superfly V CR7 Chapter 3.webp', 0, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(57, 'Nike Mercurial', 'Godasse NIKE MERCURIAL PINK', 15000, 'football', 'chaussures', 12, 'img/football/crampons/NIKE mercurial.jpg', 0, '2025-11-02 23:30:48', '2025-11-02 23:30:48'),
(58, 'Ballon Adidas Jabulani', 'Ballon de foot COUPE DU MONDE 2014 ADIDAS JABULANI', 25000, 'football', 'accessoires', 4, 'img/football/ballons/ballon coupe du monde.jpg', 1, '2025-11-03 00:17:45', '2025-11-03 00:17:45'),
(59, 'Gants Adidas Predator Pro', 'Gants de gardien avec grip Adidas Predator Pro noir', 15000, 'football', 'accessoires', 6, 'img/football/equipement/gants adidas predator pro noir.jpg', 0, '2025-11-03 00:17:45', '2025-11-03 00:17:45'),
(60, 'Gants PUMA', 'Gants de gardien pro PUMA ', 10000, 'football', 'accessoires', 6, 'img/football/equipement/gants puma.webp', 1, '2025-11-03 00:17:45', '2025-11-05 02:13:46'),
(61, 'Chasubles d\'entrainenement', 'Sets de chasuble pour entrainement solides, plusieurs couleurs avec numéro', 7000, 'football', 'accessoires', 6, 'img/football/equipement/chasubles.jpg', 0, '2025-11-03 00:17:45', '2025-11-03 00:17:45'),
(62, 'Mannequins d\'entrainement', 'Mannequins d\'entrainement solides 1M70', 10000, 'football', 'accessoires', 6, 'img/football/equipement/mannequins d\'entraînement.jpg', 0, '2025-11-03 00:17:45', '2025-11-03 00:17:45'),
(63, 'Plots d\'entrainenement', 'Sets de plots pour entrainement solides, plusieurs couleurs', 7000, 'football', 'accessoires', 6, 'img/football/equipement/plots.jpg', 0, '2025-11-03 00:21:50', '2025-11-03 00:21:50'),
(64, 'Maillot de Bain combinaison femme', 'Maillot de natation combinaison noir homologué pour compétition ', 10000, 'natation', 'maillots', 10, 'img/natation/maillot/WhatsApp Image 2025-11-01 à 02.13.48_fa41f8fc.jpg', 0, '2025-11-03 01:03:04', '2025-11-05 01:33:29'),
(65, 'Maillot de Bain combinaison femme', 'Maillot de natation combinaison noir-rose homologué pour compétition ', 10000, 'natation', 'maillots', 10, 'img\\natation\\maillot\\WhatsApp Image 2025-11-01 à 02.13.41_c397e3b8.jpg', 0, '2025-11-03 01:03:04', '2025-11-05 01:32:32'),
(67, 'Maillot de Bain femme', 'Maillot de natation haute performance', 6000, 'natation', 'maillots', 15, 'img/natation/maillot/maillot femme2.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(68, 'Maillot de Bain femme', 'Maillot de natation haute performance', 8000, 'natation', 'maillots', 6, 'img/natation/maillot/maillot femme3.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(69, 'Maillot de Bain homme', 'Maillot de natation haute performance', 7000, 'natation', 'maillots', 8, 'img/natation/maillot/maillot homme 2.jpg', 1, '2025-11-03 01:03:04', '2025-11-03 01:07:44'),
(70, 'Maillot de Bain homme', 'Maillot de natation haute performance', 5000, 'natation', 'maillots', 12, 'img/natation/maillot/maillot homme 3.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(72, 'Lunettes de Natation Pro', 'Lunettes de natation anti-buée professionnelles couleur bleu', 5000, 'natation', 'accessoires', 35, 'img/natation/accessoires/lunettes.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:10:23'),
(73, 'Tuba de Natation', 'Tuba de natation ergonomique pour entraînement', 7000, 'natation', 'accessoires', 30, 'img/natation/accessoires/WhatsApp Image 2025-11-01 à 02.13.40_bb6e34e1.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(74, 'Bonnet de Natation Silicone', 'Bonnet de natation en silicone confortable', 3000, 'natation', 'accessoires', 40, 'img/natation/accessoires/bonnet.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(75, 'Bonnet de Natation ', 'Bonnet de natation couvre oreilles', 4500, 'natation', 'accessoires', 20, 'img/natation/accessoires/WhatsApp Image 2025-11-01 à 02.16.30_4cb3c883.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(76, 'Palmes de Natation Training', 'Palmes d\'entraînement pour natation', 9000, 'natation', 'accessoires', 10, 'img/natation/accessoires/WhatsApp Image 2025-11-01 à 02.13.48_0f3eb97a.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(77, 'Brassard de natation pour enfant', 'Brassard flottant pour enfants', 6000, 'natation', 'accessoires', 7, 'img/natation/accessoires/brassard.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(78, 'combinaison flottante pour enfant', 'combinaison flottante pour apprentissage des enfants', 15000, 'natation', 'accessoires', 8, 'img/natation/accessoires/combi flottante enfant.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(79, 'Frites de natation', 'Frites de natation pour apparentissage, bonne qualité', 2000, 'natation', 'accessoires', 25, 'img/natation/accessoires/frites.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(80, 'Planche de natation', 'Planches de natation pour apparentissage, bonne qualité', 4000, 'natation', 'accessoires', 18, 'img/natation/accessoires/planche.jpg', 0, '2025-11-03 01:03:04', '2025-11-03 01:03:04'),
(81, 'Short EVERLAST ', 'Short de boxe professionnel et confortable EVERLAST noir-blanc', 15000, 'boxe', 'maillots', 9, 'img/boxe/Maillots/Short EVERLAST noir-blanc.jpg', 1, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(83, 'Short King ', 'Short de boxe professionnel et confortable KING bleu-blanc', 13000, 'boxe', 'maillots', 15, 'img/boxe/Maillots/Short KING.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(84, 'Short Metal ', 'Short de boxe professionnel et confortable METAL noir', 15000, 'boxe', 'maillots', 9, 'img/boxe/Maillots/Short METAL.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(86, 'Gants de Boxe Metal', 'Gants de boxe professionnels METAL couleur noir', 15000, 'boxe', 'maillots', 12, 'img/boxe/Maillots/gants METAL noir.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(87, 'Gants de Boxe Metal', 'Gants de boxe professionnels METAL couleur blanc', 14000, 'boxe', 'maillots', 6, 'img/boxe/Maillots/gant metal.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(88, 'Gants de Boxe Venum', 'Gants de boxe professionnels VENUM couleur blanc-noir', 18000, 'boxe', 'maillots', 10, 'img/boxe/Maillots/gants venum.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(89, 'Chaussures de Boxe Adidas', 'Chaussures de boxe montantes légères ADIDAS bleue', 30000, 'boxe', 'chaussures', 10, 'img/boxe/chaussure/adidas blue.jpg', 1, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(90, 'Chaussures de Boxe Nike', 'Chaussures de boxe montantes légères NIKE noire', 28000, 'boxe', 'chaussures', 8, 'img/boxe/chaussure/chaussure nike.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(91, 'Chaussures de Boxe Adidas', 'Chaussures de boxe montantes légères ADIDAS noire', 25000, 'boxe', 'chaussures', 12, 'img/boxe/chaussure/chaussure adidas.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(92, 'Chaussures de Boxe Venum', 'Chaussures de boxe montantes légères VENUM bleu', 27000, 'boxe', 'chaussures', 9, 'img/boxe/chaussure/Venom bleu.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(93, 'Chaussures de Boxe Venum', 'Chaussures de boxe montantes légères VENUM noire-vert', 35000, 'boxe', 'chaussures', 7, 'img/boxe/chaussure/venum vert-noir.jpg', 1, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(94, 'Chaussures de Boxe Nike', 'Chaussures de boxe montantes légères NIKE grise', 28000, 'boxe', 'chaussures', 8, 'img/boxe/chaussure/Nike grise.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(95, 'Chaussures de Boxe Lonsdale', 'Chaussures de boxe montantes légères LONSDALE noire', 20000, 'boxe', 'chaussures', 10, 'img/boxe/chaussure/Lonsdale.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(96, 'Chaussures de Boxe ISBA', 'Chaussures de boxe montantes légères ISBA noire', 18000, 'boxe', 'chaussures', 7, 'img/boxe/chaussure/ISBA.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(97, 'Sac de Boxe Suspendu', 'Sac de boxe en cuir METAL résistant pour entraînement intensif', 150000, 'boxe', 'accessoires', 5, 'img/boxe/accessoires/Sac de frappes METAL.jpg', 1, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(98, 'Sac de Boxe Suspendu', 'Sac de boxe en cuir ADIDAS résistant pour entraînement intensif', 115000, 'boxe', 'accessoires', 3, 'img/boxe/accessoires/Sac de frappes ADIDAS.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(99, 'punching bax', 'punching bax en cuir à suspendre, très résistant', 50000, 'boxe', 'accessoires', 7, 'img/boxe/accessoires/punching bag.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(100, 'Corde à Sauter', 'Corde à sauter professionnelle pour boxe et fitness', 4000, 'boxe', 'accessoires', 20, 'img/boxe/accessoires/corde à sauter.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(101, 'Protège-dents Boxe', 'Protège-dents de boxe confortable et résistant bleu', 5000, 'boxe', 'accessoires', 15, 'img/boxe/accessoires/protège dents bleu.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(102, 'Protège-dents Boxe', 'Protège-dents de boxe OPRO ADIDAS résistant', 12000, 'boxe', 'accessoires', 8, 'img/boxe/accessoires/protège dents opro adidas.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(103, 'Bandages de Boxe METAL', 'Bandages de boxe en coton extensible pour protection des mains ', 4000, 'boxe', 'accessoires', 30, 'img/boxe/accessoires/bande METAL.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(104, 'Casque de Protection Boxe MARTIAL', 'Casque de protection pour entraînement de boxe MARTIAL noir', 8000, 'boxe', 'accessoires', 12, 'img/boxe/accessoires/casque de protection MARTIALnoir.jpg', 1, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(105, 'Casque de Protection Boxe LEONE', 'Casque de protection pour entraînement de boxe LEONE marron', 8000, 'boxe', 'accessoires', 8, 'img/boxe/accessoires/casque marron LEONE.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:29:07'),
(106, 'Patte d\'ours', 'Patte d\'ours pour entraînement de boxe noire', 20000, 'boxe', 'accessoires', 14, 'img/boxe/accessoires/pattes d\'ours noires.jpg', 1, '2025-11-03 03:29:07', '2025-11-03 03:41:31'),
(107, 'Patte d\'ours METAL', 'Patte d\'ours METAL pour entraînement de boxe noire-rouge', 25000, 'boxe', 'accessoires', 4, 'img/boxe/accessoires/pate d\'ours METAL.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:41:46'),
(108, 'Sac d\'équipement VENUM', 'Sac d\'équipement VENUM noire large', 18000, 'boxe', 'accessoires', 6, 'img/boxe/accessoires/Sac d\'équipements VENUM.jpg', 0, '2025-11-03 03:29:07', '2025-11-03 03:39:18'),
(109, 'Short EVERLAST ', 'Short de boxe professionnel et confortable EVERLAST noir-blanc', 15000, 'boxe', 'maillots', 9, 'img/boxe/Maillots/Short EVERLAST noir-blanc.jpg', 1, '2025-11-03 03:29:08', '2025-11-03 03:29:08'),
(113, 'Gants de Boxe Everlast', 'Gants de boxe professionnels EVERLAST couleur marron', 12000, 'boxe', 'maillots', 13, 'img/boxe/Maillots/gants everlast.jpg', 1, '2025-11-03 03:29:08', '2025-11-03 03:29:08'),
(137, 'Maillot GOLDEN STATE', 'Maillot de basketball Golden State Warrior Stephen CURRY', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/gs noir.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(138, 'Maillot DENVER', 'Maillot de basketball DENVER', 12000, 'basketball', 'maillots', 15, 'img/basketball/maillots/denver.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(139, 'Maillot GRIZZLIES', 'Maillot de basketball GRIZZLIES Ja MORANT', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/grizzlies.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(140, 'Maillot MAVERICKS', 'Maillot de basketball DALLAS MAVERICKS Kyrie Irving', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/dallas irving.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(141, 'Maillot HORNETS', 'Maillot de basketball CHARLOTTE HORNETS Lamelo BALL', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/hornets.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(142, 'Maillot HAWKS', 'Maillot de basketball ATLANTA HAWKS', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/hawks.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(143, 'Maillot LAKERS', 'Maillot de basketball LOS ANGELS LAKERS LeBron JAMES jaune', 18000, 'basketball', 'maillots', 20, 'img/basketball/maillots/james.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(144, 'Maillot LAKERS', 'Maillot de basketball LOS ANGELS LAKERS violet', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/lakers violet.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(145, 'Maillot MIAMI', 'Maillot de basketball MIAMI HEAT Jamie BUTLER', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/miami.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(146, 'Maillot THUNDERS', 'Maillot de basketball THUNDERS OKLAHOMA SGA', 18000, 'basketball', 'maillots', 20, 'img/basketball/maillots/oklahoma.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(147, 'Maillot PACERS', 'Maillot de basketball INDIANA PACERS HALIBURTON', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/pacers.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(148, 'Maillot 6ers', 'Maillot de basketball PHILADELPHIE 6ers Joel EMBID', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/philadelphie 6ers.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:27:03'),
(149, 'Maillot ROCKETS', 'Maillot de basketball HOUSTON ROCKETS', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/rocket.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(150, 'Maillot SPURS', 'Maillot de basketball SAN ANTONIO SPURS WEMBY', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/spurs noir.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:27:30'),
(151, 'Maillot WOLVES', 'Maillot de basketball WOLVES MINESOTA ANT EDWARDS', 15000, 'basketball', 'maillots', 20, 'img/basketball/maillots/wolves.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(152, 'BASKET ADIDAS HARDEN', 'Baskets ADIDAS JAMES HARDEN, plusieurs couleurs', 30000, 'basketball', 'chaussures', 8, 'img/basketball/baskets/adidas harden.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(153, 'BASKET ANTHONY EDWARDS', 'Baskets ANTHONY EDWARDS, plusieurs couleurs', 25000, 'basketball', 'chaussures', 6, 'img/basketball/baskets/chaussure-anthony-edwards-1-low.avif', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(154, 'BASKET LAMELO BALL', 'Baskets LAMELO BALL, plusieurs couleurs', 25000, 'basketball', 'chaussures', 6, 'img/basketball/baskets/lamelo ball.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(155, 'BASKET NIKE KD 8 V8', 'Baskets NIKE KD 8 V8, plusieurs couleurs', 35000, 'basketball', 'chaussures', 8, 'img/basketball/baskets/nike kd 8 v8.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(156, 'BASKET JASON TATUM', 'Baskets JASON TATUM, plusieurs couleurs', 28000, 'basketball', 'chaussures', 12, 'img/basketball/baskets/tatum.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(157, 'Ballon de Basketball Official SPALDING NBA', 'Ballon de basketball taille officielle SPALDING NBA', 15000, 'basketball', 'accessoires', 18, 'img/basketball/accessoires/spalding.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(158, 'Ballon de Basketball Official MOLTEN', 'Ballon de basketball taille officielle MOLTEN', 12000, 'basketball', 'accessoires', 16, 'img/basketball/accessoires/molten.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(159, 'Bandeau Basketball', 'Bandeau en coton pour basketball', 1500, 'basketball', 'accessoires', 20, 'img/basketball/accessoires/bandeau.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(160, 'protège bras Basketball', 'Protection bras et coude pour basketball', 5000, 'basketball', 'accessoires', 18, 'img/basketball/accessoires/bras.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:21:28'),
(161, 'Panier déplaçable', 'Panier déplaçable pourventrainement de basketball', 18000, 'basketball', 'accessoires', 5, 'img/basketball/accessoires/Panier deplaçable.jpg', 0, '2025-11-05 02:21:28', '2025-11-05 02:25:30'),
(177, 'BASKET ADIDAS HARDEN', 'Baskets ADIDAS JAMES HARDEN, plusieurs couleurs', 30000, 'basketball', 'chaussures', 8, 'img/basketball/baskets/adidas harden.jpg', 0, '2025-11-05 02:21:29', '2025-11-05 02:21:29'),
(187, 'Collant une jambe', 'Collant une jambe pour basketball', 10000, 'basketball', 'accessoires', 15, 'img/basketball/accessoires/collant une jambe.jpg', 0, '2025-11-05 16:01:20', '2025-11-05 16:01:20'),
(188, 'Collant', 'Collant pour basketball', 5000, 'basketball', 'accessoires', 25, 'img/basketball/accessoires/collants.jpg', 0, '2025-11-05 16:01:20', '2025-11-05 16:01:20'),
(189, 'Serre tête', 'Serre tête stylé pour basketball, plusieurs couleurs', 500, 'basketball', 'accessoires', 25, 'img/basketball/accessoires/serre tête.jpg', 0, '2025-11-05 16:01:20', '2025-11-05 16:01:20'),
(193, 'Raquette de Tennis BABOLAT', 'Raquette de tennis Babolat Pure Aero 98 ', 20000, 'tennis', 'accessoires', 15, 'img/tennis/Raquettes et balles/Babolat Pure Aero 98 Raquette de tennis Carlos Alcaraz, Holger Rune....jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(194, 'Raquette de Tennis BABOLAT', 'Raquette de tennis Babolat Boost aero gris-jaune', 25000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Babolat Boost aero gris-jaune.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(195, 'Raquette de Tennis HEAD', 'Raquette de tennis Head Boom Team 2024 (275g)', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Head Boom Team 2024 (275g).webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(196, 'Raquette de Tennis WILSON', 'Raquette de tennis Wilson ultra pro 16x19 v4 (305g)', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/wilson-raquette-tennis-raquette-wilson-ultra-pro-16x19-v4-305g-38555576402103.webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(197, 'Raquette de Tennis BABOLAT', 'Raquette de tennis Babolat Pure Drive Team Gen11', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Babolat Pure Drive Team Gen11.webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(198, 'Raquette de Tennis WILSON RF', 'Raquette de tennis Wilson Roger Frederer 01', 25000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Wilson RF 01.webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(199, 'Raquette de Tennis BABOLAT Rafa', 'Raquette de tennis Babolat pure aero rafa (Rafaël Nadal) origin', 35000, 'tennis', 'accessoires', 6, 'img/tennis/Raquettes et balles/raquette-de-tennis-babolat-pure-aero-rafa-origin-1378266.webp', 1, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(200, 'Raquette de Tennis BABOLAT', 'Raquette de tennis Raquette Babolat Pure drive', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Babolat Pure drive.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(201, 'Raquette de Tennis WILSON', 'Raquette de tennis Wilson Ultra 100 Black V4 (300g)', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Wilson Ultra 100 Black V4 (300g).webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(202, 'Raquette de Tennis HEAD', 'Raquette de tennis Head Extreme Team 2024 (265g)', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Head Extreme Team 2024 (265g).webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(203, 'Raquette de Tennis HEAD', 'Raquette de tennis Head Gravity MP L 2025 (280g)', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Head Gravity MP L 2025 (280g).webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(204, 'Raquette de Tennis WiLsON', 'Raquette de tennis Wilson Shift 99L V1.0 (285g)', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Wilson Shift 99L V1.0 (285g).webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(205, 'Raquette de Tennis WILSON', 'Raquette de tennis Wilson Intrigue SE (264g)', 15000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Wilson Intrigue SE (264g).webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(206, 'Raquette de Tennis HEAD', 'Raquette de tennis Head Speed Pro Black Limited 2023 (310g)', 18000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Head Speed Pro Black Limited 2023 (310g).webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(207, 'Raquette de Tennis HEAD', 'Raquette de tennis Head Speed Team 2024 (270g)', 16000, 'tennis', 'accessoires', 10, 'img/tennis/Raquettes et balles/Raquette Head Speed Team 2024 (270g).jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(208, 'Sac BABOLAT', 'Sac bandoulière pour raquettes Babolat violet', 10000, 'tennis', 'accessoires', 6, 'img/tennis/accessoires/sac babolat violet.webp', 1, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(209, 'Sac HEAD', 'Sac bandoulière pour raquettes Head gris-noir', 8000, 'tennis', 'accessoires', 8, 'img/tennis/accessoires/Sac Bandoulière De Tennis Team Racquet Noir et gris HEAD.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(210, 'Sac WILSON', 'Sac bandoulière pour raquettes Wilson blanc', 12000, 'tennis', 'accessoires', 4, 'img/tennis/accessoires/sac wilson.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(211, 'Sac à dos ACOSEN', 'Sac à dos ACOSEN pour équipement de tennis', 12000, 'tennis', 'accessoires', 8, 'img/tennis/accessoires/ACOSEN Sac à Dos de Tennis.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(212, 'Etui raquette HEAD', 'Etui bandoulière pour une raquette Head', 5000, 'tennis', 'accessoires', 15, 'img/tennis/accessoires/Sacs de Tennis, sac à dos & étuis.webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(213, 'Sac BABOLAT', 'Sac bandoulière pour raquettes Babolat bleu', 10000, 'tennis', 'accessoires', 6, 'img/tennis/accessoires/sac_de_tennis_babolat_2025.webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(214, 'Sac ARTENGO', 'Sac bandoulière pour raquettes Artengo noir', 7000, 'tennis', 'accessoires', 10, 'img/tennis/accessoires/Sac Tennis ARTENGO.avif', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(215, 'Pressurisateur', 'Pressurisateur pour jusqu\'à 4 balles de tennis', 7000, 'tennis', 'accessoires', 12, 'img/tennis/accessoires/Pressurisateur balles de tennis et padel - Jusqu\'à 4 balles - Pompe intégrée.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(216, 'Panier et Ramasse-Balles de Balles de Tennis', 'Panier et Ramasse-Balles de Balles de Tennis', 12000, 'tennis', 'accessoires', 7, 'img/tennis/accessoires/Panier et Ramasse-Balles de Balles de Tennis.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(217, 'Lanceur de balles automatique', 'lanceur de balles automatique pour entraînement', 15000, 'tennis', 'accessoires', 7, 'img/tennis/accessoires/panier à balles de tennis pliable.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(218, 'Ramasseur de Balles à Roulettes', 'Ramasseur de Balles à Roulettes, 55 Boules ', 17000, 'tennis', 'accessoires', 4, 'img/tennis/accessoires/55 Boules Ramasseur de Balles à Roulettes.webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(219, 'Balles de Tennis Pack', 'Boîte de 3 balles Championship Extra Duty wilson', 5000, 'tennis', 'accessoires', 25, 'img/tennis/Raquettes et balles/Boîte de 3 balles Championship Extra Duty wilson.webp', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(220, 'Balles de Tennis Pack', 'Boîte de 3 balles de tennis US Open Extra Duty ', 5000, 'tennis', 'accessoires', 30, 'img/tennis/Raquettes et balles/Balles de tennis US Open Extra Duty — Boîte de 3 balles', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(221, 'Balles de Tennis', 'Stock de balles de tennis haute performance', 1000, 'tennis', 'accessoires', 150, 'img/tennis/Raquettes et balles/balles.jpg', 0, '2025-11-09 02:47:45', '2025-11-09 02:47:45'),
(251, 'Polo de Tennis FILA', 'Polo de tennis FILA', 6000, 'tennis', 'maillots', 12, 'img/tennis/maillots/polo fila.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(252, 'Polo de Tennis Nike', 'Polo de tennis Nike', 5000, 'tennis', 'maillots', 10, 'img/tennis/maillots/polo nike.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(253, 'Polo de Tennis Head', 'Polo de tennis Head', 5000, 'tennis', 'maillots', 11, 'img/tennis/maillots/Polo head noir.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:21:18'),
(254, 'Polo de Tennis Lacoste', 'Polo de tennis Lacoste bleu', 7000, 'tennis', 'maillots', 6, 'img/tennis/maillots/polo lacoste.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(255, 'Polo de Tennis Lacoste', 'Polo de tennis Lacoste blanc', 8000, 'tennis', 'maillots', 13, 'img/tennis/maillots/polo lacoste blanc.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(256, 'Polo de Tennis Lacoste', 'Polo de tennis Lacoste blanc bleu', 8000, 'tennis', 'maillots', 14, 'img/tennis/maillots/polo lacoste blanc bleu.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(257, 'Débardeur de Tennis nike', 'Débardeur de Tennis nike noir', 5000, 'tennis', 'maillots', 15, 'img/tennis/maillots/debardeur nike.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(258, 'Débardeur de Tennis nike femme', 'Débardeur de Tennis nike blanc femme', 5000, 'tennis', 'maillots', 15, 'img/tennis/maillots/maillot femme.jpg', 1, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(259, 'Tennis Asics', 'Chaussures de tennis Asics Gel Sesolution X', 30000, 'tennis', 'chaussures', 12, 'img/tennis/maillots/Asics Gel Sesolution X.jpg', 1, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(260, 'Tennis Nike', 'Chaussures de tennis Nike CA', 15000, 'tennis', 'chaussures', 18, 'img/tennis/maillots/tennis nike CA.avif', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(261, 'Tennis Lacoste', 'Chaussures de tennis Lacoste', 45000, 'tennis', 'chaussures', 6, 'img/tennis/maillots/tennis lacoste.jpg', 1, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(262, 'Tennis Wilson', 'Chaussures de tennis Wilson Bleu', 12000, 'tennis', 'chaussures', 11, 'img/tennis/maillots/tennis wilson.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(263, 'Tennis Wilson', 'Chaussures de tennis Wilson Rush Pro 4.5 blanche', 25000, 'tennis', 'chaussures', 8, 'img/tennis/maillots/Wilson Rush Pro 4.5 blanche.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(264, 'Tennis Adidas', 'Chaussures de tennis adidas Performance SOLEMATCH CONTROL 2', 20000, 'tennis', 'chaussures', 7, 'img/tennis/maillots/tennis adidas Performance SOLEMATCH CONTROL 2.webp', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(265, 'Tennis Nike', 'Chaussures de tennis Nike orange', 14000, 'tennis', 'chaussures', 12, 'img/tennis/maillots/tennis nike.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(266, 'Tennis Nike', 'Chaussures de tennis Nike rose', 17000, 'tennis', 'chaussures', 10, 'img/tennis/maillots/tennis nike rose.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(267, 'Tennis Adidas', 'Chaussures de tennis Adidas Solematch Control 2', 15000, 'tennis', 'chaussures', 14, 'img/tennis/maillots/tennis Adidas Solematch Control 2 Men\'s.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(268, 'Tennis Adidas', 'Chaussures de tennis Giày adidas Tennis Court Spec 2 Nam JR7258', 15000, 'tennis', 'chaussures', 12, 'img/tennis/maillots/tennis Giày adidas Tennis Court Spec 2 Nam JR7258.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(269, 'Tennis Wilson', 'Chaussures de tennis Wilson Rush Pro 3.0', 24000, 'tennis', 'chaussures', 9, 'img/tennis/maillots/Chaussure de tennis Wilson Rush Pro 3.0.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(270, 'Tennis Lacoste', 'Chaussures de tennis Lacoste noire', 13000, 'tennis', 'chaussures', 13, 'img/tennis/maillots/tennis lacoste noire.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(271, 'Tennis Asics', 'Chaussures de tennis Asics Gel Resolution ', 20000, 'tennis', 'chaussures', 8, 'img/tennis/maillots/Asics Outlet Chaussures Tennis Asics Gel Resolution Gel.webp', 1, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(272, 'Tennis Head', 'Chaussures de tennis Head Sprint Pro 3.5 Clay White-Black', 30000, 'tennis', 'chaussures', 6, 'img/tennis/maillots/e Head Sprint Pro 3.5 Clay White-Black.webp', 1, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(273, 'Accessoires poignet nike', 'Accessoires poignet nike blanc', 1500, 'tennis', 'accessoires', 30, 'img/tennis/maillots/brassard.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(274, 'Accessoires poignet nike', 'Accessoires poignet nike noir', 1500, 'tennis', 'accessoires', 30, 'img/tennis/maillots/poignets-eponge-nike-taille-simple-noir.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:18:55'),
(275, 'Accessoires poignet Adidas', 'Accessoires poignet Adidas noir', 2000, 'tennis', 'accessoires', 20, 'img/tennis/maillots/accessoire adidas noir.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(276, 'Bandeau nike', 'Bandeau Gris blanc', 1000, 'tennis', 'accessoires', 15, 'img/tennis/maillots/bandeau.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(277, 'Visière artengo', 'Visière Artengo blanche', 2500, 'tennis', 'accessoires', 12, 'img/tennis/maillots/visière artengo.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(278, 'Chapeau de tennis Nike', 'Chapeau de tennis Nike blanc', 7500, 'tennis', 'accessoires', 10, 'img/tennis/maillots/chapeau.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39'),
(279, 'Chapeau de tennis Lacoste', 'Chapeau de tennis Lacoste bleu', 5000, 'tennis', 'accessoires', 11, 'img/tennis/maillots/casquette lacoste.jpg', 0, '2025-11-12 03:12:39', '2025-11-12 03:12:39');

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id_order` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` int UNSIGNED NOT NULL,
  `status` enum('pending','processing','completed','cancelled') DEFAULT 'pending',
  `shipping_address` text,
  `shipping_city` varchar(100) DEFAULT NULL,
  `shipping_postal_code` varchar(20) DEFAULT NULL,
  `shipping_country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_order`),
  KEY `idx_user` (`id_user`),
  KEY `idx_status` (`status`),
  KEY `idx_order_date` (`order_date`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id_order`, `id_user`, `order_date`, `total_amount`, `status`, `shipping_address`, `shipping_city`, `shipping_postal_code`, `shipping_country`) VALUES
(2, 2, '2025-11-02 02:59:23', 60, 'pending', 'PK 10', 'Douala', '0000', 'Cameroun'),
(3, 3, '2025-11-02 03:57:40', 315, 'pending', 'PK 10', 'Douala', '0000', 'Cameroun'),
(4, 3, '2025-11-02 04:52:49', 200, 'pending', 'PK 10', 'Douala', '0000', 'Cameroun'),
(5, 3, '2025-11-02 05:18:06', 1600, 'pending', 'PK 10', 'Douala', '0000', 'Cameroun'),
(6, 3, '2025-11-02 05:18:43', 120000, 'pending', 'PK 10', 'Douala', '0000', 'Cameroun'),
(7, 3, '2025-11-02 06:21:48', 35, 'pending', 'Douala', 'douala', '0155', 'Cameroun'),
(8, 3, '2025-11-12 04:27:02', 55000, 'pending', 'Douala', 'douala', '455', 'Cameroun');

-- --------------------------------------------------------

--
-- Structure de la table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE IF NOT EXISTS `order_items` (
  `id_order_item` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  `id_article` int NOT NULL,
  `quantity` int NOT NULL,
  `price` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id_order_item`),
  KEY `idx_order` (`id_order`),
  KEY `idx_article` (`id_article`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `order_items`
--

INSERT INTO `order_items` (`id_order_item`, `id_order`, `id_article`, `quantity`, `price`) VALUES
(6, 3, 5, 1, 55),
(7, 3, 2, 2, 130),
(11, 6, 3, 8, 15000),
(12, 7, 30, 1, 35),
(13, 8, 5, 1, 15000),
(14, 8, 6, 1, 40000);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `email`, `password`, `first_name`, `last_name`, `phone`, `address`, `city`, `postal_code`, `country`, `created_at`, `updated_at`) VALUES
(2, 'vadyhilson@gmail.com', '$2y$10$nf5ih589/6o3kUEf6cs6YO6XIeDPgbRVyCCCi9Y/K68tajmOzOB2G', 'HILSON', 'Vady', NULL, NULL, NULL, NULL, NULL, '2025-11-01 02:52:04', '2025-11-01 02:52:04'),
(3, 'bikokjeanbernard@gmail.com', '$2y$10$02GsqcARUQija4Pmua71zOEzjMCoqL0LTaOJ9/Rgt4gqlZbevkIVi', 'Bernard', 'BIKOK', NULL, NULL, NULL, NULL, NULL, '2025-11-02 03:56:57', '2025-11-02 03:56:57');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id_article`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
