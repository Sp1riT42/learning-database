-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: ivi
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Temporary view structure for view `all_video`
--

DROP TABLE IF EXISTS `all_video`;
/*!50001 DROP VIEW IF EXISTS `all_video`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_video` AS SELECT 
 1 AS `name`,
 1 AS `description`,
 1 AS `video_resolution`,
 1 AS `style_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `buy_type`
--

DROP TABLE IF EXISTS `buy_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buy_type` varchar(245) NOT NULL COMMENT 'Тип покупки видео (аренда или навсегда)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_type`
--

LOCK TABLES `buy_type` WRITE;
/*!40000 ALTER TABLE `buy_type` DISABLE KEYS */;
INSERT INTO `buy_type` VALUES (1,'buy forever'),(2,'rent');
/*!40000 ALTER TABLE `buy_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `count_video_by_style`
--

DROP TABLE IF EXISTS `count_video_by_style`;
/*!50001 DROP VIEW IF EXISTS `count_video_by_style`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `count_video_by_style` AS SELECT 
 1 AS `style_name`,
 1 AS `COUNT(*)`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discount` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` VALUES (1,5),(2,10),(3,15),(4,32),(5,99);
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) NOT NULL,
  `file` blob NOT NULL,
  `metadata` longtext,
  `size` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'logo_joker',_binary '/files/img/joker.jpg',NULL,3);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_video`
--

DROP TABLE IF EXISTS `price_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price_video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `video_id` int NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  `discount_id` int NOT NULL,
  `buy_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_price_video_video1_idx` (`video_id`),
  KEY `fk_price_video_discount1_idx` (`discount_id`),
  KEY `fk_price_video_buy_type1_idx` (`buy_type_id`),
  CONSTRAINT `fk_price_video_buy_type1` FOREIGN KEY (`buy_type_id`) REFERENCES `buy_type` (`id`),
  CONSTRAINT `fk_price_video_discount1` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`),
  CONSTRAINT `fk_price_video_video1` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_video`
--

LOCK TABLES `price_video` WRITE;
/*!40000 ALTER TABLE `price_video` DISABLE KEYS */;
INSERT INTO `price_video` VALUES (1,1,150,2,1),(2,1,100,2,2),(3,5,250,2,1),(4,8,550,2,1);
/*!40000 ALTER TABLE `price_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `video_id` int NOT NULL,
  `datatime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sale_users1_idx` (`user_id`),
  KEY `fk_sale_price_video1_idx` (`price_id`),
  KEY `fk_sale_video1_idx` (`video_id`),
  CONSTRAINT `fk_sale_price_video1` FOREIGN KEY (`price_id`) REFERENCES `price_video` (`id`),
  CONSTRAINT `fk_sale_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sale_video1` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `subscription_id` int NOT NULL,
  `datatime_start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_subscription_users1_idx` (`user_id`),
  KEY `fk_subscription_subsription_type1_idx` (`subscription_id`),
  CONSTRAINT `fk_subscription_subsription_type1` FOREIGN KEY (`subscription_id`) REFERENCES `subscription_type` (`id`),
  CONSTRAINT `fk_subscription_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,1,4,'2020-11-01 10:12:59'),(2,3,2,'2020-11-01 10:12:59'),(3,7,1,'2020-11-01 10:12:59'),(4,2,1,'2020-11-01 10:12:59'),(5,5,1,'2020-11-01 10:12:59');
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_type`
--

DROP TABLE IF EXISTS `subscription_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscription_name` varchar(245) NOT NULL,
  `duration` int NOT NULL COMMENT 'Количество месяцев от 1 до 12',
  `price` int NOT NULL,
  `discount_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `price_UNIQUE` (`price`),
  KEY `fk_subsription_type_discount1_idx` (`discount_id`),
  CONSTRAINT `fk_subsription_type_discount1` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_type`
--

LOCK TABLES `subscription_type` WRITE;
/*!40000 ALTER TABLE `subscription_type` DISABLE KEYS */;
INSERT INTO `subscription_type` VALUES (1,'1 месяц',1,399,5),(2,'3 месяца',3,1197,2),(3,'6 месяцев',6,2394,3),(4,'12 месяцев',1,4788,4);
/*!40000 ALTER TABLE `subscription_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!50001 DROP VIEW IF EXISTS `subscriptions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `subscriptions` AS SELECT 
 1 AS `subscription_name`,
 1 AS `price`,
 1 AS `discount_percent`,
 1 AS `count(*)`,
 1 AS `sum_including_discount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(245) NOT NULL,
  `lastname` varchar(245) NOT NULL,
  `password_hash` char(64) NOT NULL,
  `phone` bigint DEFAULT NULL,
  `email` varchar(245) NOT NULL,
  `cash` decimal(10,2) unsigned DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Евгений','Похунов','a9089181a1d38a0e7e5e7f4cd6e1bfaa07094f30',89567299469,'pohunov@gmail.com',13300.50),(2,'Tyrese','Mitchell','a9ef61530760bf652987b3f4f227bc59a38f50ba',89431296060,'beatty.helena@example.org',1800.50),(3,'Ahmad','Lynch','53a836961a2f329a195f79c8b34140493da8581b',89484536278,'zoie.schmeler@example.net',9100.50),(4,'Roslyn','Kessler','15f7cbb831b21c8f015a8113bdf0983811e7702d',89392964888,'arianna.schuppe@example.com',1060.00),(5,'Rylan','Herzog','1169c0c8cddc2cb8eb11105c6514c626812171eb',89145571279,'eulah74@example.com',12300.70),(6,'Mustafa','Kozey','d039c0250f35df876c7e82c7a4f5bf2b8fc287d8',89456430353,'kristy.vonrueden@example.com',10.99),(7,'Tianna','Hettinger','8840d27b2dae2e06f8c177fd375b529d1a2781dd',89814196965,'agnes46@example.com',14350.00),(8,'Nora','VonRueden','574de00729c64e1ee518d98b4b8016559c664c93',89790840524,'urban.botsford@example.net',900.50),(9,'Reina','Weimann','8cc94e403e35f8605b2abbffec3cfe225616ff8b',89629350004,'wiegand.margarett@example.com',999.99),(10,'April','Reynolds','d95a0de366d5d865f436b06537595010bf1a260a',89689764719,'yhegmann@example.org',100000.00);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_BEFORE_INSERT` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
set new.`password_hash` = sha1(new.`password_hash`);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_id` int NOT NULL,
  `style_id` int NOT NULL,
  `name` varchar(245) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `fk_video_video_file_idx` (`file_id`),
  KEY `fk_video_video_style_idx` (`style_id`),
  CONSTRAINT `fk_video_video_file` FOREIGN KEY (`file_id`) REFERENCES `video_file` (`id`),
  CONSTRAINT `fk_video_video_style` FOREIGN KEY (`style_id`) REFERENCES `video_style` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video`
--

LOCK TABLES `video` WRITE;
/*!40000 ALTER TABLE `video` DISABLE KEYS */;
INSERT INTO `video` VALUES (1,1,2,'Джокер','История становления знаменитого злодея из Готэма. Неудачливый клоун Артур Флек однажды перестает бороться со своим безумием и жестоко смеется над всем ненавистным городом. Лауреат премии «Оскар» Хоакин Феникс исполнил одну из лучших ролей в своей карьере в долгожданном фильме-событии «Джокер» режиссера Тодда Филлипса. На Венецианском фестивале-2019 фильм получил главный приз «Золотой лев».Артур Флек – один из миллионов жителей мрачных трущоб Готэм-сити. Он работает уличным клоуном, наблюдается у врача-психиатра и, сколько себя помнит, заботится о своей болезненной матери. Несмотря на нестабильную психику и негативные мысли, у него самая безобидная мечта – стать известным стендап-комиком. Мама уверяла Артура, будто он рожден нести радость людям. По вечерам они вместе сморят веселую передачу Мюррея Франклина и привычно спорят из-за кандидата в мэры Томаса Уэйна. Артур – один из миллионов. Его никто не замечает, и поэтому никто не может предположить, что он – спящий вулкан Готэма. Стоит ему дать волю своим демонам, и весь город вспыхнет, как спичка. Тогда нервный неконтролируемый смех клоуна-неудачника Артура Флека сменится искренним, пробирающим хохотом злодея Джокера.'),(2,2,2,'Джокер','История становления знаменитого злодея из Готэма. Неудачливый клоун Артур Флек однажды перестает бороться со своим безумием и жестоко смеется над всем ненавистным городом. Лауреат премии «Оскар» Хоакин Феникс исполнил одну из лучших ролей в своей карьере в долгожданном фильме-событии «Джокер» режиссера Тодда Филлипса. На Венецианском фестивале-2019 фильм получил главный приз «Золотой лев».Артур Флек – один из миллионов жителей мрачных трущоб Готэм-сити. Он работает уличным клоуном, наблюдается у врача-психиатра и, сколько себя помнит, заботится о своей болезненной матери. Несмотря на нестабильную психику и негативные мысли, у него самая безобидная мечта – стать известным стендап-комиком. Мама уверяла Артура, будто он рожден нести радость людям. По вечерам они вместе сморят веселую передачу Мюррея Франклина и привычно спорят из-за кандидата в мэры Томаса Уэйна. Артур – один из миллионов. Его никто не замечает, и поэтому никто не может предположить, что он – спящий вулкан Готэма. Стоит ему дать волю своим демонам, и весь город вспыхнет, как спичка. Тогда нервный неконтролируемый смех клоуна-неудачника Артура Флека сменится искренним, пробирающим хохотом злодея Джокера.'),(3,3,2,'Джокер','История становления знаменитого злодея из Готэма. Неудачливый клоун Артур Флек однажды перестает бороться со своим безумием и жестоко смеется над всем ненавистным городом. Лауреат премии «Оскар» Хоакин Феникс исполнил одну из лучших ролей в своей карьере в долгожданном фильме-событии «Джокер» режиссера Тодда Филлипса. На Венецианском фестивале-2019 фильм получил главный приз «Золотой лев».Артур Флек – один из миллионов жителей мрачных трущоб Готэм-сити. Он работает уличным клоуном, наблюдается у врача-психиатра и, сколько себя помнит, заботится о своей болезненной матери. Несмотря на нестабильную психику и негативные мысли, у него самая безобидная мечта – стать известным стендап-комиком. Мама уверяла Артура, будто он рожден нести радость людям. По вечерам они вместе сморят веселую передачу Мюррея Франклина и привычно спорят из-за кандидата в мэры Томаса Уэйна. Артур – один из миллионов. Его никто не замечает, и поэтому никто не может предположить, что он – спящий вулкан Готэма. Стоит ему дать волю своим демонам, и весь город вспыхнет, как спичка. Тогда нервный неконтролируемый смех клоуна-неудачника Артура Флека сменится искренним, пробирающим хохотом злодея Джокера.'),(4,4,2,'Джокер','История становления знаменитого злодея из Готэма. Неудачливый клоун Артур Флек однажды перестает бороться со своим безумием и жестоко смеется над всем ненавистным городом. Лауреат премии «Оскар» Хоакин Феникс исполнил одну из лучших ролей в своей карьере в долгожданном фильме-событии «Джокер» режиссера Тодда Филлипса. На Венецианском фестивале-2019 фильм получил главный приз «Золотой лев».Артур Флек – один из миллионов жителей мрачных трущоб Готэм-сити. Он работает уличным клоуном, наблюдается у врача-психиатра и, сколько себя помнит, заботится о своей болезненной матери. Несмотря на нестабильную психику и негативные мысли, у него самая безобидная мечта – стать известным стендап-комиком. Мама уверяла Артура, будто он рожден нести радость людям. По вечерам они вместе сморят веселую передачу Мюррея Франклина и привычно спорят из-за кандидата в мэры Томаса Уэйна. Артур – один из миллионов. Его никто не замечает, и поэтому никто не может предположить, что он – спящий вулкан Готэма. Стоит ему дать волю своим демонам, и весь город вспыхнет, как спичка. Тогда нервный неконтролируемый смех клоуна-неудачника Артура Флека сменится искренним, пробирающим хохотом злодея Джокера.'),(5,5,4,'Матрица','Невероятный фантастический боевик, в котором суперкинематографическое семейство Вачовски наконец-то рассказало нам, как мы живем на самом деле. Итак, способен ли ты выбрать красную таблетку, можно узнать, если посмотреть «Матрицу» онлайн. Эта картина не так проста, как кажется. Тут и вечные библейские аллюзии, и идеи Уильяма Гибсона и Артура Кларка, и индийский эпос, круто перемешанные с японскими комиксами манга и боевиками Джона Ву. Конечно, смесь получилась взрывоопасной и интересной. Первая часть знаменитой трилогии повлияла на все современное кино, литературу и видеоигры. Да и на мировоззрение западного горожанина тоже. Однажды простой хакер Нео вдруг узнает, что весь мир вокруг него – иллюзия, матрица, которой управляют машины. Все это нужно новым хозяевам жизни, чтобы просто качать из человечества энергию. Но еще существует Сопротивление – личности, живущие вне матрицы и борющиеся за то, чтобы человеческий род вернул себе свое гордое имя, а люди перестали быть просто батарейками. И Нео – Избранный, тот самый, кто способен вернуть человечеству свободу.'),(6,6,4,'Матрица','Невероятный фантастический боевик, в котором суперкинематографическое семейство Вачовски наконец-то рассказало нам, как мы живем на самом деле. Итак, способен ли ты выбрать красную таблетку, можно узнать, если посмотреть «Матрицу» онлайн. Эта картина не так проста, как кажется. Тут и вечные библейские аллюзии, и идеи Уильяма Гибсона и Артура Кларка, и индийский эпос, круто перемешанные с японскими комиксами манга и боевиками Джона Ву. Конечно, смесь получилась взрывоопасной и интересной. Первая часть знаменитой трилогии повлияла на все современное кино, литературу и видеоигры. Да и на мировоззрение западного горожанина тоже. Однажды простой хакер Нео вдруг узнает, что весь мир вокруг него – иллюзия, матрица, которой управляют машины. Все это нужно новым хозяевам жизни, чтобы просто качать из человечества энергию. Но еще существует Сопротивление – личности, живущие вне матрицы и борющиеся за то, чтобы человеческий род вернул себе свое гордое имя, а люди перестали быть просто батарейками. И Нео – Избранный, тот самый, кто способен вернуть человечеству свободу.'),(7,7,5,'Бегущий по лезвию 2049','Атмосферный апокалиптический сиквел знаменитой фантастической ленты Ридли Скотта 80-х годов снял режиссер Дени Вильнев («Убийца», «Прибытие», «Враг»). В главных ролях снялись Райан Гослинг и Харрисон Форд, который играл Рика Декарда в оригинальном фильме Скотта. Тридцать лет прошло с тех пор, как охотник за беглыми репликантами Рик Декард покинул Лос-Анджелес. За это время экологический кризис на планете усугубился. Солнца не видно из-за туч, дикая природа полностью уничтожена, человечество питается генетически модифицированной едой. Корпорация Wallace, ответственная за ГМО, выпускает новое поколение репликантов – более сильных, чем их предшественники производства компании Tyrell. Образцы Wallace пользуются огромным доверием, и некоторые из них даже служат в полиции. Однажды офицер-репликант Кей находит у уничтоженного репликанта старого образца некий ящик. Когда его содержимое анализируют, полиция начинает расследование, которое может изменить всю мировую историю. Смотреть онлайн ленту «Бегущий по лезвию 2049» можно на нашем сайте.'),(8,8,5,'Бегущий по лезвию 2049','Атмосферный апокалиптический сиквел знаменитой фантастической ленты Ридли Скотта 80-х годов снял режиссер Дени Вильнев («Убийца», «Прибытие», «Враг»). В главных ролях снялись Райан Гослинг и Харрисон Форд, который играл Рика Декарда в оригинальном фильме Скотта. Тридцать лет прошло с тех пор, как охотник за беглыми репликантами Рик Декард покинул Лос-Анджелес. За это время экологический кризис на планете усугубился. Солнца не видно из-за туч, дикая природа полностью уничтожена, человечество питается генетически модифицированной едой. Корпорация Wallace, ответственная за ГМО, выпускает новое поколение репликантов – более сильных, чем их предшественники производства компании Tyrell. Образцы Wallace пользуются огромным доверием, и некоторые из них даже служат в полиции. Однажды офицер-репликант Кей находит у уничтоженного репликанта старого образца некий ящик. Когда его содержимое анализируют, полиция начинает расследование, которое может изменить всю мировую историю. Смотреть онлайн ленту «Бегущий по лезвию 2049» можно на нашем сайте.');
/*!40000 ALTER TABLE `video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_file`
--

DROP TABLE IF EXISTS `video_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resolution_id` int NOT NULL,
  `file` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_video_file_video_resolution_idx` (`resolution_id`),
  CONSTRAINT `fk_video_file_video_resolution` FOREIGN KEY (`resolution_id`) REFERENCES `video_resolution` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_file`
--

LOCK TABLES `video_file` WRITE;
/*!40000 ALTER TABLE `video_file` DISABLE KEYS */;
INSERT INTO `video_file` VALUES (1,1,_binary '/files/video/joker_sd.mp4'),(2,2,_binary '/files/video/joker_720p.mp4'),(3,3,_binary '/files/video/joker_1080p.mp4'),(4,4,_binary '/files/video/joker_4k.mp4'),(5,1,_binary '/files/video/the_matrix_sd.mp4'),(6,3,_binary '/files/video/the_matrix_1080p.mp4'),(7,3,_binary '/files/video/Blade_Runner_2049_1080p.mp4'),(8,4,_binary '/files/video/Blade_Runner_2049_4k.mp4');
/*!40000 ALTER TABLE `video_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_resolution`
--

DROP TABLE IF EXISTS `video_resolution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_resolution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `video_resolution` varchar(245) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_resolution`
--

LOCK TABLES `video_resolution` WRITE;
/*!40000 ALTER TABLE `video_resolution` DISABLE KEYS */;
INSERT INTO `video_resolution` VALUES (1,'SD'),(2,'720p'),(3,'1080p'),(4,'4k');
/*!40000 ALTER TABLE `video_resolution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_style`
--

DROP TABLE IF EXISTS `video_style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_style` (
  `id` int NOT NULL AUTO_INCREMENT,
  `style_name` varchar(245) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_style`
--

LOCK TABLES `video_style` WRITE;
/*!40000 ALTER TABLE `video_style` DISABLE KEYS */;
INSERT INTO `video_style` VALUES (1,'Комедия'),(2,'Драмма'),(3,'Мелодрамма'),(4,'Боевики'),(5,'Триллеры'),(6,'Приключения'),(7,'Зарубежные'),(8,'Мистические'),(9,'Ужасы'),(10,'Исторические');
/*!40000 ALTER TABLE `video_style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ivi'
--

--
-- Dumping routines for database 'ivi'
--
/*!50003 DROP FUNCTION IF EXISTS `percent_subscription` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `percent_subscription`(pr decimal, disc int) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
 return pr *((100 - disc) / 100);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sum_all_subsciption` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sum_all_subsciption`()
BEGIN
 select sum(subscription_type.price) as sum_price_subscription, sum(percent_subscription(subscription_type.price, discount.discount)) as sum_including_discount from ivi.subscription 
join ivi.subscription_type on subscription_type.id = subscription.subscription_id
join ivi.discount on subscription_type.discount_id = discount.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `all_video`
--

/*!50001 DROP VIEW IF EXISTS `all_video`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_video` AS select `video`.`name` AS `name`,`video`.`description` AS `description`,`video_resolution`.`video_resolution` AS `video_resolution`,`video_style`.`style_name` AS `style_name` from (((`video` join `video_file` on((`video_file`.`id` = `video`.`file_id`))) join `video_resolution` on((`video_resolution`.`id` = `video_file`.`resolution_id`))) join `video_style` on((`video_style`.`id` = `video`.`style_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `count_video_by_style`
--

/*!50001 DROP VIEW IF EXISTS `count_video_by_style`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `count_video_by_style` AS select `video_style`.`style_name` AS `style_name`,count(0) AS `COUNT(*)` from ((`video` join `video_file` on((`video_file`.`id` = `video`.`file_id`))) join `video_style` on((`video_style`.`id` = `video`.`style_id`))) group by `video_style`.`style_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `subscriptions`
--

/*!50001 DROP VIEW IF EXISTS `subscriptions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `subscriptions` AS select `subscription_type`.`subscription_name` AS `subscription_name`,`subscription_type`.`price` AS `price`,`discount`.`discount` AS `discount_percent`,count(0) AS `count(*)`,sum(`percent_subscription`(`subscription_type`.`price`,`discount`.`discount`)) AS `sum_including_discount` from ((`subscription` join `subscription_type` on((`subscription_type`.`id` = `subscription`.`subscription_id`))) join `discount` on((`subscription_type`.`discount_id` = `discount`.`id`))) group by `subscription`.`subscription_id` */;
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

-- Dump completed on 2020-11-01 17:12:19
