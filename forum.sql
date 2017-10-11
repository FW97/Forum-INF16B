-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               5.6.37-log - MySQL Community Server (GPL)
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Datenbank Struktur für forum
DROP DATABASE IF EXISTS `forum`;
CREATE DATABASE IF NOT EXISTS `forum` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `forum`;


-- Exportiere Struktur von Tabelle forum.attachment
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE IF NOT EXISTS `attachment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `attachmentfilename` varchar(50) DEFAULT NULL,
  `postingid` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `postingid` (`postingid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle forum.attachment: ~0 rows (ungefähr)
DELETE FROM `attachment`;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle forum.forum
DROP TABLE IF EXISTS `forum`;
CREATE TABLE IF NOT EXISTS `forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moderatorid` int(11) DEFAULT NULL,
  `name` text,
  `category` text,
  PRIMARY KEY (`id`),
  KEY `moderatorid` (`moderatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle forum.forum: ~0 rows (ungefähr)
DELETE FROM `forum`;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle forum.posting
DROP TABLE IF EXISTS `posting`;
CREATE TABLE IF NOT EXISTS `posting` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Text` text,
  `subjectid` int(11) DEFAULT NULL,
  `authorid` int(11) DEFAULT NULL,
  `whendeleted` date DEFAULT NULL,
  `whenposted` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `subjectid` (`subjectid`),
  KEY `authorid` (`authorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle forum.posting: ~0 rows (ungefähr)
DELETE FROM `posting`;
/*!40000 ALTER TABLE `posting` DISABLE KEYS */;
/*!40000 ALTER TABLE `posting` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle forum.subject
DROP TABLE IF EXISTS `subject`;
CREATE TABLE IF NOT EXISTS `subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `forumid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forumid` (`forumid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle forum.subject: ~0 rows (ungefähr)
DELETE FROM `subject`;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle forum.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` text,
  `lastname` text,
  `email` text,
  `pwsalt` text,
  `pwhash` text,
  `role` int(11) DEFAULT NULL,
  `imgurl` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle forum.user: ~0 rows (ungefähr)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
