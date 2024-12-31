-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: localhost    Database: reading_room
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book_contributor`
--

DROP TABLE IF EXISTS `book_contributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_contributor` (
  `book_contributor_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `contributor_id` int NOT NULL,
  `book_role_id` int NOT NULL,
  PRIMARY KEY (`book_contributor_id`),
  KEY `book_id` (`book_id`),
  KEY `contributor_id` (`contributor_id`),
  KEY `book_role_id` (`book_role_id`),
  CONSTRAINT `book_contributor_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `catalog` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_contributor_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `contributor` (`contributor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_contributor_ibfk_3` FOREIGN KEY (`book_role_id`) REFERENCES `book_role` (`book_role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_contributor`
--

LOCK TABLES `book_contributor` WRITE;
/*!40000 ALTER TABLE `book_contributor` DISABLE KEYS */;
INSERT INTO `book_contributor` VALUES (1,1,1,1),(2,2,2,1),(3,2,3,1),(4,3,4,2),(5,4,5,1),(6,5,6,1);
/*!40000 ALTER TABLE `book_contributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_language`
--

DROP TABLE IF EXISTS `book_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_language` (
  `book_language_id` int NOT NULL AUTO_INCREMENT,
  `language_id` int NOT NULL,
  `book_id` int NOT NULL,
  PRIMARY KEY (`book_language_id`),
  KEY `language_id` (`language_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `book_language_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_language_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `catalog` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_language`
--

LOCK TABLES `book_language` WRITE;
/*!40000 ALTER TABLE `book_language` DISABLE KEYS */;
INSERT INTO `book_language` VALUES (1,1,1),(2,1,2),(3,2,2),(4,1,3),(5,1,4),(6,1,5);
/*!40000 ALTER TABLE `book_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_role`
--

DROP TABLE IF EXISTS `book_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_role` (
  `book_role_id` int NOT NULL AUTO_INCREMENT,
  `book_role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`book_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_role`
--

LOCK TABLES `book_role` WRITE;
/*!40000 ALTER TABLE `book_role` DISABLE KEYS */;
INSERT INTO `book_role` VALUES (1,'author'),(2,'editor'),(3,'translator'),(4,'introduction'),(5,'curator');
/*!40000 ALTER TABLE `book_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_subject`
--

DROP TABLE IF EXISTS `book_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_subject` (
  `book_subject_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  PRIMARY KEY (`book_subject_id`),
  KEY `book_id` (`book_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `book_subject_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `catalog` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_subject_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_subject`
--

LOCK TABLES `book_subject` WRITE;
/*!40000 ALTER TABLE `book_subject` DISABLE KEYS */;
INSERT INTO `book_subject` VALUES (1,1,1),(2,1,2),(3,2,3),(4,2,4),(5,3,5),(6,3,6),(7,3,7),(8,4,7),(9,5,8);
/*!40000 ALTER TABLE `book_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog`
--

DROP TABLE IF EXISTS `catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalog` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `location_name` enum('Menking','Non-Menking') DEFAULT 'Menking',
  `dewey` varchar(50) NOT NULL,
  `publication_year` int DEFAULT NULL,
  `summary` varchar(10000) DEFAULT NULL,
  `format` varchar(500) DEFAULT NULL,
  `page_count` int DEFAULT NULL,
  `publisher` varchar(500) DEFAULT NULL,
  `book_status` enum('available','on_loan','on_hold','damaged','lost') DEFAULT 'available',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog`
--

LOCK TABLES `catalog` WRITE;
/*!40000 ALTER TABLE `catalog` DISABLE KEYS */;
INSERT INTO `catalog` VALUES (1,'The Book (The MIT Press Essential Knowledge series)','Menking','2',2018,'The book as object  as content  as idea  as interface.','Paperback',344,'The MIT Press','on_loan'),(2,'The Coming of the Book: The Impact of Printing  1450-1800','Menking','2',1984,'Books  and the printed word more generally  are aspects of modern life that are all too often taken for granted.','Paperback',378,'Verso Books','available'),(3,'4dspace: Interactive Architecture (Architectural Design)','Menking','6',2005,'In the next few years  emerging practices in interactive architecture are set to transform the built environment.','Paperback',128,'Wiley Academy Press','available'),(4,'Sources of Modern Architecture: A Critical Bibliography','Menking','16.7249',1981,'This unique guide to personalities and literature includes listings by architect  subject  and country plus an international periodical list.','Hardcover',192,'Eastview Editions','on_hold'),(5,'Edgar Huntly  Or  Memoirs of a Sleep-Walker (Penguin Classics)','Non-Menking','813.2',1988,'What would you do if everything you thought you knew about yourself turned out to be wrong?','Paperback',320,'Penguin Publishing Group','on_loan');
/*!40000 ALTER TABLE `catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clerk`
--

DROP TABLE IF EXISTS `clerk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clerk` (
  `clerk_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`clerk_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clerk`
--

LOCK TABLES `clerk` WRITE;
/*!40000 ALTER TABLE `clerk` DISABLE KEYS */;
INSERT INTO `clerk` VALUES (1,'Phil','Ochs','philochs@pratt.edu'),(2,'Dave Van','Ronk','dvronk@pratt.edu'),(3,'Woody','Guthrie','woodyguthrie@pratt.edu'),(4,'Jackson C.','Frank','jcfrank@pratt.edu'),(5,'Anne','Briggs','annebriggs@pratt.edu');
/*!40000 ALTER TABLE `clerk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clerk_to_catalog`
--

DROP TABLE IF EXISTS `clerk_to_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clerk_to_catalog` (
  `clerk_to_catalog_id` int NOT NULL AUTO_INCREMENT,
  `clerk_id` int NOT NULL,
  `book_id` int NOT NULL,
  `update_date` date NOT NULL,
  PRIMARY KEY (`clerk_to_catalog_id`),
  KEY `clerk_id` (`clerk_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `clerk_to_catalog_ibfk_1` FOREIGN KEY (`clerk_id`) REFERENCES `clerk` (`clerk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clerk_to_catalog_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `catalog` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clerk_to_catalog`
--

LOCK TABLES `clerk_to_catalog` WRITE;
/*!40000 ALTER TABLE `clerk_to_catalog` DISABLE KEYS */;
INSERT INTO `clerk_to_catalog` VALUES (1,5,1,'1999-12-25'),(2,5,2,'2023-12-25'),(3,5,3,'2002-12-25'),(4,3,4,'1999-12-24'),(5,5,4,'2001-12-24'),(6,1,5,'2024-12-15'),(7,1,4,'2024-12-15');
/*!40000 ALTER TABLE `clerk_to_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clerk_to_fee`
--

DROP TABLE IF EXISTS `clerk_to_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clerk_to_fee` (
  `clerk_to_fee_id` int NOT NULL AUTO_INCREMENT,
  `clerk_id` int DEFAULT NULL,
  `fee_id` int DEFAULT NULL,
  `clerk_to_fee_action` enum('pay off','bill') NOT NULL DEFAULT 'bill',
  PRIMARY KEY (`clerk_to_fee_id`),
  KEY `clerk_id` (`clerk_id`),
  KEY `fee_id` (`fee_id`),
  CONSTRAINT `clerk_to_fee_ibfk_1` FOREIGN KEY (`clerk_id`) REFERENCES `clerk` (`clerk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `clerk_to_fee_ibfk_2` FOREIGN KEY (`fee_id`) REFERENCES `fee` (`fee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clerk_to_fee`
--

LOCK TABLES `clerk_to_fee` WRITE;
/*!40000 ALTER TABLE `clerk_to_fee` DISABLE KEYS */;
INSERT INTO `clerk_to_fee` VALUES (2,5,2,'bill'),(3,4,3,'bill'),(4,5,3,'pay off'),(5,5,4,'pay off'),(6,5,5,'pay off');
/*!40000 ALTER TABLE `clerk_to_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contributor`
--

DROP TABLE IF EXISTS `contributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contributor` (
  `contributor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  PRIMARY KEY (`contributor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contributor`
--

LOCK TABLES `contributor` WRITE;
/*!40000 ALTER TABLE `contributor` DISABLE KEYS */;
INSERT INTO `contributor` VALUES (1,'Amaranth','Borsuk'),(2,'Lucien','Febvre'),(3,'Hendri-Jean','Martin'),(4,'Lucy','Bullivant'),(5,'Dennis','Sharp'),(6,'Charles Brockden','Brown');
/*!40000 ALTER TABLE `contributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee`
--

DROP TABLE IF EXISTS `fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fee` (
  `fee_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `payment_status` enum('paid','outstanding','processing') NOT NULL DEFAULT 'outstanding',
  `charge_date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`fee_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `fee_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fee`
--

LOCK TABLES `fee` WRITE;
/*!40000 ALTER TABLE `fee` DISABLE KEYS */;
INSERT INTO `fee` VALUES (2,2,'paid','2024-12-15',5.50),(3,3,'processing','2024-12-15',500.50),(4,4,'paid','2001-12-15',50.00),(5,5,'paid','2000-12-15',0.50);
/*!40000 ALTER TABLE `fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hold`
--

DROP TABLE IF EXISTS `hold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hold` (
  `hold_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `member_id` int NOT NULL,
  `clerk_id` int NOT NULL,
  `hold_placed_date` date NOT NULL,
  PRIMARY KEY (`hold_id`),
  KEY `book_id` (`book_id`),
  KEY `member_id` (`member_id`),
  KEY `clerk_id` (`clerk_id`),
  CONSTRAINT `hold_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `catalog` (`book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `hold_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `hold_ibfk_3` FOREIGN KEY (`clerk_id`) REFERENCES `clerk` (`clerk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hold`
--

LOCK TABLES `hold` WRITE;
/*!40000 ALTER TABLE `hold` DISABLE KEYS */;
INSERT INTO `hold` VALUES (1,1,3,1,'2001-11-15'),(2,1,4,1,'2001-10-15'),(3,3,3,1,'1999-12-25'),(4,2,4,1,'2024-10-15'),(5,1,4,1,'2024-12-15'),(6,4,5,3,'2024-12-15');
/*!40000 ALTER TABLE `hold` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language` (
  `language_id` int NOT NULL AUTO_INCREMENT,
  `language_name` varchar(50) NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'English'),(2,'Polish'),(3,'German'),(4,'French'),(5,'Spanish');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `languages_view`
--

DROP TABLE IF EXISTS `languages_view`;
/*!50001 DROP VIEW IF EXISTS `languages_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `languages_view` AS SELECT 
 1 AS `language`,
 1 AS `book_title`,
 1 AS `location_name`,
 1 AS `dewey`,
 1 AS `book_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `clerk_id` int NOT NULL,
  `loan_date` date NOT NULL,
  `due_date` date NOT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `member_id` (`member_id`),
  KEY `book_id` (`book_id`),
  KEY `clerk_id` (`clerk_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `catalog` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`clerk_id`) REFERENCES `clerk` (`clerk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `loan_chk_1` CHECK ((`due_date` > `loan_date`))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,1,1,1,'1999-12-14','2000-12-14'),(2,1,2,1,'1999-12-14','2000-12-14'),(3,2,3,2,'1999-12-14','2000-12-14'),(4,5,4,5,'1999-12-13','2000-12-14'),(5,5,5,5,'1999-12-13','2000-12-14'),(6,5,5,2,'2024-12-15','2025-01-14');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `clerk_id` int DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `date_registered` date NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `email` (`email`),
  KEY `clerk_id` (`clerk_id`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`clerk_id`) REFERENCES `clerk` (`clerk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,1,'Glen','Campbell','glencampbell@pratt.edu','1998-12-14'),(2,2,'Mickey','Newbury','mickeynbury@pratt.edu','1998-12-14'),(3,4,'Roy','Acuff','royacuff@pratt.edu','1998-12-14'),(4,3,'Merle','Haggard','mhaggard@pratt.edu','1998-12-14'),(5,3,'Marty','Robbins','mrobbins@pratt.edu','1998-12-14'),(6,4,'Waylon','Jennings','wjennings@pratt.edu','2024-12-15');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `member_fees`
--

DROP TABLE IF EXISTS `member_fees`;
/*!50001 DROP VIEW IF EXISTS `member_fees`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `member_fees` AS SELECT 
 1 AS `member_id`,
 1 AS `member_name`,
 1 AS `loan_id`,
 1 AS `fee_id`,
 1 AS `payment_status`,
 1 AS `charge_date`,
 1 AS `amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `subject_id` int NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (1,'literary criticism'),(2,'sociology'),(3,'17th century'),(4,'european history'),(5,'architecture'),(6,'urbanism'),(7,'design'),(8,'fiction');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `subjects_view`
--

DROP TABLE IF EXISTS `subjects_view`;
/*!50001 DROP VIEW IF EXISTS `subjects_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `subjects_view` AS SELECT 
 1 AS `subject`,
 1 AS `book_title`,
 1 AS `location_name`,
 1 AS `dewey`,
 1 AS `book_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `languages_view`
--

/*!50001 DROP VIEW IF EXISTS `languages_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `languages_view` AS select `l`.`language_name` AS `language`,`c`.`title` AS `book_title`,`c`.`location_name` AS `location_name`,`c`.`dewey` AS `dewey`,`c`.`book_status` AS `book_status` from ((`language` `l` join `book_language` `bl` on((`l`.`language_id` = `bl`.`language_id`))) join `catalog` `c` on((`bl`.`book_id` = `c`.`book_id`))) order by `l`.`language_name`,`c`.`title` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_fees`
--

/*!50001 DROP VIEW IF EXISTS `member_fees`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `member_fees` AS select `m`.`member_id` AS `member_id`,concat(`m`.`first_name`,' ',`m`.`last_name`) AS `member_name`,`l`.`loan_id` AS `loan_id`,`f`.`fee_id` AS `fee_id`,`f`.`payment_status` AS `payment_status`,`f`.`charge_date` AS `charge_date`,`f`.`amount` AS `amount` from ((`member` `m` join `loan` `l` on((`m`.`member_id` = `l`.`member_id`))) join `fee` `f` on((`l`.`loan_id` = `f`.`loan_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `subjects_view`
--

/*!50001 DROP VIEW IF EXISTS `subjects_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `subjects_view` AS select `s`.`subject_name` AS `subject`,`c`.`title` AS `book_title`,`c`.`location_name` AS `location_name`,`c`.`dewey` AS `dewey`,`c`.`book_status` AS `book_status` from ((`subject` `s` join `book_subject` `bs` on((`s`.`subject_id` = `bs`.`subject_id`))) join `catalog` `c` on((`bs`.`book_id` = `c`.`book_id`))) order by `s`.`subject_name`,`c`.`title` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-15 17:41:44
