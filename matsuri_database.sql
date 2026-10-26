CREATE DATABASE  IF NOT EXISTS `matsuri` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `matsuri`;
-- MySQL dump 10.13  Distrib 9.5.0, for Win64 (x86_64)
--
-- Host: localhost    Database: matsuri
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (12,'BEERS, SAKE & NO-ALC'),(9,'FROM THE GRILL'),(2,'HIGHBALLS & COCKTAILS'),(8,'HOME COMFORTS'),(1,'LITTLE BEGINNINGS'),(10,'ON THE SIDE'),(7,'STREET-STALL FAVORITES'),(11,'SWEET FINISHES');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish_ingredients`
--

DROP TABLE IF EXISTS `dish_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish_ingredients` (
  `dish_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  PRIMARY KEY (`dish_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `dish_ingredients_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`),
  CONSTRAINT `dish_ingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish_ingredients`
--

LOCK TABLES `dish_ingredients` WRITE;
/*!40000 ALTER TABLE `dish_ingredients` DISABLE KEYS */;
INSERT INTO `dish_ingredients` VALUES (25,1),(26,2),(26,3),(39,4),(4,5),(4,6),(5,7),(6,9),(6,10),(7,11),(8,12),(8,13),(8,14),(24,14),(29,14),(8,15),(25,15),(48,15),(13,16),(9,17),(13,17),(31,17),(32,17),(13,18),(17,18),(18,18),(37,18),(14,19),(14,20),(14,21),(17,21),(18,21),(14,22),(15,23),(15,24),(16,25),(16,26),(20,26),(38,26),(16,27),(17,28),(18,28),(17,29),(28,29),(17,30),(18,30),(18,31),(27,33),(28,34),(29,36),(30,37),(5,38),(24,38),(30,38),(30,39),(31,40),(31,41),(31,42),(32,43),(33,44),(33,45),(33,46),(34,47),(34,48),(22,49),(34,49),(35,50),(27,51),(35,51),(41,51),(35,52),(13,53),(19,53),(21,53),(27,53),(19,54),(19,55),(20,55),(21,55),(22,55),(23,55),(24,55),(26,55),(19,56),(23,56),(20,57),(21,57),(23,57),(20,58),(23,58),(20,59),(23,59),(21,60),(21,61),(24,61),(22,62),(26,62),(29,62),(22,63),(23,63),(22,64),(26,64),(24,65),(24,66),(25,67),(26,68),(39,69),(26,70),(40,71),(40,72),(41,73),(42,74),(42,75),(43,75),(42,76),(43,76),(43,77),(43,78),(44,79),(36,80),(37,81),(38,82),(38,83),(9,84),(9,85),(11,85),(48,85),(10,86),(48,86),(10,87),(10,88),(10,89),(11,90),(11,91),(12,92),(12,93),(12,94),(45,95),(46,96),(47,97),(47,98),(47,99),(39,102),(5,103);
/*!40000 ALTER TABLE `dish_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dishes` (
  `dish_id` int NOT NULL AUTO_INCREMENT,
  `dish_name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`dish_id`),
  KEY `fk_dishes_category` (`category_id`),
  CONSTRAINT `fk_dishes_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dishes`
--

LOCK TABLES `dishes` WRITE;
/*!40000 ALTER TABLE `dishes` DISABLE KEYS */;
INSERT INTO `dishes` VALUES (4,'Edamame','Steamed soybeans, flaky sea salt.',6.00,NULL,1),(5,'Smacked Cucumber','Sesame, rice vinegar, a little chili.',7.00,NULL,1),(6,'Shichimi Padron Peppers','Blistered peppers, seven-spice salt.',9.00,NULL,1),(7,'Japanese Pickles','Our changing selection of house-made tsukemono.',6.00,NULL,1),(8,'Tuna Tataki','Lightly seared tuna, ponzu, scallions, grated ginger. Served rare.',18.00,NULL,1),(9,'Toki highball','Suntory Toki whisky, soda, lemon.',14.00,NULL,2),(10,'Yuzu margarita','Tequila, yuzu, agave, shichimi salt.',16.00,NULL,2),(11,'Umeshu spritz','Japanese plum wine, sparkling wine, soda.',14.00,NULL,2),(12,'Tokyo negroni','Roku gin, vermouth, Campari.',16.00,NULL,2),(13,'Chicken Karaage','Ginger-soy marinade, lemon, kewpie mayo.',12.00,NULL,7),(14,'Takoyaki','Octopus batter bites, takoyaki sauce, bonito flakes, aonori.',10.00,NULL,7),(15,'Pork Gyoza','Pan-fried dumplings, chili ponzu.',9.00,NULL,7),(16,'Mushroom Gyoza','Shiitake, cabbage, ginger-soy dip.',9.00,NULL,7),(17,'Pork Okonomiyaki','Savory cabbage pancake, pork belly, okonomiyaki sauce, kewpie mayo, bonito flakes.',17.00,NULL,7),(18,'Seafood Okonomiyaki','Savory cabbage pancake, shrimp and squid, okonomiyaki sauce, kewpie mayo, bonito flakes.',20.00,NULL,7),(19,'Omurice','Chicken ketchup fried rice tucked beneath a soft omelet.',18.00,NULL,8),(20,'Tonkatsu','Panko-crusted pork cutlet, shredded cabbage, rice, tonkatsu sauce.',18.00,NULL,8),(21,'Chicken katsu curry','Panko chicken, Japanese curry, rice, pickles.',20.00,NULL,8),(22,'Gyudon','Thinly sliced beef and onions simmered in sweet soy broth over rice, pickled ginger.',17.00,NULL,8),(23,'Katsudon','Panko-crusted pork cutlet, onion reduction, scrambled egg, tonkatsu sauce, rice.',18.00,NULL,8),(24,'Miso Eggplant Don','Miso-glazed eggplant over rice, sesame, scallions, pickles.',16.00,NULL,8),(25,'Yakisoba','Wok-fried noodles, vegetables, ginger. Add chicken +3.',16.00,NULL,8),(26,'Sukiyaki','Hot pot with beef, tofu, napa cabbage, mushrooms, and shirataki in sweet soy broth. Rice alongside.',28.00,NULL,8),(27,'Chicken Thigh Yakitori','Sweet soy glaze, spring onion.',9.00,NULL,9),(28,'Pork Belly Kushiyaki','Grilled pork belly, Japanese mustard, charred edges.',11.00,NULL,9),(29,'Beef Negima','Beef and scallion skewers, savory tare glaze.',13.00,NULL,9),(30,'King Oyster Mushroom Skewers','Miso glaze, sesame, chives.',9.00,NULL,9),(31,'Shrimp Skewers','Jumbo tiger shrimp, yuzu butter, lemon, shichimi.',13.00,NULL,9),(32,'Shishamo','Grilled whole smelt, lemon. Eaten whole.',10.00,NULL,9),(33,'Ikayaki','Grilled squid, ginger-soy glaze, Japanese mayo.',17.00,NULL,9),(34,'Grilled Sablefish','Grilled black cod, sweet miso marinade, pickled ginger.',24.00,NULL,9),(35,'Unagi Kabayaki','Grilled freshwater eel, sweet soy glaze, sansho pepper.',25.00,NULL,9),(36,'Steamed Japanese rice','Perfectly fluffy, short-grain rice.',3.00,NULL,10),(37,'Furikake fries','Nori seasoning, kewpie on the side.',7.00,NULL,10),(38,'Sesame slaw','Cabbage, carrot, toasted sesame dressing.',5.00,NULL,10),(39,'Miso soup','White miso, wakame, silken tofu.',4.00,NULL,10),(40,'Taiyaki','Warm fish-shaped cake filled with sweet red bean or vanilla custard.',6.00,NULL,11),(41,'Mitarashi Dango','Chewy rice flour dumplings, lightly grilled, sweet soy glaze.',7.00,NULL,11),(42,'Strawberry Cream Crepe','Japanese-style folded crepe, strawberries, whipped cream.',11.00,NULL,11),(43,'Chocolate Banana Crepe','Japanese-style folded crepe, banana, chocolate sauce, whipped cream.',11.00,NULL,11),(44,'Mochi Ice Cream','Ask about today\'s flavors.',7.00,NULL,11),(45,'Asahi Super Dry','Crisp, clean Japanese draft lager. Pint.',9.00,NULL,12),(46,'Junmai sake','Soft rice notes, dry finish. 4 oz serving. Warm or chilled.',11.00,NULL,12),(47,'House wine','White, red or rosé. 6 oz glass.',11.00,NULL,12),(48,'Yuzu & ginger fizz','Yuzu, fresh ginger, soda. Non-alcoholic.',7.00,NULL,12);
/*!40000 ALTER TABLE `dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `ingredient_id` int NOT NULL AUTO_INCREMENT,
  `ingredient_name` varchar(100) NOT NULL,
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'noodles'),(2,'tofu'),(3,'mushrooms'),(4,'wakame'),(5,'soybeans'),(6,'sea salt'),(7,'rice vinegar'),(8,'sesame chilli'),(9,'peppers'),(10,'seven-spice salt'),(11,'tsukemono'),(12,'seared tuna'),(13,'ponzu'),(14,'scallions'),(15,'ginger'),(16,'ginger-soy'),(17,'lemon'),(18,'kewpie mayo'),(19,'octupus batter bites'),(20,'takoyaki sauce'),(21,'bonito flakes'),(22,'aonori'),(23,'dumplings'),(24,'chilli ponzu'),(25,'shiitake'),(26,'cabbage'),(27,'ginger-soy dip'),(28,'cabbage pancake'),(29,'pork belly'),(30,'okonomiyaki sauce'),(31,'shrimp and squid'),(32,'soy glaze'),(33,'spring onion'),(34,'Japanese mustard'),(35,'beef and scallion'),(36,'tare glaze'),(37,'miso glaze'),(38,'sesame'),(39,'chives'),(40,'jumbo tiger shrimp'),(41,'yuzu butter'),(42,'shichimi'),(43,'smelt'),(44,'squid'),(45,'ginger-soy glaze'),(46,'Japanese mayo'),(47,'black cod'),(48,'sweet miso marinade'),(49,'pickled ginger'),(50,'freshwater eel'),(51,'sweet soy glaze'),(52,'sansho pepper'),(53,'chicken'),(54,'ketchup'),(55,'rice'),(56,'egg'),(57,'panko breadcrumbs'),(58,'pork cutlet'),(59,'tonkatsu sauce'),(60,'Japanese curry'),(61,'pickles'),(62,'beef'),(63,'onions'),(64,'soy sauce'),(65,'miso'),(66,'eggplant'),(67,'vegetables'),(68,'napa cabbage'),(69,'silken tofu'),(70,'shirataki'),(71,'sweet red bean'),(72,'vanilla custard'),(73,'rice flour'),(74,'strawberries'),(75,'whipped cream'),(76,'crepe'),(77,'banana'),(78,'chocolate sauce'),(79,'mochi ice cream'),(80,'short-grain rice'),(81,'nori seasoning'),(82,'carrot'),(83,'toasted sesame dressing'),(84,'suntory toki whisky'),(85,'soda'),(86,'yuzu'),(87,'tequila'),(88,'agave'),(89,'shichimi salt'),(90,'Japanese plum wine'),(91,'sparkling wine'),(92,'roku gin'),(93,'vermouth'),(94,'campari'),(95,'asahi super dry'),(96,'junmai sake'),(97,'white wine'),(98,'red wine'),(99,'rosé wine'),(100,'fresh ginger'),(101,'asahi 0.0%'),(102,'white miso'),(103,'chili');
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-25 23:58:42
