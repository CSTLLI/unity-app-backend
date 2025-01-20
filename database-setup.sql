-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 20 jan. 2025 à 15:51
-- Version du serveur : 11.7.1-MariaDB
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `unity_game_db`
--
CREATE DATABASE IF NOT EXISTS `unity_game_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci;
USE `unity_game_db`;

-- --------------------------------------------------------

--
-- Structure de la table `player_feedback`
--

DROP TABLE IF EXISTS `player_feedback`;
CREATE TABLE IF NOT EXISTS `player_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `player_feedback`
--

INSERT INTO `player_feedback` (`id`, `player_id`, `comment`, `created_at`) VALUES
(6, 1, 'tres cool ! ', '2025-01-20 14:14:53');

-- --------------------------------------------------------

--
-- Structure de la table `player_stats`
--

DROP TABLE IF EXISTS `player_stats`;
CREATE TABLE IF NOT EXISTS `player_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `games_played` int(11) DEFAULT 0,
  `wins` int(11) DEFAULT 0,
  `losses` int(11) DEFAULT 0,
  `score` int(11) DEFAULT 0,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `player_stats`
--

INSERT INTO `player_stats` (`id`, `player_id`, `games_played`, `wins`, `losses`, `score`, `updated_at`) VALUES
(6, 1, 5, 3, 2, 500, '2025-01-19 22:30:28'),
(7, 2, 0, 0, 0, 0, '2025-01-19 23:08:19'),
(8, 3, 12, 6, 6, 236, '2025-01-20 10:10:19'),
(9, 4, 11, 9, 1, 467, '2025-01-20 10:10:19'),
(10, 5, 2, 2, 0, 21, '2025-01-20 10:10:19'),
(11, 6, 40, 34, 6, 3567, '2025-01-20 10:10:19'),
(12, 7, 12, 1, 11, 689, '2025-01-20 10:10:19'),
(13, 8, 45, 34, 11, 4677, '2025-01-20 10:10:19'),
(14, 9, 0, 0, 0, 0, '2025-01-20 10:11:09'),
(15, 10, 0, 0, 0, 0, '2025-01-20 10:11:13'),
(16, 11, 0, 0, 0, 0, '2025-01-20 10:22:13');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`) VALUES
(1, 'cci', '$2b$10$19eUxGL63ZaIrz0I/rHa5emBXWsGgeMHYR.EAUFGB1o1ZoxkewX8e', '2025-01-19 22:29:40'),
(2, 'cci2', '$2b$10$Q1JPhoRvKs.xi6hmw/8vLO1LmCjyHRMjLumQx40NwcHF5cFIDfoKa', '2025-01-19 23:08:19'),
(3, 'cci3', '$2b$10$Y8c0NlUTpE4uacjuE9bfmO6iyN2Ti/C8jTKy6xGTly8qiCezt.zr2', '2025-01-20 10:08:21'),
(4, 'cci4', '$2b$10$ZwVvA8l2lgyplnfBoilTyOq9Z1rliRiU9OijYKgzDEB6UB6K6Br7S', '2025-01-20 10:08:25'),
(5, 'cci5', '$2b$10$0Cvu1VhnZ62DFyVcavCXS.hnekU9hXyge2VVziMq788k.H0GOhqyq', '2025-01-20 10:08:30'),
(6, 'cci6', '$2b$10$vvVes80pX8K9ONkX4bdSZeiLwDxJ87sC.S0yQW07O7BoqEZZU.Xxq', '2025-01-20 10:08:33'),
(7, 'cci7', '$2b$10$hKFujTrERK37xLurZbMVWOIadn75XEi.mtJcL6hc8rpORXRkp/.xO', '2025-01-20 10:08:36'),
(8, 'cci8', '$2b$10$3MikqUIhszKmbUaJMgmd9uwsjW6rBnkoLYV.v.K3qaART7SNRLS.C', '2025-01-20 10:08:40'),
(9, 'cci9', '$2b$10$MoZkAo5uqvi94iIEGccxku796PJAaHO0aPdM2NgGFH7V7pSCxKFt6', '2025-01-20 10:11:09'),
(10, 'cci10', '$2b$10$r7o.JKBmU8gn5tXx8QK2BeG1SadTwvbRKYQrXlv4Xd2ohuCMG4Pr2', '2025-01-20 10:11:13'),
(11, 'cci11', '$2b$10$oDMVCvOU04Y9NBfR.F16S.W9WCrMJ7PuUC..mKVUDbpnPjJ3Sy./a', '2025-01-20 10:22:13');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `player_feedback`
--
ALTER TABLE `player_feedback`
  ADD CONSTRAINT `player_feedback_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `player_stats`
--
ALTER TABLE `player_stats`
  ADD CONSTRAINT `player_stats_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
