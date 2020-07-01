-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 04 juin 2020 à 09:12
-- Version du serveur :  8.0.18
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `musée`
--

-- --------------------------------------------------------

--
-- Structure de la table `artiste`
--

DROP TABLE IF EXISTS `artiste`;
CREATE TABLE IF NOT EXISTS `artiste` (
  `numartiste` int(11) NOT NULL AUTO_INCREMENT,
  `nomartiste` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `prénom` varchar(255) NOT NULL,
  `dateNaissance` date NOT NULL,
  `dateDécès` date NOT NULL,
  `numnationalite` int(11) NOT NULL,
  `descriptionArtiste` longtext NOT NULL,
  PRIMARY KEY (`numartiste`),
  KEY `numnationalite` (`numnationalite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `auteur`
--

DROP TABLE IF EXISTS `auteur`;
CREATE TABLE IF NOT EXISTS `auteur` (
  `numoeuvre` int(11) NOT NULL,
  `numartiste` int(11) NOT NULL,
  KEY `numartiste` (`numartiste`),
  KEY `numoeuvre` (`numoeuvre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `courantartistique`
--

DROP TABLE IF EXISTS `courantartistique`;
CREATE TABLE IF NOT EXISTS `courantartistique` (
  `numcourant` int(11) NOT NULL AUTO_INCREMENT,
  `nomcourant` varchar(255) NOT NULL,
  `début` date NOT NULL,
  `fin` date NOT NULL,
  `descriptionCourant` text NOT NULL,
  PRIMARY KEY (`numcourant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `exemplaire`
--

DROP TABLE IF EXISTS `exemplaire`;
CREATE TABLE IF NOT EXISTS `exemplaire` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `numoeuvre` int(11) NOT NULL,
  `nummusee` int(11) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `nummusee` (`nummusee`),
  KEY `numoeuvre` (`numoeuvre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `matière`
--

DROP TABLE IF EXISTS `matière`;
CREATE TABLE IF NOT EXISTS `matière` (
  `nummat` int(11) NOT NULL AUTO_INCREMENT,
  `nommat` varchar(255) NOT NULL,
  PRIMARY KEY (`nummat`),
  UNIQUE KEY `nommat` (`nommat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `musée`
--

DROP TABLE IF EXISTS `musée`;
CREATE TABLE IF NOT EXISTS `musée` (
  `nummusee` int(11) NOT NULL AUTO_INCREMENT,
  `nommusee` varchar(255) NOT NULL,
  `numville` int(11) NOT NULL,
  PRIMARY KEY (`nummusee`),
  KEY `numville` (`numville`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `nationalité`
--

DROP TABLE IF EXISTS `nationalité`;
CREATE TABLE IF NOT EXISTS `nationalité` (
  `numnationalité` int(11) NOT NULL,
  `nomnationalité` varchar(255) NOT NULL,
  PRIMARY KEY (`numnationalité`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `oeuvre`
--

DROP TABLE IF EXISTS `oeuvre`;
CREATE TABLE IF NOT EXISTS `oeuvre` (
  `numoeuvre` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `année` date NOT NULL,
  `dimensions` float NOT NULL,
  `numtype` int(11) NOT NULL,
  `nummat` int(11) NOT NULL,
  `numcourant` int(11) NOT NULL,
  PRIMARY KEY (`numoeuvre`),
  KEY `numtype` (`numtype`),
  KEY `nummat` (`nummat`),
  KEY `numcourant` (`numcourant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `participe`
--

DROP TABLE IF EXISTS `participe`;
CREATE TABLE IF NOT EXISTS `participe` (
  `numcourant` int(11) NOT NULL,
  `numartiste` int(11) NOT NULL,
  KEY `numartiste` (`numartiste`),
  KEY `numcourant` (`numcourant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `numtype` int(11) NOT NULL AUTO_INCREMENT,
  `nomtype` varchar(255) NOT NULL,
  PRIMARY KEY (`numtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

DROP TABLE IF EXISTS `ville`;
CREATE TABLE IF NOT EXISTS `ville` (
  `numville` int(11) NOT NULL,
  `nomVille` varchar(255) NOT NULL,
  PRIMARY KEY (`numville`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `artiste`
--
ALTER TABLE `artiste`
  ADD CONSTRAINT `artiste_ibfk_1` FOREIGN KEY (`numnationalite`) REFERENCES `nationalité` (`numnationalité`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `auteur`
--
ALTER TABLE `auteur`
  ADD CONSTRAINT `auteur_ibfk_1` FOREIGN KEY (`numartiste`) REFERENCES `artiste` (`numartiste`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `auteur_ibfk_2` FOREIGN KEY (`numoeuvre`) REFERENCES `oeuvre` (`numoeuvre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `exemplaire`
--
ALTER TABLE `exemplaire`
  ADD CONSTRAINT `exemplaire_ibfk_1` FOREIGN KEY (`nummusee`) REFERENCES `musée` (`nummusee`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `exemplaire_ibfk_2` FOREIGN KEY (`numoeuvre`) REFERENCES `oeuvre` (`numoeuvre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `musée`
--
ALTER TABLE `musée`
  ADD CONSTRAINT `musée_ibfk_1` FOREIGN KEY (`numville`) REFERENCES `ville` (`numville`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `oeuvre`
--
ALTER TABLE `oeuvre`
  ADD CONSTRAINT `oeuvre_ibfk_1` FOREIGN KEY (`numtype`) REFERENCES `type` (`numtype`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `oeuvre_ibfk_2` FOREIGN KEY (`nummat`) REFERENCES `matière` (`nummat`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `oeuvre_ibfk_3` FOREIGN KEY (`numcourant`) REFERENCES `courantartistique` (`numcourant`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `participe`
--
ALTER TABLE `participe`
  ADD CONSTRAINT `participe_ibfk_1` FOREIGN KEY (`numartiste`) REFERENCES `artiste` (`numartiste`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `participe_ibfk_2` FOREIGN KEY (`numcourant`) REFERENCES `courantartistique` (`numcourant`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
