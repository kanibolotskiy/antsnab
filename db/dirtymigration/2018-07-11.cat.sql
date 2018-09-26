-- MySQL dump 10.13  Distrib 5.6.37, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: antsnab
-- ------------------------------------------------------
-- Server version	5.6.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category_prodproperty`
--

DROP TABLE IF EXISTS `category_prodproperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_prodproperty` (
  `category_prodproperty_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `name` varchar(1000) NOT NULL,
  `unit` varchar(10) NOT NULL DEFAULT '',
  `default` varchar(1000) NOT NULL DEFAULT '',
  `type_id` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `showInProdPreview` tinyint(1) DEFAULT '0',
  `showInSummary` tinyint(1) DEFAULT '0',
  `showInProdTab` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_prodproperty_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_prodproperty`
--

LOCK TABLES `category_prodproperty` WRITE;
/*!40000 ALTER TABLE `category_prodproperty` DISABLE KEYS */;
INSERT INTO `category_prodproperty` VALUES (1,63,'Масса 1 м2, не менее','кг','5,0',2,0,1,0,0),(2,63,'В десяточкуюююю','12кг/м2','102',1,0,1,0,3),(12,63,'Свойство A','ед.','Его значение',1,0,1,0,0),(13,63,'Свойство B','ед.','его значение 2',1,0,1,0,10),(14,63,'asdf','asdf','asfd',1,1,1,0,0),(15,27,'Удалить потом','св. лет','100500',1,0,1,0,0),(16,65,'Основа','','Стеклоткань',1,1,0,0,0),(17,65,'Верхнее покрытие','','Сланец серый',1,1,0,0,1),(18,65,'Упаковка','','рулон',1,1,0,0,2),(19,65,'В упаковке','','10 м2',1,1,0,0,3),(20,65,'Масса 1 м2, не менее','кг','5,0',1,0,1,0,0),(21,65,'Масса вяжущего с наплавляемой стороны, не менее','кг/м2','2,0',1,0,1,0,1),(22,65,'Гибкость на брусе R=10 мм, на лицевой поверхности образца не должно быть трещин, при температуре не выше','оС','-25',1,0,1,0,2),(23,65,'Температура хрупкости вяжущего, не выше','оС','-35',1,0,1,0,3),(11,63,'Верхнее покрытие','','Сланец серый',2,1,0,0,1),(24,65,'Теплостойкость в течение 2 часов, не должно быть сползания посыпки, вздутий и других дефектов, при температуре','оС','+100',1,0,1,0,4),(25,65,'Разрывная сила при растяжении в продольном/поперечном направлении, не менее','Н (кгс)','800 (82) / 700 (71)',1,0,1,0,5),(26,65,'Потеря посыпки, не более','г/образец','1,0',1,0,1,0,6),(27,65,'Водопоглощение в течение 24 часов, по массе, не более','%','1,0',1,0,1,0,7),(28,65,'Размеры рулона (длина х ширина)','м','10х1',1,0,1,0,8),(29,66,'Свойство A','','8987987987',1,0,1,0,0);
/*!40000 ALTER TABLE `category_prodproperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_prodproperty_type`
--

DROP TABLE IF EXISTS `category_prodproperty_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_prodproperty_type` (
  `category_prodproperty_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_prodproperty_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_prodproperty_type`
--

LOCK TABLES `category_prodproperty_type` WRITE;
/*!40000 ALTER TABLE `category_prodproperty_type` DISABLE KEYS */;
INSERT INTO `category_prodproperty_type` VALUES (1,'text'),(2,'input');
/*!40000 ALTER TABLE `category_prodproperty_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_prodtab`
--

DROP TABLE IF EXISTS `category_prodtab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_prodtab` (
  `category_prodtab_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `name` varchar(1000) NOT NULL,
  `default` varchar(1000) NOT NULL DEFAULT '',
  `sortOrder` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`category_prodtab_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_prodtab`
--

LOCK TABLES `category_prodtab` WRITE;
/*!40000 ALTER TABLE `category_prodtab` DISABLE KEYS */;
INSERT INTO `category_prodtab` VALUES (1,65,'Применение','&lt;h2&gt;Применение Эластоизол Премиум ТКП-5,0&lt;/h2&gt;&lt;p&gt;Материал приклеивается на подготовленное основание путем оплавления покровного слоя с нижней стороны методом сваривания внахлест свободно лежащего материала. Наплавление производится газовыми или другими горелками.&lt;/p&gt;&lt;p&gt;Устройство кровли возможно в любое время года, кроме дождливой и снежной погоды.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h3&gt;Показатели пожарной опасности&lt;/h3&gt;&lt;ul&gt;&lt;li&gt;Группа горючести Г4 по ГОСТ 30244&lt;/li&gt;&lt;li&gt;Группа воспламеняемости В3 по ГОСТ 30402&lt;/li&gt;&lt;li&gt;Группа распространения пламени РП4 по ГОСТ Р 51032&lt;/li&gt;&lt;/ul&gt;',1),(2,65,'Хранение','&lt;h2&gt;Хранение Эластоизол Премиум ТКП-5,0&lt;/h2&gt;&lt;p&gt;Хранение и транспортировка материала Эластоизол Премиум допускается только в вертикальном положении. Гарантийный срок хранения – 12 месяцев.&lt;/p&gt;',2),(3,65,'Скидки','&lt;h2&gt;Скидки&lt;/h2&gt;&lt;p&gt;Оптовые цены на Эластоизол Премиум действительны при единоразовой оплате 5 000 м2.&lt;/p&gt;&lt;p&gt;Если же ваш заказ более 10 000 м2, обращайтесь к нашим &lt;a href=&quot;index.php?route=information/contact&quot; target=&quot;_blank&quot;&gt;менеджерам&lt;/a&gt;, подобный объем достоин особых условий.&lt;/p&gt;',3);
/*!40000 ALTER TABLE `category_prodtab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_address`
--

DROP TABLE IF EXISTS `oc_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `company` varchar(40) NOT NULL,
  `address_1` varchar(128) NOT NULL,
  `address_2` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT '0',
  `zone_id` int(11) NOT NULL DEFAULT '0',
  `custom_field` text NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_address`
--

LOCK TABLES `oc_address` WRITE;
/*!40000 ALTER TABLE `oc_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_affiliate`
--

DROP TABLE IF EXISTS `oc_affiliate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_affiliate` (
  `affiliate_id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `company` varchar(40) NOT NULL,
  `website` varchar(255) NOT NULL,
  `address_1` varchar(128) NOT NULL,
  `address_2` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  `code` varchar(64) NOT NULL,
  `commission` decimal(4,2) NOT NULL DEFAULT '0.00',
  `tax` varchar(64) NOT NULL,
  `payment` varchar(6) NOT NULL,
  `cheque` varchar(100) NOT NULL,
  `paypal` varchar(64) NOT NULL,
  `bank_name` varchar(64) NOT NULL,
  `bank_branch_number` varchar(64) NOT NULL,
  `bank_swift_code` varchar(64) NOT NULL,
  `bank_account_name` varchar(64) NOT NULL,
  `bank_account_number` varchar(64) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`affiliate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_affiliate`
--

LOCK TABLES `oc_affiliate` WRITE;
/*!40000 ALTER TABLE `oc_affiliate` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_affiliate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_affiliate_activity`
--

DROP TABLE IF EXISTS `oc_affiliate_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_affiliate_activity` (
  `affiliate_activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `affiliate_id` int(11) NOT NULL,
  `key` varchar(64) NOT NULL,
  `data` text NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`affiliate_activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_affiliate_activity`
--

LOCK TABLES `oc_affiliate_activity` WRITE;
/*!40000 ALTER TABLE `oc_affiliate_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_affiliate_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_affiliate_login`
--

DROP TABLE IF EXISTS `oc_affiliate_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_affiliate_login` (
  `affiliate_login_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(96) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `total` int(4) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`affiliate_login_id`),
  KEY `email` (`email`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_affiliate_login`
--

LOCK TABLES `oc_affiliate_login` WRITE;
/*!40000 ALTER TABLE `oc_affiliate_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_affiliate_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_affiliate_transaction`
--

DROP TABLE IF EXISTS `oc_affiliate_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_affiliate_transaction` (
  `affiliate_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `affiliate_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`affiliate_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_affiliate_transaction`
--

LOCK TABLES `oc_affiliate_transaction` WRITE;
/*!40000 ALTER TABLE `oc_affiliate_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_affiliate_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_api`
--

DROP TABLE IF EXISTS `oc_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_api` (
  `api_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `key` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`api_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_api`
--

LOCK TABLES `oc_api` WRITE;
/*!40000 ALTER TABLE `oc_api` DISABLE KEYS */;
INSERT INTO `oc_api` VALUES (1,'Default','2jZbdipNrvduHLeHp9Xv6IaoLXNB8onpA6YTc3yIdvBuybnBtlPzgxN0mGMwpX81QP0K6wZsuEG30einaQnf5A7ZdOsZh8c0kckVv76JrFE0KuEsahCM4Y16m7YwHwn7W3o9NpADGMgZ4ZIDemJDRCOichfWYhsdYqdCPzpC8fVRsyd5b31Ma5eroAeOrCWgij7ihIGrtZYof9r3G42b4jjj0YMh12gfpTOIbreigHp3EW2Msnz0I1Qboot8rgLk',1,'2018-02-25 21:06:06','2018-02-25 21:06:06');
/*!40000 ALTER TABLE `oc_api` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_api_ip`
--

DROP TABLE IF EXISTS `oc_api_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_api_ip` (
  `api_ip_id` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  PRIMARY KEY (`api_ip_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_api_ip`
--

LOCK TABLES `oc_api_ip` WRITE;
/*!40000 ALTER TABLE `oc_api_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_api_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_api_session`
--

DROP TABLE IF EXISTS `oc_api_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_api_session` (
  `api_session_id` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` int(11) NOT NULL,
  `token` varchar(32) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `session_name` varchar(32) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`api_session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_api_session`
--

LOCK TABLES `oc_api_session` WRITE;
/*!40000 ALTER TABLE `oc_api_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_api_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_attribute`
--

DROP TABLE IF EXISTS `oc_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_attribute` (
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_group_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`attribute_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_attribute`
--

LOCK TABLES `oc_attribute` WRITE;
/*!40000 ALTER TABLE `oc_attribute` DISABLE KEYS */;
INSERT INTO `oc_attribute` VALUES (1,6,1),(2,6,5),(3,6,3),(4,3,1),(5,3,2),(6,3,3),(7,3,4),(8,3,5),(9,3,6),(10,3,7),(11,3,8);
/*!40000 ALTER TABLE `oc_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_attribute_description`
--

DROP TABLE IF EXISTS `oc_attribute_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_attribute_description` (
  `attribute_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`attribute_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_attribute_description`
--

LOCK TABLES `oc_attribute_description` WRITE;
/*!40000 ALTER TABLE `oc_attribute_description` DISABLE KEYS */;
INSERT INTO `oc_attribute_description` VALUES (1,1,'Description'),(2,1,'No. of Cores'),(4,1,'test 1'),(5,1,'test 2'),(6,1,'test 3'),(7,1,'test 4'),(8,1,'test 5'),(9,1,'test 6'),(10,1,'test 7'),(11,1,'test 8'),(3,1,'Clockspeed');
/*!40000 ALTER TABLE `oc_attribute_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_attribute_group`
--

DROP TABLE IF EXISTS `oc_attribute_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_attribute_group` (
  `attribute_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`attribute_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_attribute_group`
--

LOCK TABLES `oc_attribute_group` WRITE;
/*!40000 ALTER TABLE `oc_attribute_group` DISABLE KEYS */;
INSERT INTO `oc_attribute_group` VALUES (3,2),(4,1),(5,3),(6,4);
/*!40000 ALTER TABLE `oc_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_attribute_group_description`
--

DROP TABLE IF EXISTS `oc_attribute_group_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_attribute_group_description` (
  `attribute_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`attribute_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_attribute_group_description`
--

LOCK TABLES `oc_attribute_group_description` WRITE;
/*!40000 ALTER TABLE `oc_attribute_group_description` DISABLE KEYS */;
INSERT INTO `oc_attribute_group_description` VALUES (3,1,'Память'),(4,1,'Technical'),(5,1,'Материнская плата'),(6,1,'Процессор');
/*!40000 ALTER TABLE `oc_attribute_group_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_banner`
--

DROP TABLE IF EXISTS `oc_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_banner` (
  `banner_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_banner`
--

LOCK TABLES `oc_banner` WRITE;
/*!40000 ALTER TABLE `oc_banner` DISABLE KEYS */;
INSERT INTO `oc_banner` VALUES (6,'Продукция HP',1),(7,'Слайдшоу на главной',1),(8,'Производители',1);
/*!40000 ALTER TABLE `oc_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_banner_image`
--

DROP TABLE IF EXISTS `oc_banner_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_banner_image` (
  `banner_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `link` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `descr` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`banner_image_id`)
) ENGINE=MyISAM AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_banner_image`
--

LOCK TABLES `oc_banner_image` WRITE;
/*!40000 ALTER TABLE `oc_banner_image` DISABLE KEYS */;
INSERT INTO `oc_banner_image` VALUES (87,6,1,'HP Banner','index.php?route=product/manufacturer/info&amp;manufacturer_id=7','catalog/demo/compaq_presario.jpg',0,''),(94,8,1,'NFL','','catalog/demo/manufacturer/nfl.png',0,''),(95,8,1,'RedBull','','catalog/demo/manufacturer/redbull.png',0,''),(96,8,1,'Sony','','catalog/demo/manufacturer/sony.png',0,''),(91,8,1,'Coca Cola','','catalog/demo/manufacturer/cocacola.png',0,''),(92,8,1,'Burger King','','catalog/demo/manufacturer/burgerking.png',0,''),(93,8,1,'Canon','','catalog/demo/manufacturer/canon.png',0,''),(88,8,1,'Harley Davidson','','catalog/demo/manufacturer/harley.png',0,''),(89,8,1,'Dell','','catalog/demo/manufacturer/dell.png',0,''),(90,8,1,'Disney','','catalog/demo/manufacturer/disney.png',0,''),(97,8,1,'Starbucks','','catalog/demo/manufacturer/starbucks.png',0,''),(98,8,1,'Nintendo','','catalog/demo/manufacturer/nintendo.png',0,''),(135,7,1,'Рубероид6','https://ant-snab.ru/products/roll/ruberoid/','catalog/demo/banners/2611.jpg',5,'Продаем традиционный\r\nкровельный материал\r\nследующих марок:'),(133,7,1,'Мастики4','https://ant-snab.ru/products/mastics/','catalog/demo/banners/2604.jpg',3,'Ант-Снаб производит и поставляет\r\nбитумные мастики, праймеры,\r\nбитумы на любой вкус'),(134,7,1,'Кровля5','https://ant-snab.ru/products/roll/','catalog/demo/banners/2605.jpg',4,'Мы поставляем наплавляемые\r\nрулонные материалы ведущих\r\nроссийских производителей:'),(132,7,1,'Рубероид','https://ant-snab.ru/products/roll/ruberoid/','catalog/demo/banners/2611.jpg',2,'Продаем традиционный\r\nкровельный материал\r\nследующих марок:'),(131,7,1,'Кровля','https://ant-snab.ru/products/roll/','catalog/demo/banners/2605.jpg',1,'Мы поставляем наплавляемые\r\nрулонные материалы ведущих\r\nроссийских производителей:'),(130,7,1,'Мастики','https://ant-snab.ru/products/mastics/','catalog/demo/banners/2604.jpg',0,'Ант-Снаб производит и поставляет\r\nбитумные мастики, праймеры,\r\nбитумы на любой вкус'),(136,7,1,'Мастики7','https://ant-snab.ru/products/mastics/','catalog/demo/banners/2604.jpg',6,'Ант-Снаб производит и поставляет\r\nбитумные мастики, праймеры,\r\nбитумы на любой вкус'),(137,7,1,'Кровля8','https://ant-snab.ru/products/roll/','catalog/demo/banners/2605.jpg',7,'Мы поставляем наплавляемые\r\nрулонные материалы ведущих\r\nроссийских производителей:'),(138,7,1,'Рубероид9','https://ant-snab.ru/products/roll/ruberoid/','catalog/demo/banners/2611.jpg',8,'Продаем традиционный\r\nкровельный материал\r\nследующих марок:'),(139,7,1,'Мастики10','https://ant-snab.ru/products/mastics/','catalog/demo/banners/2604.jpg',9,'Ант-Снаб производит и поставляет\r\nбитумные мастики, праймеры,\r\nбитумы на любой вкус'),(140,7,1,'Кровля11','https://ant-snab.ru/products/roll/','catalog/demo/banners/2605.jpg',10,'Мы поставляем наплавляемые\r\nрулонные материалы ведущих\r\nроссийских производителей:'),(141,7,1,'Рубероид12','https://ant-snab.ru/products/mastics/','catalog/demo/banners/2611.jpg',11,'Продаем традиционный\r\nкровельный материал\r\nследующих марок:');
/*!40000 ALTER TABLE `oc_banner_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_callform`
--

DROP TABLE IF EXISTS `oc_callform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_callform` (
  `callform_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(100) NOT NULL DEFAULT '',
  `text` varchar(2000) NOT NULL DEFAULT '',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`callform_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_callform`
--

LOCK TABLES `oc_callform` WRITE;
/*!40000 ALTER TABLE `oc_callform` DISABLE KEYS */;
INSERT INTO `oc_callform` VALUES (1,'Сергей','89268123112','Какое то сообщение','2018-04-04 12:52:52'),(2,'Сергей','+79376220800','Бла бла бла','2018-04-04 12:59:08'),(3,'ыва','(926) 812-3112','','2018-04-04 13:17:15'),(4,'Сергей','(937) 622-0800','Сообщение','2018-04-05 19:07:31'),(5,'sdfdf','(937) 622-0800','ssdfsdf','2018-04-05 22:25:35'),(6,'sdfsdf','(937) 622-08__','','2018-04-05 22:26:36'),(7,'Серге','(345) 242-3454','','2018-04-05 22:36:39');
/*!40000 ALTER TABLE `oc_callform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cart`
--

DROP TABLE IF EXISTS `oc_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_cart` (
  `cart_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `api_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `product_id` int(11) NOT NULL,
  `recurring_id` int(11) NOT NULL,
  `option` text NOT NULL,
  `quantity` int(5) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `cart_id` (`api_id`,`customer_id`,`session_id`,`product_id`,`recurring_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cart`
--

LOCK TABLES `oc_cart` WRITE;
/*!40000 ALTER TABLE `oc_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_category`
--

DROP TABLE IF EXISTS `oc_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL,
  `column` int(3) NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `isfinal` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `srcId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_category`
--

LOCK TABLES `oc_category` WRITE;
/*!40000 ALTER TABLE `oc_category` DISABLE KEYS */;
INSERT INTO `oc_category` VALUES (71,'',0,0,1,0,1,'2018-07-07 10:51:16','2018-07-07 12:25:50',0,0),(73,'catalog/images/products/Bitumnye-rulonnye-materialy_2031.jpg',71,1,1,15,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2031),(74,'catalog/images/products/Mastiki-prajmery-bitum_2032.jpg',71,1,1,16,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2032),(75,'catalog/images/products/Germetiki-peny-klei_2034.jpg',71,1,1,18,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2034),(76,'catalog/images/products/Geomaterialy_2035.jpg',71,1,1,19,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2035),(77,'catalog/images/products/Fanera_2036.jpg',71,1,1,21,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2036),(78,'catalog/images/products/OSB-3_2037.jpg',71,1,1,22,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2037),(79,'catalog/images/products/Orgalit_2038.jpg',71,1,1,23,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2038),(80,'catalog/images/products/Instrumenty_2808.jpg',71,1,1,28,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2808),(81,'catalog/images/products/Teplonositeli_2540.jpg',71,1,1,25,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2540),(82,'catalog/images/products/Kraski-i-emali_2702.jpg',71,1,1,26,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2702),(83,'catalog/images/products/Suhie-smesi_3103.jpg',71,1,1,20,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,3103),(84,'catalog/images/products/Metizy_3111.jpg',71,1,1,27,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,3111),(85,'catalog/images/products/roll-orgkrovlya.jpg',73,1,1,4,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2043),(86,'catalog/images/products/roll-krz.jpg',73,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2044),(87,'catalog/images/products/roll-tn.jpg',73,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,2045),(88,'catalog/images/products/Ruberoid_2047.jpg',73,1,1,6,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2047),(89,'catalog/images/products/Pergamin_3071.jpg',73,1,1,7,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3071),(90,'catalog/images/products/Goryachie-mastiki_3073.jpg',74,1,1,9,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3073),(91,'catalog/images/products/Bitum_3075.jpg',74,1,1,11,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3075),(92,'catalog/images/products/Holodnye-mastiki_3072.jpg',74,1,1,8,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3072),(93,'catalog/images/products/Prajmery_3074.jpg',74,1,1,10,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3074),(94,'catalog/images/products/Montazhnye-peny_3086.jpg',75,1,1,8,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,3086),(95,'catalog/images/products/Klei_3092.jpg',75,1,1,9,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,3092),(96,'catalog/images/products/Germetiki_3076.jpg',75,1,1,7,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',0,3076),(97,'catalog/images/products/Planter.jpg',76,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2163),(98,'catalog/images/products/Geotekstil_2061.jpg',76,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2061),(99,'catalog/images/products/Fanera-FK_2062.jpg',77,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2062),(100,'catalog/images/products/Fanera-FSF_2063.jpg',77,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2063),(101,'catalog/images/products/Laminirovannaya-fanera_2064.jpg',77,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2064),(102,'catalog/images/products/Talion_3096.jpg',78,1,1,11,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3096),(103,'catalog/images/products/Marka-T.jpg',79,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2066),(104,'catalog/images/products/TermoStrim_2545.jpg',81,1,1,6,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2545),(105,'catalog/images/products/TermoStrim-Eko_2568.jpg',81,1,1,5,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2568),(106,'catalog/images/products/PF-115_2705.jpg',82,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2705),(107,'catalog/images/products/Dlya-mastik-i-prajmerov_3097.jpg',80,1,1,13,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3097),(108,'catalog/images/products/Dlya-germetikov_3098.jpg',80,1,1,15,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3098),(109,'catalog/images/products/Dlya-montazhnoj-peny_3099.jpg',80,1,1,16,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3099),(110,'catalog/images/products/Malyarnyj-instrument_3100.jpg',80,1,1,17,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3100),(111,'catalog/images/products/Rastvoriteli_3101.jpg',80,1,1,18,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3101),(112,'catalog/images/products/Rashodnye-materialy_3102.jpg',80,1,1,19,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3102),(113,'catalog/images/products/SHtukaturki_3104.jpg',83,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3104),(114,'catalog/images/products/SHpatlevki_3105.jpg',83,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3105),(115,'catalog/images/products/Universalnye-smesi_3106.jpg',83,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3106),(116,'catalog/images/products/Kladochnye-smesi_3107.jpg',83,1,1,4,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3107),(117,'catalog/images/products/Smesi-dlya-pola_3108.jpg',83,1,1,5,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3108),(118,'catalog/images/products/Plitochnyj-klej_3109.jpg',83,1,1,6,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3109),(119,'catalog/images/products/Obmazochnaya-gidroizolyaciya_3110.jpg',83,1,1,7,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3110),(120,'catalog/images/products/Samorezy_3112.jpg',84,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3112),(121,'catalog/images/products/Dyubel-gvozdi_3113.jpg',84,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3113),(122,'catalog/images/products/Krepezh-dlya-izolyacii_3114.jpg',84,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3114),(123,'catalog/images/products/Stekloizol_2069.jpg',85,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2069),(124,'catalog/images/products/Steklokrom_2070.jpg',85,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2070),(125,'catalog/images/products/Steklofleks_2071.jpg',85,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2071),(126,'catalog/images/products/Elastobit_2072.jpg',85,1,1,4,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2072),(127,'catalog/images/products/Stekloelast_2073.jpg',85,1,1,5,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2073),(128,'catalog/images/products/Rubiteks_2074.jpg',85,1,1,6,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2074),(129,'catalog/images/products/Elastoizol-Premium_2076.jpg',86,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2076),(130,'catalog/images/products/Elastoizol-Biznes_2078.jpg',86,1,1,4,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2078),(131,'catalog/images/products/Elastoizol-Prof_2079.jpg',86,1,1,5,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2079),(132,'catalog/images/products/Elastoizol-Standart_2081.jpg',86,1,1,7,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2081),(133,'catalog/images/products/Elastoizol-Optim_2082.jpg',86,1,1,8,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2082),(134,'catalog/images/products/Gidrostekloizol_2083.jpg',86,1,1,9,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2083),(135,'catalog/images/products/Steklomast_2084.jpg',86,1,1,10,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2084),(136,'catalog/images/products/Gidrobarer_2085.jpg',86,1,1,11,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2085),(137,'catalog/images/products/Gidroizol_2086.jpg',86,1,1,12,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2086),(138,'catalog/images/products/Rubemast_2092.jpg',86,1,1,18,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2092),(139,'catalog/images/products/Tehnoelast_2093.jpg',87,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2093),(140,'catalog/images/products/Unifleks_2094.jpg',87,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2094),(141,'catalog/images/products/Bipol_2095.jpg',87,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2095),(142,'catalog/images/products/Linokrom_2097.jpg',87,1,1,5,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2097),(143,'catalog/images/products/Bikrost_2098.jpg',87,1,1,6,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2098),(144,'catalog/images/products/Tehnoelast-Akustik_2100.jpg',87,1,1,9,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2100),(145,'catalog/images/products/Stekloizol-R_2815.jpg',87,1,1,7,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,2815),(146,'catalog/images/products/Butilenovye_3085.jpg',96,1,1,9,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3085),(147,'catalog/images/products/Bitumnye-i-krovelnye_3083.jpg',96,1,1,7,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3083),(148,'catalog/images/products/Tiokolovye_3081.jpg',96,1,1,5,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3081),(149,'catalog/images/products/MS-Polimery_3082.jpg',96,1,1,6,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3082),(150,'catalog/images/products/Poliuretanovye_3080.jpg',96,1,1,4,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3080),(151,'catalog/images/products/Silikonovye_3077.jpg',96,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3077),(152,'catalog/images/products/Akrilovye_3078.jpg',96,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3078),(153,'catalog/images/products/Butilkauchukovye_3079.jpg',96,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3079),(154,'catalog/images/products/Vysokotemperaturnye-i-termostojkie_3084.jpg',96,1,1,8,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3084),(155,'catalog/images/products/Bytovye-peny_3087.jpg',94,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3087),(156,'catalog/images/products/Professionalnye-peny_3088.jpg',94,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3088),(157,'catalog/images/products/Ognestojkie-peny_3089.jpg',94,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3089),(158,'catalog/images/products/Zimnie-peny_3090.jpg',94,1,1,4,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3090),(159,'catalog/images/products/Ochistiteli-peny_3091.jpg',94,1,1,5,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3091),(160,'catalog/images/products/ZHidkie-gvozdi_3094.jpg',95,1,1,2,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3094),(161,'catalog/images/products/Himicheskie-ankery_3095.jpg',95,1,1,3,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3095),(162,'catalog/images/products/Klej-pena_3093.jpg',95,1,1,1,1,'2018-07-11 08:45:19','2018-07-11 08:45:19',1,3093);
/*!40000 ALTER TABLE `oc_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_category_description`
--

DROP TABLE IF EXISTS `oc_category_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_category_description` (
  `category_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `meta_title` varchar(2000) DEFAULT '',
  `meta_h1` varchar(2000) DEFAULT '',
  `meta_description` varchar(2000) DEFAULT '',
  `meta_keyword` varchar(2000) DEFAULT '',
  `description_bottom` text,
  `meta_keyword2` varchar(2000) DEFAULT '',
  PRIMARY KEY (`category_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_category_description`
--

LOCK TABLES `oc_category_description` WRITE;
/*!40000 ALTER TABLE `oc_category_description` DISABLE KEYS */;
INSERT INTO `oc_category_description` VALUES (71,1,'Продукция','&lt;p&gt;&lt;nobr&gt;Интернет-магазин&lt;/nobr&gt; &lt;nobr&gt;Ант-Снаб&lt;/nobr&gt; предлагает своим клиентам только лучшие,\r\nпроверенные временем&amp;nbsp;товары, представленные на&amp;nbsp;строительном рынке\r\nРоссии.&lt;/p&gt;\r\n&lt;p&gt;Одновременно с&amp;nbsp;этим мы&amp;nbsp;пытаемся найти подход к&amp;nbsp;любому клиенту, поэтому в\r\nнашем ассортименте представлены как материалы &lt;nobr&gt;премиум-класса,&lt;/nobr&gt; так и&amp;nbsp;бюджетные\r\nтовары.&lt;/p&gt;\r\n&lt;p&gt;На&amp;nbsp;страницах товаров Вы&amp;nbsp;можете узнать для себя &lt;nobr&gt;что-то&lt;/nobr&gt; новое: изучить\r\nхарактеристики, прочесть отзывы покупателей, посмотреть ответы специалистов на\r\nвопросы, скачать документацию и&amp;nbsp;конечно заказать понравившиеся материалы.&lt;/p&gt;\r\n&lt;hr&gt;','Каталог продукции интернет-магазина строительных и отделочных материалов Ант-Снаб','Продукция','Каталог строительных, отделочных, расходных и сопутствующих материалов компании Ант-Снаб. Купить с доставкой все для вашей стройки или ремонта можно в одном месте','Строительные, отделочные, расходные, сопутствующие, материалы, для стройки, ремонта, каталог, ассортимент, продукция, стройматериалы, купить, цена, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб',NULL,''),(73,1,'Битумные рулонные материалы','<p>Все рулонные кровельные&nbsp;материалы представляют собой основу (картон,\nстеклохолст, стеклоткань или полиэстер), на которую наносится битумное вяжущее.\nИсключением являются только материалы на основе картона, которые пропитываются\nбитумом без нанесения.</p>\n<p>На верхние слои материалов наносится защитная посыпка (крошка или сланец\nразличных цветов) для защиты от ультрафиолетового излучения и преждевременного\nстарения покрытия.</p>\n<p>Ант-Снаб предлагает своим клиентам только проверенные временем&nbsp;рулонные\nматериалы от ведущих российских производителей.</p>','Битумные рулонные материалы – купить оптом в Москве, интернет-магазин Ант-Снаб','Битумные рулонные кровельные и гидроизоляционные материалы','Битумные рулонные наплавляемые кровельные и гидроизоляционные материалы ведущих российских производителей. Купить все материалы для гидроизоляции фундаментов и плоской кровли можно оптом с доставкой в Москву в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумные, рулонные, наплавляемые, кровельные, гидроизоляционные, материалы, для плоской кровли, гидроизоляции, крыши, фундамента, изоляции, купить, цена, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Рулонные битумные материалы на стеклоосновах используются по большей части\nпри устройстве плоских кровель городских многоэтажных домов, цехов\nпроизводственных предприятий, офисных и торговых зданий, парковок и гаражей;\nдля гидроизоляции фундаментов, цоколей, межэтажных перекрытий.</p>\n<p>В малоэтажном строительстве в основном применяются материалы на картонной\nоснове: <a href=\"djem://2047\" target=\"_blank\">рубероид</a>,\n<a href=\"djem://2092\" target=\"_blank\">рубемаст</a> или <a href=\"djem://3071\"\ntarget=\"_blank\">пергамин</a>. При устройстве временного&nbsp;гидроизоляционного\nковра или кровельного покрытия на скатных кровлях оптимальным будет\nиспользование именно этих материалов: они имеют невысокую цену и просты в\nмонтаже.</p>\n<p>Если вы затрудняетесь с выбором, смело обращайтесь к нам\n<a href=\"djem://238\">в офис</a>. Все расскажем, объясним разницу и поможем не\nтолько&nbsp;сделать правильный выбор, но и не разориться.</p>','В разделе представлены битумные рулонные материалы Оргкровли, Рязанского КРЗ, ТехноНИКОЛЬ, Филикровли: наплавляемые для кровли и гидроизоляции: специальные для мостов, тоннелей и шумоизоляции; фольгированные для трубопроводов; традиционные на картоне'),(74,1,'Мастики, праймеры, битум','<p>Битумные мастики широко применяются в современном строительстве:\nгидроизоляция и герметизация конструкций, приклеивание строительных материалов,\nустройство кровель, подготовка оснований, антикоррозийная обработка.</p>\n<p>Ант-Снаб предлагает своим клиентам недорогие&nbsp;мастики и праймеры\nсобственного производства, а также продукцию других ведущих российских\nпроизводителей.</p>','Мастики, праймеры, битум – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Битумные мастики, праймеры, битум','Битумные мастики холодного и горячего применения, праймеры, грунтовки, битумы ведущих отечественных производителей для гидроизоляционных и кровельных работ. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумные, мастики, праймеры, холодные, горячие, грунтовки, эмульсионные, водные, битумы, в ведрах, мешках, гост, ту, готовые к применению, для кровельных, гидроизоляционных, работ, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Практически любая битумная мастика&nbsp;состоит из&nbsp;смеси битумов,\nрастворителей (керосин, бензин, солярка, сольвент, уайт-спирит и т.п.) и\nтехнологических добавок.</p>\n<p>В зависимости от назначения, состав битума может быть модифицирован.\nНапример, добавлен синтетический каучук, сбс-полимер или резиновая крошка. Так\nполучают битумно-полимерные и битумно-резиновые мастики.</p>\n<p>Для увеличения объемности и повышения пластичности в состав добавляются\nминеральные наполнители.</p>\n<p>Мастики разделяются по типу применения:</p>\n<p><font color=\"#CC9966\">•</font> <a href=\"djem://3072\"\ntarget=\"_blank\">холодного</a> применения - те, которые не требуют обязательного\nподогрева перед применением;<br>\n<font color=\"#CC9966\">•</font> <a href=\"djem://3073\"\ntarget=\"_blank\">горячего</a> применения - требующие разогрева перед\nиспользованием.</p>\n<p>Ант-Снаб предлагает своим клиентам все&nbsp;самые известные и надежные марки\nмастик и праймеров. Если вы сомневаетесь в правильности своего выбора или\nпросто запутались в многообразии битумных мастик, смело\n<a href=\"djem://238/\">обращайтесь к нам в офис</a>, поможем!</p>',''),(75,1,'Герметики, пены, клеи','<p>В разделе представлены герметизирующие материалы для самых разнообразных\nповерхностей: межпанельных швов, плоских и скатных кровель, санитарные\nгерметики, нейтральные силиконы, высокотемпературные герметики и многие\nдругие.</p>\n<p>Также мы предлагаем нашим клиентам бытовые и профессиональные монтажные пены\nдля всех времен года, клеи, клей-пены&nbsp;и огнестойкие материалы самых\nизвестных производителей не только на российском, но и на международном\nрынке.</p>\n<p>Все товары можно купить самовывозом со склада или заказать с доставкой в\nинтернет-магазине Ант-Снаб.</p>','Герметики, пены, клеи – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Герметики, клеи, пены','Строительные и бытовые герметики, монтажные пены, клеи для внутренних и наружных работ. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Строительные, бытовые, профессиональные, герметики, клей-герметки, клеи, клей-пены, монтажные пены, химические анкеры, Соудал, САЗИ, Экорум, Технониколь, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','',''),(76,1,'Геоматериалы','<p>Ант-Снаб предлагает все необходимые для строительства и дренажа материалы:\nгеотекстиль, профилированные мембраны и комплектующие.</p>\n<p>В нашем интернет-магазина всегда можно сделать правильный выбор, заказать\nпонравившиеся материалы, купить их на складе или заказать доставку по Москве и\nМосковской области.</p>','Геоматериалы – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Геоматериалы','Геосинтетические материалы для устройства дренажа, дорожных работ и защиты изоляционных материалов от повреждений. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Геоматериалы, геотекстиль, профилированные мембраны, дорожное строительство, дренаж, благоустройство, озеленение, защитные, изоляционные, работы, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','',''),(77,1,'Фанера','<p>Фанера – это древесный слоистый материал, состоящий из склеенных между собой\nтрех и более листов лущеного шпона различных пород древесины с взаимно\nперпендикулярным расположением волокон древесины в смежных слоях.</p>\n<p>Для склеивания фанеры применяется шпон лиственных и хвойных пород, причем\nсчитается, что лист фанеры изготовлен из тех пород древесины, из которых\nизготовлены его наружные слои.</p>\n<p>Компания «Ант-Снаб» занимается поставками на рынок Москвы и Московской\nобласти фанеры производства заводов Твери, Вологды, Нижнего Новгорода,\nСмоленска и Китая.</p>','Фанера – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Фанера','Фанера – древесный слоистый материал, состоящий из склеенных между листов лущеного шпона древесины. Купить все виды и сорта в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Фанера, березовая, ФК, ФСФ, ФОФ, Ламинированная, квадратная, строительная, шлифованная, нешлифованная, влагостойкая, повышенная влагостойкость, водостойкая, толщина, сорт, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Всегда в наличии на складе в Подмосковье <a href=\"djem://2062\"\ntarget=\"_blank\">фанера ФК</a>, <a href=\"djem://2063\" target=\"_blank\">фанера\nФСФ</a>, <a href=\"djem://2064\" target=\"_blank\">ламинированная фанера</a> из\nберезового шпона.</p>',''),(78,1,'OSB-3','<p>Ориентированно-стружечные плиты (Oriented Strand Board) – лучшее достижение\nсовременных технологий модификации древесины на сегодняшний день.</p>\n<p>OSB-3 является современной заменой всем привычной фанере. За счет более\nтехнологичного производства удалось получить универсальный строительный и\nотделочный материал с высокими прочностными характеристиками.</p>\n<p>Ант-Снаб предлагает своим клиентам только ОСП-3 ведущих российских\nпроизводителей.</p>','OSB-3 – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','OSB-3','OSB-3 – прессованная влагостойкая плита из длинноволокнистой щепы. Купить все форматы и толщины в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','OSB-3, ОСП-3, ОСП, ОСБ, OSB, плита, влагостойкая, прессованная, формат, толщина, размер, ориентированно, стружечная, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Листы OSB-3 изготавливаются путем высокотемпературного прессования\nдлинноволокнистой щепы в трехслойные плиты. В наружных слоях щепа ориентирована\nпо длине плиты, а во внутреннем слое – по ширине.</p>\n<p>Выравнивание щепы во всех слоях, отсутствие сучков, пустот и\nразнонаправленности волокон обеспечивает прекрасные прочностные характеристики\nматериала.</p>',''),(79,1,'Оргалит','<p>ДВП или оргалит – это современный материал из древесного сырья, который\nпроизводится мокрым или сухим&nbsp;способом при участии клеящих веществ и\nтехнологических добавок.</p>\n<p>Область применения включает в себя&nbsp;строительные и отделочные работы,\nпроизводство мебели, временных конструкций, тары и упаковки. Часто ДВП\nвыступает в роли подкладочного или облицовочного материала.</p>\n<p>Ант-Снаб предлагает со склада или с доставкой оргалит из Тверской\nобласти.</p>','Оргалит – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','ДВП Оргалит','Оргалит – древесноволокнистая плита ДВП, производимая мокрым или сухим способом при участии клеящих веществ. Купить все форматы и толщины в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Оргалит, ДВП, древесноволокнистая плита, сухая, мокрая, гладкая, шершавая, облагороженная, необлагороженная, сорт, марка, толщина, формат, размер, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>ДВП (древесно-волокнистая плита), более известная как Оргалит — один из\nсамых распространенных отделочных материалов. Благодаря низкой стоимости,\nширокой сфере применения и удобным форматам листов снискал нешуточную\nпопулярность в нашей стране.</p>\n<p>Несмотря на свою прочность, ДВП легко обрабатывается и может применяться не\nтолько при отделочных работах, но и в строительстве, производстве мебели и даже\nавтомобилестроении.</p>\n<p>Низкая цена ДВП делает его одним из самых популярных строительных и\nотделочных материалов. Оргалит доступен всем слоям населения, что делает его\nвыгодным не только для строителей, но и для простых людей. ДВП можно купить и\nна рынке, но не везде оргалит, который Вы приобретете, будет именно\nтаким,&nbsp;как написано на ценнике.</p>',''),(80,1,'Инструменты','<p>Данные раздел каталога продукции посвящен различным инструментам,\nрасходникам и сопутствующим товарам, которые помогут сделать работу с\nматериалами&nbsp;комфортной и быстрой.</p>\n<p>Для удобства инструменты разделены на категории по видам материалов, с\nкоторыми они применяются.</p>','Инструменты и расходники – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Инструменты и сопутствующие товары','Ручной инструмент для нанесения битумных мастик, малярные инструменты, пистолеты для герметиков и монтажных пен, растворители и расходные материалы. Купить все материалы в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Инструменты, ручной, малярный, для нанесения, применения, мастики, краски, монтажные пены, герметики, расходные материалы, расходники, сопутствующие товары, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Компания Ант-Снаб продает инструменты, расходные и сопутствующие материалы\nне только оптом, но и в розницу со склада в Москве.</p>\n<p>Большинство продукции всегда есть в наличии.</p>',''),(81,1,'Теплоносители','<p>Теплоносители –&nbsp;это специальные жидкости для систем отопления и\nкондиционирования. Они обладают большей плотностью по&nbsp;сравнению\nс&nbsp;водой, и&nbsp;почти такой же&nbsp;теплоемкостью.</p>\n<p>Жидкости обеспечивают низкую температуру замерзания и&nbsp;высокую\nтеплопроводность.</p>','Теплоносители – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Теплоносители для систем отопления и кондиционирования','Теплоносители – специальные жидкости для систем отопления и кондиционирования, обладают большей плотностью по сравнению с водой. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Теплоноситель, антифриз, тосол, жидкость, система отопления, кондиционирование, загородный дом, коттедж, зеленый, красный, этиленгликоль, пропиленгликоль, готовый, концентрат, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>В&nbsp;основном теплоносители производятся на&nbsp;основе\n<a href=\"djem://2545\" target=\"_blank\">этиленгликоля</a> или\n<a href=\"djem://2568\" target=\"_blank\">пропиленгликоля</a>&nbsp;с добавлением\nантикоррозийных присадок.</p>\n<p>Жидкости для систем отопления обладают высокой стабильностью и обеспечивают\nнепрерывную работу в течение не менее 5 лет или 10 отопительных сезонов.</p>',''),(82,1,'Краски и эмали','<p>В разделе представлены эмали и краски для отделочных работ&nbsp;и\nремонта&nbsp;различных конструкций, жилых и производственных&nbsp;зданий,\nторговых площадей, гаражей, ограждений и многого другого.</p>','Краски и эмали – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Краски и эмали','Эмали и краски для отделочных работ и ремонта различных конструкций, жилых и производственных зданий, торговых площадей. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Эмали, краски, лаки, ГОСТ, ТУ, отделочные работы, строительные, внутри, снаружи, внутренние, наружные, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Сейчас российская и мировая лакокрасочная промышленность выпускает\nпродукцию, обладающую высокими эксплуатационными характеристиками, защитными и\nэстетическими функциями.</p>\n<p>Ант-Снаб предлагает самые оптимальные решения в области лакокрасочных\nматериалов.</p>',''),(83,1,'Сухие смеси','<p>Ант-Снаб поставляет на строительные объекты Москвы и Московской области\nтолько качественные, проверенные временем сухие смеси ведущих российских\nпроизводителей.</p>\n<p>Мы оперативно привезем на вашу стройку цементные и гипсовые штукатурки,\nбазовые и финишные шпатлевки, смеси для общестроительных работ,\nмонтажно-кладочные смеси и плиточные клеи.</p>','Сухие смеси – купить оптом в Москве, интернет-магазин Ант-Снаб','Сухие смеси','Сухие смеси для внутренних, наружных и общестроительных работ. Купить все материалы оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Сухие смеси, строительные, отделочные, работы, шпатлевки, штукатурки, кладочные, плиточные, клеи, обмазочная гидроизоляци, финишная отделка, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','',''),(84,1,'Метизы','<p>Качественные крепежные изделия для строительных и отделочных работ.</p>\n<p>Компания Ант-Снаб — официальный партнер торговой марки Tech-KREP, ведущего\nпроизводителя метизной продукции.</p>\n<p>В нашем интернет-магазине можно выбрать подходящие метизы, оформить заказ,\nзабрать покупки самостоятельно со склада или заказать с доставкой по Москве и\nМосковской области.</p>','Метизы – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Метизы','Саморезы для гипсокартона, металла, дерева, дюбель-гвозди с потайным и грибовидным бортиком, крепеж для изоляции. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Метизы, крепеж, саморезы, дюбели, гвозди, грибки, дерево, металл, гипс, гипсокартон, ГКЛ, ГВЛ, потайной, грибовидный, острый, сверло, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Наша компания продает метизы не только оптом, но и в розницу. Минимальная\nпартия к отгрузке - 1 упаковка. На вес метизы пока не продаются.</p>',''),(85,1,'Оргкровля','<p>Завод Оргкровля производит широкий спектр рулонных кровельных и\nгидроизоляционных материалов с&nbsp;продолжительным сроком службы и\nвозможностью всесезонного использования.</p>\n<p>Продукция обеспечена гарантийным и техническим сопровождением&nbsp;–\nсертификатами качества, руководствами и инструкциями по применению.</p>\n<p>Материалы&nbsp;завода соответствуют всем нормативным требованиям, проверены\nмноголетней практикой и зарекомендовали себя как качественные, надежные и\nотвечающие уровню развития современных технологий.</p>\n<p>ООО \"ТК Ант-Снаб\" – официальный представитель ЗАО \"Оргкровля\" на территории\nМосквы и Московской области.</p>','Кровельные материалы Оргкровля – купить оптом в Москве, интернет-магазин Ант-Снаб','Рулонные материалы завода Оргкровля','Битумные и битумно-полимерные материалы производства рязанского завода Оргкровля. Купить все гидроизоляционные кровельные материалы можно оптом с доставкой в Москву в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонные, кровельные, битумные, наплавляемые, гидроизоляционные, материалы, для плоской кровли, крыши, фундамента, гидроизоляции, оргкровля, рязань, производитель, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>ЗАО \"Оргкровля\" более 45 лет работает в сфере производства мягких кровельных\nматериалов и разработки кровельных технологий.</p>\n<p>В советское время специалисты предприятия производили модернизацию и\nавтоматизацию оборудования практически на всех рубероидных заводах СССР.</p>\n<p>С начала 90-х годов наряду с модернизацией действующих заводов, ЗАО\n\"Оргкровля\" проектировало и запускало новые кровельные производства. За это\nвремя в действие было введено более 20 новых предприятий, полностью оснащенных\nоборудованием Оргкровли.</p>\n<p>Несмотря на наличие всего двух производственных линий, завод известен\nвысокой производительностью. Если нужного&nbsp;материала не оказалось\nв&nbsp;наличии,&nbsp;завод изготовит его в течение максимум 3 дней, а мы\nоперативно доставим его на вашу стройку.</p>','В разделе представлены кровельные и гидроизоляционные материалы производства рязанского завода Оргкровля'),(86,1,'Рязанский КРЗ','<p>Рязанский Картонно-Рубероидный завод существует более 50 лет.\nПроизводственные мощности составляют более 100 миллионов м<sup>2</sup>\nразличных видов кровельных материалов.</p>\n<p>Процесс производства сертифицирован по международному стандарту качества ISO\n9001: 2000. Это позволяет предприятию занимать достойное место на российском и\nевропейском рынке.</p>\n<p>ООО \"ТК Ант-Снаб\" является официальным представителем ЗАО \"МПК \"КРЗ\" на\nтерритории Москвы и Московской области.</p>','Рулонные материалы Рязанского КРЗ – купить оптом в Москве, интернет-магазин Ант-Снаб','Рулонные материалы Рязанского КРЗ','Битумные наплавляемые кровельные материалы Рязанского КРЗ, одного из старейших заводов России. Купить все материалы для гидроизоляции фундаментов и плоской кровли можно оптом с доставкой в Москву в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумные, кровельные, рулонные, наплавляемые, гидроизоляционные, материалы, для крыши, плоская кровля, фундамент, гидроизоляция, крз, ркрз, рязанский, рязань, завод, производитель, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Завод КРЗ производит кровельные материалы повышенного качества с увеличенным\nсроком службы, которые используются на крупных и значимых объектах.</p>\n<p>Там, где требуется высокая надежность и гарантии, такие материалы как,\n<a href=\"djem://2076\" target=\"_blank\">Эластоизол-Премиум</a> и\n<a href=\"djem://2078\" target=\"_blank\">Эластоизол-Бизнес</a>, заслужили у\nстроительных компаний отличную репутацию.</p>\n<p>Недорогие кровельные материалы Рязанского КРЗ пользуются спросом у бюджетных\nорганизаций и частных потребителей. Применение <a href=\"djem://2083\"\ntarget=\"_blank\">Гидростеклоизола</a> или <a href=\"djem://2084\"\ntarget=\"_blank\">Стекломаста</a> не требует больших затрат и использования\nдорогостоящего оборудования, но качество этих материалов позволяет сделать\nкровлю надежной.</p>\n<p>Если вы сомневаетесь в том, какой материал выбрать, то смело обращайтесь к\nнам <a href=\"djem://238\">в офис</a>: расскажем, посоветуем и привезем на\nобъект!</p>','В разделе представлены битумные рулонные материалы для устройства и ремонта мягкой кровли, для гидроизоляции зданий, сооружений, фундаментных плит и перекрытий, мостов, тоннелей и парковок, для пароизоляционных работ'),(87,1,'ТехноНИКОЛЬ','<p>ТехноНИКОЛЬ – крупнейший в России и Европе производитель\nкровельных&nbsp;и&nbsp;гидроизоляционных материалов. В состав корпорации входят\nболее&nbsp;50 производственных предприятий. Более 200 миллионов людей живут в\nдомах, построенных с применением материалов ТехноНИКОЛЬ.</p>\n<p>Компания Ант-Снаб является представителем компании на&nbsp;территории Москвы\nи Московской области.</p>','Гидроизоляционные материалы ТехноНИКОЛЬ – купить оптом в Москве, интернет-магазин Ант-Снаб','Битумные рулонные гидроизоляционные и кровельные материалы ТехноНИКОЛЬ','Рулонные битумные материалы для кровли и гидроизоляции от ведущего российского производителя – ТехноНИКОЛЬ. Купить все кровельные и гидроизоляционные материалы можно оптом с доставкой в Москву в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонные, кровельные, битумные, наплавляемые, гидроизоляционные, материалы, для плоской кровли, крыши, фундамента, гидроизоляции, технониколь, техно, николь, производитель, купить, цена, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>На заводах корпорации производятся как премиальные материалы со сроком\nслужбы более 25 лет, такие как <a href=\"djem://2093\"\ntarget=\"_blank\">Техноэласт</a> и <a href=\"djem://2094\"\ntarget=\"_blank\">Унифлекс</a>, так и недорогие, но надежные гидроизоляционные\nматериалы <a href=\"djem://2097\" target=\"_blank\">Линокром</a> и\n<a href=\"djem://2098\" target=\"_blank\">Бикрост</a>, знакомые многим\nстроителям.</p>\n<p>Если вы затрудняетесь с выбором нужного материала, смело\n<a href=\"djem://238\">обращайтесь в офис</a>, наши сотрудники доходчиво все\nобъяснят и посоветуют самое рациональное технологическое решение.</p>','В разделе представлены широко известные кровельные и гидроизоляционные материалы производства компании ТехноНИКОЛЬ'),(88,1,'Рубероид','<p>Традиционный и знакомый каждому материал, используемый при кровельных и\nгидроизоляционных работах.</p>\n<p>Рубероид производится путем двустороннего нанесения битумного вяжущего с\nнаполнителем и посыпкой на предварительно пропитанный битумом кровельный\nкартон.</p>\n<p>В зависимости от марки на обе стороны рулона наносится мелкозернистая\nпесчаная посыпка или тальк.</p>','Рубероид – купить оптом в Москве, интернет-магазин Ант-Снаб','Рубероид','Рубероид – самый популярный в России битумный рулонный кровельный изоляционный материал. Гибкость на брусе +5, теплостойкость +80 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, кровельный, битумный, гидроизоляционный, картонный, материал, для кровли, крыши, гидроизоляции, фундамента, рубероид, купить, цена, со склада, в розницу, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p><br>Марка РПП-300 может использоваться в качестве нижнего (подкладочного) слоя\nкровельного ковра или для гидроизоляции фундаментов, подвалов, других\nстроительных конструкций и сооружений.</p>\n<p>Марка РКП-350 используется при кровельных работах в качестве нижнего слоя\nкровельного ковра в случае устройства двухслойного покрытия, или в качестве\nверхнего слоя кровельного покрытия при устройстве однослойного ковра.</p>\n<p>Марка РКК-350 применяется при устройстве и ремонта кровельного ковра на\nплоских и скатных крышах в качестве защитного слоя.</p>',''),(89,1,'Пергамин','<p>Традиционный для России пароизоляционный материал. Производится путем\nпропитки картона нефтяными битумами.</p>\n<p>Помимо пароизоляции пергамин используется в качестве ветрозащитного или\nупаковочного материала. Неспадающий интерес к материалу вызван его крайне\nнизкой ценой в сравнении с более современными аналогами.</p>\n<p>Ант-Снаб продает пергамин произведенный под собственной маркой по ТУ, а\nтакже рязанский пергамин по ГОСТ.</p>','Пергамин – купить оптом в Москве, интернет-магазин Ант-Снаб','Пергамин','Пергамин – недорогой пароизоляционный битумный рулонный материал на основе картона. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, пароизоляционный, битумный, ветрозащитный, влагозащитный, картонный, материал, для дачи, бани, пергамин, ту, гост, купить, цена, со склада, в розницу, оптом, с доставкой, от производителя, интернет-магазин, Ант-Снаб','<p><br>\nПри заказе партии свыше 10 000 рулонов мы имеем возможность производства по\nТехническим Условиям заказчика (плотность картона, намотка).</p>',''),(90,1,'Горячие мастики','<p>Горячими битумными мастиками называются те, которые требуют обязательного\nразогрева перед использованием.</p>\n<p>Подобные мастики используются, в основном, при кровельных, гидроизоляционных\nили дорожных работах.</p>\n<p>Ант-Снаб предлагает своим клиентам продукцию собственного производства, а\nтакже горячие мастики других ведущих российских производителей.</p>','Горячие битумные мастики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Битумные мастики горячего применения','Битумные мастики по ГОСТ и ТУ для изоляционных работ, требующие предварительного разогрева перед применением. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумные, мастики, горячие, подогрев, отверждение, гост, ту, в мешках, изоляционные, кровельные, дорожные, морозостойкие, гидроизоляционные, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','',''),(91,1,'Битум','<p>Битум – материал, получаемый путем окисления остаточных продуктов\nнефтепереработки, представляет собой сложную смесь углеводородов и их\nпроизводных.</p>\n<p>Ант-Снаб поставляет со складов в Москве строительные битумы самых популярных\nмарок в мешках и брикетах.</p>','Битум – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Строительные битумы','Строительные битумы в мешках или брикетах по ГОСТ для строительных, изоляционных и дорожных работ. Купить материал всех марок в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битум, кусковой, брикет, мешок, твердый, гост, ту, дорожные, кровельные, гидроизоляция, изоляционные, работы, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>В строительстве битум используется для гидроизоляционных, кровельных или\nдорожных работ. При необходимости его можно разбавить растворителями до\nнеобходимой консистенции, получив&nbsp;мастику или праймер.</p>',''),(92,1,'Холодные мастики','<p>Холодными называются битумные мастики, которые не требуют обязательного\nподогрева перед использованием, то есть готовые к применению.</p>\n<p>Такие мастики используются&nbsp;при гидроизоляционных, кровельных и других\nстроительных работах.</p>\n<p>Ант-Снаб предлагает своим клиентам&nbsp;продукцию собственного производства,\nа также мастики других ведущих российских производителей.</p>','Холодные битумные мастики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Битумные мастики, готовые к применению','Готовые к применению битумные и битумно-полимерные мастики для гидроизоляционных, кровельных, ремонтных и защитных работ. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумные, мастики, полимерные, готовые к применению, холодные, отверждение, эмульсионные, водные, гост, ту, кровельные, гидроизоляционные, защитные, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','',''),(93,1,'Праймеры','<p>Битумный праймер - это готовая к применению грунтовка для подготовки\nразличных типов оснований перед производством гидроизоляционных или кровельных\nработ.</p>\n<p>Ант-Снаб предлагает своим клиентам&nbsp;битумные грунтовки&nbsp;собственного\nпроизводства, а также&nbsp;праймеры других ведущих российских\nпроизводителей.</p>','Битумные праймеры – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Битумные праймеры','Готовые к применению грунтовки на основе битума и растворителей для подготовки оснований перед гидроизоляционными и кровельными работами. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумные, полимерные, праймеры, грунтовки, готовые, холодные, отверждение, подготовка, основания, гидроизоляционные, кровельные, перед наплавлением, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Использование праймеров повышает адгезию, облегчает дальнейшее наплавление\nбитумных рулонных материалов и продлевает срок службы гидроизоляционных и\nкровельных покрытий.</p>',''),(94,1,'Монтажные пены','<p>Монтажная пена как строительный материал появилась сравнительно недавно, но\nсегодня сложно представить строительство или ремонт без нее.</p>\n<p>Компания Ант-Снаб — представитель ведущих мировых и российских\nпроизводителей пены: Soudal и ТехноНИКОЛЬ.</p>\n<p>В нашем интернет-магазине всегда можно выбрать бытовую или профессиональную\nпену для любого сезона, купить ее на нашем складе или же заказать с доставкой\nпо Москве и области.</p>','Монтажные пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Монтажные пены','Полиуретановые однокомпонентные монтажные пены бытового назначения с трубочкой, профессиональные под пистолет, огнестойкие, для зимы и очистители от ведущих мировых производителей. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Монтажные пены, бытовые, профессиональные, полиуретановые, однокомпонентные, очистители, огнестойкие, с трубочкой, под пистолет, зимние, летние, всесезонные, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Все монтажные полиуретановые пены подразделяются по нескольким\nпризнакам.</p>\n<p><u>по составу:</u></p>\n<p>●&nbsp;однокомпонентные;<br>\n●&nbsp;двухкомпонентные;</p>\n<p><u>по сезону применения:</u></p>\n<p>●&nbsp;летняя;<br>\n●&nbsp;зимняя;<br>\n●&nbsp;всесезонная;</p>\n<p><u>по способу нанесения:</u></p>\n<p>●&nbsp;бытовые - ручного применения с трубочкой-адаптером;<br>\n●&nbsp;профессиональные - применение с помощью пистолета;</p>\n<p><u>по классу горючести:</u></p>\n<p>●&nbsp;В1 - противопожарная;<br>\n●&nbsp;В2 - самозатухающая;<br>\n●&nbsp;В3 - горючая.</p>\n<p>Ант-Снаб предлагает своим покупателем все виды монтажных пен, большинство из\nкоторых всегда в наличии на нашем складе.<br></p>',''),(95,1,'Клеи','<p>В разделе представлены клеящие материалы для склеивания различных\nматериалов&nbsp;и крепления элементов в самых разнообразных поверхностях.</p>\n<p>Ант-Снаб — официальный партнер ведущих мировых производителей в этой\nобласти: Soudal и ТехноНИКОЛЬ.</p>\n<p>В нашем интернет-магазине можно подобрать подходящий вариант, купить его на\nнашем складе или заказать доставку по Москве и Московской области.</p>','Клеи  – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Клеи, клей-пены и химические анкеры','Полиуретановые и каучуковые клеи, клей-пены, химические анкеры для бытовых нужд и строительных работ. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Клей-пены, клеи, полиуретановые, в баллонах, жидкие гвозди, монтажные, химические анкеры, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем клеи, клей-пены и химические анкеры не только оптом, но и в\nрозницу. Минимальная партия к отгрузке&nbsp;- 1 шт. Практически все материалы\nесть в наличии на складе.</p>',''),(96,1,'Герметики','<p>Герметизация — очень важная часть в строительном процессе, от качества ее\nвыполнения зависит долговечность, комфорт и уют зданий и помещений.</p>\n<p>Интернет-магазин Ант-Снаб предлагает своим покупателям только качественные,\nпроверенные временем герметизирующие материалы ведущих мировых и российских\nпроизводителей.</p>\n<p>ООО \"ТК Ант-Снаб\" — официальный представитель Soudal, САЗИ, Ecoroom,\nТехноНИКОЛЬ.</p>\n<p>Все герметики можно купить самовывозом с нашего склада или заказать с\nдоставкой по Москве и Московской области.</p>','Герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Герметики','Герметики и клей-герметики на разнообразных основах для бытовых нужд и строительных работ. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, клей-герметики, бытовые, строительные, картриджи, колбасы, файл-пакеты, ведра, однокомпонентные, двухкомпонентные, готовые, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем герметики и клей-герметики не только лишь оптом, но и в розницу.\nМинимальная партия для заказа - 1 шт.</p>\n<p>Большинство представленной продукции всегда в наличии на нашем складе.</p>',''),(97,1,'Planter','<p>Planter&nbsp;–&nbsp;профилированная мембрана, которая производится из\nполиэтилена высокой плотности, с отформованными шипами высотой 8 мм.</p>\n<p>Мембрана Плантер обладает высокими прочностными характеристиками, стойка к\nхимически агрессивным средам, к воздействию плесени и бактерий, корней растений\nи радону.</p>\n<p>Ант-Снаб предлагает своим клиентам все виды профилированных мембран Planter\nи необходимых комплектующих.</p>','Planter – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Профилированные мембраны Planter','Профилированная мембрана из полиэтилена высокой плотности с отформованными шипами высотой 8 мм и комплектующие. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Профилированная мембрана, плантер, Planter, Технониколь, отформованные шипы, комплектующие, защитные, дренажные, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Компания ТехноНИКОЛЬ&nbsp;&nbsp;–&nbsp;лидер на рынке гидроизоляционных и\nкровельных материалов, постоянно развивается, чтобы сохранять конкурентные\nпозиции. Накопленный опыт и знания позволяют компании предлагать лучшие решения\nдля кровельных и гидроизоляционных систем любых типов.</p>\n<p>Одно из самых современных решений для зданий и сооружений с повышенными\nтребованиями к надежности и безопасности&nbsp;&nbsp;–&nbsp;строительные системы\nс профилированными мембранами Planter.</p>\n<p>Мембраны производятся на заводах компании в Рязани и Учалах по современной\nэкструзионной технологии производства. Данная технология позволяет получить\nматериал с идеальной структурой полотна без внутренних дефектов, вследствие\nчего достигается высокое качество и долговечность при эксплуатации.</p>',''),(98,1,'Геотекстиль','<p>Нетканое полотно, изготовленное иглопробивным способом из синтетических\nштапельных волокон.</p>\n<p>Геотекстиль широко используется в гражданском и дорожном строительстве как\nармирующий, разделительный, защитный, фильтрующий и дренирующий материал.</p>\n<p>В нашем интернет-магазине вы всегда можете выбрать нужный материал, оформить\nзаказ, забрать покупки самостоятельно или заказать доставку по Москве и\nобласти.</p>','Геотекстиль – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Геотекстиль','Нетканое иглопробивное полотно для устройства дренажа, дорожного строительства, нужд сельского хозяйства.Купить все марки в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Геотекстиль, дорнит, нетканое, полотно, иглопробивное, устройство, дренажа, разделительный слой, дорожное строительство, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Геотекстиль широко применяется при устройстве дренажных систем, в\nгидротехническом строительстве в качестве фильтра береговых укреплений.</p>\n<p>Геотекстиль – стойкий к химическому воздействию, может эксплуатироваться при\nвысоких и низких температурах, под воздействием высокого давления и трения.</p>\n<p>Материал выпускается со следующей плотностью: <a href=\"djem://2165\"\ntarget=\"_blank\">100</a>, <a href=\"djem://2166\" target=\"_blank\">150</a>,\n<a href=\"djem://2167\" target=\"_blank\">200</a>, <a href=\"djem://2168\"\ntarget=\"_blank\">250</a>, <a href=\"djem://2169\" target=\"_blank\">300</a>,\n<a href=\"djem://2170\" target=\"_blank\">350</a>, <a href=\"djem://2171\"\ntarget=\"_blank\">400</a>,&nbsp;<a href=\"djem://2539\" target=\"_blank\">500</a>\nг/м<sup>2</sup>.</p>',''),(99,1,'Фанера ФК','<div itemprop=\"offers\" itemscope=\"\" itemtype=\"http://schema.org/Offer\">\n<div>\n<p>Фанера ФК – это фанера средней влагостойкости, получаемая путем склеивания\nберезовых шпонов карбомидными клеевыми препаратами.</p>\n<p>Используется&nbsp;такая фанера&nbsp;при производстве конструкционных\nматериалов, в автомобилестроении, вагоностроении, при производстве\nупаковки.</p>\n<p><nobr>Ант-Снаб</nobr>&nbsp;предлагает своим покупателям нешлифованную фанеру\nсорта 4/4. Фанера производится на&nbsp;заводах в&nbsp;Смоленске&nbsp;и\nТвери.</p>\n</div>\n</div>','Фанера ФК – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Фанера ФК','ФК – березовая фанера средней влагостойкости, строительная, нешлифованная сорт 4/4 с форматом листа 1525х1525 мм. Купить все толщины в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Фанера, ФК, березовая, квадратная, строительная, шлифованная, водостойкая, средняя, влагостойкость, нешлифованная, толщина, формат, 1525, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Самый распространенный формат листа у&nbsp;фанеры ФК&nbsp;—&nbsp;1525х1525,\nеще ее&nbsp;называют квадратная фанера. Толщины\nот&nbsp;4&nbsp;до&nbsp;21&nbsp;мм. ФК&nbsp;бывает как шлифованная, так и\n<a href=\"djem://2173\" target=\"_blank\">нешлифованная</a> строительная.</p>\n<p>Фанера ФК&nbsp;отлично пилится, сверлится, скрепляется саморезами или\nгвоздями. Это делает ее&nbsp;удобным и&nbsp;универсальным материалом для\nразличных работ.</p>',''),(100,1,'Фанера ФСФ','<p>Фанера ФСФ&nbsp;– фанера повышенной влагостойкости. Производится путем\nсклеивания нескольких слоев лущеного березового шпона с применением\nфенолформальдегидных смол. Склеивание происходит при повышенной температуре под\nдавлением.</p>\n<p>Ант-Снаб предлагает Фанеру ФСФ сорта 4/4 со склада или с доставкой на вашу\nстройку.</p>','Фанера ФСФ – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Фанера ФСФ','ФСФ – березовая фанера повышенной влагостойкости, строительная, нешлифованная сорт 4/4 с форматом листа 2440х1220 мм. Купить все толщины в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Фанера, ФСФ, березовая, широкая, строительная, нешлифованная, влагостойкая, повышенная, водостойкая, водостойкость, толщина, формат, 2440, 1220, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Фанера ФСФ применяется при строительных работах, в производстве\nконструкционных материалов, автомобилестроении, вагоностроении, в производстве\nупаковочных материалов.</p>\n<p>Отличается высокой прочностью на разрыв и изгибы. Данные свойства\nпрактически не меняются при перепадах температур и влажности. Фанера отлично\nпилится, сверлится, скрепляется гвоздями и шурупами.</p>',''),(101,1,'Ламинированная фанера','<p>Ламинированная фанера – фанера повышенной влагостойкости, чаще всего 1\nсорта, покрытая с двух сторон листа защитным слоем из ламинированной пленки.\nНекоторые производители наносят на слой ламинации сетку для удобного распила\nфанеры.</p>\n<p>Ламинированная фанера&nbsp;– материал, без которого не обойтись при\nмонолитных и опалубочных работах.</p>','Ламинированная фанера – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Ламинированная фанера ФСФ','Ламинированная фанера повышенной влагостойкости сорта 1/1, покрытая с двух сторон листа ламинированной пленкой. Для опалубки и опалубочных работ. Купить все толщины в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Фанера, ламинированная, коричневая, китай, китайская, дешевая, сорт, опалубочная, для опалубки, толщина, 18, 21, мм, формат, 2440, 1220, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Ламинированная фанера ФСФ имеет гораздо большую плотность, механическую\nпрочность и повышенную влагостойкость.</p>\n<p>Ламинированную фанеру&nbsp;используют в качестве отделочного материала, для\nизготовления рекламных щитов, при производстве тары и&nbsp;упаковки,\nа&nbsp;также для изготовления мебели.</p>',''),(102,1,'Талион','<p>Экологически чистые плиты OSB-3 Талион производятся на заводе компании,\nрасположенном в г. Торжок Тверской области. На заводе установлено современное\nнемецкое оборудование, соответствующее европейским стандартами.</p>\n<p>Компания Ант-Снаб предлагает своим клиентам ОСП плиты с форматом листа\n2500х1250 мм всех популярных толщин.</p>\n<p>В нашем интернет-магазине можно выбрать необходимую продукцию, оформить\nзаказ, забрать покупки самостоятельно со склада или заказать доставку по Москве\nи Московской области.</p>','OSB-3 Талион – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','OSB-3 Талион','OSB-3 Талион – качественная влагостойкая ОСП, с форматом листов 2500х1250 мм, производимая на заводе в г. Торжок, Тверской области. Купить все толщины в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','OSB-3, ОСП-3, ОСП, ОСБ, OSB, Талион, Талеон, Talion, Taleon, Торжок, Тверь, Тверская область, влагостойкая, плиита, формат, толщина, размер, 2500, 1250, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Ант-Снаб продает ориентированно-стружечные плиты Талион не только оптом, но\nи в розницу. Можно купить даже 1 лист.</p>',''),(103,1,'Марка Т-С','<p>ДВП (оргалит) марки Т-С – легкий и прочный материал повышенной твердости с\nнеоблагороженной лицевой поверхностью.</p>\n<p>Это современный материал из древесного сырья, который производится мокрым\nспособом при участии клеящих веществ и технологических добавок.</p>\n<p>Ант-Снаб предлагает со склада или с доставкой оргалит марки Т-С производства\nтверского завода.</p>','ДВП марки Т-С – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','ДВП марки Т-С','Оргалит марки Т-С – полутвердая необлагороженная древесноволокнистая плита, обладающая гладкой поверхностью с лицевой стороны. Купить все толщины в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Оргалит, ДВП, марка, ТС, Т, С, Т-С, группа Б, древесноволокнистая плита, шершавая, необлагороженная, гладкая, сорт, марка, толщина, формат, размер, 2745, 2440, 2140, 1220, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Область применения включает строительные и отделочные работы, производство\nмебели, временных конструкций, упаковки. Часто ДВП выступает в роли\nподкладочного или облицовочного материала.</p>\n<p>Древесноволокнистая плита обладает длительным сроком службы, устойчивостью к\nвоздействию влаги, доступной ценой и экологической безопасностью.</p>\n<p>Нашим клиентам мы предлагаем ДВП марки Т-С следующих форматов:\n<a href=\"djem://2186\" target=\"_blank\">2140х1220 мм</a>, <a href=\"djem://2185\"\ntarget=\"_blank\">2440х1220 мм</a> и <a href=\"djem://2184\"\ntarget=\"_blank\">2745х1220 мм</a>.</p>',''),(104,1,'Этиленгликоль','<p>Теплоносители для систем отопления и кондиционирования на основе\nэтиленгликоля - это специальные жидкости красно-розового цвета.</p>\n<p>Применяются в качестве рабочей жидкости в системах отопления и\nкондиционирования промышленных и торговых объектов, в многоэтажных домах, а\nтакже в загородных домах, дачах, коттеджах.</p>\n<p>Ант-Снаб предлагает своим клиентам со склада в Москве только проверенные\nтеплоносители на основе этиленгликоля.</p>','Теплоносители на этиленгликоле – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Теплоносители на основе этиленгликоля','Теплоносители на основе этиленгликоля – жидкости красно-розового цвета для систем отопления и кондиционирования. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Теплоноситель, антифриз, тосол жидкость, красная, розовая, этиленгликоль, этилен, гликоль, готовый, концентрат, система отопления, дача, коттедж, загородный дом, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Производятся&nbsp;теплоносители с применением органических антикоррозийных\nприсадок, обеспечивают низкую температуру замерзания, высокую теплопроводность\nи теплоемкость.</p>\n<p>Разбавленные даже до -15<sup>о</sup>С, они гарантированно защитят систему от\nразрушения в случае аварийной остановки и при более низких показателях\nтемпературы (до -60<sup>о</sup>С), так как гликолевые растворы при охлаждении\nне расширяются в объеме.</p>\n<p>Выпускаются с температурой начала кристаллизации: -30° (готовый к\nприменению); -65° (концентрированный).</p>\n<p>Обладают высокой стабильностью и обеспечивают непрерывную работу в течение\nпяти лет или десяти отопительных сезонов.</p>',''),(105,1,'Пропиленгликоль','<p>Теплоносители на основе пропиленгликоля - экологически и токсикологически\nбезопасные жидкости для систем отопления и кондиционирования.</p>\n<p>Используются в теплообменных системах с повышенными требованиями по\nэкологической безопасности, обеспечивая низкую температуру замерзания, высокую\nтеплопроводность и теплоемкость.</p>\n<p>Компания Ант-Снаб предлагает своим клиентам только качественные и доступные\nжидкости на основе пропиленгликоля.</p>','Теплоносители на пропиленгликоле – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Теплоносители на основе пропиленгликоля','Теплоносители на основе пропиленгликоля – готовые к применению жидкости для систем отопления и кондиционирования зеленого цвета. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Теплоноситель, антифриз, тосол, жидкость, зеленая, пропиленгликоль, пропилен, гликоль, экологичный, безопасный, система отопления, загородный дом, дача, коттедж, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Водные растворы&nbsp;пропиленгликоля обладают меньшей плотностью, чем\nрастворы этиленгликоля, что снижает нагрузку на циркуляционный насос системы.\nЕще одним преимуществом является низкая коррозийная активность.</p>\n<p>Теплоноситель&nbsp;гарантированно защитит систему от разрушения в случае\nаварийной остановки и при показателях температуры до -60<sup>о</sup>С, так как\nгликолевые растворы при охлаждении не расширяются в объеме.</p>\n<p>Пропиленгликолевые теплоносители&nbsp;для систем отопления выпускаются с\nтемпературой начала кристаллизации: -30°С, полностью готовыми к применению.</p>\n<p>Обладают высокой стабильностью и обеспечивают непрерывную работу в течение\nпяти лет или десяти отопительных сезонов.</p>',''),(106,1,'ПФ-115','<p>Эмаль ПФ-115 – пентафталевый лакокрасочный материал, основной компонент\nкоторого - алкидный лак.&nbsp;Чаще всего используется для окраски металла и\nдерева, хорошо&nbsp;ложится эмаль на&nbsp;бетонные и пластиковые\nповерхности.</p>\n<p>Ант-Снаб предлагает своим клиентам эмали ПФ-115, произведенные по ГОСТ\n6465-76. Всегда в наличии на складе широкий выбор цветов.</p>','Эмаль ПФ-115 – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Эмаль ПФ-115 по ГОСТ 6465-76','Эмаль ПФ-115 – пентафталевый лакокрасочный материал, основной компонент которого - алкидный лак, используется для окраски металла и дерева. Купить все цвета в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Эмаль, ПФ, 115, ПФ-115, пентафталевый, ГОСТ, 6465-76, цвета, алкидная, окраска, покрытие, внутри, снаружи, помещений, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы предлагаем своим клиентам качественный&nbsp;товар, произведенный&nbsp;по\nГОСТ 6465-76&nbsp;от производителя «ЦВЕТОГАММА». Компания существует на рынке с\n1997 года.</p>\n<p>На модернизированном в 2014 году заводе, расположенном в г. Ярцево\nСмоленской области изготавливаются краски и эмали с проверенной рецептурой по\nразумной цене.</p>\n<p>В умеренном и холодном климате стойкое покрытие эмали надежно защищает\nздания и конструкции от неблагоприятного воздействия погодных условий.</p>\n<p>Глянцевое покрытие долговечно, оно прослужит порядка 4 лет. ПФ-115 отлично\nзарекомендовала себя при внутренних работах, ей красят полы и стены складов,\nподсобных, технических помещений.</p>',''),(107,1,'Для мастик и праймеров','<p>Удобные и качественные ручные инструменты для быстрого нанесения на\nразличные поверхности&nbsp;битумных мастик горячего&nbsp; и холодного\nотверждения, битумных праймеров.</p>\n<p>В интернет-магазине Ант-Снаб вы всегда можете подобрать подходящий\nинструмент, оформить заказ, забрать свои покупки самостоятельно или заказать\nдоставку по Москве и Московской области.</p>','Инструменты для мастики и праймера – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Инструменты для нанесения битумных мастик и праймеров','Инструменты для удобного и быстрого нанесения битумных мастик горячего и холодного применения, праймеров. Купить все инструменты в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Инструмент, ручной, нанесение, битумные мастики, кисти, макловицы, праймеры, шпатели, валики, герметики, жесткие, мягкие, меховые, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем инструменты для битумных мастик не только оптом, но и в розницу.\nМинимальная партия - 1 шт. Большинство представленной продукции всегда есть в\nналичи на складе.</p>',''),(108,1,'Для герметиков','<p>Качественные выдавливающие пистолеты для герметиков в стандартных\nкартриджах, колбасах и химических анкеров.</p>\n<p>В интернет-магазине Ант-Снаб всегда можно подобрать необходимый инструмент,\nоформить заказ, забрать покупки самостоятельно со склада или заказать доставку\nпо Москве и области.</p>','Инструменты для герметиков – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Инструменты для герметиков в тубах и колбасах','Выдавливающие пистолеты для герметиков в стандартных картриджах, колбасах и химических анкеров. Купить все инструменты в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Пистолеты, выдавливающие, для герметиков, картриджи, тубы, колбасы, файл пакеты, химические анкеры, Бибер, Biber, Soudal, Соудал, Судал, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем инструменты для герметиков не только оптом, но и в розницу.\nМинимальная партия - 1 шт. Большинство представленной продукции всегда есть в\nналичи на складе.</p>',''),(109,1,'Для монтажной пены','<p>Качественные металлические и пластиковые пистолеты для профессиональных\nмонтажных пен в стандартных баллонах.</p>\n<p>В интернет-магазине Ант-Снаб всегда можно подобрать подходящий пистолет,\nоформить заказ, забрать покупки самому или заказать доставку по Москве в\nудобное время.<br></p>','Инструменты для монтажной пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Инструменты для монтажной пены','Пистолеты для профессиональных монтажных пен в стандартных баллонах. Купить все инструменты в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Пистолеты, для монтажной пены, полиуретановой, пистолетной, профессиональной, баллоны, Бибер, Biber, Soudal, Соудал, Судал, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем инструменты для монтажной пены не только оптом, но и в розницу.\nМинимальная партия - 1 шт. Большинство представленной продукции всегда есть в\nналичи на складе.</p>',''),(110,1,'Малярный инструмент','<p>Малярный инструмент для нанесения красок, эмалей, лаков на вертикальные и\nгоризонтальные поверхности.</p>\n<p>В интернет-магазине Ант-Снаб вы всегда сможете подобрать нужный инструмент,\nкупить его на нашем складе или оформить доставку по Москве и области.</p>','Малярный инструмент – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Малярный инструмент','Малярный инструмент для нанесения красок, эмалей, лаков на вертикальные и горизонтальные поверхности. Купить все инструменты в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Малярный инструмент, валики, велюровые, широкие, узкие, для краски, лаков, эмалей, нанесение, окраска, покраска,купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем малярный инструмент не только оптом, но и в розницу. Минимальная\nпартия - 1 шт. Большинство представленной продукции всегда есть в наличи на\nскладе.</p>',''),(111,1,'Растворители','<p>Растворители для разведения&nbsp;битумных мастик, праймеров, лаков, красок и\nэмалей в удобных упаковках. Также подойдут для очистки инструмента и\nповерхностей.</p>\n<p>В интернет-магазине Ант-Снаб всегда можно подобрать подходящий инструмент,\nоформить заказ, забрать его самостоятельно или получить с доставкой по Москве и\nобласти.</p>','Растворители – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Растворители','Растворители для битумных мастик, праймеров, лаков, красок и эмалей в удобных упаковках. Купить все материалы в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Растворители, уайт спирит, разведение, бутылка, канистра, литр, 10, мастики, краски, эмали, грунтовки, очистка инструментов, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем растворители не только оптом, но и в розницу. Минимальная партия\n- 1 шт. Большинство представленной продукции всегда есть в наличи на\nскладе.</p>',''),(112,1,'Расходные материалы','<p>Расходные материалы,&nbsp;которые всегда пригодятся&nbsp;при строительных\nили отделочных работах.</p>\n<p>В интернет-магазине Ант-Снаб вы всегда можете подобрать нужные материалы,\nоформить заказ и получить его либо самостоятельно на складе, либо с доставкой в\nудобное время.</p>','Расходные материалы – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Расходные материалы','Расходные материалы, необходимые для строительных или отделочных работ. Купить все материалы в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Расходные материалы, расходники, сопутствующие товары, перчатки, скотч, малярный, бумажный, лента, перчатки, пвх, хб, рабочие, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем расходные материалы и сопутствующие товары не только оптом, но и\nв розницу. Минимальная партия - 1 шт. Большинство представленной продукции\nвсегда есть в наличи на складе.</p>',''),(113,1,'Штукатурки','<p>Штукатурные растворы используются для базового выравнивания стен и потолков:\nустранения выбоин, ям, трещин, уклона вертикальных поверхностей. Выпускаются на\nгипсовой и цементной основе для работ внутри помещения, для наружных\nстен&nbsp;производятся только&nbsp;цементные смеси.</p>\n<p>Ант-Снаб - официальный представитель компании \"Фаворит\", производителя\nматериалов под торговой маркой De Luxe. Мы оперативно&nbsp;поставим\nкачественные и недорогие&nbsp;штукатурки на ваши объекты.</p>','Штукатурки – купить оптом в Москве, интернет-магазин Ант-Снаб','Штукатурки','Цементные и гипсовые смеси для устранения дефектов поверхностей внутри или снаружи помещения. Купить все штукатурки оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Штукатурки, гипсовые, цементные, в мешках, смеси, устранение дефектов, выравнивание, внутренние, наружные работы, внутри, снаружи помещения, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Строительные материалы De Luxe выпускаются компанией \"Фаворит\"&nbsp;на\nсовременном производстве, располагающемся в г. Котельники, Московская\nобласть.</p>\n<p>Собственная испытательная лаборатория завода производит как&nbsp;проверку\nпринимаемого сырья, так и контроль показателей выпускаемой продукции,\nобеспечивая стабильность&nbsp;ее качества.</p>',''),(114,1,'Шпатлевки','<p>Шпатлевочные составы восстребованы при подготовке поверхностей к финишной\nотделке. При помощи шпатлевки убирают мелкие неровности, незначительные\nвыбоины, трещины, царапины. В результате чего образуется гладкое покрытие с\nоднородной структурой.</p>\n<p>Ант-Снаб - официальный представитель компании \"Фаворит\", производителя\nсовременных материалов под торговой маркой De Luxe. Мы оперативно&nbsp;поставим\nкачественные и недорогие&nbsp;штукатурки на ваши объекты.</p>','Шпатлевки – купить оптом в Москве, интернет-магазин Ант-Снаб','Шпатлевки','Гипсовые и цементные смеси для выравнивания поверхностей перед отделочными работами. Купить все шпатлевки оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Шпатлевки, шпаклевки, гипсовые, цементные, в мешках, смеси, ведра, готовые, сухие, выравнивание, поверхностей, отделочные работы, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Шпатлевочные&nbsp;материалы под маркой&nbsp;De&nbsp;Luxe&nbsp;выпускаются\nкомпанией «Фаворит»&nbsp;на современном производстве, располагающемся в&nbsp;г.\nКотельники, Московская область.</p>\n<p>Собственная испытательная лаборатория завода производит проверку не\nтолько&nbsp;входящего сырья,&nbsp;но и&nbsp;контроль показателей выпускаемой\nпродукции, обеспечивая тем самым стабильность&nbsp;ее качества.</p>',''),(115,1,'Универсальные смеси','<p>Универсальные смеси - это материалы для различных общестроительных работ:\nбетонирования и стяжки полов, кладки блочных материалов, кирпича, тротуарной\nплитки, устранения дефектов конструкций.</p>\n<p>ООО \"ТК Ант-Снаб\" - официальный представитель компании \"Фаворит\",\nпроизводителя материалов под торговой маркой De Luxe. Мы\nоперативно&nbsp;поставим качественные и недорогие&nbsp;смеси на ваши\nобъекты.</p>','Универсальные смеси – купить оптом в Москве, интернет-магазин Ант-Снаб','Универсальные смеси','Цементно-песчаные смеси для общестроительных работ. Купить все марки пескобетона оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Универсальные смеси, сухие, цементные, песчаные, строительные работы, общестроительные, пескобетон, песок, бетон, ремонтные, основания, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Материалы под маркой&nbsp;De&nbsp;Luxe&nbsp;выпускаются компанией\n«Фаворит»&nbsp;на современном производстве. Завод находится в&nbsp;г.\nКотельники &nbsp;Московской области.</p>\n<p>Испытательная лаборатория завода производит проверку не\nтолько&nbsp;входящего сырья,&nbsp;но и&nbsp;осуществляет контроль показателей\nвыпускаемой продукции, обеспечивая тем самым стабильность&nbsp;качества.</p>',''),(116,1,'Кладочные смеси','<p>Монтажно-кладочные смеси необходимы при возведении стен и перегородок из\nпенобетона, кирпича и каменных блоков. Обеспечивают долговечное и прочное\nсцепление элементов кладки.</p>\n<p>ООО \"ТК Ант-Снаб\" - представитель компании \"Фаворит\", производителя\nматериалов под торговой маркой De Luxe. Мы оперативно&nbsp;поставим\nкачественные и недорогие&nbsp;кладочные смеси на ваши объекты.</p>','Кладочные смеси – купить оптом в Москве, интернет-магазин Ант-Снаб','Кладочные смеси','Смеси для кладки стен и перегородок из блоков и кирпича. Купить все кладочные смеси оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Кладочные смеси, сухие, кладка, перегородки, блоки, кирпича, пеноблок, пазогребневый, раствор, мешок, газобетонные, керамические, кирпичные, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Строительные материалы марки&nbsp;De&nbsp;Luxe&nbsp;выпускаются&nbsp;ООО\n«Фаворит»&nbsp;на современном производстве, располагающемся в&nbsp;г.\nКотельники, Московская область.</p>\n<p>Испытательная лаборатория завода производит как&nbsp;проверку принимаемого\nсырья, так и&nbsp;контроль показателей выпускаемой продукции, обеспечивая\nстабильность&nbsp;ее качества.</p>\n<p>В производстве кладочных составов торговой марки De Luxe используются\nминеральные вяжущие и модификаторы, благодаря чему достигаются высокие\nпоказатели сцепления с поверхностью, теплоизоляции и пластичности.</p>',''),(117,1,'Смеси для пола','<p>Смеси для устройства наливных полов -\nэто&nbsp;технологичные&nbsp;многокомпонентные материалы, позволяющие получить\nдолговечное бесшовное покрытие.</p>\n<p>Ант-Снаб&nbsp;- официальный представитель&nbsp;ООО \"Фаворит\", производителя\nматериалов под торговой маркой De Luxe. Мы оперативно&nbsp;поставим\nкачественные и недорогие&nbsp;стяжки и смеси для пола&nbsp;на ваши объекты.</p>','Смеси для пола – купить оптом в Москве, интернет-магазин Ант-Снаб','Смеси для пола','Составы для выравнивания горизонтальных оснований перед укладкой декоративных покрытий. Купить все смеси для пола оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Смеси для полов, наливные полы, стяжки, высокопрочные, сухие, выравнивание, горизонтальные поверхности, основания, самовыравнивающиеся, теплый пол, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Строительные материалы De Luxe выпускаются компаней Фаворит&nbsp;на\nсовременно оснащенном производстве, располагающемся в г. Котельники\n&nbsp;Московской области.</p>\n<p>Собственная испытательная лаборатория завода производит тщательную проверку\nпринимаемого сырья и осуществляет контроль показателей выпускаемой продукции,\nобеспечивая стабильность&nbsp;ее качества.</p>\n<p>Сухие смеси De Luxe для устройства наливного пола отвечают всем современным\nтребованиям, а&nbsp;также рекомендуются для создания систем \"Теплый пол\".</p>\n<p>В состав таких смесей входит фракционированный песок, цемент, минеральные\nнаполнители и модифицирующие добавки.</p>\n<p>Затворенная смесь высокопластична, легко растекается и самовыравнивается.\nГотовое покрытие получается крайне износостойким, морозостойким, препятствует\nпроникновению воды к основанию.</p>',''),(118,1,'Плиточный клей','<p>В разделе представлены смеси для укладки керамической плитки, в основе\nкоторых использован&nbsp;цемент и мелкая фракция песка.</p>\n<p>Ант-Снаб - официальный представитель компании \"Фаворит\", производителя\nсовременных материалов под торговой маркой De Luxe. Мы оперативно&nbsp;поставим\nкачественные плиточные клеи и другие сухие смеси на ваши объекты.</p>','Плиточный клей – купить оптом в Москве, интернет-магазин Ант-Снаб','Плиточный клей','Цементные клеящие составы для облицовки стен и полов керамической плиткой или керамогранитом. Купить все плиточные клеи оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Плиточный клей, для плитки, цементные, клеящие, составы, облицовка, керамическая, керамогранит, наружные, внутренние работы, ремонтный состав, теплый пол, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Строительные материалы De Luxe выпускаются компаней Фаворит&nbsp;на\nсовременно оснащенном производстве, располагающемся в г. Котельники, Московская\nобласть.</p>\n<p>Собственная испытательная лаборатория завода производит как&nbsp;проверку\nпринимаемого сырья, так и контроль показателей выпускаемой продукции,\nобеспечивая стабильность&nbsp;ее качества.</p>\n<p>Плиточные клеи De Luxe производятся по уникальной рецептуре с добавлением\nмодифицирующих компонентов.</p>\n<p>Готовый к работе материал эластичен, экономно расходуется, закрепляемая\nплитка не \"сползает\". Застывший клей&nbsp;мало подвержен\nвоздействию&nbsp;температурных перепадов&nbsp;и деформации основания. Устойчив\nк влаге.</p>',''),(119,1,'Обмазочная гидроизоляция','<p>Обмазочная гидроизоляция используется для защиты поверхностей, не\nподвергающихся деформации, от проникновения воды. Составы идеальны для изоляции\nподвалов, санузлов, балконов и бассейнов.</p>\n<p>ООО \"ТК Ант-Снаб\" - представитель компании \"Фаворит\", производителя\nматериалов под торговой маркой De Luxe. Мы оперативно&nbsp;поставим\nкачественные и недорогие&nbsp;гидроизоляционные и другие смеси на ваши\nобъекты.</p>','Обмазочная гидроизоляция – купить оптом в Москве, интернет-магазин Ант-Снаб','Обмазочная гидроизоляция','Смеси для создания жестких водонепроницаемых покрытий. Купить все смеси для обмазочной гидроизоляции оптом с доставкой по Москве и области можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Обмазочная гидроизоляция, сухая, смесь, водонепроницаемый состав, покрытие, гидроизоляционная, балконы, террасы, бассейны, фундаменты, купить, цена, оптом, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Строительные материалы марки&nbsp;De&nbsp;Luxe&nbsp;выпускаются&nbsp;ООО\n«Фаворит»&nbsp;на современном производстве, располагающемся в&nbsp;г.\nКотельники, Московская область.</p>\n<p>Испытательная лаборатория завода производит как&nbsp;проверку принимаемого\nсырья, так и&nbsp;контроль показателей выпускаемой продукции, обеспечивая\nстабильность&nbsp;ее качества.</p>\n<p>Обмазочная гидроизоляция очень проста&nbsp;в работе и безопасна. Состав\nможет использоваться в том числе в жилых помещениях и для изоляции резервуаров\nс питьевой водой.</p>\n<p>Обмазочная гидроизоляции торговой марки De Luxe рекомендуется в качестве\nэлемента системы \"Теплый пол\".</p>',''),(120,1,'Саморезы','<p>Качественные фосфатированные и оцинкованные саморезы для крепления\nгипсокартона, металла, дерева; с прессшайбой и без; острые и со сверлом.</p>\n<p>Компания Ант-Снаб — официальный партнер торговой марки Tech-KREP, ведущего\nпроизводителя метизной продукции.</p>\n<p>В нашем интернет-магазине всегда можно подобрать подходящие материалы,\nоформить заказ, забрать покупки самостоятельно со склада или заказать доставку\nпо Москве и области.</p>','Саморезы – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Саморезы','Саморезы фосфатированные и оцинкованные для дерева, металла, гипсокартона, острые и со сверлом. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Саморезы, фосфатированные, оцинкованные, черные, металлические, сталь, дерево, металл, гипсокартон, острый, сверло, прессшайба, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Наша компания продает саморезы не только оптом, но и в розницу. Минимальная\nпартия - 1 упаковка. На вес и поштучно саморезы пока не продаются.</p>',''),(121,1,'Дюбель-гвозди','<p>Распорные дюбели из полипропилена с желтыми гвоздями со скрытым или\nгрибовидным бортиком.</p>\n<p>Ант-Снаб — официальный партнер торговой марки Tech-KREP, ведущего\nпроизводителя метизной продукции.</p>\n<p>В нашем интернет-магазине всегда можно подобрать подходящий материал,\nоформить заказ, забрать покупку самостоятельно со склада или заказать доставку\nпо Москве.</p>','Дюбель-гвозди – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Дюбель-гвозди','Распорные дюбели с желтым гвоздем, с потайным и грибовидным бортиком. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Дюбель, гвоздь, распорный, желтый, потайной, грибовидный, борт, бортик, потай, гриб, скрытый, шуруп, упаковка, шт, кг, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем дюбель-гвозди не только крупным и мелким оптом, но и в розницу.\nМинимальная партия - 1 упаковка. На вес и поштучно метизы пока не\nпродаются.</p>',''),(122,1,'Крепеж для изоляции','<p>Пластиковые дюбели для крепления изоляционных и других строительных\nматериалов, с металлическими или пластиковыми гвоздями.</p>\n<p>Компания Ант-Снаб — официальный партнер торговой марки Tech-KREP, ведущего\nпроизводителя метизной продукции.</p>\n<p>В нашем интернет-магазине вы всегда сможете&nbsp;найти подходящий материал,\nоформить заказ, забрать его самостоятельно или заказать доставку по Москве и\nобласти.</p>','Крепеж для изоляции – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Крепеж для изоляции','Крепеж грибок с металлическим или пластиковым гвоздем для крепления теплоизоляции и других материалов к основаниям. Купить все виды в розницу со склада или оптом с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Крепеж для теплоизоляции, грибок, металлический, пластиковый, гвоздь, красный, строительные, отделочные, материалы, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем крепеж для изоляции не только оптом, но и в розницу. Минимальная\nпартия - 1 упаковка. На вес и поштучно&nbsp;грибки пока не продаются.</p>',''),(123,1,'Стеклоизол','<p>Качественный и недорогой битумный кровельный и гидроизоляционный\nнаплавляемый материал.</p>\n<p>Стеклоизол&nbsp;производится&nbsp;только на негниющей стеклооснове:\nстеклоткани, стеклохолсте или полиэстере. В качестве защитного слоя\nиспользуется крупнозернистая посыпка и полимерная пленка.</p>','Стеклоизол – купить оптом в Москве, интернет-магазин Ант-Снаб','Стеклоизол','Стеклоизол – качественный и недорогой битумный кровельный и гидроизоляционный наплавляемый материал. Гибкость на брусе 0, теплостойкость +80 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, оргкровля, Стеклоизол, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Стеклоизол пришел на смену традиционному рубероиду и предназначается для\nмассового применения при устройстве новых кровельных покрытий, ремонта\nсуществующих кровель и для гидроизоляции строительных конструкций.</p>\n<p>Использование высокоокисленного битума и современных модификаторов позволило\nпродлить срок службы кровельного или гидроизоляционного ковра из Стеклоизола на\nсрок более 10 лет.</p>\n<p>Марки&nbsp;П-2.5, П-3.0, П-3.5 применяются для гидроизоляции строительных\nконструкций, а также для устройства и ремонта кровли в качестве нижнего\nслоя;</p>\n<p>Марки К-3.5, К-4.0, К-4.5 применяются для устройства и ремонта кровли в\nкачестве верхнего слоя.</p>','Стеклоизол - надежный и недорогой битумный материал, который имеет прекрасные характеристики - гибкость на брусе 0&deg;С, теплостойкость +80&deg;С'),(124,1,'Стеклокром','<p>Битумный кровельный и гидроизоляционный наплавляемый материал, используется\nна поверхностях с малым уклоном.</p>\n<p>Стеклокром выпускается на биостойкой стеклооснове: стеклоткани, стеклохолсте\nили полиэстере. В качестве защитного слоя используется крупнозернистая посыпка\nи полимерная пленка.</p>\n<p>Среди строителей Стеклокром – один из самых популярных материалов, благодаря\nлегкости применения.</p>','Стеклокром – купить оптом в Москве, интернет-магазин Ант-Снаб','Стеклокром','Стеклокром – битумный кровельный и гидроизоляционный наплавляемый материал. Гибкость на брусе -5, теплостойкость +80 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, оргкровля, полимерный, сбс, модифицированный, Стеклокром, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Материал&nbsp;марок П-3.0 и П-3.5 применяется для гидроизоляции строительных\nконструкций, а также для устройства и ремонта кровли в качестве нижнего\n(подкладочного) слоя;</p>\n<p>Материал&nbsp;марок К-4.0 и К-4.5 применяется для устройства и ремонта\nкровли в качестве верхнего (бронированного) слоя.</p>','Стеклокром - качественный и недорогой битумный материал на стеклооснове для устройства плоских кровель и гидроизоляции строительных конструкций. Гибкость на брусе -5&deg;С, теплостойкость +80&deg;С'),(125,1,'Стеклофлекс','<p>Недорогой кровельный и гидроизоляционный битумный материал, обеспечивающий\nсухость и комфорт в помещениях.</p>\n<p>Стеклофлекс выпускается на стеклоткани, стеклохолсте и полиэстере. В\nкачестве защиты материала от ультрафиолетового излучения используется\nкрупнозернистая посыпка, которая позволяет продлить срок службы до 12 лет.</p>\n<p>Может укладываться на бетонные, цементно-песчаные и другие виды\nоснований.</p>','Стеклофлекс – купить оптом в Москве, интернет-магазин Ант-Снаб','Стеклофлекс','Стеклофлекс – кровельный и гидроизоляционный битумный наплавляемый материал. Гибкость на брусе -10, теплостойкость +85 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, оргкровля, полимерный, сбс, модифицированный, Стеклофлекс, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Материал&nbsp;марок П-3.0 и П-3.5 используется как гидроизоляционный\nматериал, надежно защищающий подвалы и фундаменты от грунтовых вод;</p>\n<p>Материал&nbsp;марок К-4.0 и К-4.5 применяется для устройства и ремонта\nкровли в качестве верхнего слоя.</p>','Стеклофлекс - рулонный битумно-полимерный материал для устройства плоских кровель и гидроизоляции строительных конструкций. Гибкость на брусе -10&deg;С, теплостойкость +85&deg;С'),(126,1,'Эластобит','<p>Битумно-полимерный (СБС – модифицированный) рулонный кровельный и\nгидроизолирующий наплавляемый материал.</p>\n<p>Благодаря производству на современном оборудовании с применением средств\nгомогенезирования битумно-полимерной массы, вяжущее получается особо\nкачественным и долговечным.</p>','Эластобит – купить оптом в Москве, интернет-магазин Ант-Снаб','Эластобит','Эластобит – битумно-полимерный рулонный кровельный и гидроизолирующий наплавляемый материал. Гибкость на брусе -15, теплостойкость +85 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, оргкровля, полимерный, сбс, модифицированный, Эластобит, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Марки П-3.0 и П-3.5 применяются для гидроизоляции строительных конструкций,\nа также для устройства и ремонта кровли в качестве нижнего (подкладочного)\nслоя;</p>\n<p>Марки&nbsp;К-4.0 и К-4.5&nbsp;используются для устройства и ремонта кровли в\nкачестве верхнего (бронированного) слоя.</p>','Эластобит - качественный и недорогой битумно-полимерный материал для устройства ковра плоских кровель и гидроизоляции строительных конструкций. Гибкость на брусе -15&deg;С, теплостойкость +85&deg;С'),(127,1,'Стеклоэласт','<p>Битумно-полимерный рулонный кровельный и гидроизолирующий материал на\nстекловолокнистой или полиэфирной основе.</p>\n<p>Крупнозернистая или сланцевая посыпка верхнего слоя служит надежной защитой\nот ультрафиолетового воздействия, что значительно увеличивает срок службы\nкровельного ковра.</p>','Стеклоэласт – купить оптом в Москве, интернет-магазин Ант-Снаб','Стеклоэласт','Стеклоэласт – битумно-полимерный рулонный кровельный и гидроизолирующий материал на стекловолокнистой или полиэфирной основе. Гибкость на брусе -20, теплостойкость +100 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, оргкровля, полимерный, сбс, модифицированный, Стеклоэласт, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Современное строительство требует&nbsp;использования кровельных материалов,\nкоторые изготовлены по современным технологиям с применением только\nвысококачественного сырья.</p>\n<p>Этим требования отвечает битумно-полимерный кровельный гидроизоляционный\nматериал Стеклоэласт. Он производится на биостойкой стекловолокнистой или\nполиэфирной основе.</p>\n<p>Стеклоэласт марок П-3.5 и П-4.0 применяется для гидроизоляции строительных\nконструкций, а также для устройства и ремонта кровли в качестве нижнего\nслоя;</p>\n<p>Стеклоэласт марок К-4.5 и К-5.0&nbsp;используется для устройства и ремонта\nкровли, в том числе металлической.</p>','Стеклоэласт - рулонный битумно-полимерный материал бизнес-класса для устройства плоских кровель и гидроизоляции строительных конструкций. Гибкость на брусе -20&deg;С, теплостойкость +100&deg;С'),(128,1,'Рубитэкс','<p>Битумно-полимерный рулонный кровельный и гидроизолирующий материал, который\nможет использоваться во всех климатических зонах, обеспечивая сохранность и\nнадежность важнейших объектов.</p>\n<p>Битумно-полимерное гомогенезированное вяжущее наносится исключительно на\nбиостойкие основы: стеклохолст, стеклоткань и полиэстер.</p>','Рубитэкс – купить оптом в Москве, интернет-магазин Ант-Снаб','Рубитэкс','Рубитэкс – битумно-полимерный рулонный кровельный и гидроизолирующий материал премиум-класса для самых важных объектов. Гибкость на брусе -25, теплостойкость +100 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, оргкровля, полимерный, сбс, модифицированный, Рубитэкс, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Материал&nbsp;применяется на объектах, где требуется исключительная\nнадежность. Благодаря своим уникальным свойствам кровля, выполненная из этого\nматериала, служит не менее 25 лет.</p>\n<p>Марки&nbsp;П-3.5, П-4.0 и П-5.0 применяются для гидроизоляции строительных\nконструкций, а также для устройства и ремонта кровли в качестве нижнего\nслоя;</p>\n<p>Марки К-4.5, К-5.0 и К-6.0&nbsp;используют для устройства и ремонта кровли в\nкачестве верхнего слоя или в качестве однослойного кровельного ковра.</p>','Рубитэкс - рулонный битумно-полимерный материал для плоских кровель и гидроизоляции строительных конструкций. Гибкость на брусе -25&deg;С, теплостойкость +100&deg;С'),(129,1,'Эластоизол Премиум','<p>Современный битумно-полимерный СБС-модифицированный наплавляемый кровельный\nи гидроизоляционный материал.</p>\n<p>Эластоизол Премиум производится путем нанесения модифицированного битумного\nвяжущего на основу: стеклохолст, стеклоткань или полиэстер. Благодаря\nдобавлению СБС-модификатора в битумное вяжущее, с материалом можно работать при\nтемпературе от -25°С до +100°С.</p>','Рулонные материалы Рязанского КРЗ – купить оптом в Москве, интернет-магазин Ант-Снаб','Эластоизол Премиум','Битумные наплавляемые кровельные материалы Рязанского КРЗ, одного из старейших заводов России. Купить все материалы для гидроизоляции фундаментов и плоской кровли можно оптом с доставкой в Москву в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумные, кровельные, рулонные, наплавляемые, гидроизоляционные, материалы, для крыши, плоская кровля, фундамент, гидроизоляция, крз, ркрз, рязанский, рязань, завод, производитель, купить, цена, у дилера, представителя, оптом, с доставкой, интернет-магазин, Ант-Снаб','<p>Эластоизол Премиум&nbsp;может применяться для устройства кровельного ковра\nзданий и сооружений всех типов, подойдет для гидроизоляции любых строительных\nконструкций.</p>\n<p>Верхний слой – с крупнозернистой сланцевой посыпкой серого цвета с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Эластоизол-Премиум - отличный рулонный битумно-полимерный материал для плоской кровли и гидроизоляции строительных конструкций. Эластоизол полный аналог Техноэласта, Рубитекса и Филизола. Гибкость на брусе -25&deg;С, теплостойкость +100&deg;С'),(130,1,'Эластоизол Бизнес','<p>Современный битумно-полимерный СБС-модифицированный наплавляемый кровельный\nи гидроизоляционный материал.</p>\n<p>Эластоизол Бизнес используется как в качестве кровельного покрытия, так и в\nкачестве гидроизоляционного материала. Добавление СБС-модификаторов в состав\nбитумного вяжущего положительно сказывается на минимальной температуре для\nработ и на эксплуатационных характеристиках.</p>','Эластоизол Бизнес – купить оптом в Москве, интернет-магазин Ант-Снаб','Эластоизол Бизнес','Эластоизол Бизнес – качественный наплавляемый гидроизоляционный кровельный материал. Гибкость на брусе -20, теплостойкость +95 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  полимерный, сбс, модифицированный, эластоизол, бизнес, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Верхний слой – с крупнозернистой сланцевой посыпкой серого цвета с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Эластоизол-Бизнес - битумно-полимерный материал для устройства плоских кровель и гидроизоляции строительных конструкций. Материал - аналог Унифлекса, Стеклоэласта, Айситекс-Стандарта и Филикрова. Гибкость на брусе -20&deg;С, теплостойкость +95&deg;С'),(131,1,'Эластоизол Проф','<p>Современный битумно-полимерный СБС-модифицированный наплавляемый кровельный\nи гидроизоляционный материал.</p>\n<p>Эластоизол Проф применяется&nbsp;для устройства кровельного ковра зданий и\nсооружений всех типов, а также для гидроизоляции строительных конструкций:\nфундаментов, тоннелей и других.</p>','Эластоизол Проф – купить оптом в Москве, интернет-магазин Ант-Снаб','Эластоизол Проф','Эластоизол Проф – качественный гидроизоляционный и кровельный наплавляемый материал. Гибкость на брусе -15, теплостойкость +85 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  полимерный, сбс, модифицированный, эластоизол, проф, элабит, 15, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Добавление СБС-модификаторов в битумное вяжущее привело к увеличению\nгибкости на брусе (до -15<sup>о</sup>С) и повышению теплостойкости\n(+85<sup>о</sup>С).</p>\n<p>Верхний слой – с крупнозернистой посыпкой серого цвета с лицевой стороны и\nполимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Эластоизол-Проф - рулонный битумно-полимерный материал для устройства плоских кровель и гидроизоляции строительных конструкций. Эластоизол-Проф полный аналог Эластобита, цена которого выше. Гибкость на брусе -15&deg;С, теплостойкость +85&deg;С'),(132,1,'Эластоизол Стандарт','<p>Современный битумно-полимерный СБС-модифицированный наплавляемый кровельный\nи гидроизоляционный материал.</p>\n<p>Эластоизол Стандарт применяется для устройства кровельного ковра зданий и\nсооружений всех типов, а также для гидроизоляции строительных конструкций:\nфундаментов, тоннелей и других.</p>','Эластоизол Стандарт – купить оптом в Москве, интернет-магазин Ант-Снаб','Эластоизол Стандарт','Эластоизол Стандарт – битумно-полимерный гидроизоляционный кровельный наплавляемый материал. Гибкость на брусе -10, теплостойкость +85 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  полимерный, сбс, модифицированный, эластоизол, стандарт, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>В состав битумного вяжущего материала входит полимер стирол-бутадиен-стирол,\nкоторый расширяет температурный рабочий диапазон и увеличивает срок службы\nвашей кровли. При правильном хранении и укладке материал прослужит до 15\nлет.</p>\n<p>Верхний слой – с крупнозернистой посыпкой серого цвета с лицевой стороны и\nполимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Эластоизол-Стандарт - рулонный битумно-полимерный материал для устройства плоских кровель и гидроизоляции строительных конструкций. Эластоизол-Стандарт полный аналог материала Стеклофлекс. Гибкость на брусе -10&deg;С, теплостойкость +85&deg;С'),(133,1,'Эластоизол Оптим','<p>Современный битумно-полимерный СБС-модифицированный наплавляемый кровельный\nи гидроизоляционный материал.</p>\n<p>Эластоизол Оптим применяется для устройства кровельного ковра зданий и\nсооружений всех типов, а также для гидроизоляции строительных конструкций:\nфундаментов, тоннелей и других.</p>','Эластоизол Оптим – купить оптом в Москве, интернет-магазин Ант-Снаб','Эластоизол Оптим','Эластоизол Оптим – битумно-модифицированный материал для кровли и гидроизоляции. Гибкость на брусе -5, теплостойкость +85 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  полимерный, сбс, модифицированный, эластоизол, оптим, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Материал Эластоизол Оптим одобрен к применению департаментом капитального\nремонта жилищного фонда, а также департаментом жилищно-коммунального хозяйства\nи благоустройства г. Москвы.</p>\n<p>Верхний слой – с крупнозернистой посыпкой серого цвета с лицевой стороны и\nполимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Эластоизол-Оптим - рулонный битумно-полимерный материал для устройства плоских кровель и гидроизоляции строительных конструкций. Материал - полный аналог Стеклокрома. Гибкость на брусе -5&deg;С, теплостойкость +85&deg;С'),(134,1,'Гидростеклоизол','<p>Традиционный для России рулонный кровельный и гидроизоляционный материал на\nстеклооснове.</p>\n<p>Гидростеклоизол производится путем нанесения битумного вяжущего на основу:\nстеклохолст или стеклоткань. Материалом можно работать при температуре до -3°С.\nТеплостойкость +85°С.</p>','Гидростеклоизол – купить оптом в Москве, интернет-магазин Ант-Снаб','Гидростеклоизол','Гидростеклоизол – битумный наплавляемый материал для кровли и гидроизоляции. Гибкость на брусе -3, теплостойкость +85 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  гидростеклоизол, стеклогидроизол, стекло, гидроизол, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Гидростеклоизол предназначен для устройства кровельного ковра зданий и\nсооружений, а также для гидроизоляции любых строительных конструкций. Срок\nслужбы материала — 10−15 лет, что делает его оптимальным по соотношению\nцена/качество.</p>\n<p>Верхний слой – с крупнозернистой посыпкой (гранулят серого цвета) с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Гидростеклоизол - надежный битумный материал по отличной цене за м², для фундамента и устройства плоских кровель и гидроизоляции строительных конструкций. Не имеет аналогов. Гибкость на брусе -3&deg;С, теплостойкость +85&deg;С'),(135,1,'Стекломаст','<p>Рулонный кровельный и гидроизоляционный материал на основе стеклоткани или\nполиэстера с пластификатором.</p>\n<p>Стекломаст применяется для устройства кровельного ковра на кровлях с уклоном\nне более 15 градусов. А также для гидроизоляции фундаментов и любых\nстроительных конструкций.</p>','Стекломаст – купить оптом в Москве, интернет-магазин Ант-Снаб','Стекломаст','Стекломаст – битумный наплавляемый гидроизоляционный и кровельный материал. Гибкость на брусе 0, теплостойкость +80 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  стекломаст, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Срок службы&nbsp;Стекломаста&nbsp;при соблюдении технологии укладки – не\nменее 15 лет.</p>\n<p>Верхний слой – с крупнозернистой посыпкой (гранулят серого цвета) с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Стекломаст - качественный и недорогой материал на стеклоткани для устройства плоских кровель и гидроизоляции строительных конструкций. Аналог таких материалов как Линокром, Бирепласт и Филигиз. Гибкость на брусе 0&deg;С, теплостойкость +80&deg;С'),(136,1,'Гидробарьер','<p>Рулонный кровельный и гидроизоляционный материал на стеклооснове.</p>\n<p>Производится вместо снятого с производства материала Стеклобит.</p>\n<p>Гидробарьер предназначен для устройства кровельного ковра зданий и\nсооружений, а также для гидроизоляции любых строительных конструкций. Срок\nслужбы покрытия при соблюдении технологии укладки – не менее 15 лет.</p>','Гидробарьер – купить оптом в Москве, интернет-магазин Ант-Снаб','Гидробарьер','Гидробарьер – битумный наплавляемый кровельный гидроизоляционный материал. Гибкость на брусе 0, теплостойкость +80 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  гидробарьер, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Материал Гидробарьер производится заводом относительно недавно, но уже\nуспешно используется для капитального и аварийного ремонта на многих кровлях\nгорода Москвы и Московской области.</p>\n<p>Верхний слой – с крупнозернистой посыпкой (гранулят серого цвета) с лицевой\nстороны и полимерной пленкой с нижней стороны полотна;</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Гидробарьер - качественный и недорогой материал на стеклоткани для устройства плоских кровель и гидроизоляции строительных конструкций. Аналог таких материалов как Линокром, Бирепласт и Филигиз. Гибкость на брусе 0&deg;С, теплостойкость +80&deg;С'),(137,1,'Гидроизол','<p>Надежный и недорогой рулонный кровельный и гидроизоляционный материал на\nстеклооснове.</p>\n<p>Материал получается путем двухстороннего нанесения покровного битумного\nсостава и посыпки.</p>\n<p>Производится Гидроизол исключительно на основе стеклоткани или стеклохолста.\nБлагодаря этому, существенно увеличивается долговечность изолируемой\nповерхности, поскольку основы не подвержены гниению.</p>','Гидроизол – купить оптом в Москве, интернет-магазин Ант-Снаб','Гидроизол','Гидроизол – недорогой битумный наплавляемый кровельный и гидроизоляционный материал. Гибкость на брусе 0, теплостойкость +80 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  гидроизол, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Гидроизол предназначен для устройства кровельного ковра зданий и сооружений\nвсех типов, с уклоном кровли не более 15 градусов.</p>\n<p>Также материал применяется в качестве гидроизоляции фундаментов, подвальных\nпомещений, перекрытий и иных строительных конструкций.</p>\n<p>Верхний слой – с крупнозернистой посыпкой (гранулят серого цвета) с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Гидроизол - надежный битумный материал, который можно наплавить, а можно приклеить на мастику. Аналог Стеклоизола и Бикроста. Гидроизол имеет прекрасные для своей цены характеристики - гибкость на брусе 0&deg;С, теплостойкость +80&deg;С'),(138,1,'Рубемаст','<p>Рулонный кровельный наплавляемый материал на основе картона.</p>\n<p>Рубемаст получают путем двустороннего нанесения покровного состава и посыпки\nна пропитанный битумом кровельный картон, плотность которого составляет не\nменее 350 г/м<sup>2</sup>.</p>','Рубемаст – купить оптом в Москве, интернет-магазин Ант-Снаб','Рубемаст','Рубемаст – наплавляемый битумный материал на основе картона для кровли и гидроизоляции. Гибкость на брусе +5, теплостойкость +70 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Битумный, рулонный, кровельный, гидроизоляционный, материал, для плоской кровли, фундамента, гидроизоляции, крыши, крз, ркрз, рязанский, рязань, завод,  рубемаст, купить, цена, у дилера, представителя, официального, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Материал&nbsp;используется для ремонта и устройства нижнего и верхнего слоя\nкровельного ковра, для гидроизоляции сооружений и зданий.</p>\n<p>В зависимости от марки, Рубемаст с верхней стороны рулона может быть покрыт\nтальком, не позволяющим слипаться слоям рулона, либо крупнозернистой крошкой\nдля защиты битумного вяжущего от ультрафиолета.</p>\n<p>Рубемаст РНП-350 – используется в качестве подкладочного (нижнего) слоя\nкровельного ковра при ремонте или устройстве плоских кровель. Также может\nиспользоваться в качестве гидроизоляционного материала.</p>\n<p>Рубемаст РНК-350 – применяется в качестве защитного (верхнего) слоя при\nремонте или устройстве плоской кровли.</p>','Рубемаст РНК и РНП - проверенный временем, надежный материал для плоской кровли. Представляет собой кровельный картон с нанесенным с двух сторон битумным вяжущим. Выпускается с крупнозернистой крошкой для верхнего слоя'),(139,1,'Техноэласт','<p>Рулонный кровельный и гидроизоляционный наплавляемый водостойкий\nбитумно-полимерный материал.</p>\n<p>Техноэласт&nbsp;получают путем двустороннего нанесения на стеклохолст,\nстеклоткань или полиэстер битумно-полимерного вяжущего, состоящего из битума,\nСБС полимерного модификатора и минерального наполнителя (тальк, доломит и др.).\nМатериал является биостойким.</p>','Техноэласт – купить оптом в Москве, интернет-магазин Ант-Снаб','Техноэласт','Техноэласт – битумно-полимерный наплавляемый материал для гидроизоляции и кровли. Гибкость на брусе -25, теплостойкость +100 градусов. Купить материал всех марок оптом и в розницу со склада или с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, технониколь, полимерный, сбс, модифицированный, техноэласт, купить, цена, у дилера, представителя, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Техноэласт применяется для устройства нижних слоев кровельного покрытия,\nгидроизоляции фундаментов, тоннелей, других строительных конструкций, а также\nдля устройства верхнего слоя кровельного ковра.</p>\n<p>Верхний слой – с крупнозернистой сланцевой посыпкой серого цвета с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>','Техноэласт – рулонный битумно–полимерный материал для устройства плоских кровель и гидроизоляции строительных конструкций. Гибкость на брусе –25&deg;С, теплостойкость +100&deg;С'),(140,1,'Унифлекс','<p>Рулонный наплавляемый битумно-полимерный кровельный и гидроизоляционный\nматериал.</p>\n<p>Унифлекс&nbsp;получают путем двустороннего нанесения на стекловолокнистую\nили полиэфирную основу битумно-полимерного вяжущего, которое состоит из битума,\nСБС-модификатора и минерального наполнителя.</p>','Унифлекс – купить оптом в Москве, интернет-магазин Ант-Снаб','Унифлекс','Унифлекс – наплавляемый битумно-полимерный гидроизоляционный и кровельный материал. Гибкость на брусе -20, теплостойкость +95 градусов. Купить материал всех марок оптом и в розницу со склада или с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, технониколь, полимерный, сбс, модифицированный, унифлекс, купить, цена, у дилера, представителя, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Унифлекс применяется для устройства нижних слоев кровельного ковра,\nгидроизоляции фундаментов и других строительных конструкций, а также для\nустройства верхнего слоя кровельного ковра.</p>\n<p>Верхний слой – с крупнозернистой сланцевой посыпкой серого цвета с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>',''),(141,1,'Биполь','<p>Рулонный наплавляемый кровельный материал.</p>\n<p>Биполь&nbsp;получают путем двустороннего нанесения на стекловолокнистую или\nполиэфирную основу битумно-полимерного вяжущего, состоящего из битума,\nСБС-модификатора и минерального наполнителя (тальк или доломит).</p>','Биполь – купить оптом в Москве, интернет-магазин Ант-Снаб','Биполь','Биполь – рулонный наплавляемый гидроизоляционный и кровельный битумный материал. Гибкость на брусе -15, теплостойкость +85 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, технониколь, полимерный, сбс, модифицированный, биполь, купить, цена, у дилера, представителя, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Марки ЭКП, ТКП, ХКП – применяются для устройства верхнего слоя кровельного\nковра.</p>\n<p>Марки ЭПП, ТПП, ХПП – используются в качестве нижнего слоя кровельного\nковра, для устройства гидроизоляции.</p>\n<p>Верхние слои – с крупнозернистой сланцевой посыпкой серого цвета с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижние слои – с полимерной пленкой с двух сторон полотна.</p>',''),(142,1,'Линокром','<p>Рулонный наплавляемый кровельный материал.</p>\n<p>Линокром&nbsp;получают путем двустороннего нанесения на стеклохолст,\nстеклоткань или полиэфирную основу битумного вяжущего, состоящего из битума,\nнаполнителя и технологических добавок, с последующим нанесением с двух сторон\nзащитных слоев.</p>','Линокром – купить оптом в Москве, интернет-магазин Ант-Снаб','Линокром','Линокром – битумный рулонный наплавляемый гидроизоляционный и кровельный материал. Гибкость на брусе 0, теплостойкость +80 градусов. Купить материал всех марок оптом и в розницу со склада или с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, технониколь, линокром, купить, цена, у дилера, представителя, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Марки ЭКП, ТКП, ХКП – применяются для устройства верхнего слоя кровельного\nпокрытия.</p>\n<p>Марки ЭПП, ТПП, ХПП – используются в качестве нижнего слоя кровельного\nпокрытия, а также для устройства гидроизоляции.</p>\n<p>Верхний слой – с крупнозернистой посыпкой серого цвета с лицевой стороны и\nполимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>',''),(143,1,'Бикрост','<p>Рулонный наплавляемый кровельный материал.</p>\n<p>Бикрост&nbsp;получают путем двустороннего нанесения на стеклохолст,\nперфорированный стеклохолст, каркасную стеклоткань или полиэфирную основу\nбитумного вяжущего, состоящего из битума и наполнителя, с последующим\nнанесением на обе стороны защитных слоев.</p>','Бикрост – купить оптом в Москве, интернет-магазин Ант-Снаб','Бикрост','Бикрост – рулонный битумный наплавляемый гидроизоляционный и кровельный материал. Гибкость на брусе 0, теплостойкость +80 градусов. Купить материал всех марок оптом с доставкой в Москву можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, технониколь, бикрост, купить, цена, у дилера, представителя, оптом, в розницу, с доставкой, интернет-магазин, Ант-Снаб','<p>Марки&nbsp;ЭКП, ТКП, ХКП – предназначены для устройства верхних слоев\nкровельного ковра.</p>\n<p>Марки ЭПП, ТПП, ХПП – используются в качестве нижних слоев кровельного\nпокрытия, а также для устройства гидроизоляции.</p>\n<p>Верхний слой – с крупнозернистой посыпкой серого цвета с лицевой стороны и\nполимерной пленкой с нижней стороны полотна.</p>\n<p>Нижний слой – с полимерной пленкой с двух сторон полотна.</p>',''),(144,1,'Техноэласт Акустик','<p>Рулонный прокладочный звукоизоляционный материал для шумоизоляции межэтажных\nперекрытий.</p>\n<p>Материал предотвращает распространение ударных шумов, передающихся по\nнесущим конструкциям здания.</p>\n<p>Техноэласт Акустик применяют в качестве звукоизолирующего слоя в\nсоответствии с требованиями СНиП 23-03-2003 и СП 51.13330.2011. Наиболее часто\nматериал используют при внутренней отделке помещений для устройства «плавающих»\nполов, полов с подогревом и полов по лагам, а также при установке межкомнатных\nперегородок.</p>','Техноэласт Акустик – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Техноэласт Акустик','Техноэласт Акустик – рулонный прокладочный звукоизоляционный материал для межэтажных перекрытий и устройства плавающих полов. Купить материал всех марок оптом и в розницу со склада или с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, гидроизоляционный, звукоизоляционный, шумоизоляционный, виброизоляционный, материал, для стяжки, полов, плавающих, межэтажных перекрытий, полимерный, модифицированный, техноэласт, акустик, купить, цена, у дилера, представителя, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Техноэласт Акустик Супер А350 – звуко- гидроизоляционный материал,\nпроизводится на основе стеклохолста, на обе стороны которого нанесено\nбитумно-полимерное вяжущее со слоем звукоизоляционного термоскрепленного\nполотна с одной стороны и металлизированной пленкой с другой стороны полотна.\nПрименяемая в материале пленка улучшает теплоизоляционные свойства\nзвукоизолирующей прослойки.</p>\n<p>Техноэласт Акустик С Б350 – звукоизоляционный безосновный материал с\nсамоклеящимся боковым нахлестом. Производится путем склейки битумным вяжущим\nметаллизированной полиэфирной пленки со звукоизоляционным полотном.\nСамоклеящийся боковой нахлест дополнительно закрыт силиконизированной пленкой.\nПрименяемая в материале металлизированная пленка обладает высокой стойкостью к\nпроколам и предотвращает увлажнение звукоизолирующего слоя при укладке\nцементно-песчаной стяжки.</p>',''),(145,1,'Стеклоизол Р','<p>Рулонный наплавляемый гидроизоляционный и кровельный материал.</p>\n<p>Стеклоизол Р&nbsp;получают путем двустороннего нанесения на стеклохолст,\nперфорированный стеклохолст или каркасную стеклоткань битумного вяжущего,\nсостоящего из битума и наполнителя, с последующим нанесением на обе стороны\nзащитных слоев.</p>','Стеклоизол Р – купить оптом в Москве, интернет-магазин Ант-Снаб','Стеклоизол Р','Стеклоизол Р – недорогой рулонный битумный наплавляемый материал для гидроизоляции и кровли. Гибкость на брусе 0, теплостойкость +80 градусов. Купить материал всех марок оптом и в розницу со склада или с доставкой по Москве можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Рулонный, наплавляемый, кровельный, битумный, гидроизоляционный, материал, для плоской кровли, гидроизоляции, фундаментов, крыши, технониколь, стеклоизол, р, купить, цена, у дилера, представителя, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Марки ТКП и ХКП – применяются для устройства верхних слоев кровельного ковра\nс защитной от ультрафиолетового излучения и атмосферных осадков.</p>\n<p>Марки ТПП и ХПП – используются в качестве нижних слоев кровельного покрытия,\nа также для устройства гидроизоляции.</p>\n<p>Верхние слои – с крупнозернистой сланцевой посыпкой серого цвета с лицевой\nстороны и полимерной пленкой с нижней стороны полотна.</p>\n<p>Нижние слои – с полимерной пленкой с двух сторон полотна.</p>',''),(146,1,'Бутиленовые','<p>Герметики на основе бутилена для широкого спектра общестроительных работ.\nИспользуются для герметизации швов и соединений с деформацией не более 7%.</p>\n<p>ООО \"ТК Ант-Снаб\" — официальный представитель концерна Soudal, ведущего\nмирового производителя герметизирующих материалов.</p>\n<p>В нашем интернет-магазине всегда найдется оптимальный вариант для покупки.\nЗабрать товары можно самостоятельно со склада или заказать доставку по Москве и\nМосковской области.</p>','Бутиленовые герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Бутиленовые герметики','Строительные герметики на бутиленовой основе для внутренних и наружных работ. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, бутиленовые, однокомпонентные, готовые, строительные, внутренние, наружные, работы, деформация, деформационные, серый, белый, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Преимущества бутиленовых герметиков:</p>\n<p>●&nbsp;невысокая цена;<br>\n●&nbsp;постоянная эластичность под пленкой&nbsp;- никогда не высыхает, не\nлопается и не сжимается;<br>\n●&nbsp;не содержит растворителей и не оставляет пятен на пористых\nповерхностях;<br>\n●&nbsp;отличная адгезия ко всем строительным материалам: бетону, металлу,\nкерамике, стеклу, дереву;<br>\n●&nbsp;создает газонепроницаемый барьер не пропуская запахов.</p>\n<p>Выпускаются герметики двух цветов: серый и белый.</p>',''),(147,1,'Битумные и кровельные','<p>В разделе представлены материалы на основе битумных эластомеров и акриловой\nдисперсии для герметизации или ремонта (в том числе аварийного) различных\nкровельных покрытий.</p>\n<p>ООО \"ТК Ант-Снаб\" — официальный партнер компании Soudal, ведущего мирового\nпроизводителя герметизирующих материалов.</p>\n<p>В нашем магазине можно подобрать подходящий материал, купить его со склада в\nМоскве или заказать доставку в удобное время.</p>','Битумные кровельные герметики  – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Битумные и кровельные герметики и ленты','Кровельные герметики и ленты на основе битума или акриловой дисперсии для устройства, текущего и аварийного ремонта кровель всех типов. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, ленты, кровельные, битумные, акриловые, алюминиевые, герметизирующие, самоклеящиемся, прозрачные, профессиональные, ремонт, кровля, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Ант-Снаб предлагает своим клиентам кровельные герметики и самоклеящиеся\nгерметизирующие ленты оптом и в розницу, от 1 шт. Все популярные материалы\nвсегда в наличии на нашем московском складе.</p>',''),(148,1,'Тиоколовые','<p>Тиоколовые герметики пользуются большой популярностью из-за высокой\nстойкости к ультрафиолетовому излучению, водостойкости, прекрасной адгезии и\nотсутствия усадки.</p>\n<p>ООО \"ТК Ант-Снаб\" — официальный представитель компании САЗИ, которая уже\nболее 20 лет занимается разработкой и производством тиоколовых герметиков.</p>\n<p>В нашем интернет-магазине всегда можно подобрать оптимальный вариант, а\nзатем заказать его с доставкой по Москве и Московской области.</p>','Тиоколовые герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Тиоколовые герметики','Двухкомпонентные строительные герметики на тиоколовой основе для деформационных, дорожных, бетонных и других швов. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, тиоколовые, двухкомпонентные, строительные, тиокол, полимер, деформационный, дорожный, бетонный, шов, САЗИ, Сазиласт, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Двухкомпонентные тиоколовые герметики используются для герметизации:</p>\n<p>●&nbsp;швов, нарезанных в бетонных поверхностях;<br>\n●&nbsp;элементов автодорог;<br>\n●&nbsp;фальцев и других элементов металлических кровель;<br>\n●&nbsp;вводов коммуникаций.</p>\n<p>Герметики поставляются в виде комплекта: основная паста и вулканизирующая\nпаста. Основной цвет - серый.</p>',''),(149,1,'MS Полимеры','<p>Гибридные герметики и клей-герметики на основе MS-полимера получили широкое\nраспространение благодаря целому ряду причин: великолепная липкость к\nповерхностям (в том числе влажным), отсутствие запаха, возможность окрашивания,\nустойчивость к УФ-излучению, широкий диапазон температур применения.</p>\n<p>Компания Ант-Снаб — официальный представитель Soudal и САЗИ, ведущих\nпроизводителей материалов на основе МС-полимера.</p>\n<p>В нашем интернет-магазине вы сможете подобрать оптимальный для себя вариант,\nзаказать его с доставкой или забрать самостоятельно со склада.</p>','MS-полимерные герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Гибридные герметики на основе МС-полимеров','Готовые к применению герметики и клей-герметики на основе гибридного МС-полимера для внутренних и наружных работ. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, клеи, клей-герметики, гибридный, полимер, МС, MS, smx, фиксалл, Соудал, САЗИ, универсальные, наружные, внутренние, работы, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>На сегодняшний день гибридные герметики получают все большее распространение\nв строительстве и различном производстве, в автомобилестроении и\nсудостроении.</p>\n<p>Мы предлагаем своим клиентам герметизирующие материалы на основе гибридного\nполимера в удобных упаковках: картриджах 290 мл и ведрах 15 кг.</p>',''),(150,1,'Полиуретановые','<p>Герметики на основе полиуретана получили широкое распространение по\nнескольким причинам: отличная эластичность (до 1000%), прекрасная адгезия к\nбетону и металлу, долговечность, отсутствие усадки.</p>\n<p>Ант-Снаб — официальный представитель ведущих российских и мировых\nпроизводителей полиуретановых герметиков: САЗИ, Soudal и Ecoroom.</p>\n<p>В нашем интернет-магазине можно выбрать однокомпонентные и двухкомпонентные\nполиуретановые герметики, купить их самостоятельно со склада в Москве или\nзаказать доставку.</p>','Полиуретановые герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Полиуретановые герметики для швов','Однокомпонентные и двухкомпонентные строительные герметики на основе полиуретана для герметизации, ремонта и заделки межпанельных деформационных швов. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, полиуретановые, однокомпонентные, двухкомпонентные, готовые, для межпанельных, деформационных, швов, бетонные, САЗИ, Соудал, Экорум, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Полиуретановые герметики широко используются в современном строительстве и\nпроизводстве:</p>\n<p>●&nbsp;межпанельные швы в гражданском и промышленном строительстве;<br>\n●&nbsp;деформационные швы в бетонных полах;<br>\n●&nbsp;соединения на кровле;<br>\n●&nbsp;структурное остекление зимних садов и теплиц;<br>\n●&nbsp;автомобильное производство;<br>\n●&nbsp;установка окон и стеклопакетов.</p>\n<p>Ант-Снаб предлагает герметики в тубах по 310 мл, колбасах 600 мл и ведрах\nдля промышленного использования.<br></p>',''),(151,1,'Силиконовые','<p>Силиконовые герметики пользуются большой популярностью благодаря широкой\nобласти применения, простоте использования и невыской цене.</p>\n<p>ООО \"ТК Ант-Снаб\" — официальный представитель компании Soudal, мирового\nлидера среди производителей герметизирующих материалов на основе силикона.</p>\n<p>В нашем интернет-магазине всегда можно выбрать качественные и недорогие\nматериалы, самостоятельно забрать их со склада или заказать с доставкой по\nМоскве и Московской области.</p>','Силиконовые герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Силиконовые герметики','Однокомпонентные герметики на силиконовой основе для герметизации внутри и снаружи помещений. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, бытовые, силиконовые, силиконы, нейтральные, санитарные, универсальные, цветные, бесцветные, однокомпонентные, готовые, в картриджах, тубах, колбасах, файл-пакет, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Однокомпонентные силиконовые герметики делятся на два типа по своему\nхимическому составу:</p>\n<p><strong>Кислотные</strong> - довольно сильно пахнут уксусом,\nдешевые,&nbsp;вызывают коррозию некоторых металлов.<br>\n<strong>Нейтральные</strong> - пахнут слабее кислотных, не вызывают коррозии,\nно стоят дороже.</p>\n<p>В нашем магазине представлены оба вида герметиков, если вы затрудняетесь с\nвыбором, обращайтесь к нашим <a href=\"djem://238\">сотрудникам</a>. Они всегда\nпомогут сделать правильный выбор.</p>',''),(152,1,'Акриловые','<p>Акриловые или акрилатные герметики широко используются в строительстве\nблагодаря прекрасной адгезии к большинству материалов, возможности легкого\nокрашивания и низкой цене.</p>\n<p>ООО \"ТК Ант-Снаб\" — представитель ведущих российских и мировых\nпроизводителей герметизирующих материалов на основе акрила: Soudal, САЗИ,\nEcoroom.</p>\n<p>В нашем интернет-магазине можно выбрать материалы на любой вкус, купить их\nсамостоятельно со склада или заказать с доставкой по Москве и области.</p>','Акриловые герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Акриловые герметики','Однокомпонентные герметики на акриловой (акрилатной) основе для герметизации внутри и снаружи помещений, заделки межпанельных швов, установки окон. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, акриловые, акрилатные, окрашиваемые, наружные, внутренние, работы, межпанельные швы, оконные, однокомпонентные, готовые, бытовые, профессиональные, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>При выборе в качестве герметизирующего материала герметиков на основе акрила\nважно помнить, что максимально допустимая для&nbsp;них&nbsp;деформация - 15%. В\nпротивном случае возможно отслаивание от поверхности.</p>\n<p>Также при покупке следует обратить внимание на то, водостойкий герметик или\nнет. Неводостойкие варианты могут применяться при осуществлении работ внутри\nпомещений. Водостойкие - при изоляции оконных блоков или работах на кровле.</p>',''),(153,1,'Бутилкаучуковые','<p>Бутилкаучуковые (бутил-каучуковые) герметики пользуются огромным спросом при\nгерметизации межпанельных&nbsp;швов&nbsp;благодаря широкому диапазону рабочих\nтемператур (от -20<sup>о</sup>С до +40<sup>о</sup>С), высокой эластичности и\nневысокой цене в сравнении&nbsp;с шовными материалами на других основах.</p>\n<p>Компания Ант-Снаб предалагает своим клиентам только качественные и доступные\nматериалы производства ЗАО \"Интерстек\" и ТехноНИКОЛЬ.</p>\n<p>В нашем магазине всегда можно выбрать оптимальный вариант, купить\nего&nbsp;из наличия на&nbsp;складе или же заказать доставку по Москве и\nМосковской области.</p>','Бутилкаучуковые герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Бутилкаучуковые герметики для межпанельных швов','Готовые к применению однокомпонентные бутилкаучуковые герметики для герметизации, ремонта и заделки межпанельных швов. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, бутиловые, бутилкаучуковые, бутил, каучуковые, однокомпонентные, готовые, в ведрах, межпанельные швы, ремонт, заделка, серый, белый, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Самым известным однокомпонентным герметиком на основе бутилового каучука\nдолгие годы был Гермабутил-С. Но он снят с производства, и купить его более не\nпредставляется возможным.</p>\n<p>Беда небольшая, поскольку существующие сейчас на рынке аналоги не только не\nуступают, но и превосходят каноничный гермабутил по техническим\nхарактеристикам.</p>\n<p>Герметик выпускается в двух цветах: сером и белом. Материал белого цвета\nпосле отверждения можно окрашивать всеми видами фасадных красок.</p>',''),(154,1,'Высокотемпературные и термостойкие','<p>В разделе представлены материалы на основе силикона и силиката\nнатрия&nbsp;для герметизации соединений и узлов, подверженных воздействию\nвысоких температур.</p>\n<p>Ант-Снаб — официальный партнер компании Soudal, ведущего мирового\nпроизводителя герметизирующих материалов.</p>\n<p>Выбрать и купить материалы всегда можно в нашем интернет-магазине. Покупки\nможно забрать самостоятельно или заказать доставку.</p>','Высокотемпературные герметики – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Высокотемпературные и термостойкие герметики','Герметики, выдерживающие воздействие очень высоких температур и открытого огня. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Герметики, высокотемпературные, силикон, силиконовые, силикатные, силикат, для печей, каминов, дымоходов, огнестойкий, огнезащитный, красный, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','',''),(155,1,'Бытовые пены','<p>Полиуретановые монтажные пены бытового применения. Баллоны оснащены\nтрубочками-адаптерами для нанесения без пистолета. Представлены пены для\nлетнего или всесезонного использования.</p>\n<p>Ант-Снаб — официальный партнер ведущих производителей: Soudal и\nТехноНИКОЛЬ.</p>\n<p>В интернет-магазине можно выбрать оптимальный вариант, купить его\nсамостоятельно со склада в Москве или заказать доставку в удобное для вас\nвремя.</p>','Бытовые монтажные пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Бытовые монтажные пены с трубочкой','Летние и всесезонные монтажные пены бытового применения с трубочкой для ручного нанесения. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Монтажные пены, бытовые, с трубочкой, ручные, нанесение, однокомпонентные, для окон, дверей, полиуретановые, Соудал, Soudal, Технониколь, летние, всесезонные, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Бытовые монтажные пены отличаются разным объемом выхода, обратите на это\nвнимание при выборе. Ведь радость от низкой цены может резко улетучиться, если\nбаллона не хватит для решения поставленных задач.</p>\n<p>Если сомневаетесь в правильном выборе, смело обращайтесь к\n<a href=\"djem://238\">нашим сотрудникам</a>, они помогут.</p>',''),(156,1,'Профессиональные пены','<p>Однокомпонентные монтажные пены для использования с пистолетом. В разделе\nпредставлены летние и всесезонные пены.</p>\n<p>ООО \"ТК Ант-Снаб\" — партнер ведущих российских и мировых производителей\nпены: ТехноНИКОЛЬ и Soudal.</p>\n<p>В нашем интернет-магазин всегда можно выбрать оптимальный вариант, заказать\nего с доставкой или купить на складе в Москве.</p>','Профессиональные монтажные пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Профессиональные монтажные пены','Профессиональные всесезонные и летние монтажные пены под пистолет. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Монтажные пены, полиуретановые, пистолетные, однокомпонентные, профессиональные, под пистолет, летние, всесезонные, Соудал, Технониколь, Soudal, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Профессиональные монтажные пены отличаются объемом выхода из баллона.\nОбращайте на это внимание перед тем как сделать окончательный выбор. Ведь\nрадость от сэкономленных денег может исчезнуть также внезапно, как и пена.</p>\n<p>Обращайтесь за консультацией к нашим <a href=\"djem://238\"\ntarget=\"_blank\">сотрудникам</a>, они помогут сделать оптимальный выбор.</p>',''),(157,1,'Огнестойкие пены','<p>Однокомпонентные огнезащитные монтажные пены для герметизации швов.\nЗамедляют воспламенение, защищают от газов и задымления.</p>\n<p>Компания Ант-Снаб — официальный партнер ведущих производителей: Soudal и\nТехноНИКОЛЬ.</p>\n<p>В нашем интернет-магазине всегда можно выбрать подходящую пену, купить и\nзабрать ее самостоятельно со склада или заказать доставку по Москве и\nМосковской области.</p>','Огнестойкие монтажные пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Огнестойкие монтажные пены','Огнестойкие монтажные пены ручного нанесения с трубочкой или под пистолет. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Монтажные пены, полиуретановые, огнезащитные, противопожарные, огнестойкие, ручные, пистолетные, с трубочкой, под пистолет, красная, розовая, Соудал, Soudal, Технониколь, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем огнестойкие монтажные пены оптом и в розницу, минимальная партия\nк отгрузке - 1 баллон. Большинство продукции всегда в наличии на складе.</p>',''),(158,1,'Зимние пены','<p>Бытовые и профессиональные монтажные пены, предназначенные для использования\nпри низких температурах (до -18<sup>о</sup>С).</p>\n<p>Компания Ант-Снаб — официальный партнер ведущих мировых производителей пены:\nSoudal и ТехноНИКОЛЬ.</p>\n<p>В нашем интернет-магазине вы сможете выбрать нужный материал, оформить\nзаказ, забрать его самостоятельно со склада в Москве или заказать доставку в\nудобное время.</p>','Зимние монтажные пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Зимние бытовые и профессиональные монтажные пены','Зимние монтажные пены ручного применения с трубочкой или профессиональные под пистолет для работ при низких температурах. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Монтажные пены, зимние, бытовые, профессиональные, ручные, с трубочкой, пистолетные, под пистолет, Соудал, Soudal, Технониколь, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>При выборе зимней пены обращайте внимание не только на привлекательную цену,\nно и на объем выхода из баллона. Иногда радость от сэкономленных денег проходит\nтакже быстро, как и пена.</p>\n<p>Сделать правильный выбор всегда помогут наши\n<a href=\"djem://238\">менеджеры</a>, обращайтесь!</p>',''),(159,1,'Очистители пены','<p>Тщательно подобранные смеси растворителей в аэрозольных баллонах для\nудаления незатвердевшей монтажной пены с одежды и поверхностей, для очистки\nинструментов.</p>\n<p>ООО \"ТК Ант-Снаб\"&nbsp;— официальный представитель ведущих производителей:\nSoudal и ТехноНИКОЛЬ.</p>\n<p>В нашем интернет-магазине всегда можно выбрать оптимальный материал,\nзаказать его с доставкой или забрать самостоятельно со склада в Москве.</p>','Очистители монтажной пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Очистители монтажной пены','Очистители для удаления незасохшей монтажной пены и очистки инструмента и пистолетов. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Очистители, для монтажной пены, инструмента, незастывшая, неотвердевшая, для удаления, Соудал, Soudal, Технониколь, с трубочкой, адаптером, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>При выборе очистителей для монтажной пены обращайте внимание на показатель\nнапоненности баллона. Дешевое - не всегда лучшее.</p>\n<p>Если сомневаетесь, обращайтесь к нашим <a href=\"djem://238\">сотрудникам</a>,\nони всегда помогут.</p>',''),(160,1,'Жидкие гвозди','<p>Универсальные клеящие составы для приклеивания различных строительных и\nотделочных материалов к поверхностям.</p>\n<p>ООО \"ТК Ант-Снаб\" — официальный партнер концерна Soudal, признанного лидера\nсреди производителей клеящих и герметизирующих материалов.</p>\n<p>В нашем интернет-магазин всегда можно подобрать оптимальный вариант,\nоформить заказ, забрать покупки самостоятельно или заказать доставку по\nМоскве.</p>','Жидкие гвозди – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Монтажные клеи и жидкие гвозди','Клеи на каучуковой основе для качественного приклеивания различных строительных и отделочных материалов. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Клей, монтажный, каучуковый, жидкие гвозди, приклеивание, строительные, отделочные, материалы, плинтусы, пвх, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем жидкие гвозди не только оптом, но и в розницу, от 1\nкартриджа.</p>',''),(161,1,'Химические анкеры','<p>Профессиональные и бытовые химические анкеры на основе винилэстеровых или\nполиэстеровых смол&nbsp;для крепления различных элементов без монтажного\nнапряжения.</p>\n<p>Ант-Снаб — официальный представитель мирового концерна Soudal, лидера в\nобласти разработки и производства хим. анкеров.</p>\n<p>В нашем интернет-магазине легко сделать правильный выбор, оформить заказ,\nкупить материал самостоятельно на складе или заказать доставку по Москве и\nобласти.</p>','Химические анкеры – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Химические анкеры','Химические анкеры для крепления различных элементов без монтажного напряжения. Применяются снаружи и внутри помещений. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Химические анкеры, крепление, без монтажного, напряжения, винилэстеровые, винил, полиэстеровые, эстеровые, картриджи, тубы, Соудал, Soudal, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем химические анкеры не только крупным и мелким оптом, но и в\nрозницу. Минимальный заказ - 1 картридж.</p>\n<p>Большинство представленной продукции всегда в наличии на складе.</p>',''),(162,1,'Клей-пена','<p>Однокомпонентные полиуретановые клей-пены в баллонах ручного и пистолетного\nнанесения для приклеивания различных строительных и отделочных материалов.</p>\n<p>Компания Ант-Снаб — официальный партнер ведущих мировых и российских\nпроизводителей: Soudal и ТехноНИКОЛЬ.</p>\n<p>В нашем интернет-магазине всегда можно подобрать подходящий материал,\nоформить покупку, забрать товар самостоятельно или заказать доставку по Москве\nи области.</p>','Клей-пены – купить оптом и в розницу в Москве, интернет-магазин Ант-Снаб','Клей-пены','Полиуретановые клей-пены в баллонах для приклеивания теплоизоляционных и других строительных материалов к различным поверхностям. Купить все материалы в розницу и оптом со складов в Москве или с доставкой можно в компании Ант-Снаб. (495) 255-01-37 или 8-800 775-28-31','Клей-пены, полиуретановые, однокомпонентные, в баллоне, аэрозоли, приклеивание, стройматериалы, строительные, материалы, теплоизоляция, пенополистирол, xps, купить, цена, оптом, в розницу, со склада, в Москве, с доставкой, интернет-магазин, Ант-Снаб','<p>Мы продаем клей-пену не только крупным и мелким оптом, но и в розницу.\nМинимальная партия к отгрузке - 1 баллон. Большинство представленной продукции\nвсегда в наличии на складе.</p>','');
/*!40000 ALTER TABLE `oc_category_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_category_filter`
--

DROP TABLE IF EXISTS `oc_category_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_category_filter` (
  `category_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_category_filter`
--

LOCK TABLES `oc_category_filter` WRITE;
/*!40000 ALTER TABLE `oc_category_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_category_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_category_path`
--

DROP TABLE IF EXISTS `oc_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_category_path` (
  `category_id` int(11) NOT NULL,
  `path_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`path_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_category_path`
--

LOCK TABLES `oc_category_path` WRITE;
/*!40000 ALTER TABLE `oc_category_path` DISABLE KEYS */;
INSERT INTO `oc_category_path` VALUES (71,71,0),(73,71,0),(73,73,1),(74,71,0),(74,74,1),(75,71,0),(75,75,1),(76,71,0),(76,76,1),(77,71,0),(77,77,1),(78,71,0),(78,78,1),(79,71,0),(79,79,1),(80,71,0),(80,80,1),(81,71,0),(81,81,1),(82,71,0),(82,82,1),(83,71,0),(83,83,1),(84,71,0),(84,84,1),(85,71,0),(85,73,1),(85,85,2),(86,71,0),(86,73,1),(86,86,2),(87,71,0),(87,73,1),(87,87,2),(88,71,0),(88,73,1),(88,88,2),(89,71,0),(89,73,1),(89,89,2),(90,71,0),(90,74,1),(90,90,2),(91,71,0),(91,74,1),(91,91,2),(92,71,0),(92,74,1),(92,92,2),(93,71,0),(93,74,1),(93,93,2),(94,71,0),(94,75,1),(94,94,2),(95,71,0),(95,75,1),(95,95,2),(96,71,0),(96,75,1),(96,96,2),(97,71,0),(97,76,1),(97,97,2),(98,71,0),(98,76,1),(98,98,2),(99,71,0),(99,77,1),(99,99,2),(100,71,0),(100,77,1),(100,100,2),(101,71,0),(101,77,1),(101,101,2),(102,71,0),(102,78,1),(102,102,2),(103,71,0),(103,79,1),(103,103,2),(104,71,0),(104,81,1),(104,104,2),(105,71,0),(105,81,1),(105,105,2),(106,71,0),(106,82,1),(106,106,2),(107,71,0),(107,80,1),(107,107,2),(108,71,0),(108,80,1),(108,108,2),(109,71,0),(109,80,1),(109,109,2),(110,71,0),(110,80,1),(110,110,2),(111,71,0),(111,80,1),(111,111,2),(112,71,0),(112,80,1),(112,112,2),(113,71,0),(113,83,1),(113,113,2),(114,71,0),(114,83,1),(114,114,2),(115,71,0),(115,83,1),(115,115,2),(116,71,0),(116,83,1),(116,116,2),(117,71,0),(117,83,1),(117,117,2),(118,71,0),(118,83,1),(118,118,2),(119,71,0),(119,83,1),(119,119,2),(120,71,0),(120,84,1),(120,120,2),(121,71,0),(121,84,1),(121,121,2),(122,71,0),(122,84,1),(122,122,2),(123,71,0),(123,73,1),(123,85,2),(123,123,3),(124,71,0),(124,73,1),(124,85,2),(124,124,3),(125,71,0),(125,73,1),(125,85,2),(125,125,3),(126,71,0),(126,73,1),(126,85,2),(126,126,3),(127,71,0),(127,73,1),(127,85,2),(127,127,3),(128,71,0),(128,73,1),(128,85,2),(128,128,3),(129,71,0),(129,73,1),(129,86,2),(129,129,3),(130,71,0),(130,73,1),(130,86,2),(130,130,3),(131,71,0),(131,73,1),(131,86,2),(131,131,3),(132,71,0),(132,73,1),(132,86,2),(132,132,3),(133,71,0),(133,73,1),(133,86,2),(133,133,3),(134,71,0),(134,73,1),(134,86,2),(134,134,3),(135,71,0),(135,73,1),(135,86,2),(135,135,3),(136,71,0),(136,73,1),(136,86,2),(136,136,3),(137,71,0),(137,73,1),(137,86,2),(137,137,3),(138,71,0),(138,73,1),(138,86,2),(138,138,3),(139,71,0),(139,73,1),(139,87,2),(139,139,3),(140,71,0),(140,73,1),(140,87,2),(140,140,3),(141,71,0),(141,73,1),(141,87,2),(141,141,3),(142,71,0),(142,73,1),(142,87,2),(142,142,3),(143,71,0),(143,73,1),(143,87,2),(143,143,3),(144,71,0),(144,73,1),(144,87,2),(144,144,3),(145,71,0),(145,73,1),(145,87,2),(145,145,3),(146,71,0),(146,75,1),(146,96,2),(146,146,3),(147,71,0),(147,75,1),(147,96,2),(147,147,3),(148,71,0),(148,75,1),(148,96,2),(148,148,3),(149,71,0),(149,75,1),(149,96,2),(149,149,3),(150,71,0),(150,75,1),(150,96,2),(150,150,3),(151,71,0),(151,75,1),(151,96,2),(151,151,3),(152,71,0),(152,75,1),(152,96,2),(152,152,3),(153,71,0),(153,75,1),(153,96,2),(153,153,3),(154,71,0),(154,75,1),(154,96,2),(154,154,3),(155,71,0),(155,75,1),(155,94,2),(155,155,3),(156,71,0),(156,75,1),(156,94,2),(156,156,3),(157,71,0),(157,75,1),(157,94,2),(157,157,3),(158,71,0),(158,75,1),(158,94,2),(158,158,3),(159,71,0),(159,75,1),(159,94,2),(159,159,3),(160,71,0),(160,75,1),(160,95,2),(160,160,3),(161,71,0),(161,75,1),(161,95,2),(161,161,3),(162,71,0),(162,75,1),(162,95,2),(162,162,3);
/*!40000 ALTER TABLE `oc_category_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_category_to_layout`
--

DROP TABLE IF EXISTS `oc_category_to_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_category_to_layout` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_category_to_layout`
--

LOCK TABLES `oc_category_to_layout` WRITE;
/*!40000 ALTER TABLE `oc_category_to_layout` DISABLE KEYS */;
INSERT INTO `oc_category_to_layout` VALUES (71,0,0),(73,0,0),(74,0,0),(75,0,0),(76,0,0),(77,0,0),(78,0,0),(79,0,0),(80,0,0),(81,0,0),(82,0,0),(83,0,0),(84,0,0),(85,0,0),(86,0,0),(87,0,0),(88,0,0),(89,0,0),(90,0,0),(91,0,0),(92,0,0),(93,0,0),(94,0,0),(95,0,0),(96,0,0),(97,0,0),(98,0,0),(99,0,0),(100,0,0),(101,0,0),(102,0,0),(103,0,0),(104,0,0),(105,0,0),(106,0,0),(107,0,0),(108,0,0),(109,0,0),(110,0,0),(111,0,0),(112,0,0),(113,0,0),(114,0,0),(115,0,0),(116,0,0),(117,0,0),(118,0,0),(119,0,0),(120,0,0),(121,0,0),(122,0,0),(123,0,0),(124,0,0),(125,0,0),(126,0,0),(127,0,0),(128,0,0),(129,0,0),(130,0,0),(131,0,0),(132,0,0),(133,0,0),(134,0,0),(135,0,0),(136,0,0),(137,0,0),(138,0,0),(139,0,0),(140,0,0),(141,0,0),(142,0,0),(143,0,0),(144,0,0),(145,0,0),(146,0,0),(147,0,0),(148,0,0),(149,0,0),(150,0,0),(151,0,0),(152,0,0),(153,0,0),(154,0,0),(155,0,0),(156,0,0),(157,0,0),(158,0,0),(159,0,0),(160,0,0),(161,0,0),(162,0,0);
/*!40000 ALTER TABLE `oc_category_to_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_category_to_store`
--

DROP TABLE IF EXISTS `oc_category_to_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_category_to_store` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_category_to_store`
--

LOCK TABLES `oc_category_to_store` WRITE;
/*!40000 ALTER TABLE `oc_category_to_store` DISABLE KEYS */;
INSERT INTO `oc_category_to_store` VALUES (71,0),(73,0),(74,0),(75,0),(76,0),(77,0),(78,0),(79,0),(80,0),(81,0),(82,0),(83,0),(84,0),(85,0),(86,0),(87,0),(88,0),(89,0),(90,0),(91,0),(92,0),(93,0),(94,0),(95,0),(96,0),(97,0),(98,0),(99,0),(100,0),(101,0),(102,0),(103,0),(104,0),(105,0),(106,0),(107,0),(108,0),(109,0),(110,0),(111,0),(112,0),(113,0),(114,0),(115,0),(116,0),(117,0),(118,0),(119,0),(120,0),(121,0),(122,0),(123,0),(124,0),(125,0),(126,0),(127,0),(128,0),(129,0),(130,0),(131,0),(132,0),(133,0),(134,0),(135,0),(136,0),(137,0),(138,0),(139,0),(140,0),(141,0),(142,0),(143,0),(144,0),(145,0),(146,0),(147,0),(148,0),(149,0),(150,0),(151,0),(152,0),(153,0),(154,0),(155,0),(156,0),(157,0),(158,0),(159,0),(160,0),(161,0),(162,0);
/*!40000 ALTER TABLE `oc_category_to_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_country`
--

DROP TABLE IF EXISTS `oc_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `iso_code_2` varchar(2) NOT NULL,
  `iso_code_3` varchar(3) NOT NULL,
  `address_format` text NOT NULL,
  `postcode_required` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`country_id`)
) ENGINE=MyISAM AUTO_INCREMENT=258 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_country`
--

LOCK TABLES `oc_country` WRITE;
/*!40000 ALTER TABLE `oc_country` DISABLE KEYS */;
INSERT INTO `oc_country` VALUES (1,'Афганистан','AF','AFG','',0,0),(2,'Албания','AL','ALB','',0,0),(3,'Алжир','DZ','DZA','',0,0),(4,'Восточное Самоа','AS','ASM','',0,0),(5,'Андорра','AD','AND','',0,0),(6,'Ангола','AO','AGO','',0,0),(7,'Ангилья','AI','AIA','',0,0),(8,'Антарктида','AQ','ATA','',0,0),(9,'Антигуа и Барбуда','AG','ATG','',0,0),(10,'Аргентина','AR','ARG','',0,0),(11,'Армения','AM','ARM','',0,1),(12,'Аруба','AW','ABW','',0,0),(13,'Австралия','AU','AUS','',0,0),(14,'Австрия','AT','AUT','',0,0),(15,'Азербайджан','AZ','AZE','',0,1),(16,'Багамские острова','BS','BHS','',0,0),(17,'Бахрейн','BH','BHR','',0,0),(18,'Бангладеш','BD','BGD','',0,0),(19,'Барбадос','BB','BRB','',0,0),(20,'Белоруссия (Беларусь)','BY','BLR','',0,1),(21,'Бельгия','BE','BEL','',0,0),(22,'Белиз','BZ','BLZ','',0,0),(23,'Бенин','BJ','BEN','',0,0),(24,'Бермудские острова','BM','BMU','',0,0),(25,'Бутан','BT','BTN','',0,0),(26,'Боливия','BO','BOL','',0,0),(27,'Босния и Герцеговина','BA','BIH','',0,0),(28,'Ботсвана','BW','BWA','',0,0),(29,'Остров Буве','BV','BVT','',0,0),(30,'Бразилия','BR','BRA','',0,0),(31,'Британская территория в Индийском океане','IO','IOT','',0,0),(32,'Бруней','BN','BRN','',0,0),(33,'Болгария','BG','BGR','',0,0),(34,'Буркина-Фасо','BF','BFA','',0,0),(35,'Бурунди','BI','BDI','',0,0),(36,'Камбоджа','KH','KHM','',0,0),(37,'Камерун','CM','CMR','',0,0),(38,'Канада','CA','CAN','',0,0),(39,'Кабо-Верде','CV','CPV','',0,0),(40,'Каймановы острова','KY','CYM','',0,0),(41,'Центрально-Африканская Республика','CF','CAF','',0,0),(42,'Чад','TD','TCD','',0,0),(43,'Чили','CL','CHL','',0,0),(44,'Китайская Народная Республика','CN','CHN','',0,0),(45,'Остров Рождества','CX','CXR','',0,0),(46,'Кокосовые острова','CC','CCK','',0,0),(47,'Колумбия','CO','COL','',0,0),(48,'Коморские острова','KM','COM','',0,0),(49,'Конго','CG','COG','',0,0),(50,'Острова Кука','CK','COK','',0,0),(51,'Коста-Рика','CR','CRI','',0,0),(52,'Кот д\'Ивуар','CI','CIV','',0,0),(53,'Хорватия','HR','HRV','',0,0),(54,'Куба','CU','CUB','',0,0),(55,'Кипр','CY','CYP','',0,0),(56,'Чехия','CZ','CZE','',0,0),(57,'Дания','DK','DNK','',0,0),(58,'Джибути','DJ','DJI','',0,0),(59,'Доминика','DM','DMA','',0,0),(60,'Доминиканская Республика','DO','DOM','',0,0),(61,'Восточный Тимор','TP','TMP','',0,0),(62,'Эквадор','EC','ECU','',0,0),(63,'Египет','EG','EGY','',0,0),(64,'Сальвадор','SV','SLV','',0,0),(65,'Экваториальная Гвинея','GQ','GNQ','',0,0),(66,'Эритрея','ER','ERI','',0,0),(67,'Эстония','EE','EST','',0,1),(68,'Эфиопия','ET','ETH','',0,0),(69,'Фолклендские (Мальвинские) острова','FK','FLK','',0,0),(70,'Фарерские острова','FO','FRO','',0,0),(71,'Фиджи','FJ','FJI','',0,0),(72,'Финляндия','FI','FIN','',0,0),(73,'Франция','FR','FRA','',0,0),(74,'Франция, Метрополия','FX','FXX','',0,0),(75,'Французская Гвиана','GF','GUF','',0,0),(76,'Французская Полинезия','PF','PYF','',0,0),(77,'Французские Южные территории','TF','ATF','',0,0),(78,'Габон','GA','GAB','',0,0),(79,'Гамбия','GM','GMB','',0,0),(80,'Грузия','GE','GEO','',0,1),(81,'Германия','DE','DEU','{company}\r\n{firstname} {lastname}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}',0,0),(82,'Гана','GH','GHA','',0,0),(83,'Гибралтар','GI','GIB','',0,0),(84,'Греция','GR','GRC','',0,0),(85,'Гренландия','GL','GRL','',0,0),(86,'Гренада','GD','GRD','',0,0),(87,'Гваделупа','GP','GLP','',0,0),(88,'Гуам','GU','GUM','',0,0),(89,'Гватемала','GT','GTM','',0,0),(90,'Гвинея','GN','GIN','',0,0),(91,'Гвинея-Бисау','GW','GNB','',0,0),(92,'Гайана','GY','GUY','',0,0),(93,'Гаити','HT','HTI','',0,0),(94,'Херд и Макдональд, острова','HM','HMD','',0,0),(95,'Гондурас','HN','HND','',0,0),(96,'Гонконг','HK','HKG','',0,0),(97,'Венгрия','HU','HUN','',0,0),(98,'Исландия','IS','ISL','',0,0),(99,'Индия','IN','IND','',0,0),(100,'Индонезия','ID','IDN','',0,0),(101,'Иран','IR','IRN','',0,0),(102,'Ирак','IQ','IRQ','',0,0),(103,'Ирландия','IE','IRL','',0,0),(104,'Израиль','IL','ISR','',0,0),(105,'Италия','IT','ITA','',0,0),(106,'Ямайка','JM','JAM','',0,0),(107,'Япония','JP','JPN','',0,0),(108,'Иордания','JO','JOR','',0,0),(109,'Казахстан','KZ','KAZ','',0,1),(110,'Кения','KE','KEN','',0,0),(111,'Кирибати','KI','KIR','',0,0),(112,'Корейская Народно-Демократическая Республика','KP','PRK','',0,0),(113,'Республика Корея','KR','KOR','',0,0),(114,'Кувейт','KW','KWT','',0,0),(115,'Киргизия (Кыргызстан)','KG','KGZ','',0,1),(116,'Лаос','LA','LAO','',0,0),(117,'Латвия','LV','LVA','',0,1),(118,'Ливан','LB','LBN','',0,0),(119,'Лесото','LS','LSO','',0,0),(120,'Либерия','LR','LBR','',0,0),(121,'Ливия','LY','LBY','',0,0),(122,'Лихтенштейн','LI','LIE','',0,0),(123,'Литва','LT','LTU','',0,1),(124,'Люксембург','LU','LUX','',0,0),(125,'Макао','MO','MAC','',0,0),(126,'Македония','MK','MKD','',0,0),(127,'Мадагаскар','MG','MDG','',0,0),(128,'Малави','MW','MWI','',0,0),(129,'Малайзия','MY','MYS','',0,0),(130,'Мальдивы','MV','MDV','',0,0),(131,'Мали','ML','MLI','',0,0),(132,'Мальта','MT','MLT','',0,0),(133,'Маршалловы острова','MH','MHL','',0,0),(134,'Мартиника','MQ','MTQ','',0,0),(135,'Мавритания','MR','MRT','',0,0),(136,'Маврикий','MU','MUS','',0,0),(137,'Майотта','YT','MYT','',0,0),(138,'Мексика','MX','MEX','',0,0),(139,'Микронезия','FM','FSM','',0,0),(140,'Молдова','MD','MDA','',0,1),(141,'Монако','MC','MCO','',0,0),(142,'Монголия','MN','MNG','',0,0),(143,'Монтсеррат','MS','MSR','',0,0),(144,'Марокко','MA','MAR','',0,0),(145,'Мозамбик','MZ','MOZ','',0,0),(146,'Мьянма','MM','MMR','',0,0),(147,'Намибия','NA','NAM','',0,0),(148,'Науру','NR','NRU','',0,0),(149,'Непал','NP','NPL','',0,0),(150,'Нидерланды','NL','NLD','',0,0),(151,'Антильские (Нидерландские) острова','AN','ANT','',0,0),(152,'Новая Каледония','NC','NCL','',0,0),(153,'Новая Зеландия','NZ','NZL','',0,0),(154,'Никарагуа','NI','NIC','',0,0),(155,'Нигер','NE','NER','',0,0),(156,'Нигерия','NG','NGA','',0,0),(157,'Ниуэ','NU','NIU','',0,0),(158,'Остров Норфолк','NF','NFK','',0,0),(159,'Северные Марианские острова','MP','MNP','',0,0),(160,'Норвегия','NO','NOR','',0,0),(161,'Оман','OM','OMN','',0,0),(162,'Пакистан','PK','PAK','',0,0),(163,'Палау','PW','PLW','',0,0),(164,'Панама','PA','PAN','',0,0),(165,'Папуа - Новая Гвинея','PG','PNG','',0,0),(166,'Парагвай','PY','PRY','',0,0),(167,'Перу','PE','PER','',0,0),(168,'Филиппины','PH','PHL','',0,0),(169,'Острова Питкэрн','PN','PCN','',0,0),(170,'Польша','PL','POL','',0,0),(171,'Португалия','PT','PRT','',0,0),(172,'Пуэрто-Рико','PR','PRI','',0,0),(173,'Катар','QA','QAT','',0,0),(174,'Реюньон','RE','REU','',0,0),(175,'Румыния','RO','ROM','',0,0),(176,'Российская Федерация','RU','RUS','',0,1),(177,'Руанда','RW','RWA','',0,0),(178,'Сент-Китс и Невис','KN','KNA','',0,0),(179,'Сент-Люсия','LC','LCA','',0,0),(180,'Сент-Винсент и Гренадины','VC','VCT','',0,0),(181,'Западное Самоа','WS','WSM','',0,0),(182,'Сан-Марино','SM','SMR','',0,0),(183,'Сан-Томе и Принсипи','ST','STP','',0,0),(184,'Саудовская Аравия','SA','SAU','',0,0),(185,'Сенегал','SN','SEN','',0,0),(186,'Сейшельские острова','SC','SYC','',0,0),(187,'Сьерра-Леоне','SL','SLE','',0,0),(188,'Сингапур','SG','SGP','',0,0),(189,'Словакия','SK','SVK','{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city} {postcode}\r\n{zone}\r\n{country}',0,0),(190,'Словения','SI','SVN','',0,0),(191,'Соломоновы острова','SB','SLB','',0,0),(192,'Сомали','SO','SOM','',0,0),(193,'Южно-Африканская Республика','ZA','ZAF','',0,0),(194,'Южная Джорджия и Южные Сандвичевы острова','GS','SGS','',0,0),(195,'Испания','ES','ESP','',0,0),(196,'Шри-Ланка','LK','LKA','',0,0),(197,'Остров Святой Елены','SH','SHN','',0,0),(198,'Сен-Пьер и Микелон','PM','SPM','',0,0),(199,'Судан','SD','SDN','',0,0),(200,'Суринам','SR','SUR','',0,0),(201,'Шпицберген и Ян Майен','SJ','SJM','',0,0),(202,'Свазиленд','SZ','SWZ','',0,0),(203,'Швеция','SE','SWE','',0,0),(204,'Швейцария','CH','CHE','',0,0),(205,'Сирия','SY','SYR','',0,0),(206,'Тайвань (провинция Китая)','TW','TWN','',0,0),(207,'Таджикистан','TJ','TJK','',0,1),(208,'Танзания','TZ','TZA','',0,0),(209,'Таиланд','TH','THA','',0,0),(210,'Того','TG','TGO','',0,0),(211,'Токелау','TK','TKL','',0,0),(212,'Тонга','TO','TON','',0,0),(213,'Тринидад и Тобаго','TT','TTO','',0,0),(214,'Тунис','TN','TUN','',0,0),(215,'Турция','TR','TUR','',0,0),(216,'Туркменистан','TM','TKM','',0,1),(217,'Острова Теркс и Кайкос','TC','TCA','',0,0),(218,'Тувалу','TV','TUV','',0,0),(219,'Уганда','UG','UGA','',0,0),(220,'Украина','UA','UKR','',0,1),(221,'Объединенные Арабские Эмираты','AE','ARE','',0,0),(222,'Великобритания','GB','GBR','',1,0),(223,'Соединенные Штаты Америки','US','USA','{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city}, {zone} {postcode}\r\n{country}',0,0),(224,'Мелкие отдаленные острова США','UM','UMI','',0,0),(225,'Уругвай','UY','URY','',0,0),(226,'Узбекистан','UZ','UZB','',0,1),(227,'Вануату','VU','VUT','',0,0),(228,'Ватикан','VA','VAT','',0,0),(229,'Венесуэла','VE','VEN','',0,0),(230,'Вьетнам','VN','VNM','',0,0),(231,'Виргинские острова (Британские)','VG','VGB','',0,0),(232,'Виргинские острова (США)','VI','VIR','',0,0),(233,'Уоллис и Футуна','WF','WLF','',0,0),(234,'Западная Сахара','EH','ESH','',0,0),(235,'Йемен','YE','YEM','',0,0),(236,'Сербия и Черногория','CS','SCG','',0,0),(237,'Заир','ZR','ZAR','',0,0),(238,'Замбия','ZM','ZMB','',0,0),(239,'Зимбабве','ZW','ZWE','',0,0),(242,'Черногория','ME','MNE','',0,0),(243,'Сербия','RS','SRB','',0,0),(244,'Аландские острова','AX','ALA','',0,0),(245,'Бонайре, Синт-Эстатиус и Саба','BQ','BES','',0,0),(246,'Кюрасао','CW','CUW','',0,0),(247,'Палестинская территория, оккупированная','PS','PSE','',0,0),(248,'Южный Судан','SS','SSD','',0,0),(249,'Санкт-Бартелеми','BL','BLM','',0,0),(250,'Санкт-Мартин (французская часть)','MF','MAF','',0,0),(251,'Канарские Острова','IC','ICA','',0,0),(252,'Остров Вознесения (Великобритания)','AC','ASC','',0,0),(253,'Косово, Республика','XK','UNK','',0,0),(254,'Остров Мэн','IM','IMN','',0,0),(255,'Тристан-да-Кунья','TA','SHN','',0,0),(256,'Остров Гернси','GG','GGY','',0,0),(257,'Остров Джерси','JE','JEY','',0,0);
/*!40000 ALTER TABLE `oc_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_coupon`
--

DROP TABLE IF EXISTS `oc_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_coupon` (
  `coupon_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` varchar(20) NOT NULL,
  `type` char(1) NOT NULL,
  `discount` decimal(15,4) NOT NULL,
  `logged` tinyint(1) NOT NULL,
  `shipping` tinyint(1) NOT NULL,
  `total` decimal(15,4) NOT NULL,
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `uses_total` int(11) NOT NULL,
  `uses_customer` varchar(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`coupon_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_coupon`
--

LOCK TABLES `oc_coupon` WRITE;
/*!40000 ALTER TABLE `oc_coupon` DISABLE KEYS */;
INSERT INTO `oc_coupon` VALUES (4,'-10% скидка','2222','P',10.0000,0,0,0.0000,'2011-01-01','2012-01-01',10,'10',1,'2009-01-27 13:55:03'),(5,'Бесплатная доставка','3333','P',0.0000,0,1,100.0000,'2009-03-01','2009-08-31',10,'10',1,'2009-03-14 21:13:53'),(6,'-10.00 скидка','1111','F',10.0000,0,0,10.0000,'1970-11-01','2020-11-01',100000,'10000',1,'2009-03-14 21:15:18');
/*!40000 ALTER TABLE `oc_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_coupon_category`
--

DROP TABLE IF EXISTS `oc_coupon_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_coupon_category` (
  `coupon_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`coupon_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_coupon_category`
--

LOCK TABLES `oc_coupon_category` WRITE;
/*!40000 ALTER TABLE `oc_coupon_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_coupon_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_coupon_history`
--

DROP TABLE IF EXISTS `oc_coupon_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_coupon_history` (
  `coupon_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`coupon_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_coupon_history`
--

LOCK TABLES `oc_coupon_history` WRITE;
/*!40000 ALTER TABLE `oc_coupon_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_coupon_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_coupon_product`
--

DROP TABLE IF EXISTS `oc_coupon_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_coupon_product` (
  `coupon_product_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`coupon_product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_coupon_product`
--

LOCK TABLES `oc_coupon_product` WRITE;
/*!40000 ALTER TABLE `oc_coupon_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_coupon_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_currency`
--

DROP TABLE IF EXISTS `oc_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_currency` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `code` varchar(3) NOT NULL,
  `symbol_left` varchar(12) NOT NULL,
  `symbol_right` varchar(12) NOT NULL,
  `decimal_place` char(1) NOT NULL,
  `value` float(15,8) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_currency`
--

LOCK TABLES `oc_currency` WRITE;
/*!40000 ALTER TABLE `oc_currency` DISABLE KEYS */;
INSERT INTO `oc_currency` VALUES (1,'Рубль','RUB','',' ₽','2',1.00000000,1,'2018-07-07 18:04:17'),(2,'US Dollar','USD','','$','2',0.01550000,1,'2015-11-10 17:33:53'),(3,'Euro','EUR','','€','2',0.01440000,1,'2015-11-10 17:33:53');
/*!40000 ALTER TABLE `oc_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_custom_field`
--

DROP TABLE IF EXISTS `oc_custom_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_custom_field` (
  `custom_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `value` text NOT NULL,
  `validation` varchar(255) NOT NULL,
  `location` varchar(7) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`custom_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_custom_field`
--

LOCK TABLES `oc_custom_field` WRITE;
/*!40000 ALTER TABLE `oc_custom_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_custom_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_custom_field_customer_group`
--

DROP TABLE IF EXISTS `oc_custom_field_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_custom_field_customer_group` (
  `custom_field_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`custom_field_id`,`customer_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_custom_field_customer_group`
--

LOCK TABLES `oc_custom_field_customer_group` WRITE;
/*!40000 ALTER TABLE `oc_custom_field_customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_custom_field_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_custom_field_description`
--

DROP TABLE IF EXISTS `oc_custom_field_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_custom_field_description` (
  `custom_field_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`custom_field_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_custom_field_description`
--

LOCK TABLES `oc_custom_field_description` WRITE;
/*!40000 ALTER TABLE `oc_custom_field_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_custom_field_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_custom_field_value`
--

DROP TABLE IF EXISTS `oc_custom_field_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_custom_field_value` (
  `custom_field_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`custom_field_value_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_custom_field_value`
--

LOCK TABLES `oc_custom_field_value` WRITE;
/*!40000 ALTER TABLE `oc_custom_field_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_custom_field_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_custom_field_value_description`
--

DROP TABLE IF EXISTS `oc_custom_field_value_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_custom_field_value_description` (
  `custom_field_value_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `custom_field_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`custom_field_value_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_custom_field_value_description`
--

LOCK TABLES `oc_custom_field_value_description` WRITE;
/*!40000 ALTER TABLE `oc_custom_field_value_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_custom_field_value_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer`
--

DROP TABLE IF EXISTS `oc_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_group_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `cart` text,
  `wishlist` text,
  `newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  `custom_field` text NOT NULL,
  `ip` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `safe` tinyint(1) NOT NULL,
  `token` text NOT NULL,
  `code` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer`
--

LOCK TABLES `oc_customer` WRITE;
/*!40000 ALTER TABLE `oc_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_activity`
--

DROP TABLE IF EXISTS `oc_customer_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_activity` (
  `customer_activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `key` varchar(64) NOT NULL,
  `data` text NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_activity`
--

LOCK TABLES `oc_customer_activity` WRITE;
/*!40000 ALTER TABLE `oc_customer_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_group`
--

DROP TABLE IF EXISTS `oc_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_group` (
  `customer_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `approval` int(1) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`customer_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_group`
--

LOCK TABLES `oc_customer_group` WRITE;
/*!40000 ALTER TABLE `oc_customer_group` DISABLE KEYS */;
INSERT INTO `oc_customer_group` VALUES (1,0,1);
/*!40000 ALTER TABLE `oc_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_group_description`
--

DROP TABLE IF EXISTS `oc_customer_group_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_group_description` (
  `customer_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`customer_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_group_description`
--

LOCK TABLES `oc_customer_group_description` WRITE;
/*!40000 ALTER TABLE `oc_customer_group_description` DISABLE KEYS */;
INSERT INTO `oc_customer_group_description` VALUES (1,1,'Default','test');
/*!40000 ALTER TABLE `oc_customer_group_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_history`
--

DROP TABLE IF EXISTS `oc_customer_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_history` (
  `customer_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_history`
--

LOCK TABLES `oc_customer_history` WRITE;
/*!40000 ALTER TABLE `oc_customer_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_ip`
--

DROP TABLE IF EXISTS `oc_customer_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_ip` (
  `customer_ip_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_ip_id`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_ip`
--

LOCK TABLES `oc_customer_ip` WRITE;
/*!40000 ALTER TABLE `oc_customer_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_login`
--

DROP TABLE IF EXISTS `oc_customer_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_login` (
  `customer_login_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(96) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `total` int(4) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`customer_login_id`),
  KEY `email` (`email`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_login`
--

LOCK TABLES `oc_customer_login` WRITE;
/*!40000 ALTER TABLE `oc_customer_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_online`
--

DROP TABLE IF EXISTS `oc_customer_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_online` (
  `ip` varchar(40) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `url` text NOT NULL,
  `referer` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_online`
--

LOCK TABLES `oc_customer_online` WRITE;
/*!40000 ALTER TABLE `oc_customer_online` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_reward`
--

DROP TABLE IF EXISTS `oc_customer_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_reward` (
  `customer_reward_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL DEFAULT '0',
  `order_id` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `points` int(8) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_reward_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_reward`
--

LOCK TABLES `oc_customer_reward` WRITE;
/*!40000 ALTER TABLE `oc_customer_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_search`
--

DROP TABLE IF EXISTS `oc_customer_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_search` (
  `customer_search_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `sub_category` tinyint(1) NOT NULL,
  `description` tinyint(1) NOT NULL,
  `products` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_search_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_search`
--

LOCK TABLES `oc_customer_search` WRITE;
/*!40000 ALTER TABLE `oc_customer_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_transaction`
--

DROP TABLE IF EXISTS `oc_customer_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_transaction` (
  `customer_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_transaction`
--

LOCK TABLES `oc_customer_transaction` WRITE;
/*!40000 ALTER TABLE `oc_customer_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_customer_wishlist`
--

DROP TABLE IF EXISTS `oc_customer_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_customer_wishlist` (
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_id`,`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_customer_wishlist`
--

LOCK TABLES `oc_customer_wishlist` WRITE;
/*!40000 ALTER TABLE `oc_customer_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_customer_wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_download`
--

DROP TABLE IF EXISTS `oc_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_download` (
  `download_id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(160) NOT NULL,
  `mask` varchar(128) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`download_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_download`
--

LOCK TABLES `oc_download` WRITE;
/*!40000 ALTER TABLE `oc_download` DISABLE KEYS */;
INSERT INTO `oc_download` VALUES (1,'rek_ant-snab.pdf.Lrj7RQKQTNys2CTofMeC8mUClROxrnpS','rek_ant-snab.pdf','2018-04-12 09:32:18'),(2,'cont_ant-snab.pdf.XzmL7L0HZdz16EXvambESUprTSmKVh4K','cont_ant-snab.pdf','2018-04-12 09:32:34'),(3,'sklad-a-plan.pdf.JDa4QZE4AmF8uHtfdkmwjUdNYVGJGEAd','sklad-a-plan.pdf','2018-04-12 09:33:40'),(4,'sklad-sh-plan.pdf.AWhbYPglyE9DyyeZjW2VOOJe7CBZrpCw','sklad-sh-plan.pdf','2018-04-12 09:34:21');
/*!40000 ALTER TABLE `oc_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_download_description`
--

DROP TABLE IF EXISTS `oc_download_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_download_description` (
  `download_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`download_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_download_description`
--

LOCK TABLES `oc_download_description` WRITE;
/*!40000 ALTER TABLE `oc_download_description` DISABLE KEYS */;
INSERT INTO `oc_download_description` VALUES (1,1,'Реквизиты'),(2,1,'Договор'),(3,1,'Карта Алтуфьево'),(4,1,'Карта Щёлково');
/*!40000 ALTER TABLE `oc_download_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_event`
--

DROP TABLE IF EXISTS `oc_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `trigger` text NOT NULL,
  `action` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_event`
--

LOCK TABLES `oc_event` WRITE;
/*!40000 ALTER TABLE `oc_event` DISABLE KEYS */;
INSERT INTO `oc_event` VALUES (2,'menu_editor','admin/controller/localisation/language/add/after','extension/module/menu_editor/eventUpdatedLanguage',1,'2018-03-26 02:02:59',0),(3,'menu_editor','admin/controller/localisation/language/edit/after','extension/module/menu_editor/eventUpdatedLanguage',1,'2018-03-26 02:02:59',0),(4,'menu_editor','admin/controller/localisation/language/delete/after','extension/module/menu_editor/eventUpdatedLanguage',1,'2018-03-26 02:02:59',0);
/*!40000 ALTER TABLE `oc_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_extension`
--

DROP TABLE IF EXISTS `oc_extension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_extension` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `code` varchar(32) NOT NULL,
  PRIMARY KEY (`extension_id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_extension`
--

LOCK TABLES `oc_extension` WRITE;
/*!40000 ALTER TABLE `oc_extension` DISABLE KEYS */;
INSERT INTO `oc_extension` VALUES (1,'payment','cod'),(55,'total','sub_total'),(54,'total','wholesale'),(5,'total','total'),(6,'module','banner'),(7,'module','carousel'),(9,'shipping','flat'),(13,'module','category'),(14,'module','account'),(17,'payment','free_checkout'),(18,'module','featured'),(19,'module','slideshow'),(20,'theme','theme_default'),(21,'dashboard','activity'),(22,'dashboard','sale'),(23,'dashboard','recent'),(24,'dashboard','order'),(25,'dashboard','online'),(26,'dashboard','map'),(27,'dashboard','customer'),(28,'dashboard','chart'),(32,'module','menu_editor'),(35,'module','html'),(43,'module','review'),(44,'captcha','google_captcha'),(46,'module','newsblog_articles'),(50,'module','prodproperties'),(48,'feed','google_sitemap'),(49,'module','produnits'),(51,'module','prodtabs');
/*!40000 ALTER TABLE `oc_extension` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filter`
--

DROP TABLE IF EXISTS `oc_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_filter` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_group_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filter`
--

LOCK TABLES `oc_filter` WRITE;
/*!40000 ALTER TABLE `oc_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filter_description`
--

DROP TABLE IF EXISTS `oc_filter_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_filter_description` (
  `filter_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `filter_group_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`filter_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filter_description`
--

LOCK TABLES `oc_filter_description` WRITE;
/*!40000 ALTER TABLE `oc_filter_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_filter_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filter_group`
--

DROP TABLE IF EXISTS `oc_filter_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_filter_group` (
  `filter_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`filter_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filter_group`
--

LOCK TABLES `oc_filter_group` WRITE;
/*!40000 ALTER TABLE `oc_filter_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_filter_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filter_group_description`
--

DROP TABLE IF EXISTS `oc_filter_group_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_filter_group_description` (
  `filter_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`filter_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filter_group_description`
--

LOCK TABLES `oc_filter_group_description` WRITE;
/*!40000 ALTER TABLE `oc_filter_group_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_filter_group_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_geo_zone`
--

DROP TABLE IF EXISTS `oc_geo_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_geo_zone` (
  `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date_modified` datetime NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`geo_zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_geo_zone`
--

LOCK TABLES `oc_geo_zone` WRITE;
/*!40000 ALTER TABLE `oc_geo_zone` DISABLE KEYS */;
INSERT INTO `oc_geo_zone` VALUES (3,'НДС','Облагаемые НДС','2010-02-26 22:33:24','2009-01-06 23:26:25');
/*!40000 ALTER TABLE `oc_geo_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_information`
--

DROP TABLE IF EXISTS `oc_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_information` (
  `information_id` int(11) NOT NULL AUTO_INCREMENT,
  `bottom` int(1) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`information_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_information`
--

LOCK TABLES `oc_information` WRITE;
/*!40000 ALTER TABLE `oc_information` DISABLE KEYS */;
INSERT INTO `oc_information` VALUES (3,1,3,1),(4,1,1,1),(5,1,4,1),(6,1,2,1);
/*!40000 ALTER TABLE `oc_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_information_description`
--

DROP TABLE IF EXISTS `oc_information_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_information_description` (
  `information_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_h1` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`information_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_information_description`
--

LOCK TABLES `oc_information_description` WRITE;
/*!40000 ALTER TABLE `oc_information_description` DISABLE KEYS */;
INSERT INTO `oc_information_description` VALUES (6,1,'Оплата и доставка','&lt;p&gt;Мы постоянно работаем над тем, чтобы нашим клиентам было с нами удобно, способов оплаты и вариантов доставки обязательно будет больше.&amp;nbsp;&lt;/p&gt;&lt;h2&gt;Способы оплаты&lt;/h2&gt;&lt;p&gt;На сегодняшний день в интернет-магазине Ант-Снаб доступны следующие варианты оплаты вашего заказа&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;\r\n&lt;hr&gt;\r\n&lt;table cellspacing=&quot;0&quot; cellpadding=&quot;0&quot; border=&quot;0&quot;&gt;\r\n&lt;tbody&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;320&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;Для физических лиц:&lt;br&gt;\r\n&lt;br&gt;&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;60&quot;&gt;&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;320&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;Для юридических лиц:&lt;br&gt;\r\n&lt;br&gt;&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;320&quot;&gt;\r\n&lt;p&gt;&lt;img title=&quot;Мы работаем с физическими лицами&quot; border=&quot;0&quot; hspace=&quot;0&quot; alt=&quot;Мы работаем с физическими лицами&quot; src=&quot;/image/catalog/antsnab/site/fiz.jpg&quot; align=&quot;left&quot;&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;безналичная оплата\r\nпо&amp;nbsp;выставленному счету&lt;/p&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;оплата наличными в\r\nотделениях Альфа-Банка&lt;/p&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;оплата наличными в&amp;nbsp;момент\r\nполучения товара&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;60&quot;&gt;&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;320&quot;&gt;\r\n&lt;p&gt;&lt;img title=&quot;Мы работаем с юридическими лицами&quot; border=&quot;0&quot; hspace=&quot;0&quot; alt=&quot;Мы работаем с юридическими лицами&quot; src=&quot;/image/catalog/antsnab/site/yur.jpg&quot; align=&quot;left&quot;&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;безналичная оплата\r\nпо&amp;nbsp;выставленному счету&lt;/p&gt;\r\n&lt;p&gt;&amp;nbsp;&lt;/p&gt;\r\n&lt;p&gt;&amp;nbsp;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;/tbody&gt;\r\n&lt;/table&gt;\r\n&lt;hr&gt;\r\n\r\n&lt;p&gt;Альтернативные варианты оплаты всегда можно обсудить с менеджером в момент подтверждения заказа. Мы всегда идем навстречу своим клиентам.&lt;/p&gt;&lt;h2&gt;Доставка&lt;/h2&gt;&lt;p&gt;В угоду оперативности пока мы осуществляем доставку продукции только по Москве и Московской области.&lt;/p&gt;\r\n&lt;hr&gt;\r\n&lt;table cellspacing=&quot;0&quot; cellpadding=&quot;0&quot; border=&quot;0&quot;&gt;\r\n&lt;tbody&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;700&quot;&gt;\r\n&lt;p&gt;&lt;img title=&quot;&quot; border=&quot;0&quot; hspace=&quot;0&quot; alt=&quot;&quot; src=&quot;/image/catalog/antsnab/site/dost.jpg&quot; width=&quot;130&quot; align=&quot;left&quot; height=&quot;150&quot;&gt;&lt;/p&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;обычно доставка происходит\r\nна&amp;nbsp;следующий рабочий&amp;nbsp;день, но&amp;nbsp;мы&amp;nbsp;постараемся доставить ваш заказ как можно\r\nбыстрее&lt;/p&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;наши&amp;nbsp;специалисты\r\nподберут оптимальный вариант доставки и&amp;nbsp;сообщат окончательную стоимость в\r\nмомент подтверждения заказа&lt;/p&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;необходимость разгрузки\r\nтоваров и&amp;nbsp;их&amp;nbsp;подъема&amp;nbsp;до квартиры обязательно обговаривайте заранее&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;/tbody&gt;\r\n&lt;/table&gt;\r\n&lt;hr&gt;\r\n&lt;p&gt;Стандартная стоимость доставки товаров по Москве без учета разгрузки и подъема на этаж:&lt;/p&gt;\r\n&lt;table&gt;\r\n&lt;tbody&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;10&amp;nbsp;кг&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;200&amp;nbsp;кг&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;1000&amp;nbsp;кг&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;1,5 тонн&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;3&amp;nbsp;тонн&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;5&amp;nbsp;тонн&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;10&amp;nbsp;тонн&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;до&amp;nbsp;20&amp;nbsp;тонн&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;600&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;1&amp;nbsp;200&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;1&amp;nbsp;800&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;3&amp;nbsp;000&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;5&amp;nbsp;000&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;7&amp;nbsp;000&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;9&amp;nbsp;000&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;85&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;11&amp;nbsp;000&amp;nbsp;р.&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;/tbody&gt;\r\n&lt;/table&gt;\r\n&lt;p&gt;Возможность отправки продукции в ваш регион РФ уточняйте у наших сотрудников. Нет ничего невозможного!&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Самовывоз&lt;/h2&gt;&lt;p&gt;Если по каким-то причинам доставка заказа вам не нужна, вы можете забрать продукцию самостоятельно с наших складов.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;\r\n&lt;hr&gt;\r\n&lt;table cellspacing=&quot;0&quot; cellpadding=&quot;0&quot; border=&quot;0&quot;&gt;\r\n&lt;tbody&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;623&quot;&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;&lt;img title=&quot;&quot; border=&quot;0&quot; hspace=&quot;0&quot; alt=&quot;&quot; src=&quot;/image/catalog/antsnab/site/sam.jpg&quot; align=&quot;left&quot;&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;сообщите менеджеру о\r\nсвоем намерении забрать товар самостоятельно в&amp;nbsp;момент подтверждения заказа&lt;/p&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;согласуйте предполагаемую\r\nдату отгрузки и&amp;nbsp;удобный способ оплаты&lt;/p&gt;\r\n&lt;p&gt;&lt;font color=&quot;#D3A06D&quot;&gt;&lt;strong&gt;•&lt;/strong&gt;&lt;/font&gt;&amp;nbsp;обо всем остальном мы\r\nпозаботимся за&amp;nbsp;вас&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;/tbody&gt;\r\n&lt;/table&gt;\r\n&lt;hr&gt;\r\n&lt;p&gt;Надеемся, посещение нашего интернет-магазина оставит у вас только приятные воспоминания и вы станете заходить почаще.&lt;/p&gt;\r\n','Оплата и доставка: способы, варианты и условия получения заказов в интернет-магазине Ант-Снаб&lt;','Оплата и доставка','На странице собраны все доступные на сегодня варианты оплаты товаров, условия доставки заказов, способы самовывоза продукции, при совершении покупок в интернет-магазине строительных и отделочных материалов Ант-Снаб','Оплата, доставка, способы, варианты, методы, самовывоз, склады, Москва, стоимость, цена, купить, товары, магазин, покупки, доступные, интернет, строительные, отделочные, материалы, Ант-Снаб, ТК, ООО, компания'),(3,1,'Политика конфиденциальности','&lt;h2&gt;&lt;div style=&quot;text-align: center;&quot;&gt;&lt;span style=&quot;color: inherit;&quot;&gt;Политика в отношении обработки персональных данных&lt;/span&gt;&lt;/div&gt;&lt;div style=&quot;text-align: center;&quot;&gt;&lt;span style=&quot;color: inherit;&quot;&gt;в ООО «ТК Ант-Снаб»&lt;/span&gt;&lt;/div&gt;&lt;/h2&gt;&lt;p style=&quot;text-align: center; &quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;h3 style=&quot;text-align: center; &quot;&gt;1. Общие положения&lt;/h3&gt;&lt;p&gt;1.1. Политика в отношении обработки персональных данных (далее — Политика) направлена на защиту прав и свобод физических лиц, персональные данные которых обрабатывает ООО «ТК АНТ-СНАБ» (далее — Оператор).&lt;/p&gt;&lt;p&gt;1.2. Политика разработана в соответствии с п. 2 ч. 1 ст. 18.1 Федерального закона от 27 июля 2006 г. № 152−ФЗ «О персональных данных» (далее — ФЗ «О персональных данных»).&lt;/p&gt;&lt;p&gt;1.3. Политика содержит сведения, подлежащие раскрытию в соответствии с ч. 1 ст. 14 ФЗ «О персональных данных», и является общедоступным документом.&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h3 style=&quot;text-align: center; &quot;&gt;2. Сведения об операторе&lt;/h3&gt;&lt;p&gt;2.1. Оператор ведет свою деятельность по адресу г. Москва, проезд Высоковольтный, дом 1, строение 43, этаж 2, помещения 7−10.&lt;/p&gt;&lt;p&gt;2.2. Генеральный Директор Гостев Никита Андреевич (телефон +7 (495) 255−01−37) назначен ответственным за организацию обработки персональных данных.&lt;/p&gt;&lt;p&gt;2.3. База данных информации, содержащей персональные данные граждан Российской Федерации, находится по адресу: 127566, г. Москва, Высоковольтный проезд, д. 1, стр. 43, этаж 2, помещения 7−10.&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h3 style=&quot;text-align: center; &quot;&gt;3. Сведения об обработке персональных данных&lt;/h3&gt;&lt;p&gt;3.1. Оператор обрабатывает персональные данные на законной и справедливой основе для выполнения возложенных законодательством функций, полномочий и обязанностей, осуществления прав и законных интересов Оператора, работников Оператора и третьих лиц.&lt;/p&gt;&lt;p&gt;3.2. Оператор получает персональные данные непосредственно у субъектов персональных данных.&lt;/p&gt;&lt;p&gt;3.3. Оператор обрабатывает персональные данные автоматизированным и неавтоматизированным способами, с использованием средств вычислительной техники и без использования таких средств.&lt;/p&gt;&lt;p&gt;3.4. Действия по обработке персональных данных включают сбор, запись, систематизацию, накопление, хранение, уточнение (обновление, изменение), извлечение, использование, передачу (распространение, предоставление, доступ), обезличивание, блокирование, удаление и уничтожение.&lt;/p&gt;&lt;p&gt;3.5. Базы данных информации, содержащей персональные данные граждан Российской Федерации, находятся на территории Российской Федерации.&lt;/p&gt;&lt;p&gt;3.6. Для достижения целей обработки персональных данных и с согласия субъектов персональных данных Оператор может осуществлять трансграничную передачу персональных данных.&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h3 style=&quot;text-align: center; &quot;&gt;4. Обработка персональных данных работников&lt;/h3&gt;&lt;p&gt;4.1. Оператор обрабатывает персональные данные работников Оператора в рамках правоотношений, урегулированных Трудовым Кодексом Российской Федерации от 30 декабря 2001 г. № 197−ФЗ (далее — ТК РФ), в том числе главой 14 ТК РФ, касающейся защиты персональных данных работников.&lt;/p&gt;&lt;p&gt;4.2. Оператор обрабатывает персональные данные работников с целью выполнения трудовых договоров, соблюдения норм законодательства РФ, а также с целью: — вести кадровый учёт; — вести бухгалтерский учёт; — осуществлять функции, полномочия и обязанности, возложенные законодательством РФ на Оператора, в том числе по предоставлению персональных данных в органы государственной власти, в Пенсионный фонд РФ, в Фонд социального страхования РФ, в Федеральный фонд обязательного медицинского страхования, а также в иные государственные органы; — соблюдать нормы и требования по охране труда и обеспечения личной безопасности работников ООО «ТК АНТ-СНАБ», сохранности имущества; — контролировать количество и качество выполняемой работы; — предоставлять льготы и компенсации, предусмотренные законодательством РФ; — публиковать на сайте, во внутренних справочниках, адресных книгах организации; — открывать личные банковские счета работников ООО «ТК АНТ-СНАБ» для перечисления заработной платы; — организовывать обучение работников ООО «ТК АНТ-СНАБ».&lt;/p&gt;&lt;p&gt;4.3. Оператор не принимает решения, затрагивающие интересы работников, основываясь на их персональных данных, полученных электронным образом или исключительно в результате автоматизированной обработки.&lt;/p&gt;&lt;p&gt;4.4. Оператор защищает персональные данные работников за счет собственных средств в порядке, установленном ТК РФ, ФЗ «О персональных данных» и иными федеральными законами.&lt;/p&gt;&lt;p&gt;4.5. Оператор знакомит работников и их представителей под роспись с документами, устанавливающими порядок обработки персональных данных работников, а также об их правах и обязанностях в этой области.&lt;/p&gt;&lt;p&gt;4.6. Оператор разрешает доступ к персональным данным работников только допущенным лицам, которые имеют право получать только те данные, которые необходимы для выполнения их функций.&lt;/p&gt;&lt;p&gt;4.7. Оператор получает все персональные данные работников у них самих. Если данные работника возможно получить только у третьей стороны, Оператор заранее уведомляет об этом работника и получает его письменное согласие. Оператор сообщает работнику о целях, источниках, способах получения, а также о характере подлежащих получению данных и последствиях отказа работника дать письменное согласие на их получение.&lt;/p&gt;&lt;p&gt;4.8. Оператор обрабатывает персональные данные работников с их письменного согласия, предоставляемого на срок действия трудового договора.&lt;/p&gt;&lt;p&gt;4.9. Оператор обрабатывает персональные данные работников в течение срока действия трудового договора. Оператор обрабатывает персональные данные уволенных работников в течение срока, установленного п. 5 ч. 3 ст. 24 части первой Налогового Кодекса Российской Федерации от 31 июля 1998 г. № 146−ФЗ, ч. 1 ст. 29 Федерального закона «О бухгалтерском учёте» от 6 декабря 2011 г. № 402−ФЗ и иными нормативными правовыми актами.&lt;/p&gt;&lt;p&gt;4.10. Оператор может обрабатывать специальные категории персональных данных работников (сведений о состоянии здоровья, относящихся к вопросу о возможности выполнения ими трудовых функций) на основании п. 2.3 ч. 2 ст. 10 ФЗ «О персональных данных».&lt;/p&gt;&lt;p&gt;4.11. Оператор не обрабатывает биометрические персональные данные работников.&lt;/p&gt;&lt;p&gt;4.12. Оператор не получает данные о членстве работников в общественных объединениях или их профсоюзной деятельности, за исключением случаев, предусмотренных ТК РФ или иными федеральными законами.&lt;/p&gt;&lt;p&gt;4.13. Оператор обрабатывает следующие персональные данные работников:&lt;/p&gt;&lt;p&gt;— Фамилия, имя, отчество;&lt;/p&gt;&lt;p&gt;— Тип, серия и номер документа, удостоверяющего личность;&lt;/p&gt;&lt;p&gt;— Дата выдачи документа, удостоверяющего личность, и информация о выдавшем его органе;&lt;/p&gt;&lt;p&gt;— Год рождения;&lt;/p&gt;&lt;p&gt;— Месяц рождения;&lt;/p&gt;&lt;p&gt;— Дата рождения;&lt;/p&gt;&lt;p&gt;— Место рождения;&lt;/p&gt;&lt;p&gt;— Адрес;&lt;/p&gt;&lt;p&gt;— Номер контактного телефона;&lt;/p&gt;&lt;p&gt;— Семейное положение;&lt;/p&gt;&lt;p&gt;— Фотография;&lt;/p&gt;&lt;p&gt;— Образование;&lt;/p&gt;&lt;p&gt;— Профессия;&lt;/p&gt;&lt;p&gt;— Должность;&lt;/p&gt;&lt;p&gt;— Трудовой стаж;&lt;/p&gt;&lt;p&gt;— Сведения о воинском учёте;&lt;/p&gt;&lt;p&gt;— Национальная принадлежность;&lt;/p&gt;&lt;p&gt;— Доходы;&lt;/p&gt;&lt;p&gt;— Данные о социальных льготах;&lt;/p&gt;&lt;p&gt;— Идентификационный номер налогоплательщика;&lt;/p&gt;&lt;p&gt;— Номер страхового свидетельства государственного пенсионного страхования;&lt;/p&gt;&lt;p&gt;— Адрес электронной почты;&lt;/p&gt;&lt;p&gt;— Страховые взносы на ОПС;&lt;/p&gt;&lt;p&gt;— Страховые взносы на ОМС;&lt;/p&gt;&lt;p&gt;— Налоговые вычеты;&lt;/p&gt;&lt;p&gt;— Выход на пенсию;&lt;/p&gt;&lt;p&gt;— Табельный номер;&lt;/p&gt;&lt;p&gt;— Сведения о приобретённых товарах;&lt;/p&gt;&lt;p&gt;— Сведения об оказанных услугах.&lt;/p&gt;&lt;p&gt;4.14. Оператор не сообщает третьей стороне персональные данные работника без его письменного согласия, кроме случаев, когда это необходимо для предупреждения угрозы жизни и здоровью работника, а также в других случаях, предусмотренных ТК РФ, ФЗ «О персональных данных» или иными федеральными законами.&lt;/p&gt;&lt;p&gt;4.15. Оператор не сообщает персональные данные работника в коммерческих целях без его письменного согласия.&lt;/p&gt;&lt;p&gt;4.16. Оператор передаёт персональные данные работников их представителям в порядке, установленном ТК РФ, ФЗ «О персональных данных» и иными федеральными законами, и ограничивает эту информацию только теми данными, которые необходимы для выполнения представителями их функций.&lt;/p&gt;&lt;p&gt;4.17. Оператор предупреждает лиц, получающих персональные данные работника, что эти данные могут быть использованы только в целях, для которых они сообщены, требует от этих лиц подтверждения, что это правило соблюдено.&lt;/p&gt;&lt;p&gt;4.18. В порядке, установленном законодательством, и в соответствии со ст. 7 ФЗ «О персональных данных» для достижения целей обработки персональных данных и с согласия работников Оператор предоставляет персональные данные работников или поручает их обработку следующим лицам: — Государственные органы (ПФР, ФНС, ФСС и др.); — Банк (в рамках зарплатного проекта).&lt;/p&gt;&lt;p&gt;4.19. Работник может получить свободный бесплатный доступ к информации о его персональных данных и об обработке этих данных. Работник может получить копию любой записи, содержащей его персональные данные, за исключением случаев, предусмотренных федеральным законом.&lt;/p&gt;&lt;p&gt;4.20. Работник может получить доступ к медицинской документации, отражающей состояние его здоровья, с помощью медицинского работника по его выбору.&lt;/p&gt;&lt;p&gt;4.21. Работник может определить представителя для защиты его персональных данных.&lt;/p&gt;&lt;p&gt;4.22. Работник может требовать исключить или исправить свои неверные или неполные персональные данные, а также данные, обработанные с нарушением требований ТК РФ, ФЗ «О персональных данных» или иного федерального закона. При отказе Оператора исключить или исправить персональные данные работника он может заявить в письменной форме о своем несогласии и обосновать такое несогласие. Работник может дополнить персональные данные оценочного характера заявлением, выражающим его собственную точку зрения.&lt;/p&gt;&lt;p&gt;4.23. Работник может требовать известить всех лиц, которым ранее были сообщены его неверные или неполные персональные данные, обо всех произведенных в них исключениях, исправлениях или дополнениях.&lt;/p&gt;&lt;p&gt;4.24. Работник может обжаловать в суд любые неправомерные действия или бездействие Оператора при обработке и защите его персональных данных.&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h3 style=&quot;text-align: center; &quot;&gt;5. Обработка персональных данных клиентов&lt;/h3&gt;&lt;p&gt;5.1. Оператор обрабатывает персональные данные клиентов в рамках правоотношений с Оператором, урегулированных частью второй Гражданского Кодекса Российской Федерации от 26 января 1996 г. № 14−ФЗ, (далее — клиентов).&lt;/p&gt;&lt;p&gt;5.2. Оператор обрабатывает персональные данные клиентов в целях соблюдения норм законодательства РФ, а также с целью: — заключать и выполнять обязательства по договорам с клиентами; — информировать о новых товарах, специальных акциях и предложениях; — осуществлять виды деятельности, предусмотренные учредительными документами ООО «ТК АНТ-СНАБ».&lt;/p&gt;&lt;p&gt;5.3. Оператор обрабатывает персональные данные клиентов с их согласия, предоставляемого на срок действия заключенных с ними договоров. В случаях, предусмотренных ФЗ «О персональных данных», согласие предоставляется в письменном виде. В иных случаях согласие считается полученным при заключении договора или при совершении конклюдентных действий.&lt;/p&gt;&lt;p&gt;5.4. Оператор обрабатывает персональные данные клиентов в течение сроков действия заключенных с ними договоров. Оператор может обрабатывать персональные данные клиентов после окончания сроков действия заключенных с ними договоров в течение срока, установленного п. 5 ч. 3 ст. 24 части первой НК РФ, ч. 1 ст. 29 ФЗ «О бухгалтерском учёте» и иными нормативными правовыми актами.&lt;/p&gt;&lt;p&gt;5.5. Оператор обрабатывает специальные категории персональных данных несовершеннолетних клиентов с письменного согласия их законных представителей на основании ч. 1 ст. 9, п. 1 ч. 2 ст. 10 ФЗ «О персональных данных».&lt;/p&gt;&lt;p&gt;5.6. Оператор обрабатывает следующие персональные данные клиентов:&lt;/p&gt;&lt;p&gt;— Фамилия, имя, отчество;&lt;/p&gt;&lt;p&gt;— Тип, серия и номер документа, удостоверяющего личность;&lt;/p&gt;&lt;p&gt;— Дата выдачи документа, удостоверяющего личность, и информация о выдавшем его органе;&lt;/p&gt;&lt;p&gt;— Адрес;&lt;/p&gt;&lt;p&gt;— Номер контактного телефона;&lt;/p&gt;&lt;p&gt;— Адрес электронной почты;&lt;/p&gt;&lt;p&gt;— Должность;&lt;/p&gt;&lt;p&gt;— Год рождения;&lt;/p&gt;&lt;p&gt;— Месяц рождения;&lt;/p&gt;&lt;p&gt;— Дата рождения;&lt;/p&gt;&lt;p&gt;— Место рождения;&lt;/p&gt;&lt;p&gt;— Идентификационный номер налогоплательщика;&lt;/p&gt;&lt;p&gt;— Номер страхового свидетельства государственного пенсионного страхования;&lt;/p&gt;&lt;p&gt;— Национальная принадлежность;&lt;/p&gt;&lt;p&gt;— Профессия;&lt;/p&gt;&lt;p&gt;— Доходы;&lt;/p&gt;&lt;p&gt;— Страховые взносы на ОПС;&lt;/p&gt;&lt;p&gt;— Страховые взносы на ОМС;&lt;/p&gt;&lt;p&gt;— Налоговые вычеты;&lt;/p&gt;&lt;p&gt;— Выход на пенсию;&lt;/p&gt;&lt;p&gt;— Табельный номер;&lt;/p&gt;&lt;p&gt;— Трудовой стаж;&lt;/p&gt;&lt;p&gt;— Сведения о приобретённых товарах;&lt;/p&gt;&lt;p&gt;— Сведения об оказанных услугах.&lt;/p&gt;&lt;p&gt;5.7. Для достижения целей обработки персональных данных и с согласия клиентов Оператор предоставляет персональные данные или поручает их обработку следующим лицам: — Курьерские компании; — Транспортные компании; — Сервисы почтовых рассылок.&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h3 style=&quot;text-align: center; &quot;&gt;6. Сведения об обеспечении безопасности персональных данных&lt;/h3&gt;&lt;p&gt;6.1. Оператор назначает ответственного за организацию обработки персональных данных для выполнения обязанностей, предусмотренных ФЗ «О персональных данных» и принятыми в соответствии с ним нормативными правовыми актами.&lt;/p&gt;&lt;p&gt;6.2. Оператор применяет комплекс правовых, организационных и технических мер по обеспечению безопасности персональных данных для обеспечения конфиденциальности персональных данных и их защиты от неправомерных действий:&lt;/p&gt;&lt;p&gt;— обеспечивает неограниченный доступ к Политике, копия которой размещена по адресу нахождения Оператора, а также может быть размещена на сайте Оператора (при его наличии);&lt;/p&gt;&lt;p&gt;— во исполнение Политики утверждает и приводит в действие документ «Положение об обработке персональных данных» (далее — Положение) и иные локальные акты;&lt;/p&gt;&lt;p&gt;— производит ознакомление работников с положениями законодательства о персональных данных, а также с Политикой и Положением;&lt;/p&gt;&lt;p&gt;— осуществляет допуск работников к персональным данным, обрабатываемым в информационной системе Оператора, а также к их материальным носителям только для выполнения трудовых обязанностей;&lt;/p&gt;&lt;p&gt;— устанавливает правила доступа к персональным данным, обрабатываемым в информационной системе Оператора, а также обеспечивает регистрацию и учёт всех действий с ними;&lt;/p&gt;&lt;p&gt;— производит оценку вреда, который может быть причинен субъектам персональных данных в случае нарушения ФЗ «О персональных данных»;&lt;/p&gt;&lt;p&gt;— производит определение угроз безопасности персональных данных при их обработке в информационной системе Оператора;&lt;/p&gt;&lt;p&gt;— применяет организационные и технические меры и использует средства защиты информации, необходимые для достижения установленного уровня защищенности персональных данных;&lt;/p&gt;&lt;p&gt;— осуществляет обнаружение фактов несанкционированного доступа к персональным данным и принимает меры по реагированию, включая восстановление персональных данных, модифицированных или уничтоженных вследствие несанкционированного доступа к ним;&lt;/p&gt;&lt;p&gt;— производит оценку эффективности принимаемых мер по обеспечению безопасности персональных данных до ввода в эксплуатацию информационной системы Оператора;&lt;/p&gt;&lt;p&gt;— осуществляет внутренний контроль соответствия обработки персональных данных ФЗ «О персональных данных», принятым в соответствии с ним нормативным правовым актам, требованиям к защите персональных данных, Политике, Положению и иным локальным актам, включающий контроль за принимаемыми мерами по обеспечению безопасности персональных данных и их уровня защищенности при обработке в информационной системе Оператора.&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h3 style=&quot;text-align: center; &quot;&gt;7. Права субъектов персональных данных&lt;/h3&gt;&lt;p&gt;7.1. Субъект персональных данных имеет право:&lt;/p&gt;&lt;p&gt;— на получение персональных данных, относящихся к данному субъекту, и информации, касающейся их обработки;&lt;/p&gt;&lt;p&gt;— на уточнение, блокирование или уничтожение его персональных данных в случае, если они являются неполными, устаревшими, неточными, незаконно полученными или не являются необходимыми для заявленной цели обработки;&lt;/p&gt;&lt;p&gt;— на отзыв данного им согласия на обработку персональных данных;&lt;/p&gt;&lt;p&gt;— на защиту своих прав и законных интересов, в том числе на возмещение убытков и компенсацию морального вреда в судебном порядке;&lt;/p&gt;&lt;p&gt;— на обжалование действий или бездействия Оператора в уполномоченный орган по защите прав субъектов персональных данных или в судебном порядке.&lt;/p&gt;&lt;p&gt;7.2. Для реализации своих прав и законных интересов субъекты персональных данных имеют право обратиться к Оператору либо направить запрос лично или с помощью представителя. Запрос должен содержать сведения, указанные в ч. 3 ст. 14 ФЗ «О персональных данных».&lt;/p&gt;&lt;div&gt;&lt;br&gt;&lt;/div&gt;\r\n','','','',''),(5,1,'Правила размещения отзывов','&lt;p&gt;1. Настоящий раздел сайта создан для написания отзывов действующих клиентов о качестве работы ООО «ТК Ант-Снаб».&lt;/p&gt;&lt;p&gt;2. Все указанные при отправке отзыва поля, являются обязательными для заполнения.&lt;/p&gt;&lt;p&gt;3. В данном разделе не размещаются (удаляются при премодерации) сообщения, содержащие:&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp;3.1. Призывы к межнациональной, расовой, религиозной и иной розни.&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp;3.2. Материалы, оскорбительного или провокационного характера.&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp;3.3. Нецензурную лексику.&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp;3.4. Ссылки на сторонние сайты, открытые, либо скрытые предложения товаров и услуг.&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp;3.5. Материалы, запрещенные к размещению в сети Интернет действующим законодательством РФ.&lt;/p&gt;&lt;p&gt;4. Также не размещаются отзывы от пользователей, чьи данные отсутствуют в базе данных ООО «ТК Ант-Снаб», что свидетельствует о том, что размещающее сообщение лицо не является клиентом ООО «ТК Ант-Снаб» и не может иметь представления о качестве поставляемых товаров и оказываемых услуг.&lt;/p&gt;&lt;p&gt;5. Премодерация отзывов происходит исключительно в рамках вышеуказанных пунктов и не затрагивает сам отзыв, мы размещаем как положительные, так и отрицательные отзывы о себе, если таковые имеют место.&lt;/p&gt;&lt;p&gt;6. При публикации отзыва указываются только имя пользователя и время размещения, электронный адрес и название организации не отображаются.&lt;/p&gt;\r\n','Правила размещения отзывов','Правила размещения отзывов','Правила размещения отзывов','Правила размещения отзывов'),(4,1,'О компании','&lt;p&gt;Компания Ант-Снаб создана в 2012 году командой энтузиастов от «строительных продаж». Имея за плечами достаточный опыт в сфере производства и реализации строительных материалов, мы подумали – «а почему бы и нет?». И вот кто мы сегодня:&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Производитель&lt;/h2&gt;&lt;p&gt;На подмосковном заводе «АСТ», расположенном в городе Щелково, под маркой «Ант-Снаб» и «Пруф» выпускаются битумные мастики холодного и горячего применения, праймеры, строительные битумы и пергамин.&lt;/p&gt;&lt;p&gt;В 2012 году налажен выпуск пароизоляционного пергамина марок: П-250, П-300 и П-350. Материал производится по техническим условиям. Производственная мощность линии – до 5 000 рулонов в сутки.&lt;/p&gt;&lt;p&gt;С 2014 года на заводе производятся мастики и праймеры эконом-класса, отличающиеся достойными техническими характеристиками и очень демократичной ценой. Сочетая в себе эти качества, мастики и праймеры успели полюбиться многим российским строителям.&lt;/p&gt;&lt;p&gt;В 2017 году начат выпуск мастик горячего и холодного применения по ГОСТ. Производятся марки: МБК-Г, МБК-Х, МБР, МБР-Х различной теплостойкости. Готовая продукция фасуется в металлические евроведра или четырехслойные крафт-мешки.&lt;/p&gt;&lt;p&gt;В начале 2018 года запущено производство готовых к применению битумных мастик и праймеров под маркой «Пруф». Продукция отличается высоким качеством, отличными характеристиками и доступной ценой в сравнении с аналогами.&lt;/p&gt;&lt;p&gt;Надежные контракты с поставщиками, а также собственные запасы сырья и готовой продукции, позволяют уберечь наших клиентов от нервозных изменений цен и перебоев в поставках.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Официальный представитель&lt;/h2&gt;&lt;p&gt;Рязанский Картонно-Рубероидный Завод существует более 55 лет и за это время зарекомендовал себя как надежный производитель со стабильным качеством продукции. Ежегодно производится более 100 миллионов м2 различных видов кровельных материалов. Ант-Снаб – официальный представитель Рязанского КРЗ на территории Москвы и Московской области.&lt;/p&gt;&lt;p&gt;ЗАО «Оргкровля» г. Рязань более 45 лет работает в сфере производства мягких кровельных материалов и разработки кровельных технологий. Завод славится высокой производительностью, стабильным качеством продукции и низкими ценами в сравнении с аналогичной продукцией других производителей. Компания Ант-Снаб является представителем завода на территории Москвы и Московской области.&lt;/p&gt;&lt;p&gt;Тщательно просчитанная логистика позволяет нашим клиентам получать любые партии материалов Рязанского КРЗ и Оргкровли напрямую с заводов по оптимальным ценам в кратчайшие сроки.&lt;/p&gt;&lt;p&gt;Soudal – крупнейший мировой производитель полиуретановых монтажных пен, герметиков, клеев и других изоляционных материалов. Концерн работает уже более 50 лет, из них 20 лет в России. Продукция Соудал поставляется в более чем 130 стран. ООО «ТК Ант-Снаб» – официальный партнер компании в г. Москва.&lt;/p&gt;&lt;p&gt;Компания САЗИ уже более 20 лет занимается производством герметизирующих и изолирующих материалов для фасадных швов зданий, кровель, фундаментов, стыков и прочих мест примыканий. Ант-Снаб – официальный представитель САЗИ в московском регионе.&lt;/p&gt;&lt;p&gt;Акриловые и полиуретановые герметики под маркой Ecoroom производятся на заводе в подмосковном Раменском более 10 лет. Высококачественное сырье, современное оборудование и тщательный контроль качества – то, что, наряду с выгодными ценами, отличает герметики Экорум от аналогов. Компания Ант-Снаб – официальный дистрибьютор завода на территории Москвы.&lt;/p&gt;&lt;p&gt;ООО «Фаворит» – производитель сухих смесей под торговой маркой De Luxe. Качественные и доступные по цене штукатурки, шпатлевки, наливные полы и другие материалы производятся в г. Котельники Московской области. ООО «ТК Ант-Снаб» — официальный представитель компании Фаворит в Москве.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Надежный поставщик&lt;/h2&gt;&lt;p&gt;Гидроизоляционные материалы корпорации ТехноНИКОЛЬ сегодня известны всем. Более 200 миллионов людей уже живут в домах, построенных с применением этих материалов. Ант-Снаб поставляет рулонные материалы, битумные мастики и праймеры, монтажные пены и герметики со склада в Москве, а также напрямую с заводов в г. Воскресенск и г. Рязань.&lt;/p&gt;&lt;p&gt;Геотекстиль (Дорнит) – широко применяемый материал в дорожном и промышленном строительстве, при устройстве дренажей, озеленении. Наша компания поставляет геотекстиль как оптом, так и в розницу со склада в Москве.&lt;/p&gt;&lt;p&gt;Еще одним направлением деятельности для нас является оптово-розничная торговля древесно-плитными материалами. Всегда в наличии на складе фанера ФК, ФСФ и ламинированная фанера всех популярных размеров и толщин. Также мы предлагаем нашим клиентам OSB-3 и оргалит ведущих российских производителей.&lt;/p&gt;&lt;p&gt;Теплоносители для систем отопления и кондиционирования ТермоСтрим на российском рынке сравнительно недавно, но уже успели зарекомендовать себя как надежный и доступный материал. Ант-Снаб предлагает теплоносители оптом и в розницу со склада в Москве.&lt;/p&gt;&lt;p&gt;На нашем складе всегда в наличии необходимые на каждой стройке метизы, инструменты, сопутствующие товары и расходные материалы.&lt;/p&gt;&lt;p&gt;Мы не стоим на месте и постоянно совершенствуем производственное оборудование, контроль качества готовой продукции и методы продаж. Сегодня Ант-Снаб предлагаем вам присоединиться к числу наших счастливых клиентов и лично убедиться в достойном качестве, приемлемых ценах и безупречном сервисе.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Наши сертификаты&lt;/h2&gt;&lt;p&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/site/sert_soudal.jpg&quot; style=&quot;width: 300px;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/site/sert_krz.jpg&quot; style=&quot;width: 300px;&quot;&gt;&lt;/p&gt;\r\n&lt;a name=&quot;rekvizit&quot;&gt;&lt;/a&gt;\r\n&lt;h2&gt;Наши реквизиты и документы&lt;/h2&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;div class=&quot;table-responsive&quot;&gt;&lt;table class=&quot;table table-bordered table-striped&quot;&gt;\r\n&lt;tbody&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;Наименование организации&lt;/td&gt;\r\n&lt;td&gt;ООО «ТК Ант-Снаб»&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;Юридический адрес&lt;/td&gt;\r\n&lt;td&gt;127566, г. Москва, Высоковольтный проезд, д. 1, стр. 43, этаж 2, помещения\r\n7−10&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;Почтовый адрес&lt;/td&gt;\r\n&lt;td&gt;127566, г. Москва, Высоковольтный проезд, д. 1, стр. 43&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;Телефон&lt;/td&gt;\r\n&lt;td&gt;(495) 255−01−37&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;e-mail&lt;/td&gt;\r\n&lt;td&gt;&lt;a href=&quot;mailto:info@ant-snab.ru&quot;&gt;info@ant-snab.ru&lt;/a&gt;&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;Сайт&lt;/td&gt;\r\n&lt;td&gt;&lt;a href=&quot;http://www.ant-snab.ru&quot; target=&quot;_blank&quot;&gt;www.ant-snab.ru&lt;/a&gt;&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;ОГРН&lt;/td&gt;\r\n&lt;td&gt;1177746340903&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;ИНН&lt;/td&gt;\r\n&lt;td&gt;9715298737&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;КПП&lt;/td&gt;\r\n&lt;td&gt;771501001&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;ОКПО&lt;/td&gt;\r\n&lt;td&gt;13727123&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;р/с&lt;/td&gt;\r\n&lt;td&gt;40702810002310001718&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;В&amp;nbsp;банке&lt;/td&gt;\r\n&lt;td&gt;&lt;nobr&gt;АО&amp;nbsp;«АЛЬФА-БАНК»&lt;/nobr&gt; г. Москва&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;к/с&lt;/td&gt;\r\n&lt;td&gt;30101810200000000593&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;БИК&lt;/td&gt;\r\n&lt;td&gt;044525593&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td&gt;Генеральный директор&lt;/td&gt;\r\n&lt;td&gt;Гостев Никита Андреевич&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;/tbody&gt;\r\n&lt;/table&gt;&lt;/div&gt;','О компании Ант-Снаб: кто мы, миссия, наши реквизиты и документы','О компании','Официальная информация о компании Ант-Снаб. Кто мы такие, наша миссия, продукция, поставщики, реквизиты, сертификаты и документы','Официальная, информация, кто мы, наша миссия, продукция, товары, поставщики, дилеры, представители, реквизиты, генеральный директор, юридический адрес, банк, сертификаты, документы, договор, скачать, Ант-Снаб, ТК, ООО, компания');
/*!40000 ALTER TABLE `oc_information_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_information_to_layout`
--

DROP TABLE IF EXISTS `oc_information_to_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_information_to_layout` (
  `information_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`information_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_information_to_layout`
--

LOCK TABLES `oc_information_to_layout` WRITE;
/*!40000 ALTER TABLE `oc_information_to_layout` DISABLE KEYS */;
INSERT INTO `oc_information_to_layout` VALUES (4,0,11),(6,0,21),(3,0,11),(5,0,19);
/*!40000 ALTER TABLE `oc_information_to_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_information_to_store`
--

DROP TABLE IF EXISTS `oc_information_to_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_information_to_store` (
  `information_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`information_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_information_to_store`
--

LOCK TABLES `oc_information_to_store` WRITE;
/*!40000 ALTER TABLE `oc_information_to_store` DISABLE KEYS */;
INSERT INTO `oc_information_to_store` VALUES (3,0),(4,0),(5,0),(6,0);
/*!40000 ALTER TABLE `oc_information_to_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_language`
--

DROP TABLE IF EXISTS `oc_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_language` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `code` varchar(5) NOT NULL,
  `locale` varchar(255) NOT NULL,
  `image` varchar(64) NOT NULL,
  `directory` varchar(32) NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_language`
--

LOCK TABLES `oc_language` WRITE;
/*!40000 ALTER TABLE `oc_language` DISABLE KEYS */;
INSERT INTO `oc_language` VALUES (1,'Russian','ru-ru','ru_RU.UTF-8,ru_RU,russian','ru.png','russian',1,1);
/*!40000 ALTER TABLE `oc_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_layout`
--

DROP TABLE IF EXISTS `oc_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_layout` (
  `layout_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`layout_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_layout`
--

LOCK TABLES `oc_layout` WRITE;
/*!40000 ALTER TABLE `oc_layout` DISABLE KEYS */;
INSERT INTO `oc_layout` VALUES (1,'Главная'),(2,'Продукт'),(3,'Категория'),(4,'По умолчанию'),(5,'Производитель'),(6,'Аккаунт'),(7,'Оформление заказ'),(8,'Контакты'),(9,'Карта сайта'),(10,'Партнерская программа'),(11,'Информация'),(12,'Сравнение'),(13,'Поиск'),(14,'Отзывы'),(15,'Список статей'),(16,'Одна статья'),(17,'Список новостей'),(18,'Новость'),(19,'Информация короткая'),(20,'Прайс лист'),(21,'Информация средняя'),(22,'Заказ успешно');
/*!40000 ALTER TABLE `oc_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_layout_module`
--

DROP TABLE IF EXISTS `oc_layout_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_layout_module` (
  `layout_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `layout_id` int(11) NOT NULL,
  `code` varchar(64) NOT NULL,
  `position` varchar(14) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`layout_module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=219 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_layout_module`
--

LOCK TABLES `oc_layout_module` WRITE;
/*!40000 ALTER TABLE `oc_layout_module` DISABLE KEYS */;
INSERT INTO `oc_layout_module` VALUES (213,4,'account','content_top',0),(212,4,'category','column_left',1),(20,5,'0','column_left',2),(69,10,'affiliate','column_right',1),(68,6,'account','column_right',1),(168,1,'review','content_bottom',0),(167,1,'html.32','content_top',1),(209,2,'category','column_left',0),(208,3,'category','column_left',1),(211,4,'account','column_left',0),(166,1,'slideshow.27','content_top',0),(165,1,'newsblog_articles.37','column_left',2),(193,14,'html.38','content_top',0),(192,14,'newsblog_articles.37','column_left',2),(206,15,'newsblog_articles.36','column_left',1),(187,16,'newsblog_articles.37','column_left',2),(203,17,'newsblog_articles.37','column_left',1),(182,18,'newsblog_articles.37','column_left',2),(164,1,'newsblog_articles.36','column_left',1),(163,1,'category','column_left',0),(174,11,'newsblog_articles.37','column_left',2),(173,11,'newsblog_articles.36','column_left',1),(172,11,'category','column_left',0),(131,19,'category','column_left',0),(199,20,'newsblog_articles.37','column_left',2),(198,20,'newsblog_articles.36','column_left',1),(197,20,'category','column_left',0),(205,15,'category','column_left',0),(191,14,'newsblog_articles.36','column_left',1),(190,14,'category','column_left',0),(178,21,'newsblog_articles.37','column_left',1),(177,21,'category','column_left',0),(154,8,'category','column_left',0),(202,17,'category','column_left',0),(186,16,'newsblog_articles.36','column_left',1),(185,16,'category','column_left',0),(181,18,'newsblog_articles.36','column_left',1),(180,18,'category','column_left',0),(169,1,'html.33','content_bottom',1),(170,1,'newsblog_articles.36','content_bottom',2),(171,1,'newsblog_articles.37','content_bottom',3),(175,11,'newsblog_articles.36','content_bottom',0),(176,11,'newsblog_articles.37','content_bottom',1),(179,21,'newsblog_articles.37','content_bottom',0),(183,18,'newsblog_articles.36','content_bottom',0),(184,18,'newsblog_articles.37','content_bottom',1),(188,16,'newsblog_articles.36','content_bottom',0),(189,16,'newsblog_articles.37','content_bottom',1),(194,14,'html.35','content_bottom',0),(195,14,'newsblog_articles.36','content_bottom',1),(196,14,'newsblog_articles.37','content_bottom',2),(200,20,'newsblog_articles.36','content_bottom',0),(201,20,'newsblog_articles.37','content_bottom',1),(204,17,'newsblog_articles.37','content_bottom',0),(207,15,'newsblog_articles.36','content_bottom',0),(214,4,'account','content_top',1),(218,7,'category','column_left',0),(217,22,'category','column_left',0);
/*!40000 ALTER TABLE `oc_layout_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_layout_route`
--

DROP TABLE IF EXISTS `oc_layout_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_layout_route` (
  `layout_route_id` int(11) NOT NULL AUTO_INCREMENT,
  `layout_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `route` varchar(64) NOT NULL,
  PRIMARY KEY (`layout_route_id`)
) ENGINE=MyISAM AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_layout_route`
--

LOCK TABLES `oc_layout_route` WRITE;
/*!40000 ALTER TABLE `oc_layout_route` DISABLE KEYS */;
INSERT INTO `oc_layout_route` VALUES (38,6,0,'account/%'),(17,10,0,'affiliate/%'),(98,3,0,'product/category'),(89,1,0,'common/home'),(99,2,0,'product/product'),(90,11,0,'information/information'),(104,7,0,'checkout/%'),(85,8,0,'information/contact'),(32,9,0,'information/sitemap'),(101,4,0,''),(45,5,0,'product/manufacturer'),(52,12,0,'product/compare'),(53,13,0,'product/search'),(77,19,0,'information/information'),(94,14,0,'information/review'),(97,15,0,'newsblog/category'),(93,16,0,'newsblog/article'),(96,17,0,'newsblog/category'),(92,18,0,'newsblog/article'),(95,20,0,'product/price'),(91,21,0,'information/information'),(103,22,0,'сheckout/success');
/*!40000 ALTER TABLE `oc_layout_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_length_class`
--

DROP TABLE IF EXISTS `oc_length_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_length_class` (
  `length_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(15,2) NOT NULL,
  PRIMARY KEY (`length_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_length_class`
--

LOCK TABLES `oc_length_class` WRITE;
/*!40000 ALTER TABLE `oc_length_class` DISABLE KEYS */;
INSERT INTO `oc_length_class` VALUES (1,1.00),(2,1.00),(3,0.39);
/*!40000 ALTER TABLE `oc_length_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_length_class_description`
--

DROP TABLE IF EXISTS `oc_length_class_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_length_class_description` (
  `length_class_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `unit` varchar(4) NOT NULL,
  PRIMARY KEY (`length_class_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_length_class_description`
--

LOCK TABLES `oc_length_class_description` WRITE;
/*!40000 ALTER TABLE `oc_length_class_description` DISABLE KEYS */;
INSERT INTO `oc_length_class_description` VALUES (1,1,'Сантиметр','см'),(2,1,'Миллиметр','мм');
/*!40000 ALTER TABLE `oc_length_class_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_location`
--

DROP TABLE IF EXISTS `oc_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `address` text NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `geocode` varchar(32) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `open` text NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_location`
--

LOCK TABLES `oc_location` WRITE;
/*!40000 ALTER TABLE `oc_location` DISABLE KEYS */;
INSERT INTO `oc_location` VALUES (1,'Офис и склад Алтуфьево','Адрес: г. Москва, Высоковольтный проезд, дом 1, строение 43','+7 (495) 255-01-37','8 (800) 775-28-31','55.873657,37.592222','','График работы: с 8.30 до 18.30, с понедельника по пятницу\r\nБез обеда',''),(2,'Склад Щёлково','Адрес: Московская область, г. Щелково, ул. Заводская, д. 2, территория завода &quot;Щелково Агрохим&quot;','+7 (495) 255-01-37','8 (800) 775-28-31','55.910463,38.020116','','График работы: с 8.30 до 18.30, с понедельника по пятницу\r\nБез обеда','');
/*!40000 ALTER TABLE `oc_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_manufacturer`
--

DROP TABLE IF EXISTS `oc_manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_manufacturer` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_manufacturer`
--

LOCK TABLES `oc_manufacturer` WRITE;
/*!40000 ALTER TABLE `oc_manufacturer` DISABLE KEYS */;
INSERT INTO `oc_manufacturer` VALUES (5,'HTC','catalog/demo/htc_logo.jpg',0),(6,'Palm','catalog/demo/palm_logo.jpg',0),(7,'Hewlett-Packard','catalog/demo/hp_logo.jpg',0),(8,'Рязанский КРЗ','catalog/demo/apple_logo.jpg',0),(9,'Canon','catalog/demo/canon_logo.jpg',0),(10,'Sony','catalog/demo/sony_logo.jpg',0);
/*!40000 ALTER TABLE `oc_manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_manufacturer_description`
--

DROP TABLE IF EXISTS `oc_manufacturer_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_manufacturer_description` (
  `manufacturer_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_h1` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`manufacturer_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_manufacturer_description`
--

LOCK TABLES `oc_manufacturer_description` WRITE;
/*!40000 ALTER TABLE `oc_manufacturer_description` DISABLE KEYS */;
INSERT INTO `oc_manufacturer_description` VALUES (5,1,'HTC','','HTC','','',''),(6,1,'Palm','','Palm','','',''),(7,1,'Hewlett-Packard','','Hewlett-Packard','','',''),(8,1,'Рязанский КРЗ','','Apple','','',''),(9,1,'Canon','Пример текста в описания производителя','Canon','','',''),(10,1,'Sony','','Sony','','','');
/*!40000 ALTER TABLE `oc_manufacturer_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_manufacturer_to_store`
--

DROP TABLE IF EXISTS `oc_manufacturer_to_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_manufacturer_to_store` (
  `manufacturer_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`manufacturer_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_manufacturer_to_store`
--

LOCK TABLES `oc_manufacturer_to_store` WRITE;
/*!40000 ALTER TABLE `oc_manufacturer_to_store` DISABLE KEYS */;
INSERT INTO `oc_manufacturer_to_store` VALUES (5,0),(6,0),(7,0),(8,0),(9,0),(10,0);
/*!40000 ALTER TABLE `oc_manufacturer_to_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_marketing`
--

DROP TABLE IF EXISTS `oc_marketing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_marketing` (
  `marketing_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `code` varchar(64) NOT NULL,
  `clicks` int(5) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`marketing_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_marketing`
--

LOCK TABLES `oc_marketing` WRITE;
/*!40000 ALTER TABLE `oc_marketing` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_marketing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_menu`
--

DROP TABLE IF EXISTS `oc_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL,
  `type` varchar(6) NOT NULL,
  `link` varchar(255) NOT NULL,
  `sort_order` int(3) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_menu`
--

LOCK TABLES `oc_menu` WRITE;
/*!40000 ALTER TABLE `oc_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_menu_description`
--

DROP TABLE IF EXISTS `oc_menu_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_menu_description` (
  `menu_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`menu_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_menu_description`
--

LOCK TABLES `oc_menu_description` WRITE;
/*!40000 ALTER TABLE `oc_menu_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_menu_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_menu_module`
--

DROP TABLE IF EXISTS `oc_menu_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_menu_module` (
  `menu_module_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `code` varchar(64) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`menu_module_id`),
  KEY `menu_id` (`menu_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_menu_module`
--

LOCK TABLES `oc_menu_module` WRITE;
/*!40000 ALTER TABLE `oc_menu_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_menu_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_modification`
--

DROP TABLE IF EXISTS `oc_modification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_modification` (
  `modification_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `code` varchar(64) NOT NULL,
  `author` varchar(64) NOT NULL,
  `version` varchar(32) NOT NULL,
  `link` varchar(255) NOT NULL,
  `xml` mediumtext NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`modification_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_modification`
--

LOCK TABLES `oc_modification` WRITE;
/*!40000 ALTER TABLE `oc_modification` DISABLE KEYS */;
INSERT INTO `oc_modification` VALUES (10,'wspatch','wspatch','wslapshin','1.0.0','http://vk.com/wslapshin','<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<modification>\n    <name>wspatch</name>\n    <id>wspatch</id>\n    <code>wspatch</code>\n    <version>1.0.0</version>\n    <author>wslapshin</author>\n    <link>http://vk.com/wslapshin</link>\n\n    <file path=\"system/library/config.php\">\n        <operation>\n           <search><![CDATA[class Config {]]></search>\n           <add position=\"after\"><![CDATA[\n               use \\WS\\Traits\\System\\Library\\Config;\n           ]]></add>\n        </operation>\n\n        <operation>\n           <search><![CDATA[function load]]></search>\n           <add position=\"replace\"><![CDATA[\n               function __wspatch_overrided_load\n           ]]></add>\n        </operation>\n    </file>\n\n    <file path=\"system/engine/action.php\">\n        <operation>\n            <search><![CDATA[class Action {]]></search>\n           <add position=\"after\"><![CDATA[\n               use \\WS\\Traits\\System\\Engine\\Action;\n           ]]></add>\n        </operation>\n\n        <operation>\n           <search><![CDATA[function __construct]]></search>\n           <add position=\"replace\"><![CDATA[\n               function __wspatch_overrided___construct\n           ]]></add>\n        </operation>\n\n        <operation>\n           <search><![CDATA[function execute]]></search>\n           <add position=\"replace\"><![CDATA[\n               function __wspatch_overrided_execute\n           ]]></add>\n        </operation>\n    </file>\n    \n    <file path=\"system/engine/loader.php\">\n        <operation>\n           <search><![CDATA[class Loader {]]></search>\n           <add position=\"after\"><![CDATA[\n               use \\WS\\Traits\\System\\Engine\\Loader;\n           ]]></add>\n        </operation>\n\n        <operation>\n           <search><![CDATA[function view]]></search>\n           <add position=\"replace\"><![CDATA[\n               function __wspatch_overrided_view\n           ]]></add>\n        </operation>\n\n        <operation>\n           <search><![CDATA[function model]]></search>\n           <add position=\"replace\"><![CDATA[\n               function __wspatch_overrided_model\n           ]]></add>\n        </operation>\n\n        <operation>\n           <search><![CDATA[function callback]]></search>\n           <add position=\"replace\"><![CDATA[\n               function __wspatch_overrided_callback\n           ]]></add>\n        </operation>\n\n    </file>\n\n    <file path=\"system/engine/controller.php\">\n<operation>\n           <search><![CDATA[abstract class Controller {]]></search>\n           <add position=\"before\"><![CDATA[\n               use WS\\Override\\Controller\\IDEAutocompleteController as IDEAutocompleteController;\n           ]]></add>\n        </operation>\n\n        <operation>\n           <search><![CDATA[abstract class Controller {]]></search>\n           <add position=\"replace\"><![CDATA[\n               abstract class Controller extends IDEAutocompleteController {\n           ]]></add>\n        </operation>\n    </file>\n</modification>',1,'2018-03-30 21:26:00'),(12,'Local copy OCMOD by iSenseLabs','isensealabs_quickfix_ocmod','iSenseLabs','1.3','http://isenselabs.com','<modification>\r\n    <name>Local copy OCMOD by iSenseLabs</name>\r\n	<version>1.3</version>\r\n	<link>http://isenselabs.com</link>\r\n	<author>iSenseLabs</author>\r\n	<code>isensealabs_quickfix_ocmod</code>\r\n\r\n	<file path=\"admin/controller/extension/installer.php\">\r\n		<operation error=\"skip\">\r\n			<search ><![CDATA[\'url\'  => str_replace(\'&amp;\', \'&\', $this->url->link(\'extension/installer/ftp\', \'token=\' . $this->session->data[\'token\'],]]></search>\r\n			<add position=\"replace\"><![CDATA[\'url\'  => str_replace(\'&amp;\', \'&\', $this->url->link(\'extension/installer/localcopy\', \'token=\' . $this->session->data[\'token\'],]]></add>\r\n		</operation>\r\n\r\n		<operation>\r\n			<search><![CDATA[public function unzip() {]]></search>\r\n			<add position=\"before\"><![CDATA[			\r\n	public function localcopy() {\r\n		$this->load->language(\'extension/installer\');\r\n\r\n		$json = array();\r\n\r\n		if (!$this->user->hasPermission(\'modify\', \'extension/installer\')) {\r\n			$json[\'error\'] = $this->language->get(\'error_permission\');\r\n		}\r\n\r\n		if (VERSION == \'2.0.0.0\') {\r\n		    $directory = DIR_DOWNLOAD  . str_replace(array(\'../\', \'..\\\\\', \'..\'), \'\', $this->request->post[\'path\']) . \'/upload/\';\r\n		} else {\r\n		    $directory = DIR_UPLOAD  . str_replace(array(\'../\', \'..\\\\\', \'..\'), \'\', $this->request->post[\'path\']) . \'/upload/\';\r\n		}\r\n\r\n		if (!is_dir($directory)) {\r\n			$json[\'error\'] = $this->language->get(\'error_directory\');\r\n		}\r\n\r\n		if (!$json) {\r\n			// Get a list of files ready to upload\r\n			$files = array();\r\n\r\n			$path = array($directory . \'*\');\r\n\r\n			while (count($path) != 0) {\r\n				$next = array_shift($path);\r\n				\r\n				if( glob($next) ) {\r\n				foreach (glob($next) as $file) {\r\n					if (is_dir($file)) {\r\n						$path[] = $file . \'/*\';\r\n					}\r\n\r\n					$files[] = $file;\r\n				}\r\n				}\r\n			}\r\n\r\n			$root = dirname(DIR_APPLICATION).\'/\';\r\n\r\n			\r\n			foreach ($files as $file) {\r\n				// Upload everything in the upload directory\r\n				$destination = substr($file, strlen($directory));\r\n\r\n				// Update from newer OpenCart versions:\r\n				if (substr($destination, 0, 5) == \'admin\') {\r\n					$destination = DIR_APPLICATION . substr($destination, 5);\r\n				} else if (substr($destination, 0, 7) == \'catalog\') {\r\n					$destination = DIR_CATALOG . substr($destination, 7);\r\n				} else if (substr($destination, 0, 5) == \'image\') {\r\n					$destination = DIR_IMAGE . substr($destination, 5);\r\n				} else if (substr($destination, 0, 6) == \'system\') {\r\n					$destination = DIR_SYSTEM . substr($destination, 6);\r\n				} else {\r\n					$destination = $root.$destination;\r\n				}\r\n\r\n				if (is_dir($file)) {\r\n					if (!file_exists($destination)) {\r\n						if (!mkdir($destination)) {\r\n							$json[\'error\'] = sprintf($this->language->get(\'error_ftp_directory\'), $destination);\r\n						}\r\n					}\r\n				}\r\n\r\n				if (is_file($file)) {\r\n					if (!copy($file, $destination)) {\r\n						$json[\'error\'] = sprintf($this->language->get(\'error_ftp_file\'), $file);\r\n					}\r\n				}\r\n			}\r\n		}\r\n\r\n		$this->response->addHeader(\'Content-Type: application/json\');\r\n		$this->response->setOutput(json_encode($json));\r\n	}]]></add>\r\n		</operation>\r\n	</file>	\r\n</modification>\r\n',1,'2018-04-03 00:52:53'),(13,'NewsBlog - create unlimited categories with articles','newsblog','netruxa','20171002 for opencart 2.3.x','http://nedorogoi-internet-magazin.ru/opencart/','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<modification>\r\n    <name>NewsBlog - create unlimited categories with articles</name>\r\n    <code>newsblog</code>\r\n    <version>20171002 for opencart 2.3.x</version>\r\n    <author>netruxa</author>\r\n    <link>http://nedorogoi-internet-magazin.ru/opencart/</link>\r\n  <file path=\"admin/controller/common/column_left.php\">\r\n    <operation>\r\n      <search><![CDATA[// Catalog]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      		$newsblog = array();\r\n\r\n			if ($this->user->hasPermission(\'access\', \'newsblog/category\')) {\r\n				$newsblog[] = array(\r\n					\'name\'	   => $this->language->get(\'text_newsblog_category\'),\r\n					\'href\'     => $this->url->link(\'newsblog/category\', \'token=\' . $this->session->data[\'token\'], true),\r\n					\'children\' => array()\r\n				);\r\n			}\r\n\r\n			if ($this->user->hasPermission(\'access\', \'newsblog/article\')) {\r\n				$newsblog[] = array(\r\n					\'name\'	   => $this->language->get(\'text_newsblog_article\'),\r\n					\'href\'     => $this->url->link(\'newsblog/article\', \'token=\' . $this->session->data[\'token\'], true),\r\n					\'children\' => array()\r\n				);\r\n			}\r\n\r\n			if ($newsblog) {\r\n				$data[\'menus\'][] = array(\r\n					\'id\'       => \'menu-newsblog\',\r\n					\'icon\'	   => \'fa-newspaper-o\',\r\n					\'name\'	   => $this->language->get(\'text_newsblog\'),\r\n					\'href\'     => \'\',\r\n					\'children\' => $newsblog\r\n				);\r\n			}\r\n      ]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"admin/language/ru-ru/common/column_left.php\">\r\n    <operation>\r\n      <search><![CDATA[$_[\'text_catalog\']]]></search>\r\n      <add position=\"before\"><![CDATA[$_[\'text_newsblog\'] = \'NewsBlog материалы\';$_[\'text_newsblog_category\'] = \'Список категорий\';$_[\'text_newsblog_article\'] = \'Список материалов\';]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"admin/language/en-gb/common/column_left.php\">\r\n    <operation>\r\n      <search><![CDATA[$_[\'text_catalog\']]]></search>\r\n      <add position=\"before\"><![CDATA[$_[\'text_newsblog\'] = \'NewsBlog articles\';$_[\'text_newsblog_category\'] = \'Category list\';$_[\'text_newsblog_article\'] = \'Item list\';]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"catalog/controller/common/column_left.php\">\r\n    <operation>\r\n      <search><![CDATA[if ($route == \'information/information\' && isset($this->request->get[\'information_id\'])) {]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      if ($route == \'newsblog/category\' && isset($this->request->get[\'newsblog_path\'])) {\r\n			$this->load->model(\'newsblog/category\');\r\n\r\n			$path = explode(\'_\', (string)$this->request->get[\'newsblog_path\']);\r\n\r\n			$layout_id = $this->model_newsblog_category->getCategoryLayoutId(end($path));\r\n		}\r\n\r\n		if ($route == \'newsblog/article\' && isset($this->request->get[\'newsblog_article_id\'])) {\r\n			$this->load->model(\'newsblog/article\');\r\n\r\n			$layout_id = $this->model_newsblog_article->getArticleLayoutId($this->request->get[\'newsblog_article_id\']);\r\n		}\r\n      ]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"catalog/controller/common/column_right.php\">\r\n    <operation>\r\n      <search><![CDATA[if ($route == \'information/information\' && isset($this->request->get[\'information_id\'])) {]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      if ($route == \'newsblog/category\' && isset($this->request->get[\'newsblog_path\'])) {\r\n			$this->load->model(\'newsblog/category\');\r\n\r\n			$path = explode(\'_\', (string)$this->request->get[\'newsblog_path\']);\r\n\r\n			$layout_id = $this->model_newsblog_category->getCategoryLayoutId(end($path));\r\n		}\r\n\r\n		if ($route == \'newsblog/article\' && isset($this->request->get[\'newsblog_article_id\'])) {\r\n			$this->load->model(\'newsblog/article\');\r\n\r\n			$layout_id = $this->model_newsblog_article->getArticleLayoutId($this->request->get[\'newsblog_article_id\']);\r\n		}\r\n      ]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"catalog/controller/common/content_bottom.php\">\r\n    <operation>\r\n      <search><![CDATA[if ($route == \'information/information\' && isset($this->request->get[\'information_id\'])) {]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      if ($route == \'newsblog/category\' && isset($this->request->get[\'newsblog_path\'])) {\r\n			$this->load->model(\'newsblog/category\');\r\n\r\n			$path = explode(\'_\', (string)$this->request->get[\'newsblog_path\']);\r\n\r\n			$layout_id = $this->model_newsblog_category->getCategoryLayoutId(end($path));\r\n		}\r\n\r\n		if ($route == \'newsblog/article\' && isset($this->request->get[\'newsblog_article_id\'])) {\r\n			$this->load->model(\'newsblog/article\');\r\n\r\n			$layout_id = $this->model_newsblog_article->getArticleLayoutId($this->request->get[\'newsblog_article_id\']);\r\n		}\r\n      ]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"catalog/controller/common/content_top.php\">\r\n    <operation>\r\n      <search><![CDATA[if ($route == \'information/information\' && isset($this->request->get[\'information_id\'])) {]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      if ($route == \'newsblog/category\' && isset($this->request->get[\'newsblog_path\'])) {\r\n			$this->load->model(\'newsblog/category\');\r\n\r\n			$path = explode(\'_\', (string)$this->request->get[\'newsblog_path\']);\r\n\r\n			$layout_id = $this->model_newsblog_category->getCategoryLayoutId(end($path));\r\n		}\r\n\r\n		if ($route == \'newsblog/article\' && isset($this->request->get[\'newsblog_article_id\'])) {\r\n			$this->load->model(\'newsblog/article\');\r\n\r\n			$layout_id = $this->model_newsblog_article->getArticleLayoutId($this->request->get[\'newsblog_article_id\']);\r\n		}\r\n      ]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"catalog/controller/startup/seo_url.php\">\r\n    <operation>\r\n      <search><![CDATA[if ($url[0] == \'information_id\') {]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      				if ($url[0] == \'newsblog_article_id\') {\r\n						$this->request->get[\'newsblog_article_id\'] = $url[1];\r\n					}\r\n\r\n					if ($url[0] == \'newsblog_category_id\') {\r\n						if (!isset($this->request->get[\'newsblog_path\'])) {\r\n							$this->request->get[\'newsblog_path\'] = $url[1];\r\n						} else {\r\n							$this->request->get[\'newsblog_path\'] .= \'_\' . $url[1];\r\n						}\r\n					}\r\n		]]></add>\r\n	</operation>\r\n	<operation>\r\n		<search><![CDATA[$url[0] != \'information_id\']]></search>\r\n	    <add position=\"replace \"><![CDATA[$url[0] != \'newsblog_category_id\' && $url[0] != \'newsblog_article_id\' && $url[0] != \'information_id\']]></add>\r\n	</operation>\r\n	<operation>\r\n	    <search><![CDATA[} elseif (isset($this->request->get[\'information_id\'])) {]]></search>\r\n        <add position=\"before\"><![CDATA[\r\n      			} elseif (isset($this->request->get[\'newsblog_article_id\'])) {\r\n					$this->request->get[\'route\'] = \'newsblog/article\';\r\n				} elseif (isset($this->request->get[\'newsblog_path\'])) {\r\n					$this->request->get[\'route\'] = \'newsblog/category\';\r\n		]]></add>\r\n	</operation>\r\n	<operation>\r\n		<search><![CDATA[($data[\'route\'] == \'information/information\' && $key == \'information_id\')]]></search>\r\n	    <add position=\"replace\"><![CDATA[($data[\'route\'] == \'newsblog/article\' && $key == \'newsblog_article_id\') || ($data[\'route\'] == \'information/information\' && $key == \'information_id\')]]></add>\r\n	</operation>\r\n	<operation>\r\n	    <search><![CDATA[} elseif ($key == \'path\') {]]></search>\r\n        <add position=\"before\"><![CDATA[\r\n      			} elseif ($key == \'newsblog_path\') {\r\n					$categories = explode(\'_\', $value);\r\n\r\n					foreach ($categories as $category) {\r\n						$query = $this->db->query(\"SELECT * FROM \" . DB_PREFIX . \"url_alias WHERE `query` = \'newsblog_category_id=\" . (int)$category . \"\'\");\r\n\r\n						if ($query->num_rows && $query->row[\'keyword\']) {\r\n							$url .= \'/\' . $query->row[\'keyword\'];\r\n						} else {\r\n							$url = \'\';\r\n\r\n							break;\r\n						}\r\n					}\r\n\r\n					unset ($data[$key]);\r\n		]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"catalog/controller/startup/seo_pro.php\">\r\n    <operation>\r\n      <search><![CDATA[if ($url[0] == \'category_id\') {]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      				if ($url[0] == \'newsblog_category_id\') {\r\n						if (!isset($this->request->get[\'newsblog_path\'])) {\r\n							$this->request->get[\'newsblog_path\'] = $url[1];\r\n						} else {\r\n							$this->request->get[\'newsblog_path\'] .= \'_\' . $url[1];\r\n						}\r\n					} else\r\n		]]></add>\r\n	</operation>\r\n	<operation>\r\n		<search><![CDATA[if (isset($this->request->get[\'product_id\'])) {]]></search>\r\n	    <add position=\"before\"><![CDATA[\r\n		    if (isset($this->request->get[\'newsblog_article_id\'])) {\r\n				$this->request->get[\'route\'] = \'newsblog/article\';\r\n				if (!isset($this->request->get[\'newsblog_path\'])) {\r\n					$path = $this->getPathByNewsBlogArticle($this->request->get[\'newsblog_article_id\']);\r\n					if ($path) $this->request->get[\'newsblog_path\'] = $path;\r\n				}\r\n			} elseif (isset($this->request->get[\'newsblog_path\'])) {\r\n				$this->request->get[\'route\'] = \'newsblog/category\';\r\n			} else\r\n	    ]]></add>\r\n	</operation>\r\n	<operation>\r\n	    <search><![CDATA[case \'product/product\':]]></search>\r\n        <add position=\"before\"><![CDATA[\r\n      			case \'newsblog/article\':\r\n				if (isset($data[\'newsblog_article_id\'])) {\r\n					$tmp = $data;\r\n					$data = array();\r\n					if ($this->config->get(\'config_seo_url_include_path\')) {\r\n						$data[\'newsblog_path\'] = $this->getPathByNewsBlogArticle($tmp[\'newsblog_article_id\']);\r\n						if (!$data[\'newsblog_path\']) return $link;\r\n					}\r\n					$data[\'newsblog_article_id\'] = $tmp[\'newsblog_article_id\'];\r\n				}\r\n				break;\r\n\r\n			case \'newsblog/category\':\r\n				if (isset($data[\'newsblog_path\'])) {\r\n					$category = explode(\'_\', $data[\'newsblog_path\']);\r\n					$category = end($category);\r\n					$data[\'newsblog_path\'] = $this->getPathByNewsBlogCategory($category);\r\n					if (!$data[\'newsblog_path\']) return $link;\r\n				}\r\n				break;\r\n		]]></add>\r\n	</operation>\r\n	<operation>\r\n		<search><![CDATA[case \'product_id\':]]></search>\r\n	    <add position=\"before\"><![CDATA[\r\n	       			case \'newsblog_path\':\r\n						$categories = explode(\'_\', $value);\r\n						foreach($categories as $category) {\r\n							$queries[] = \'newsblog_category_id=\' . $category;\r\n						}\r\n						unset($data[$key]);\r\n						break;\r\n\r\n					case \'newsblog_article_id\':\r\n					case \'newsblog_category_id\':\r\n	    ]]></add>\r\n	</operation>\r\n	<operation>\r\n	    <search><![CDATA[private function getPathByProduct($product_id) {]]></search>\r\n        <add position=\"before\"><![CDATA[\r\n	private function getPathByNewsBlogArticle($article_id) {\r\n		$article_id = (int)$article_id;\r\n		if ($article_id < 1) return false;\r\n\r\n		static $path = null;\r\n		if (!isset($path)) {\r\n			$path = $this->cache->get(\'newsblog.article.seopath\');\r\n			if (!isset($path)) $path = array();\r\n		}\r\n\r\n		if (!isset($path[$article_id])) {\r\n			$query = $this->db->query(\"SELECT category_id FROM \" . DB_PREFIX . \"newsblog_article_to_category WHERE article_id = \'\" . $article_id . \"\' ORDER BY main_category DESC LIMIT 1\");\r\n\r\n			$path[$article_id] = $this->getPathByNewsBlogCategory($query->num_rows ? (int)$query->row[\'category_id\'] : 0);\r\n\r\n			$this->cache->set(\'newsblog.article.seopath\', $path);\r\n		}\r\n\r\n		return $path[$article_id];\r\n	}\r\n\r\n	private function getPathByNewsBlogCategory($category_id) {\r\n		$category_id = (int)$category_id;\r\n		if ($category_id < 1) return false;\r\n\r\n		static $path = null;\r\n		if (!isset($path)) {\r\n			$path = $this->cache->get(\'newsblog.category.seopath\');\r\n			if (!isset($path)) $path = array();\r\n		}\r\n\r\n		if (!isset($path[$category_id])) {\r\n			$max_level = 10;\r\n\r\n			$sql = \"SELECT CONCAT_WS(\'_\'\";\r\n			for ($i = $max_level-1; $i >= 0; --$i) {\r\n				$sql .= \",t$i.category_id\";\r\n			}\r\n			$sql .= \") AS path FROM \" . DB_PREFIX . \"newsblog_category t0\";\r\n			for ($i = 1; $i < $max_level; ++$i) {\r\n				$sql .= \" LEFT JOIN \" . DB_PREFIX . \"newsblog_category t$i ON (t$i.category_id = t\" . ($i-1) . \".parent_id)\";\r\n			}\r\n			$sql .= \" WHERE t0.category_id = \'\" . $category_id . \"\'\";\r\n\r\n			$query = $this->db->query($sql);\r\n\r\n			$path[$category_id] = $query->num_rows ? $query->row[\'path\'] : false;\r\n\r\n			$this->cache->set(\'newsblog.category.seopath\', $path);\r\n		}\r\n\r\n		return $path[$category_id];\r\n	}\r\n		]]></add>\r\n    </operation>\r\n  </file>\r\n  <file path=\"catalog/controller/information/sitemap.php\">\r\n    <operation>\r\n      <search><![CDATA[$this->load->model(\'catalog/information\');]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      	$this->load->model(\'newsblog/category\');\r\n        $this->load->model(\'newsblog/article\');\r\n\r\n		$data[\'newsblog_categories\'] = array();\r\n\r\n		$categories = $this->model_newsblog_category->getCategories(0);\r\n\r\n		foreach ($categories as $category) {\r\n			if ($category[\'settings\']) {\r\n				$settings=unserialize($category[\'settings\']);\r\n				if ($settings[\'show_in_sitemap\']==0) continue;\r\n			}\r\n\r\n			$articles = array();\r\n\r\n			if ($category[\'settings\'] && $settings[\'show_in_sitemap_articles\']) {\r\n				$filter=array(\'filter_category_id\'=>$category[\'category_id\'],\'filter_sub_category\'=>true);\r\n				$results = $this->model_newsblog_article->getArticles($filter);\r\n\r\n				foreach ($results as $result) {\r\n					$articles[] = array(\r\n						\'name\'        => $result[\'name\'],\r\n						\'href\'        => $this->url->link(\'newsblog/article\', \'newsblog_path=\' . $category[\'category_id\'] . \'&newsblog_article_id=\' . $result[\'article_id\'])\r\n					);\r\n				}\r\n            }\r\n			$data[\'newsblog_categories\'][] = array(\r\n				\'name\'     => $category[\'name\'],\r\n				\'children\' => $articles,\r\n				\'href\'     => $this->url->link(\'newsblog/category\', \'newsblog_path=\' . $category[\'category_id\'])\r\n			);\r\n		}\r\n		]]></add>\r\n	</operation>\r\n  </file>\r\n  <file path=\"catalog/view/theme/*/template/information/sitemap.tpl\">\r\n    <operation>\r\n      <search><![CDATA[<li><?php echo $text_information; ?>]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      	<?php foreach ($newsblog_categories as $category) { ?>\r\n            <li><a href=\"<?php echo $category[\'href\']; ?>\"><?php echo $category[\'name\']; ?></a>\r\n              <?php if ($category[\'children\']) { ?>\r\n              <ul>\r\n                <?php foreach ($category[\'children\'] as $article) { ?>\r\n                <li><a href=\"<?php echo $article[\'href\']; ?>\"><?php echo $article[\'name\']; ?></a></li>\r\n                <?php } ?>\r\n              </ul>\r\n              <?php } ?>\r\n            </li>\r\n            <?php } ?>\r\n		]]></add>\r\n	</operation>\r\n  </file>\r\n  <file path=\"catalog/controller/common/header.php\">\r\n    <operation>\r\n      <search><![CDATA[$data[\'language\'] = $this->load->controller(\'common/language\');]]></search>\r\n      <add position=\"before\"><![CDATA[\r\n      	$this->load->model(\'newsblog/category\');\r\n        $this->load->model(\'newsblog/article\');\r\n\r\n		$data[\'newsblog_categories\'] = array();\r\n\r\n		$categories = $this->model_newsblog_category->getCategories(0);\r\n\r\n		foreach ($categories as $category) {\r\n			if ($category[\'settings\']) {\r\n				$settings=unserialize($category[\'settings\']);\r\n				if ($settings[\'show_in_top\']==0) continue;\r\n			}\r\n\r\n			$articles = array();\r\n\r\n			if ($category[\'settings\'] && $settings[\'show_in_top_articles\']) {\r\n				$filter=array(\'filter_category_id\'=>$category[\'category_id\'],\'filter_sub_category\'=>true);\r\n				$results = $this->model_newsblog_article->getArticles($filter);\r\n\r\n				foreach ($results as $result) {\r\n					$articles[] = array(\r\n						\'name\'        => $result[\'name\'],\r\n						\'href\'        => $this->url->link(\'newsblog/article\', \'newsblog_path=\' . $category[\'category_id\'] . \'&newsblog_article_id=\' . $result[\'article_id\'])\r\n					);\r\n				}\r\n            }\r\n			$data[\'categories\'][] = array(\r\n				\'name\'     => $category[\'name\'],\r\n				\'children\' => $articles,\r\n				\'column\'   => 1,\r\n				\'href\'     => $this->url->link(\'newsblog/category\', \'newsblog_path=\' . $category[\'category_id\'])\r\n			);\r\n		}\r\n		]]></add>\r\n	</operation>\r\n  </file>\r\n</modification>',1,'2018-04-03 01:09:31');
/*!40000 ALTER TABLE `oc_modification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_module`
--

DROP TABLE IF EXISTS `oc_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_module` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `code` varchar(32) NOT NULL,
  `setting` text NOT NULL,
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_module`
--

LOCK TABLES `oc_module` WRITE;
/*!40000 ALTER TABLE `oc_module` DISABLE KEYS */;
INSERT INTO `oc_module` VALUES (30,'Баннер на странице категорий','banner','{\"name\":\"Баннер на странице категорий\",\"banner_id\":\"6\",\"width\":\"182\",\"height\":\"182\",\"status\":\"1\"}'),(29,'Карусель на главной странице','carousel','{\"name\":\"Карусель на главной странице\",\"banner_id\":\"8\",\"width\":\"130\",\"height\":\"100\",\"status\":\"1\"}'),(28,'Рекомендуемые на главной странице','featured','{\"name\":\"Рекомендуемые на главной странице\",\"product\":[\"43\",\"40\",\"42\",\"30\"],\"limit\":\"4\",\"width\":\"200\",\"height\":\"200\",\"status\":\"1\"}'),(27,'Слайдшоу на главной странице','slideshow','{\"name\":\"\\u0421\\u043b\\u0430\\u0439\\u0434\\u0448\\u043e\\u0443 \\u043d\\u0430 \\u0433\\u043b\\u0430\\u0432\\u043d\\u043e\\u0439 \\u0441\\u0442\\u0440\\u0430\\u043d\\u0438\\u0446\\u0435\",\"banner_id\":\"7\",\"width\":\"781\",\"height\":\"385\",\"status\":\"1\"}'),(31,'Баннер Продукция HP','banner','{\"name\":\"Баннер Продукция HP\",\"banner_id\":\"6\",\"width\":\"182\",\"height\":\"182\",\"status\":\"1\"}'),(32,'О нас на главной','html','{\"name\":\"\\u041e \\u043d\\u0430\\u0441 \\u043d\\u0430 \\u0433\\u043b\\u0430\\u0432\\u043d\\u043e\\u0439\",\"module_description\":{\"1\":{\"title\":\"\\u0414\\u043e\\u0431\\u0440\\u043e \\u043f\\u043e\\u0436\\u0430\\u043b\\u043e\\u0432\\u0430\\u0442\\u044c \\u043d\\u0430 \\u0441\\u0430\\u0439\\u0442 \\u043a\\u043e\\u043c\\u043f\\u0430\\u043d\\u0438\\u0438 \\u0410\\u043d\\u0442-\\u0421\\u043d\\u0430\\u0431!\",\"description\":\"&lt;p&gt;\\u041c\\u044b \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u043c \\u0438 \\u043f\\u0440\\u043e\\u0434\\u0430\\u0435\\u043c \\u0441\\u0442\\u0440\\u043e\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u044b\\u0435 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u044b. \\u0420\\u0430\\u0431\\u043e\\u0442\\u0430\\u0435\\u043c \\u0441 \\u0442\\u043e\\u0440\\u0433\\u043e\\u0432\\u044b\\u043c\\u0438 \\u043a\\u043e\\u043c\\u043f\\u0430\\u043d\\u0438\\u044f\\u043c\\u0438, \\u0441\\u0442\\u0440\\u043e\\u0438\\u0442\\u0435\\u043b\\u044f\\u043c\\u0438 \\u0438 \\u0447\\u0430\\u0441\\u0442\\u043d\\u044b\\u043c\\u0438 \\u043b\\u0438\\u0446\\u0430\\u043c\\u0438.&lt;\\/p&gt;&lt;p&gt;\\u0427\\u0442\\u043e\\u0431\\u044b \\u0441\\u044d\\u043a\\u043e\\u043d\\u043e\\u043c\\u0438\\u0442\\u044c \\u0412\\u0430\\u0448\\u0435 \\u0432\\u0440\\u0435\\u043c\\u044f, \\u043d\\u0430 \\u044d\\u0442\\u043e\\u0439 \\u0441\\u0442\\u0440\\u0430\\u043d\\u0438\\u0446\\u0435 \\u043c\\u044b \\u0440\\u0430\\u0437\\u043c\\u0435\\u0449\\u0430\\u0435\\u043c \\u0442\\u043e\\u043b\\u044c\\u043a\\u043e \\u0441\\u0430\\u043c\\u043e\\u0435 \\u0432\\u0430\\u0436\\u043d\\u043e\\u0435 \\u2013 \\u043d\\u0430\\u0448\\u0443 \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0446\\u0438\\u044e. \\u0420\\u0430\\u0437\\u0432\\u0435\\u0440\\u043d\\u0443\\u0442\\u043e \\u043e \\u043d\\u0430\\u0441 \\u043c\\u043e\\u0436\\u043d\\u043e \\u043f\\u0440\\u043e\\u0447\\u0435\\u0441\\u0442\\u044c \\u0432 \\u0440\\u0430\\u0437\\u0434\\u0435\\u043b\\u0435 &lt;a href=&quot;\\/index.php?route=information\\/information&amp;amp;information_id=4&quot;&gt;&quot;\\u041e \\u043a\\u043e\\u043c\\u043f\\u0430\\u043d\\u0438\\u0438&quot;&lt;\\/a&gt;&lt;\\/p&gt;\"}},\"status\":\"1\"}'),(33,'На Главной внизу','html','{\"name\":\"\\u041d\\u0430 \\u0413\\u043b\\u0430\\u0432\\u043d\\u043e\\u0439 \\u0432\\u043d\\u0438\\u0437\\u0443\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;p&gt;\\u0412 \\u0440\\u0430\\u0437\\u0434\\u0435\\u043b\\u0435 &lt;a href=&quot;index.php?route=newsblog\\/category&amp;amp;newsblog_path=1&quot;&gt;\\u043d\\u043e\\u0432\\u043e\\u0441\\u0442\\u0438&lt;\\/a&gt; \\u0432\\u0441\\u0435\\u0433\\u0434\\u0430 \\u043c\\u043e\\u0436\\u043d\\u043e \\u0443\\u0437\\u043d\\u0430\\u0442\\u044c \\u043e\\u0431 \\u0438\\u0437\\u043c\\u0435\\u043d\\u0435\\u043d\\u0438\\u044f\\u0445 \\u0432 \\u0430\\u0441\\u0441\\u043e\\u0440\\u0442\\u0438\\u043c\\u0435\\u043d\\u0442\\u0435, \\u0430\\u043a\\u0442\\u0443\\u0430\\u043b\\u044c\\u043d\\u044b\\u0445 \\u0446\\u0435\\u043d\\u0430\\u0445 \\u0438 \\u0437\\u043d\\u0430\\u0447\\u0438\\u043c\\u044b\\u0445 \\u0441\\u043e\\u0431\\u044b\\u0442\\u0438\\u044f\\u0445 \\u0432 \\u0436\\u0438\\u0437\\u043d\\u0438 \\u043a\\u043e\\u043c\\u043f\\u0430\\u043d\\u0438\\u0438. \\u0420\\u0430\\u0437\\u0434\\u0435\\u043b &lt;a href=&quot;index.php?route=newsblog\\/category&amp;amp;newsblog_path=2&quot;&gt;\\u0441\\u0442\\u0430\\u0442\\u044c\\u0438&lt;\\/a&gt; \\u043f\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u043d\\u043e \\u043f\\u043e\\u043f\\u043e\\u043b\\u043d\\u044f\\u0435\\u0442\\u0441\\u044f \\u0438\\u043d\\u0442\\u0435\\u0440\\u0435\\u0441\\u043d\\u044b\\u043c\\u0438 \\u0438 \\u043d\\u0443\\u0436\\u043d\\u044b\\u043c\\u0438 \\u043f\\u0443\\u0431\\u043b\\u0438\\u043a\\u0430\\u0446\\u0438\\u044f\\u043c\\u0438. \\u0410 \\u0435\\u0441\\u043b\\u0438 \\u0432\\u043e\\u043f\\u0440\\u043e\\u0441\\u044b \\u0432\\u0441\\u0435 \\u0436\\u0435 \\u043e\\u0441\\u0442\\u0430\\u043d\\u0443\\u0442\\u0441\\u044f, \\u0442\\u043e \\u0438\\u0445 \\u0432\\u0441\\u0435\\u0433\\u0434\\u0430 \\u043c\\u043e\\u0436\\u043d\\u043e \\u0437\\u0430\\u0434\\u0430\\u0442\\u044c \\u043d\\u0430\\u0448\\u0438\\u043c &lt;a href=&quot;index.php?route=information\\/contact&quot;&gt;\\u043c\\u0435\\u043d\\u0435\\u0434\\u0436\\u0435\\u0440\\u0430\\u043c.&lt;\\/a&gt;&lt;\\/p&gt;&lt;p&gt;\\u041e \\u043a\\u0430\\u0447\\u0435\\u0441\\u0442\\u0432\\u0435 \\u043d\\u0430\\u0448\\u0435\\u0439 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b \\u043b\\u0443\\u0447\\u0448\\u0435 \\u0432\\u0441\\u0435\\u0433\\u043e \\u0441\\u043a\\u0430\\u0436\\u0443\\u0442 \\u043f\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u043d\\u044b\\u0435 \\u043a\\u043b\\u0438\\u0435\\u043d\\u0442\\u044b. \\u0423\\u0432\\u0435\\u0440\\u0435\\u043d\\u044b, \\u0447\\u0442\\u043e \\u0438 \\u0432\\u044b \\u043e\\u0441\\u0442\\u0430\\u043d\\u0435\\u0442\\u0435\\u0441\\u044c \\u0434\\u043e\\u0432\\u043e\\u043b\\u044c\\u043d\\u044b \\u0441\\u043e\\u0442\\u0440\\u0443\\u0434\\u043d\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e\\u043c \\u0441 \\u041e\\u041e\\u041e &quot;\\u0422\\u041a \\u0410\\u043d\\u0442-\\u0421\\u043d\\u0430\\u0431&quot;.&lt;\\/p&gt;\"}},\"status\":\"1\"}'),(35,'Отзывы внизу','html','{\"name\":\"\\u041e\\u0442\\u0437\\u044b\\u0432\\u044b \\u0432\\u043d\\u0438\\u0437\\u0443\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;p&gt;\\u041c\\u044b \\u043e\\u043a\\u0430\\u0437\\u044b\\u0432\\u0430\\u0435\\u043c \\u0443\\u0441\\u043b\\u0443\\u0433\\u0438 \\u043f\\u043e &lt;a href=&quot;\\/index.php?route=information\\/information&amp;amp;information_id=6&quot;&gt;\\u0431\\u0435\\u0440\\u0435\\u0436\\u043d\\u043e\\u0439 \\u0434\\u043e\\u0441\\u0442\\u0430\\u0432\\u043a\\u0435&lt;\\/a&gt; \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u043e\\u0432 \\u043d\\u0430 \\u043e\\u0431\\u044a\\u0435\\u043a\\u0442\\u044b. \\u0414\\u043b\\u044f \\u043f\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u043d\\u044b\\u0445 \\u043a\\u043b\\u0438\\u0435\\u043d\\u0442\\u043e\\u0432 \\u0434\\u0435\\u0439\\u0441\\u0442\\u0432\\u0443\\u0435\\u0442 \\u0441\\u0438\\u0441\\u0442\\u0435\\u043c\\u0430 \\u0441\\u043a\\u0438\\u0434\\u043e\\u043a.&lt;\\/p&gt;&lt;p&gt;\\u041e \\u043a\\u0430\\u0447\\u0435\\u0441\\u0442\\u0432\\u0435 \\u043d\\u0430\\u0448\\u0435\\u0439 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b \\u0433\\u043e\\u0432\\u043e\\u0440\\u044f\\u0442 \\u043e\\u0442\\u0437\\u044b\\u0432\\u044b \\u043d\\u0430\\u0448\\u0438\\u0445 \\u043f\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u043d\\u044b\\u0445 \\u043f\\u0430\\u0440\\u0442\\u043d\\u0435\\u0440\\u043e\\u0432. \\u0423\\u0432\\u0435\\u0440\\u0435\\u043d\\u044b, \\u0447\\u0442\\u043e \\u0438 \\u0412\\u044b \\u043e\\u0441\\u0442\\u0430\\u043d\\u0435\\u0442\\u0435\\u0441\\u044c \\u0434\\u043e\\u0432\\u043e\\u043b\\u044c\\u043d\\u044b \\u0441\\u043e\\u0442\\u0440\\u0443\\u0434\\u043d\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e\\u043c \\u0441 \\u041e\\u041e\\u041e &quot;\\u0410\\u043d\\u0442-\\u0421\\u043d\\u0430\\u0431&quot;.&lt;\\/p&gt;&lt;div&gt;&lt;br&gt;&lt;\\/div&gt;\"}},\"status\":\"1\"}'),(36,'Новости сайдбар','newsblog_articles','{\"name\":\"\\u041d\\u043e\\u0432\\u043e\\u0441\\u0442\\u0438 \\u0441\\u0430\\u0439\\u0434\\u0431\\u0430\\u0440\",\"module_description\":{\"1\":{\"title\":\"\\u0421\\u0432\\u0435\\u0436\\u0438\\u0435 \\u043d\\u043e\\u0432\\u043e\\u0441\\u0442\\u0438\",\"description\":\"\"}},\"show_categories\":[\"1\"],\"width\":\"80\",\"height\":\"80\",\"limit\":\"3\",\"desc_limit\":\"350\",\"template\":\"newsblog_news.tpl\",\"date_format\":\"d.m.Y\",\"sort_by\":\"a.date_available\",\"sort_direction\":\"desc\",\"status\":\"1\"}'),(37,'Статьи сайдбар','newsblog_articles','{\"name\":\"\\u0421\\u0442\\u0430\\u0442\\u044c\\u0438 \\u0441\\u0430\\u0439\\u0434\\u0431\\u0430\\u0440\",\"module_description\":{\"1\":{\"title\":\"\\u0421\\u0442\\u0430\\u0442\\u044c\\u0438 \\u043e \\u0442\\u043e\\u0432\\u0430\\u0440\\u0430\\u0445\",\"description\":\"\"}},\"show_categories\":[\"2\"],\"width\":\"80\",\"height\":\"80\",\"limit\":\"3\",\"desc_limit\":\"350\",\"template\":\"\",\"date_format\":\"d.m.Y\",\"sort_by\":\"a.date_available\",\"sort_direction\":\"desc\",\"status\":\"1\"}'),(38,'Отзывы наверху','html','{\"name\":\"\\u041e\\u0442\\u0437\\u044b\\u0432\\u044b \\u043d\\u0430\\u0432\\u0435\\u0440\\u0445\\u0443\",\"module_description\":{\"1\":{\"title\":\"\\u041e\\u0442\\u0437\\u044b\\u0432\\u044b \\u043e \\u0440\\u0430\\u0431\\u043e\\u0442\\u0435 \\u043a\\u043e\\u043c\\u043f\\u0430\\u043d\\u0438\\u0438 \\u0410\\u043d\\u0442-\\u0421\\u043d\\u0430\\u0431\",\"description\":\"&lt;p&gt;\\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e &amp;nbsp;\\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e \\u0441\\u044a\\u0435\\u0448\\u044c \\u0436\\u0435 \\u0435\\u0449\\u0451 \\u044d\\u0442\\u0438\\u0445 \\u043c\\u044f\\u0433\\u043a\\u0438\\u0445 \\u0444\\u0440\\u0430\\u043d\\u0446\\u0443\\u0437\\u0441\\u043a\\u0438\\u0445 \\u0431\\u0443\\u043b\\u043e\\u043a, \\u0434\\u0430 \\u0432\\u044b\\u043f\\u0435\\u0439 \\u0447\\u0430\\u044e&amp;nbsp;&lt;\\/p&gt;&lt;div&gt;&lt;br&gt;&lt;\\/div&gt;\"}},\"status\":\"1\"}');
/*!40000 ALTER TABLE `oc_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article`
--

DROP TABLE IF EXISTS `oc_newsblog_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT NULL,
  `date_available` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `viewed` int(5) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article`
--

LOCK TABLES `oc_newsblog_article` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article` DISABLE KEYS */;
INSERT INTO `oc_newsblog_article` VALUES (1,'catalog/antsnab/articles/3212_prev.jpg','2018-04-03 07:41:36',500,1,0,'2018-04-03 07:41:36','2018-04-03 07:50:40'),(2,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:10',500,1,10,'2018-04-03 07:48:10','2018-04-03 07:50:12'),(3,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:30',500,1,0,'2018-04-03 07:48:30','0000-00-00 00:00:00'),(4,'catalog/antsnab/articles/3212_prev.jpg','2018-04-03 07:48:30',500,1,0,'2018-04-03 07:48:30','2018-04-03 07:51:26'),(5,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:37',500,1,1,'2018-04-03 07:48:37','2018-04-12 02:32:17'),(6,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:37',500,1,0,'2018-04-03 07:48:37','2018-04-12 02:32:22'),(7,'catalog/antsnab/articles/3212_prev.jpg','2018-04-03 07:48:37',500,1,2,'2018-04-03 07:48:37','2018-04-03 07:50:57'),(8,'catalog/antsnab/articles/3212_prev.jpg','2018-04-03 07:48:37',500,1,0,'2018-04-03 07:48:37','0000-00-00 00:00:00'),(9,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:57',500,1,2,'2018-04-03 07:48:57','2018-04-12 01:44:47'),(10,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:57',500,1,36,'2018-04-03 07:48:57','2018-04-12 10:05:19'),(11,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:57',500,1,18,'2018-04-03 07:48:57','2018-04-12 01:44:56'),(12,'catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg','2018-04-03 07:48:57',500,1,0,'2018-04-03 07:48:57','2018-04-12 01:45:04'),(13,'catalog/antsnab/articles/3212_prev.jpg','2018-04-03 07:48:57',500,1,4,'2018-04-03 07:48:57','2018-04-12 01:45:41'),(14,'catalog/antsnab/articles/3212_prev.jpg','2018-04-03 07:48:57',500,1,6,'2018-04-03 07:48:57','2018-04-12 01:25:52'),(15,'catalog/antsnab/articles/3213.jpg','2017-04-03 07:58:59',500,1,6,'2017-04-03 07:58:59','2018-04-11 01:15:15'),(16,'catalog/antsnab/articles/3208.jpg','2017-04-03 08:01:50',500,1,2,'2017-04-03 08:01:50','0000-00-00 00:00:00'),(17,'catalog/antsnab/articles/3213.jpg','2017-04-03 08:01:55',500,1,0,'2017-04-03 08:01:55','0000-00-00 00:00:00'),(18,'catalog/antsnab/articles/3208.jpg','2017-04-03 08:09:07',500,1,1,'2017-04-03 08:09:07','0000-00-00 00:00:00'),(19,'catalog/antsnab/articles/3208.jpg','2017-04-03 08:09:21',500,1,0,'2017-04-03 08:09:21','0000-00-00 00:00:00'),(20,'catalog/antsnab/articles/3213.jpg','2017-04-03 08:09:48',500,1,6,'2017-04-03 08:09:48','0000-00-00 00:00:00'),(21,'catalog/antsnab/articles/3208.jpg','2016-04-03 08:09:58',500,1,2,'2016-04-03 08:09:58','2018-04-06 08:58:32'),(22,'catalog/antsnab/articles/1156_prev(1).jpg','2016-04-08 21:03:24',500,1,23,'2016-04-08 21:03:24','2018-04-09 18:35:24'),(23,'catalog/antsnab/articles/3213.jpg','2017-04-03 08:09:48',500,1,1,'2018-04-11 01:14:52','2018-04-11 01:17:13');
/*!40000 ALTER TABLE `oc_newsblog_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article_attribute`
--

DROP TABLE IF EXISTS `oc_newsblog_article_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article_attribute` (
  `article_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`article_id`,`attribute_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article_attribute`
--

LOCK TABLES `oc_newsblog_article_attribute` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_newsblog_article_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article_description`
--

DROP TABLE IF EXISTS `oc_newsblog_article_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article_description` (
  `article_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `preview` text NOT NULL,
  `description` text NOT NULL,
  `tag` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_h1` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`article_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article_description`
--

LOCK TABLES `oc_newsblog_article_description` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article_description` DISABLE KEYS */;
INSERT INTO `oc_newsblog_article_description` VALUES (1,1,'1Фикс Алл Классик и Фикс Алл Флекси, в чем разница','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;/span&gt;&lt;nobr style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Оказывается, бытует мнение, будто бы&amp;nbsp;Флекси более эластичный и&amp;nbsp;вообще «он лучше». Поясняем.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как известно, продукция компании Soudal продается во&amp;nbsp;всем мире, равно как и очень популярный&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик&lt;/nobr&gt;&amp;nbsp;Fix&amp;nbsp;All.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Если посетить&amp;nbsp;европейский сайт производителя, то&amp;nbsp;можно увидеть стандартную линейку Фикс Алл: Flexi, Crystal, High&amp;nbsp;Tack, Turbo,&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;X-treme&lt;/nobr&gt;&amp;nbsp;Power. К&amp;nbsp;слову, два последних в&amp;nbsp;России не&amp;nbsp;продаются.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/allfixalleurope.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;видите, в&amp;nbsp;Европе Классиком и&amp;nbsp;не&amp;nbsp;пахнет. Он&amp;nbsp;производился исключительно для рынков России, Украины и&amp;nbsp;Казахстана. По&amp;nbsp;каким причинам он&amp;nbsp;назывался иначе, неясно. Сейчас, в&amp;nbsp;угоду унификации, производитель приводит линейку продукции к единому виду. Именно так и&amp;nbsp;появился у&amp;nbsp;нас Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте обратимся к&amp;nbsp;техническим характеристикам, может&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;все-таки&lt;/nobr&gt;&amp;nbsp;там есть отличия…&lt;/p&gt;&lt;table class=&quot;table table-bordered&quot;&gt;&lt;tbody&gt;&lt;tr&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;Показатель&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Flexi&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Classic&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Цвет&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Основа&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Механизм отверждения&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Образование поверхностной пленки&lt;br style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;&lt;em style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;при 20&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С и&amp;nbsp;относительной влажности 65%&lt;/em&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/tbody&gt;&lt;/table&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Хм, не&amp;nbsp;видно отличий.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ну&amp;nbsp;и&amp;nbsp;чтобы окончательно развеять все сомнения, мы&amp;nbsp;запросили у&amp;nbsp;российского представительства компании Соудал официальный комментарий.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/soudal_letter.jpg&quot; style=&quot;width: 557px;&quot;&gt;&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Итак, разницы между Fix&amp;nbsp;All&amp;nbsp;Flexi и&amp;nbsp;Fix&amp;nbsp;All&amp;nbsp;Classic&amp;nbsp;— нет, мы&amp;nbsp;с вами просто&amp;nbsp;в очередной раз стали жертвами в&amp;nbsp;войне маркетологов.&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но&amp;nbsp;не&amp;nbsp;стоит забивать этим голову, ведь Фикс Алл это в&amp;nbsp;первую очередь очень качественный и&amp;nbsp;приятный в&amp;nbsp;использовании&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик.&lt;/nobr&gt;&amp;nbsp;В&amp;nbsp;нашей компании всегда можно приобрести все товары из&amp;nbsp;линейки, пока даже Классик остался. Звоните!&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;span style=&quot;text-align: right;&quot;&gt;Ваш, Ант-Снаб&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','','Клей-герметики Фикс Алл Флекси и Классик, в чем разница?','Фикс Алл Классик и Фикс Алл Флекси, в чем разница','Разбираемся есть ли отличия между клей-герметиками Фикс Алл Классик и Фикс Алл Флекси. Посмотрим как выглядит линейка Fix All в Европе, сравним технические характеристики, получим официальный комментарий от российского представительства\r\n','Статья, публикация, герметик, герметизирующие материалы, таблица, соудал, soudal, характеристики, сравнение, Фикс Алл, Флекси, Классик, Fix all, flexi, classic, разница, в чем отличие, что лучшеАнт-Снаб, ТК, ООО, компания'),(2,1,'2Огнестойкая монтажная пена: что это такое и зачем она нужна','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(3,1,'3Огнестойкая монтажная пена: что это такое и зачем она нужна','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(4,1,'4Фикс Алл Классик и Фикс Алл Флекси, в чем разница','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;/span&gt;&lt;nobr style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Оказывается, бытует мнение, будто бы&amp;nbsp;Флекси более эластичный и&amp;nbsp;вообще «он лучше». Поясняем.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как известно, продукция компании Soudal продается во&amp;nbsp;всем мире, равно как и очень популярный&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик&lt;/nobr&gt;&amp;nbsp;Fix&amp;nbsp;All.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Если посетить&amp;nbsp;европейский сайт производителя, то&amp;nbsp;можно увидеть стандартную линейку Фикс Алл: Flexi, Crystal, High&amp;nbsp;Tack, Turbo,&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;X-treme&lt;/nobr&gt;&amp;nbsp;Power. К&amp;nbsp;слову, два последних в&amp;nbsp;России не&amp;nbsp;продаются.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/allfixalleurope.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;видите, в&amp;nbsp;Европе Классиком и&amp;nbsp;не&amp;nbsp;пахнет. Он&amp;nbsp;производился исключительно для рынков России, Украины и&amp;nbsp;Казахстана. По&amp;nbsp;каким причинам он&amp;nbsp;назывался иначе, неясно. Сейчас, в&amp;nbsp;угоду унификации, производитель приводит линейку продукции к единому виду. Именно так и&amp;nbsp;появился у&amp;nbsp;нас Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте обратимся к&amp;nbsp;техническим характеристикам, может&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;все-таки&lt;/nobr&gt;&amp;nbsp;там есть отличия…&lt;/p&gt;&lt;table class=&quot;table table-bordered&quot;&gt;&lt;tbody&gt;&lt;tr&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;Показатель&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Flexi&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Classic&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Цвет&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Основа&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Механизм отверждения&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Образование поверхностной пленки&lt;br style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;&lt;em style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;при 20&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С и&amp;nbsp;относительной влажности 65%&lt;/em&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/tbody&gt;&lt;/table&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Хм, не&amp;nbsp;видно отличий.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ну&amp;nbsp;и&amp;nbsp;чтобы окончательно развеять все сомнения, мы&amp;nbsp;запросили у&amp;nbsp;российского представительства компании Соудал официальный комментарий.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/soudal_letter.jpg&quot; style=&quot;width: 557px;&quot;&gt;&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Итак, разницы между Fix&amp;nbsp;All&amp;nbsp;Flexi и&amp;nbsp;Fix&amp;nbsp;All&amp;nbsp;Classic&amp;nbsp;— нет, мы&amp;nbsp;с вами просто&amp;nbsp;в очередной раз стали жертвами в&amp;nbsp;войне маркетологов.&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но&amp;nbsp;не&amp;nbsp;стоит забивать этим голову, ведь Фикс Алл это в&amp;nbsp;первую очередь очень качественный и&amp;nbsp;приятный в&amp;nbsp;использовании&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик.&lt;/nobr&gt;&amp;nbsp;В&amp;nbsp;нашей компании всегда можно приобрести все товары из&amp;nbsp;линейки, пока даже Классик остался. Звоните!&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;span style=&quot;text-align: right;&quot;&gt;Ваш, Ант-Снаб&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','','Клей-герметики Фикс Алл Флекси и Классик, в чем разница?','Фикс Алл Классик и Фикс Алл Флекси, в чем разница','Разбираемся есть ли отличия между клей-герметиками Фикс Алл Классик и Фикс Алл Флекси. Посмотрим как выглядит линейка Fix All в Европе, сравним технические характеристики, получим официальный комментарий от российского представительства\r\n','Статья, публикация, герметик, герметизирующие материалы, таблица, соудал, soudal, характеристики, сравнение, Фикс Алл, Флекси, Классик, Fix all, flexi, classic, разница, в чем отличие, что лучшеАнт-Снаб, ТК, ООО, компания'),(5,1,'5Огнестойкая монтажная пена: что это такое и зачем она нужна','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(6,1,'6Огнестойкая монтажная пена: что это такое и зачем она нужна','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(7,1,'7Фикс Алл Классик и Фикс Алл Флекси, в чем разница','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;/span&gt;&lt;nobr style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Оказывается, бытует мнение, будто бы&amp;nbsp;Флекси более эластичный и&amp;nbsp;вообще «он лучше». Поясняем.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как известно, продукция компании Soudal продается во&amp;nbsp;всем мире, равно как и очень популярный&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик&lt;/nobr&gt;&amp;nbsp;Fix&amp;nbsp;All.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Если посетить&amp;nbsp;европейский сайт производителя, то&amp;nbsp;можно увидеть стандартную линейку Фикс Алл: Flexi, Crystal, High&amp;nbsp;Tack, Turbo,&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;X-treme&lt;/nobr&gt;&amp;nbsp;Power. К&amp;nbsp;слову, два последних в&amp;nbsp;России не&amp;nbsp;продаются.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/allfixalleurope.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;видите, в&amp;nbsp;Европе Классиком и&amp;nbsp;не&amp;nbsp;пахнет. Он&amp;nbsp;производился исключительно для рынков России, Украины и&amp;nbsp;Казахстана. По&amp;nbsp;каким причинам он&amp;nbsp;назывался иначе, неясно. Сейчас, в&amp;nbsp;угоду унификации, производитель приводит линейку продукции к единому виду. Именно так и&amp;nbsp;появился у&amp;nbsp;нас Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте обратимся к&amp;nbsp;техническим характеристикам, может&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;все-таки&lt;/nobr&gt;&amp;nbsp;там есть отличия…&lt;/p&gt;&lt;table class=&quot;table table-bordered&quot;&gt;&lt;tbody&gt;&lt;tr&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;Показатель&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Flexi&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Classic&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Цвет&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Основа&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Механизм отверждения&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Образование поверхностной пленки&lt;br style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;&lt;em style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;при 20&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С и&amp;nbsp;относительной влажности 65%&lt;/em&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/tbody&gt;&lt;/table&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Хм, не&amp;nbsp;видно отличий.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ну&amp;nbsp;и&amp;nbsp;чтобы окончательно развеять все сомнения, мы&amp;nbsp;запросили у&amp;nbsp;российского представительства компании Соудал официальный комментарий.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/soudal_letter.jpg&quot; style=&quot;width: 557px;&quot;&gt;&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Итак, разницы между Fix&amp;nbsp;All&amp;nbsp;Flexi и&amp;nbsp;Fix&amp;nbsp;All&amp;nbsp;Classic&amp;nbsp;— нет, мы&amp;nbsp;с вами просто&amp;nbsp;в очередной раз стали жертвами в&amp;nbsp;войне маркетологов.&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но&amp;nbsp;не&amp;nbsp;стоит забивать этим голову, ведь Фикс Алл это в&amp;nbsp;первую очередь очень качественный и&amp;nbsp;приятный в&amp;nbsp;использовании&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик.&lt;/nobr&gt;&amp;nbsp;В&amp;nbsp;нашей компании всегда можно приобрести все товары из&amp;nbsp;линейки, пока даже Классик остался. Звоните!&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;span style=&quot;text-align: right;&quot;&gt;Ваш, Ант-Снаб&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','','Клей-герметики Фикс Алл Флекси и Классик, в чем разница?','Фикс Алл Классик и Фикс Алл Флекси, в чем разница','Разбираемся есть ли отличия между клей-герметиками Фикс Алл Классик и Фикс Алл Флекси. Посмотрим как выглядит линейка Fix All в Европе, сравним технические характеристики, получим официальный комментарий от российского представительства\r\n','Статья, публикация, герметик, герметизирующие материалы, таблица, соудал, soudal, характеристики, сравнение, Фикс Алл, Флекси, Классик, Fix all, flexi, classic, разница, в чем отличие, что лучшеАнт-Снаб, ТК, ООО, компания'),(8,1,'8Фикс Алл Классик и Фикс Алл Флекси, в чем разница','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;/span&gt;&lt;nobr style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Оказывается, бытует мнение, будто бы&amp;nbsp;Флекси более эластичный и&amp;nbsp;вообще «он лучше». Поясняем.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как известно, продукция компании Soudal продается во&amp;nbsp;всем мире, равно как и очень популярный&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик&lt;/nobr&gt;&amp;nbsp;Fix&amp;nbsp;All.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Если посетить&amp;nbsp;европейский сайт производителя, то&amp;nbsp;можно увидеть стандартную линейку Фикс Алл: Flexi, Crystal, High&amp;nbsp;Tack, Turbo,&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;X-treme&lt;/nobr&gt;&amp;nbsp;Power. К&amp;nbsp;слову, два последних в&amp;nbsp;России не&amp;nbsp;продаются.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/allfixalleurope.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;видите, в&amp;nbsp;Европе Классиком и&amp;nbsp;не&amp;nbsp;пахнет. Он&amp;nbsp;производился исключительно для рынков России, Украины и&amp;nbsp;Казахстана. По&amp;nbsp;каким причинам он&amp;nbsp;назывался иначе, неясно. Сейчас, в&amp;nbsp;угоду унификации, производитель приводит линейку продукции к единому виду. Именно так и&amp;nbsp;появился у&amp;nbsp;нас Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте обратимся к&amp;nbsp;техническим характеристикам, может&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;все-таки&lt;/nobr&gt;&amp;nbsp;там есть отличия…&lt;/p&gt;&lt;table class=&quot;table table-bordered&quot;&gt;&lt;tbody&gt;&lt;tr&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;Показатель&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Flexi&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Classic&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Цвет&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Основа&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Механизм отверждения&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Образование поверхностной пленки&lt;br style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;&lt;em style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;при 20&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С и&amp;nbsp;относительной влажности 65%&lt;/em&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/tbody&gt;&lt;/table&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Хм, не&amp;nbsp;видно отличий.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ну&amp;nbsp;и&amp;nbsp;чтобы окончательно развеять все сомнения, мы&amp;nbsp;запросили у&amp;nbsp;российского представительства компании Соудал официальный комментарий.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/soudal_letter.jpg&quot; style=&quot;width: 557px;&quot;&gt;&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Итак, разницы между Fix&amp;nbsp;All&amp;nbsp;Flexi и&amp;nbsp;Fix&amp;nbsp;All&amp;nbsp;Classic&amp;nbsp;— нет, мы&amp;nbsp;с вами просто&amp;nbsp;в очередной раз стали жертвами в&amp;nbsp;войне маркетологов.&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но&amp;nbsp;не&amp;nbsp;стоит забивать этим голову, ведь Фикс Алл это в&amp;nbsp;первую очередь очень качественный и&amp;nbsp;приятный в&amp;nbsp;использовании&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик.&lt;/nobr&gt;&amp;nbsp;В&amp;nbsp;нашей компании всегда можно приобрести все товары из&amp;nbsp;линейки, пока даже Классик остался. Звоните!&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;span style=&quot;text-align: right;&quot;&gt;Ваш, Ант-Снаб&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','','Клей-герметики Фикс Алл Флекси и Классик, в чем разница?','Фикс Алл Классик и Фикс Алл Флекси, в чем разница','Разбираемся есть ли отличия между клей-герметиками Фикс Алл Классик и Фикс Алл Флекси. Посмотрим как выглядит линейка Fix All в Европе, сравним технические характеристики, получим официальный комментарий от российского представительства\r\n','Статья, публикация, герметик, герметизирующие материалы, таблица, соудал, soudal, характеристики, сравнение, Фикс Алл, Флекси, Классик, Fix all, flexi, classic, разница, в чем отличие, что лучшеАнт-Снаб, ТК, ООО, компания'),(9,1,'9Огнестойкая монтажная пена: что это такое и зачем она нужна','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(10,1,'Здесь есть упоминаемые','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(11,1,'11Огнестойкая монтажная пена: что это такое и зачем она нужна','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(12,1,'12Огнестойкая монтажная пена: что это такое и зачем она нужна','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Монтажная пена уже давно стала незаменимым материалом в&amp;nbsp;строительстве. Помимо неоспоримых плюсов, таких как прекрасная звуко- и&amp;nbsp;теплоизолирующая способность, есть и&amp;nbsp;серьезные минусы&amp;nbsp;— легковоспламеняемость и&amp;nbsp;горючесть.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;ходе строительных работ и&amp;nbsp;внутренней отделки многих объектов предъявляются повышенные требования к&amp;nbsp;пожарной безопасности. Когда по&amp;nbsp;СНиП даже дверные короба и&amp;nbsp;оконные проемы в&amp;nbsp;зданиях необходимо заполнять пеной с&amp;nbsp;повышенным классом огнестойкости.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Кроме того, такая же&amp;nbsp;пена должна применяться при монтаже отопительных систем и&amp;nbsp;соединений, которые могут подвергаться нагреву. С&amp;nbsp;обязательным использованием огнестойкой пены устраиваются кабельные проходки.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Самыми важными свойствами противопожарной пены можно назвать ее&amp;nbsp;возможность изолировать помещения от&amp;nbsp;попадания угарного газа и&amp;nbsp;противостоять быстрому распространению пламени. Помимо этого, благодаря низкой теплопроводности, пена защищает элементы конструкций от&amp;nbsp;воздействия высоких температур.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте немного углубимся в&amp;nbsp;особенности материала:&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;не&amp;nbsp;зависимо от&amp;nbsp;наименований, которые присваивают своим продуктам те&amp;nbsp;или иные производители (огнестойкая, огнеупорная, противопожарная, пожаростойкая и т.д.) в&amp;nbsp;их&amp;nbsp;составе используются антипирены&amp;nbsp;— специальные компоненты, препятствующие горению;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;противопожарные пены намерено окрашиваются в&amp;nbsp;оранжевый, розовый или красный цвет. Это избавляет от&amp;nbsp;путаницы в&amp;nbsp;ходе проведения работ, и&amp;nbsp;стойкую к огню пену всегда легко отличить от&amp;nbsp;обычной пены;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;—&amp;nbsp;огнестойкая пена сравнительно плотнее и&amp;nbsp;тяжелее обычной монтажной пены, выход можно назвать скромным&amp;nbsp;— 35−45&amp;nbsp;литров из&amp;nbsp;одного баллона.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам стало интересно проверить, а&amp;nbsp;действительно ли&amp;nbsp;огнестойкая пена не&amp;nbsp;горит? В&amp;nbsp;качестве образца была выбрана пена&amp;nbsp;&lt;a href=&quot;https://ant-snab.ru/products/sealants/montajnye-peny/ognestoikie/soudafoam-1k-fr/&quot; target=&quot;_blank&quot; style=&quot;padding: 0px; margin: 0px; text-decoration-line: underline; list-style-type: none; display: inline-block; outline: 0px !important;&quot;&gt;Soudafoam 1K&amp;nbsp;FR&lt;/a&gt;&amp;nbsp;в&amp;nbsp;баллоне под ручное выпенивание.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_1.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель пены&amp;nbsp;— компания с&amp;nbsp;мировым именем, Soudal. Пена розового цвета, заявленный выход из&amp;nbsp;одного баллона&amp;nbsp;— до&amp;nbsp;45&amp;nbsp;литров. Данная пена выпускается и&amp;nbsp;с адаптером под пистолет.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/ognestoikaya-pena-article_2.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-align: left; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Производитель заявляет до&amp;nbsp;240&amp;nbsp;минут замедления распространения огня, что соответствует классу EI&amp;nbsp;240. И&amp;nbsp;это очень хороший показатель! Мы&amp;nbsp;ждать 4&amp;nbsp;часа конечно не&amp;nbsp;будем, но&amp;nbsp;усложним задачу и&amp;nbsp;попробуем пожечь наши образцы газовой&amp;nbsp;горелкой (температура свыше 500&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С).&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ваш Ант-Снаб&lt;/p&gt;','','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','Огнестойкая монтажная пена: что это такое, зачем нужна и реально ли работает','&quot;Речь в статье идет об огнестойкой монтажной пене. Разберемся зачем она нужна и где применяется. Проведем эксперимент и выясним реально ли материал является противопожарным и не горит. Бонусом сожжем обычную пену.','Статья, публикация, монтажная пена, огнестойкая, противопожарная, огнеупорная, эксперимент, тест, сравнение, Soudal, Соудал, Судал, Soudafoam, 1k, fr, Соудафоам, Судафоам, ручная, с трубочкой, Ант-Снаб, ТК, ООО, компания\r\n'),(13,1,'13Фикс Алл Классик и Фикс Алл Флекси, в чем разница','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;/span&gt;&lt;nobr style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Оказывается, бытует мнение, будто бы&amp;nbsp;Флекси более эластичный и&amp;nbsp;вообще «он лучше». Поясняем.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как известно, продукция компании Soudal продается во&amp;nbsp;всем мире, равно как и очень популярный&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик&lt;/nobr&gt;&amp;nbsp;Fix&amp;nbsp;All.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Если посетить&amp;nbsp;европейский сайт производителя, то&amp;nbsp;можно увидеть стандартную линейку Фикс Алл: Flexi, Crystal, High&amp;nbsp;Tack, Turbo,&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;X-treme&lt;/nobr&gt;&amp;nbsp;Power. К&amp;nbsp;слову, два последних в&amp;nbsp;России не&amp;nbsp;продаются.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/allfixalleurope.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;видите, в&amp;nbsp;Европе Классиком и&amp;nbsp;не&amp;nbsp;пахнет. Он&amp;nbsp;производился исключительно для рынков России, Украины и&amp;nbsp;Казахстана. По&amp;nbsp;каким причинам он&amp;nbsp;назывался иначе, неясно. Сейчас, в&amp;nbsp;угоду унификации, производитель приводит линейку продукции к единому виду. Именно так и&amp;nbsp;появился у&amp;nbsp;нас Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте обратимся к&amp;nbsp;техническим характеристикам, может&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;все-таки&lt;/nobr&gt;&amp;nbsp;там есть отличия…&lt;/p&gt;&lt;table class=&quot;table table-bordered&quot;&gt;&lt;tbody&gt;&lt;tr&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;Показатель&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Flexi&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Classic&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Цвет&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Основа&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Механизм отверждения&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Образование поверхностной пленки&lt;br style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;&lt;em style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;при 20&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С и&amp;nbsp;относительной влажности 65%&lt;/em&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/tbody&gt;&lt;/table&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Хм, не&amp;nbsp;видно отличий.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ну&amp;nbsp;и&amp;nbsp;чтобы окончательно развеять все сомнения, мы&amp;nbsp;запросили у&amp;nbsp;российского представительства компании Соудал официальный комментарий.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/soudal_letter.jpg&quot; style=&quot;width: 557px;&quot;&gt;&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Итак, разницы между Fix&amp;nbsp;All&amp;nbsp;Flexi и&amp;nbsp;Fix&amp;nbsp;All&amp;nbsp;Classic&amp;nbsp;— нет, мы&amp;nbsp;с вами просто&amp;nbsp;в очередной раз стали жертвами в&amp;nbsp;войне маркетологов.&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но&amp;nbsp;не&amp;nbsp;стоит забивать этим голову, ведь Фикс Алл это в&amp;nbsp;первую очередь очень качественный и&amp;nbsp;приятный в&amp;nbsp;использовании&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик.&lt;/nobr&gt;&amp;nbsp;В&amp;nbsp;нашей компании всегда можно приобрести все товары из&amp;nbsp;линейки, пока даже Классик остался. Звоните!&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;span style=&quot;text-align: right;&quot;&gt;Ваш, Ант-Снаб&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','','Клей-герметики Фикс Алл Флекси и Классик, в чем разница?','Фикс Алл Классик и Фикс Алл Флекси, в чем разница','Разбираемся есть ли отличия между клей-герметиками Фикс Алл Классик и Фикс Алл Флекси. Посмотрим как выглядит линейка Fix All в Европе, сравним технические характеристики, получим официальный комментарий от российского представительства\r\n','Статья, публикация, герметик, герметизирующие материалы, таблица, соудал, soudal, характеристики, сравнение, Фикс Алл, Флекси, Классик, Fix all, flexi, classic, разница, в чем отличие, что лучшеАнт-Снаб, ТК, ООО, компания'),(14,1,'14Фикс Алл Классик и Фикс Алл Флекси, в чем разница','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;/span&gt;&lt;nobr style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;В&amp;nbsp;последнее время участились вопросы от&amp;nbsp;наших клиентов об&amp;nbsp;отличиях&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметиков&lt;/nobr&gt;&amp;nbsp;Фикс Алл Классик и&amp;nbsp;Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Оказывается, бытует мнение, будто бы&amp;nbsp;Флекси более эластичный и&amp;nbsp;вообще «он лучше». Поясняем.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как известно, продукция компании Soudal продается во&amp;nbsp;всем мире, равно как и очень популярный&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик&lt;/nobr&gt;&amp;nbsp;Fix&amp;nbsp;All.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Если посетить&amp;nbsp;европейский сайт производителя, то&amp;nbsp;можно увидеть стандартную линейку Фикс Алл: Flexi, Crystal, High&amp;nbsp;Tack, Turbo,&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;X-treme&lt;/nobr&gt;&amp;nbsp;Power. К&amp;nbsp;слову, два последних в&amp;nbsp;России не&amp;nbsp;продаются.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/allfixalleurope.jpg&quot; style=&quot;width: 700px;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;видите, в&amp;nbsp;Европе Классиком и&amp;nbsp;не&amp;nbsp;пахнет. Он&amp;nbsp;производился исключительно для рынков России, Украины и&amp;nbsp;Казахстана. По&amp;nbsp;каким причинам он&amp;nbsp;назывался иначе, неясно. Сейчас, в&amp;nbsp;угоду унификации, производитель приводит линейку продукции к единому виду. Именно так и&amp;nbsp;появился у&amp;nbsp;нас Фикс Алл Флекси.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Давайте обратимся к&amp;nbsp;техническим характеристикам, может&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;все-таки&lt;/nobr&gt;&amp;nbsp;там есть отличия…&lt;/p&gt;&lt;table class=&quot;table table-bordered&quot;&gt;&lt;tbody&gt;&lt;tr&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;Показатель&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Flexi&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;&lt;strong style=&quot;font-family: OpenSans; font-size: 13px; text-align: -webkit-center; outline: 0px !important;&quot;&gt;Fix&amp;nbsp;All&amp;nbsp;Classic&lt;/strong&gt;&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Цвет&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;td&gt;белый&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Основа&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;td&gt;SMX&amp;nbsp;гибридный полимер&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Механизм отверждения&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;td&gt;влажностная полимеризация&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Образование поверхностной пленки&lt;br style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;&lt;em style=&quot;font-family: OpenSans; font-size: 13px; outline: 0px !important;&quot;&gt;при 20&lt;sup style=&quot;outline: 0px !important;&quot;&gt;о&lt;/sup&gt;С и&amp;nbsp;относительной влажности 65%&lt;/em&gt;&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;td&gt;около 10&amp;nbsp;минут&lt;br&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/tbody&gt;&lt;/table&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Хм, не&amp;nbsp;видно отличий.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Ну&amp;nbsp;и&amp;nbsp;чтобы окончательно развеять все сомнения, мы&amp;nbsp;запросили у&amp;nbsp;российского представительства компании Соудал официальный комментарий.&lt;/p&gt;&lt;p style=&quot;text-align: center; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;img src=&quot;http://ant-snab/image/catalog/antsnab/articles/soudal_letter.jpg&quot; style=&quot;width: 557px;&quot;&gt;&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Итак, разницы между Fix&amp;nbsp;All&amp;nbsp;Flexi и&amp;nbsp;Fix&amp;nbsp;All&amp;nbsp;Classic&amp;nbsp;— нет, мы&amp;nbsp;с вами просто&amp;nbsp;в очередной раз стали жертвами в&amp;nbsp;войне маркетологов.&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но&amp;nbsp;не&amp;nbsp;стоит забивать этим голову, ведь Фикс Алл это в&amp;nbsp;первую очередь очень качественный и&amp;nbsp;приятный в&amp;nbsp;использовании&amp;nbsp;&lt;nobr style=&quot;outline: 0px !important;&quot;&gt;клей-герметик.&lt;/nobr&gt;&amp;nbsp;В&amp;nbsp;нашей компании всегда можно приобрести все товары из&amp;nbsp;линейки, пока даже Классик остался. Звоните!&lt;/p&gt;&lt;p align=&quot;left&quot; style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;&lt;span style=&quot;text-align: right;&quot;&gt;Ваш, Ант-Снаб&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','','Клей-герметики Фикс Алл Флекси и Классик, в чем разница?','Фикс Алл Классик и Фикс Алл Флекси, в чем разница','Разбираемся есть ли отличия между клей-герметиками Фикс Алл Классик и Фикс Алл Флекси. Посмотрим как выглядит линейка Fix All в Европе, сравним технические характеристики, получим официальный комментарий от российского представительства\r\n','Статья, публикация, герметик, герметизирующие материалы, таблица, соудал, soudal, характеристики, сравнение, Фикс Алл, Флекси, Классик, Fix all, flexi, classic, разница, в чем отличие, что лучшеАнт-Снаб, ТК, ООО, компания'),(15,1,'15Небольшой тест мастики Пруф от Гоши Пескова','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам очень важно получать обратную связь от&amp;nbsp;конечных потребителей наших мастик и&amp;nbsp;праймеров, строителей.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но, продавая мастику одному из&amp;nbsp;наших клиентов, мы&amp;nbsp;даже представить не&amp;nbsp;могли, что помимо гидроизоляционных свойств, она имеет еще и… целебные…&lt;/p&gt;','','','','',''),(16,1,'16Повышение цен на пергамин с 19.03.2018','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Уважаемые клиенты!&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Сообщаем Вам, что в&amp;nbsp;связи с&amp;nbsp;увеличением стоимости сырья, мы&amp;nbsp;вынуждены поднять отпускные цены на&amp;nbsp;пергамин.&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Уважаемые клиенты!&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;&lt;br&gt;&lt;/span&gt;&lt;/font&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Сообщаем Вам, что в связи с увеличением стоимости сырья, мы вынуждены поднять отпускные цены на пергамин.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Наша главная цель – сохранение привычного качества отпускаемой продукции.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;С 19 марта 2018 года вырастут оптовые и розничные цены на Пергамин&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;марки П-250, марки П-300 и марки П-350.Подорожание составит от 1% до 5%.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Все оплаченные заказы будут отгружены по ценам, действовавшим на момент поступления оплаты.&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Официальное письмо можно скачать по этой &lt;a href=&quot;https://ant-snab.ru/docs/66PC.pdf&quot;&gt;ссылке&lt;/a&gt;.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Ваш Ант-Снаб&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;','','','','',''),(17,1,'17Небольшой тест мастики Пруф от Гоши Пескова','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам очень важно получать обратную связь от&amp;nbsp;конечных потребителей наших мастик и&amp;nbsp;праймеров, строителей.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но, продавая мастику одному из&amp;nbsp;наших клиентов, мы&amp;nbsp;даже представить не&amp;nbsp;могли, что помимо гидроизоляционных свойств, она имеет еще и… целебные…&lt;/p&gt;','','','','',''),(18,1,'18Повышение цен на пергамин с 19.03.2018','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Уважаемые клиенты!&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Сообщаем Вам, что в&amp;nbsp;связи с&amp;nbsp;увеличением стоимости сырья, мы&amp;nbsp;вынуждены поднять отпускные цены на&amp;nbsp;пергамин.&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Уважаемые клиенты!&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;&lt;br&gt;&lt;/span&gt;&lt;/font&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Сообщаем Вам, что в связи с увеличением стоимости сырья, мы вынуждены поднять отпускные цены на пергамин.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Наша главная цель – сохранение привычного качества отпускаемой продукции.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;С 19 марта 2018 года вырастут оптовые и розничные цены на Пергамин&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;марки П-250, марки П-300 и марки П-350.Подорожание составит от 1% до 5%.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Все оплаченные заказы будут отгружены по ценам, действовавшим на момент поступления оплаты.&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Официальное письмо можно скачать по этой &lt;a href=&quot;https://ant-snab.ru/docs/66PC.pdf&quot;&gt;ссылке&lt;/a&gt;.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Ваш Ант-Снаб&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;','','','','',''),(22,1,'22Что такое пергамин','&lt;p&gt;Сегодня мы поговорим о таком материале, как пергамин. Мы постараемся максимально полно и подробно описать что же это за материал, как его можно использовать, и как с выгодой для себя купить пергамин именно той марки, который Вам нужен.&lt;/p&gt;','&lt;p style=&quot;text-align: left;&quot;&gt;Сегодня мы поговорим о таком материале, как пергамин. Мы постараемся максимально полно и подробно описать что же это за материал, как его можно использовать, и как с выгодой для себя купить пергамин именно той марки, который Вам нужен.&lt;/p&gt;&lt;p&gt;Пергамин – это кровельный картон, пропитанный нефтяным битумом, сменивший на поприще изоляционных материалов толь.&lt;/p&gt;&lt;p&gt;От последнего отказались потому что деготь, применяемый при его производстве, обладает высокой степенью канцерогенности.&lt;/p&gt;&lt;h2&gt;Разница между пергамином по ГОСТ и по ТУ&lt;/h2&gt;&lt;p&gt;Самый частый вопрос о пергамине – «В чем разница между ГОСТ и ТУ»? Мы уже вскользь затрагивали эту тему в статье о сертификатах, но решили напомнить еще раз. Основное различие – в плотности картона, используемого при производстве пергамина.&lt;/p&gt;&lt;p&gt;Для наглядности мы приготовили таблицу.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;table class=&quot;table-bordered table-striped&quot; cellspacing=&quot;0&quot; cellpadding=&quot;0&quot; border=&quot;1&quot;&gt;\r\n&lt;tbody&gt;\r\n&lt;tr&gt;\r\n&lt;td class=&quot;title&quot; width=&quot;168&quot; colspan=&quot;2&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;Марка пергамина&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td class=&quot;title&quot; width=&quot;170&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;Плотность картона&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td class=&quot;title&quot; width=&quot;179&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;Размер рулона&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td class=&quot;title&quot; width=&quot;122&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&lt;strong&gt;Вес рулона&lt;/strong&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td rowspan=&quot;3&quot; width=&quot;73&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;ГОСТ&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;94&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;П-350&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;170&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;350&amp;nbsp;гр/м&lt;sup&gt;2&lt;/sup&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;179&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;20х1 м&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;122&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;15&amp;nbsp;кг&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;94&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;П-300&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;170&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;300&amp;nbsp;гр/м&lt;sup&gt;2&lt;/sup&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;179&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;20х1 м&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;122&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;12&amp;nbsp;кг&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;94&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;П-250&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;170&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;Не&amp;nbsp;производится&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;179&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&amp;nbsp;-&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;122&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;&amp;nbsp;-&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td rowspan=&quot;3&quot; width=&quot;73&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;ТУ&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;94&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;П-350&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;170&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;180−200 гр/м&lt;sup&gt;2&lt;/sup&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;179&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;15х1 м&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;122&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;3&amp;nbsp;кг&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;94&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;П-300&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;170&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;150−170 гр/м&lt;sup&gt;2&lt;/sup&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;179&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;15х1 м&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;122&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;4,5 кг&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;tr&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;94&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;П-250&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;170&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;125&amp;nbsp;гр/м&lt;sup&gt;2&lt;/sup&gt;&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;179&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;15х1 м&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;td valign=&quot;top&quot; width=&quot;122&quot;&gt;\r\n&lt;p align=&quot;center&quot;&gt;6&amp;nbsp;кг&lt;/p&gt;\r\n&lt;/td&gt;\r\n&lt;/tr&gt;\r\n&lt;/tbody&gt;\r\n&lt;/table&gt;&lt;p&gt;&lt;i&gt;В таблице указаны данные по присутствующему в нашем ассортименте пергамину производства Рязанского КРЗ, и по нашему родному антснабовскому пергамину.&lt;/i&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;Отдельно хочется отметить, что&lt;b&gt; пергамин П-250 по ГОСТ не производится!&lt;/b&gt; А пергамин П-300 по ГОСТ рязанский завод не делает уже несколько лет.&lt;/p&gt;&lt;p&gt;Итак, разобравшись с тем, какой бывает пергамин, и чем ГОСТ отличается от ТУ, идем дальше. Посмотрим для чего же нужен этот традиционный материал в наш век высоких технологий.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Области применения пергамина&lt;br&gt;&lt;/h2&gt;&lt;ul&gt;&lt;li&gt;подкладка для нижних слоев кровельного ковра;&lt;/li&gt;&lt;li&gt;строительство зимних бань;&lt;/li&gt;&lt;li&gt;защита утеплителя внутри помещения, а иногда и с наружной стороны от влаги и конденсата (росы), для продления срока службы теплоизоляционного материала;&lt;/li&gt;&lt;li&gt;изоляция от испарений и конденсата между древесностружечными материала и железобетонными основаниями;&lt;/li&gt;&lt;li&gt;упаковочный материал для изделий из металлов;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;Основная область применения и задача пергамин – все-таки пароизоляция и защита от конденсата. Для тех, кто не сталкивался с подобными терминами ранее, обращаемся к Википедии:&lt;/p&gt;&lt;p&gt;Пароизоляция – это совокупность различных методово защиты теплоизолирующих материалов и строительных конструкций от проникновения пара и, как следствие, от выпадения и впитывания конденсата (росы). В отличие от гидроизоляции пароизоляции препятствует проникновению пара, а не жидкости.&lt;/p&gt;&lt;p&gt;Получается, что, например, при строительстве той же самой бани или дачного дома, пергамин жизненно необходим – он продлевает срок службы утеплителя, обеспечивает температурно-влажностный режим в помещении.&lt;/p&gt;&lt;p&gt;Важно помнить, что пергамин не является кровельным материалом, как ошибочно полагают многие (если не все). Он всего лишь вспомогательный материал при кровельных работах.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Какой пергамин купить&lt;/h2&gt;&lt;p&gt;Необходимость пароизоляции уже ясна, теперь нужно определиться какой именно пергамин купить Вам.&lt;/p&gt;&lt;p&gt;Тут все зависит от поставленных задач и целей. Безусловно, ГОСТ плотнее, толще и кажется более основательным. Однако по нашему опыту, при правильном устройстве пароизоляции срок службы и плотность отличаются не настолько сильно, насколько разнится цена.&lt;/p&gt;&lt;p&gt;Большинству своих клиентов мы рекомендуем брать именно произведенный по ТУ пергамин, ведь соотношение цена/качество важнее каждого из этих элементов по отдельности.&lt;/p&gt;&lt;p&gt;Безусловным плюсом пергамина от Ант--Снаб является его цена. Самый дешевый легкий пергамин можно купить у нас по цене менее 100 рублей за рулон. И это розничная цена! Для оптовиков и региональных партнеров мы предоставляет дополнительные скидки.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Как не быть обманутым при покупке пергамина&lt;/h2&gt;&lt;p&gt;Если Вы все же решите покупать пергамин в другом месте, запомните ключевые моменты, в которых могут обмануть при продаже:&lt;/p&gt;&lt;ul&gt;&lt;li&gt;пергамина П-250 ГОСТ не существует в природе;&lt;/li&gt;&lt;li&gt;пергамин П-350 ТУ не может стоить 50 рублей за рулон, ГОСТ – тем более;&lt;/li&gt;&lt;li&gt;вариантов намотки рулонов – масса, всегда проверяйте не продали ли Вам 13 метров по цене 20−ти;&lt;/li&gt;&lt;li&gt;сертификатов на пергамин ТУ нет ни у кого – это бессмысленно;&lt;/li&gt;&lt;li&gt;вес рулонов пергамина всегда указывается справочно, но погрешность невелика. Если Вы купили рулон «пергамина П-350 ГОСТ (20 метров)», он никак не может весить 5 кг.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;Чтобы избежать всех этих неприятных моментов, сомнений и проверок – смело звоните к нам в офис и смело заказывайте наши честные 15−метровые рулоны.&lt;/p&gt;&lt;p style=&quot;text-align: right; &quot;&gt;Ваш, Ант-Снаб&lt;/p&gt;','','','','',''),(19,1,'19Повышение цен на пергамин с 19.03.2018','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Уважаемые клиенты!&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Сообщаем Вам, что в&amp;nbsp;связи с&amp;nbsp;увеличением стоимости сырья, мы&amp;nbsp;вынуждены поднять отпускные цены на&amp;nbsp;пергамин.&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Уважаемые клиенты!&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;&lt;br&gt;&lt;/span&gt;&lt;/font&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Сообщаем Вам, что в связи с увеличением стоимости сырья, мы вынуждены поднять отпускные цены на пергамин.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Наша главная цель – сохранение привычного качества отпускаемой продукции.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;С 19 марта 2018 года вырастут оптовые и розничные цены на Пергамин&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;марки П-250, марки П-300 и марки П-350.Подорожание составит от 1% до 5%.&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size: 14px; color: rgb(68, 68, 68); font-family: OpenSans;&quot;&gt;Все оплаченные заказы будут отгружены по ценам, действовавшим на момент поступления оплаты.&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Официальное письмо можно скачать по этой &lt;a href=&quot;https://ant-snab.ru/docs/66PC.pdf&quot;&gt;ссылке&lt;/a&gt;.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;text-align: right; padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Ваш Ант-Снаб&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;','','','','',''),(20,1,'20Небольшой тест мастики Пруф от Гоши Пескова','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам очень важно получать обратную связь от&amp;nbsp;конечных потребителей наших мастик и&amp;nbsp;праймеров, строителей.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но, продавая мастику одному из&amp;nbsp;наших клиентов, мы&amp;nbsp;даже представить не&amp;nbsp;могли, что помимо гидроизоляционных свойств, она имеет еще и… целебные…&lt;/p&gt;','','','','',''),(21,1,'21Повышение цен на пергамин с 19.03.2018','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Уважаемые клиенты!&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Сообщаем Вам, что в связи с увеличением стоимости сырья, мы вынуждены поднять отпускные цены на пергамин&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Уважаемые клиенты!&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Сообщаем Вам, что в связи с увеличением стоимости сырья, мы вынуждены поднять отпускные цены на пергамин.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Наша главная цель – сохранение привычного качества отпускаемой продукции.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;С 19 марта 2018 года вырастут оптовые и розничные цены на Пергамин&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;марки П-250, марки П-300 и марки П-350.Подорожание составит от 1% до 5%.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Все оплаченные заказы будут отгружены по ценам, действовавшим на момент поступления оплаты.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Официальное письмо можно скачать по этой ссылке.&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; outline: 0px !important;&quot;&gt;&lt;font color=&quot;#444444&quot; face=&quot;OpenSans&quot;&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;Ваш Ант-Снаб&lt;/span&gt;&lt;/font&gt;&lt;/p&gt;&lt;div&gt;&lt;br&gt;&lt;/div&gt;&lt;div&gt;&lt;br&gt;&lt;/div&gt;','','','','',''),(23,1,'23!!!Небольшой тест мастики Пруф от Гоши Пескова','&lt;p&gt;&lt;span style=&quot;color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;','&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Как вы&amp;nbsp;знаете, в&amp;nbsp;этом году мы&amp;nbsp;запустили в&amp;nbsp;производство новую линейку продукции Пруф.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Нам очень важно получать обратную связь от&amp;nbsp;конечных потребителей наших мастик и&amp;nbsp;праймеров, строителей.&lt;/p&gt;&lt;p style=&quot;padding: 0px 0px 10px; margin-bottom: 0px; list-style-type: none; color: rgb(68, 68, 68); font-family: OpenSans; font-size: 14px; outline: 0px !important;&quot;&gt;Но, продавая мастику одному из&amp;nbsp;наших клиентов, мы&amp;nbsp;даже представить не&amp;nbsp;могли, что помимо гидроизоляционных свойств, она имеет еще и… целебные…&lt;/p&gt;','','','','','');
/*!40000 ALTER TABLE `oc_newsblog_article_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article_image`
--

DROP TABLE IF EXISTS `oc_newsblog_article_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article_image` (
  `product_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_image_id`),
  KEY `article_id` (`article_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article_image`
--

LOCK TABLES `oc_newsblog_article_image` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_newsblog_article_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article_related`
--

DROP TABLE IF EXISTS `oc_newsblog_article_related`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article_related` (
  `article_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL,
  `type` int(1) NOT NULL,
  PRIMARY KEY (`article_id`,`related_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article_related`
--

LOCK TABLES `oc_newsblog_article_related` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article_related` DISABLE KEYS */;
INSERT INTO `oc_newsblog_article_related` VALUES (10,42,2),(42,10,2),(10,30,2),(30,10,2),(10,47,2),(47,10,2),(10,28,2),(28,10,2);
/*!40000 ALTER TABLE `oc_newsblog_article_related` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article_to_category`
--

DROP TABLE IF EXISTS `oc_newsblog_article_to_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article_to_category` (
  `article_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `main_category` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_id`,`category_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article_to_category`
--

LOCK TABLES `oc_newsblog_article_to_category` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article_to_category` DISABLE KEYS */;
INSERT INTO `oc_newsblog_article_to_category` VALUES (1,2,1),(2,2,1),(3,2,1),(4,2,1),(5,2,0),(6,2,0),(7,2,1),(8,2,1),(9,4,1),(10,4,1),(11,3,1),(12,3,1),(13,4,1),(14,2,0),(15,1,1),(16,1,1),(17,1,1),(18,1,1),(19,1,1),(20,1,1),(21,1,1),(22,2,1),(23,1,1),(9,2,0),(13,2,0),(11,2,0),(12,2,0),(14,4,1),(10,2,0),(5,4,1),(6,4,1);
/*!40000 ALTER TABLE `oc_newsblog_article_to_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article_to_layout`
--

DROP TABLE IF EXISTS `oc_newsblog_article_to_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article_to_layout` (
  `article_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`article_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article_to_layout`
--

LOCK TABLES `oc_newsblog_article_to_layout` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article_to_layout` DISABLE KEYS */;
INSERT INTO `oc_newsblog_article_to_layout` VALUES (1,0,0),(2,0,0),(3,0,0),(4,0,0),(5,0,0),(6,0,0),(7,0,0),(8,0,0),(9,0,0),(10,0,0),(11,0,0),(12,0,0),(13,0,0),(14,0,0),(15,0,0),(16,0,0),(17,0,0),(18,0,0),(19,0,0),(20,0,0),(21,0,0),(22,0,0),(23,0,0);
/*!40000 ALTER TABLE `oc_newsblog_article_to_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_article_to_store`
--

DROP TABLE IF EXISTS `oc_newsblog_article_to_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_article_to_store` (
  `article_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_article_to_store`
--

LOCK TABLES `oc_newsblog_article_to_store` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_article_to_store` DISABLE KEYS */;
INSERT INTO `oc_newsblog_article_to_store` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0);
/*!40000 ALTER TABLE `oc_newsblog_article_to_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_category`
--

DROP TABLE IF EXISTS `oc_newsblog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `settings` text NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_category`
--

LOCK TABLES `oc_newsblog_category` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_category` DISABLE KEYS */;
INSERT INTO `oc_newsblog_category` VALUES (1,'',0,0,1,'2018-04-03 07:23:46','2018-04-22 10:37:45','a:27:{s:11:\"date_format\";s:5:\"d.m.Y\";s:16:\"image_size_width\";s:3:\"207\";s:17:\"image_size_height\";s:3:\"167\";s:30:\"images_size_articles_big_width\";s:3:\"330\";s:31:\"images_size_articles_big_height\";s:3:\"220\";s:32:\"images_size_articles_small_width\";s:3:\"330\";s:33:\"images_size_articles_small_height\";s:3:\"220\";s:17:\"images_size_width\";s:3:\"207\";s:18:\"images_size_height\";s:3:\"167\";s:5:\"limit\";s:1:\"2\";s:15:\"show_in_sitemap\";i:1;s:24:\"show_in_sitemap_articles\";i:1;s:11:\"show_in_top\";i:0;s:20:\"show_in_top_articles\";i:0;s:12:\"show_preview\";i:0;s:7:\"sort_by\";s:16:\"a.date_available\";s:14:\"sort_direction\";s:4:\"desc\";s:16:\"template_article\";s:14:\"onearticle.tpl\";s:17:\"template_category\";s:11:\"allnews.tpl\";s:19:\"show_comments_vk_id\";s:0:\"\";s:25:\"show_comments_vk_category\";i:0;s:24:\"show_comments_vk_article\";i:0;s:25:\"show_comments_fb_category\";i:0;s:24:\"show_comments_fb_article\";i:0;s:19:\"show_comments_dq_id\";s:0:\"\";s:25:\"show_comments_dq_category\";i:0;s:24:\"show_comments_dq_article\";i:0;}'),(2,'',0,1,1,'2018-04-03 07:31:30','2018-04-09 18:40:45','a:27:{s:11:\"date_format\";s:5:\"d.m.Y\";s:16:\"image_size_width\";s:3:\"207\";s:17:\"image_size_height\";s:3:\"167\";s:30:\"images_size_articles_big_width\";s:3:\"330\";s:31:\"images_size_articles_big_height\";s:3:\"220\";s:32:\"images_size_articles_small_width\";s:3:\"330\";s:33:\"images_size_articles_small_height\";s:3:\"220\";s:17:\"images_size_width\";s:3:\"207\";s:18:\"images_size_height\";s:3:\"167\";s:5:\"limit\";s:1:\"9\";s:15:\"show_in_sitemap\";i:1;s:24:\"show_in_sitemap_articles\";i:1;s:11:\"show_in_top\";i:0;s:20:\"show_in_top_articles\";i:0;s:12:\"show_preview\";i:0;s:7:\"sort_by\";s:16:\"a.date_available\";s:14:\"sort_direction\";s:4:\"desc\";s:16:\"template_article\";s:14:\"onearticle.tpl\";s:17:\"template_category\";s:15:\"allarticles.tpl\";s:19:\"show_comments_vk_id\";s:0:\"\";s:25:\"show_comments_vk_category\";i:0;s:24:\"show_comments_vk_article\";i:0;s:25:\"show_comments_fb_category\";i:0;s:24:\"show_comments_fb_article\";i:0;s:19:\"show_comments_dq_id\";s:0:\"\";s:25:\"show_comments_dq_category\";i:0;s:24:\"show_comments_dq_article\";i:0;}'),(3,'',2,1,1,'2018-04-12 00:04:17','2018-04-12 00:04:17','a:19:{s:11:\"date_format\";s:5:\"d.m.Y\";s:16:\"image_size_width\";s:3:\"207\";s:17:\"image_size_height\";s:3:\"167\";s:30:\"images_size_articles_big_width\";s:3:\"330\";s:31:\"images_size_articles_big_height\";s:3:\"220\";s:32:\"images_size_articles_small_width\";s:3:\"330\";s:33:\"images_size_articles_small_height\";s:3:\"220\";s:17:\"images_size_width\";s:3:\"207\";s:18:\"images_size_height\";s:3:\"167\";s:5:\"limit\";s:2:\"10\";s:15:\"show_in_sitemap\";i:1;s:24:\"show_in_sitemap_articles\";i:1;s:11:\"show_in_top\";i:0;s:20:\"show_in_top_articles\";i:0;s:12:\"show_preview\";i:0;s:7:\"sort_by\";s:16:\"a.date_available\";s:14:\"sort_direction\";s:4:\"desc\";s:16:\"template_article\";s:14:\"onearticle.tpl\";s:17:\"template_category\";s:15:\"allarticles.tpl\";}'),(4,'',2,2,1,'2018-04-12 00:06:43','2018-04-12 02:31:46','a:27:{s:11:\"date_format\";s:5:\"d.m.Y\";s:16:\"image_size_width\";s:3:\"207\";s:17:\"image_size_height\";s:3:\"167\";s:30:\"images_size_articles_big_width\";s:3:\"330\";s:31:\"images_size_articles_big_height\";s:3:\"220\";s:32:\"images_size_articles_small_width\";s:3:\"330\";s:33:\"images_size_articles_small_height\";s:3:\"220\";s:17:\"images_size_width\";s:3:\"207\";s:18:\"images_size_height\";s:3:\"167\";s:5:\"limit\";s:1:\"3\";s:15:\"show_in_sitemap\";i:1;s:24:\"show_in_sitemap_articles\";i:1;s:11:\"show_in_top\";i:0;s:20:\"show_in_top_articles\";i:0;s:12:\"show_preview\";i:0;s:7:\"sort_by\";s:16:\"a.date_available\";s:14:\"sort_direction\";s:4:\"desc\";s:16:\"template_article\";s:14:\"onearticle.tpl\";s:17:\"template_category\";s:15:\"allarticles.tpl\";s:19:\"show_comments_vk_id\";s:0:\"\";s:25:\"show_comments_vk_category\";i:0;s:24:\"show_comments_vk_article\";i:0;s:25:\"show_comments_fb_category\";i:0;s:24:\"show_comments_fb_article\";i:0;s:19:\"show_comments_dq_id\";s:0:\"\";s:25:\"show_comments_dq_category\";i:0;s:24:\"show_comments_dq_article\";i:0;}');
/*!40000 ALTER TABLE `oc_newsblog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_category_description`
--

DROP TABLE IF EXISTS `oc_newsblog_category_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_category_description` (
  `category_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_h1` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_category_description`
--

LOCK TABLES `oc_newsblog_category_description` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_category_description` DISABLE KEYS */;
INSERT INTO `oc_newsblog_category_description` VALUES (1,1,'Новости','','Новости о строительных и отделочных материалах, изменения цен, жизнь компании Ант-Снаб','Новости','Все новости о строительных и отделочных материалах, изменениях цен, расширении ассортимента и жизни компании Ант-Снаб с 2012 года','Новости, обновление, изменение, цены, ассортимент, расширение, жизни, строительные, отделочные, материалы, все, хронологический порядок, блог, поздравления, Ант-Снаб, ТК, ООО, компания'),(2,1,'Статьи','','Полезные и познавательные статьи о строительных и отделочных материалах','Статьи','Публикации о строительных и отделочных материалах: как выбрать, применение, нормы загрузки, типичные ошибки, нормативы, ГОСТы и интересные факты.','Статьи, публикации, о строительных, отделочных, материалах, стройматериалы, как выбрать, применять, использовать, ошибки, дефекты, полезное, интересное, нормативы, госты, Ант-Снаб, ТК, ООО, компания'),(3,1,'Общие статьи','','','','',''),(4,1,'Герметики','','','','','');
/*!40000 ALTER TABLE `oc_newsblog_category_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_category_path`
--

DROP TABLE IF EXISTS `oc_newsblog_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_category_path` (
  `category_id` int(11) NOT NULL,
  `path_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`path_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_category_path`
--

LOCK TABLES `oc_newsblog_category_path` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_category_path` DISABLE KEYS */;
INSERT INTO `oc_newsblog_category_path` VALUES (1,1,0),(2,2,0),(3,2,0),(3,3,1),(4,2,0),(4,4,1);
/*!40000 ALTER TABLE `oc_newsblog_category_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_category_to_layout`
--

DROP TABLE IF EXISTS `oc_newsblog_category_to_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_category_to_layout` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_category_to_layout`
--

LOCK TABLES `oc_newsblog_category_to_layout` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_category_to_layout` DISABLE KEYS */;
INSERT INTO `oc_newsblog_category_to_layout` VALUES (1,0,17),(2,0,15),(3,0,15),(4,0,15);
/*!40000 ALTER TABLE `oc_newsblog_category_to_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_newsblog_category_to_store`
--

DROP TABLE IF EXISTS `oc_newsblog_category_to_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_newsblog_category_to_store` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_newsblog_category_to_store`
--

LOCK TABLES `oc_newsblog_category_to_store` WRITE;
/*!40000 ALTER TABLE `oc_newsblog_category_to_store` DISABLE KEYS */;
INSERT INTO `oc_newsblog_category_to_store` VALUES (1,0),(2,0),(3,0),(4,0);
/*!40000 ALTER TABLE `oc_newsblog_category_to_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_option`
--

DROP TABLE IF EXISTS `oc_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_option` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_option`
--

LOCK TABLES `oc_option` WRITE;
/*!40000 ALTER TABLE `oc_option` DISABLE KEYS */;
INSERT INTO `oc_option` VALUES (1,'radio',1),(2,'checkbox',2),(4,'text',3),(5,'select',4),(6,'textarea',5),(7,'file',6),(8,'date',7),(9,'time',8),(10,'datetime',9),(11,'select',10),(12,'date',11);
/*!40000 ALTER TABLE `oc_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_option_description`
--

DROP TABLE IF EXISTS `oc_option_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_option_description` (
  `option_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`option_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_option_description`
--

LOCK TABLES `oc_option_description` WRITE;
/*!40000 ALTER TABLE `oc_option_description` DISABLE KEYS */;
INSERT INTO `oc_option_description` VALUES (1,1,'Переключатель'),(2,1,'Флажок'),(4,1,'Текст'),(6,1,'Текстовая область'),(8,1,'Дата'),(7,1,'Файл'),(5,1,'Список'),(9,1,'Время'),(10,1,'Дата и Время'),(12,1,'Дата доставки'),(11,1,'Размер');
/*!40000 ALTER TABLE `oc_option_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_option_value`
--

DROP TABLE IF EXISTS `oc_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_option_value` (
  `option_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`option_value_id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_option_value`
--

LOCK TABLES `oc_option_value` WRITE;
/*!40000 ALTER TABLE `oc_option_value` DISABLE KEYS */;
INSERT INTO `oc_option_value` VALUES (43,1,'',3),(32,1,'',1),(45,2,'',4),(44,2,'',3),(42,5,'',4),(41,5,'',3),(39,5,'',1),(40,5,'',2),(31,1,'',2),(23,2,'',1),(24,2,'',2),(46,11,'',1),(47,11,'',2),(48,11,'',3);
/*!40000 ALTER TABLE `oc_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_option_value_description`
--

DROP TABLE IF EXISTS `oc_option_value_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_option_value_description` (
  `option_value_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`option_value_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_option_value_description`
--

LOCK TABLES `oc_option_value_description` WRITE;
/*!40000 ALTER TABLE `oc_option_value_description` DISABLE KEYS */;
INSERT INTO `oc_option_value_description` VALUES (43,1,1,'Large'),(32,1,1,'Small'),(45,1,2,'Флажок 4'),(44,1,2,'Флажок 3'),(31,1,1,'Medium'),(42,1,5,'Желтый'),(41,1,5,'Зеленый'),(39,1,5,'Красный'),(40,1,5,'Синий'),(23,1,2,'Флажок 1'),(24,1,2,'Флажок 2'),(48,1,11,'Large'),(47,1,11,'Medium'),(46,1,11,'Small');
/*!40000 ALTER TABLE `oc_option_value_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order`
--

DROP TABLE IF EXISTS `oc_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_no` int(11) NOT NULL DEFAULT '0',
  `invoice_prefix` varchar(26) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `store_name` varchar(64) NOT NULL,
  `store_url` varchar(255) NOT NULL,
  `customer_id` int(11) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) NOT NULL DEFAULT '0',
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `custom_field` text NOT NULL,
  `payment_firstname` varchar(32) NOT NULL,
  `payment_lastname` varchar(32) NOT NULL,
  `payment_company` varchar(60) NOT NULL,
  `payment_address_1` varchar(128) NOT NULL,
  `payment_address_2` varchar(128) NOT NULL,
  `payment_city` varchar(128) NOT NULL,
  `payment_postcode` varchar(10) NOT NULL,
  `payment_country` varchar(128) NOT NULL,
  `payment_country_id` int(11) NOT NULL,
  `payment_zone` varchar(128) NOT NULL,
  `payment_zone_id` int(11) NOT NULL,
  `payment_address_format` text NOT NULL,
  `payment_custom_field` text NOT NULL,
  `payment_method` varchar(128) NOT NULL,
  `payment_code` varchar(128) NOT NULL,
  `shipping_firstname` varchar(32) NOT NULL,
  `shipping_lastname` varchar(32) NOT NULL,
  `shipping_company` varchar(40) NOT NULL,
  `shipping_address_1` varchar(128) NOT NULL,
  `shipping_address_2` varchar(128) NOT NULL,
  `shipping_city` varchar(128) NOT NULL,
  `shipping_postcode` varchar(10) NOT NULL,
  `shipping_country` varchar(128) NOT NULL,
  `shipping_country_id` int(11) NOT NULL,
  `shipping_zone` varchar(128) NOT NULL,
  `shipping_zone_id` int(11) NOT NULL,
  `shipping_address_format` text NOT NULL,
  `shipping_custom_field` text NOT NULL,
  `shipping_method` varchar(128) NOT NULL,
  `shipping_code` varchar(128) NOT NULL,
  `comment` text NOT NULL,
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `order_status_id` int(11) NOT NULL DEFAULT '0',
  `affiliate_id` int(11) NOT NULL,
  `commission` decimal(15,4) NOT NULL,
  `marketing_id` int(11) NOT NULL,
  `tracking` varchar(64) NOT NULL,
  `language_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
  `ip` varchar(40) NOT NULL,
  `forwarded_ip` varchar(40) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `accept_language` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order`
--

LOCK TABLES `oc_order` WRITE;
/*!40000 ALTER TABLE `oc_order` DISABLE KEYS */;
INSERT INTO `oc_order` VALUES (1,0,'',0,'','',0,0,'','','','','','','','','','','','','','',0,'',0,'','','','','','','','','','','','',0,'',0,'','','','','',0.0000,0,0,0.0000,0,'',0,0,'',0.00000000,'','','','','2018-06-26 06:45:49','2018-06-26 06:45:49'),(2,0,'',0,'','',0,0,'','','','','','','','','','','','','','',0,'',0,'','','','','','','','','','','','',0,'',0,'','','','','',0.0000,0,0,0.0000,0,'',0,0,'',0.00000000,'','','','','2018-06-26 06:48:27','2018-06-26 06:48:27'),(3,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'','','','','','','','','','','','','','',0,'',0,'','[]','','','','','','','','','','',0,'',0,'','[]','','','',10000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 06:52:38','2018-06-26 06:52:38'),(4,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'','','','','','','sssss','sssss','','','','','','',0,'',0,'','[]','','','sssss','sssss','','','','','','',0,'',0,'','[]','','','',10000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 06:57:13','2018-06-26 06:57:13'),(5,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'','','','','','','zzzzzz','zzzzzz','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','zzzzzz','zzzzzz','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',20000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 06:59:06','2018-06-26 06:59:06'),(6,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'sssss','sssss','wslapshin@gmail.com','(111) 111-1111','','[]','sssss','sssss','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','sssss','sssss','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 07:07:28','2018-06-26 07:07:28'),(7,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'fssssssss','fssssssss','wslapshin@gmail.com','(111) 111-1111','','[]','fssssssss','fssssssss','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','fssssssss','fssssssss','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 07:15:39','2018-06-26 07:15:39'),(8,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'sssss','sssss','wslapshin@gmail.com','(111) 111-1111','','[]','sssss','sssss','','sdfasdfsdf','sdfasdfsdf','','','',0,'',0,'','[]','','','sssss','sssss','','sdfasdfsdf','sdfasdfsdf','','','',0,'',0,'','[]','','','',0.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 07:16:33','2018-06-26 07:16:33'),(9,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'asdfasdf','asdfasdf','wslapshin@gmail.com','(111) 111-1111','','[]','asdfasdf','asdfasdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','asdfasdf','asdfasdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',0.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 07:19:05','2018-06-26 07:19:05'),(10,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'sdfsfdsdf','sdfsfdsdf','wslapshin@gmail.com','(111) 111-1111','','[]','sdfsfdsdf','sdfsfdsdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','sdfsfdsdf','sdfsfdsdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',20000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 07:36:30','2018-06-26 07:36:30'),(11,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'sdfsdf','sdfsdf','wslapshin@gmail.com','(111) 111-1111','','[]','sdfsdf','sdfsdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','sdfsdf','sdfsdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',10000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 07:38:17','2018-06-26 07:38:17'),(12,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'sfasdf','sfasdf','wslapshin@gmail.com','(111) 111-1111','','[]','sfasdf','sfasdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','sfasdf','sfasdf','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 07:40:03','2018-06-26 07:40:03'),(13,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',20000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:01:47','2018-06-26 10:01:47'),(14,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',20000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:02:42','2018-06-26 10:02:42'),(15,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',20000.0000,0,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:05:14','2018-06-26 10:05:14'),(16,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:38:20','2018-06-26 10:38:54'),(17,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:40:06','2018-06-26 10:40:06'),(18,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:43:00','2018-06-26 10:43:00'),(19,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:49:25','2018-06-26 10:49:25'),(20,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 10:50:21','2018-06-26 10:50:21'),(21,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 11:01:40','2018-06-26 11:01:40'),(22,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 11:03:32','2018-06-26 11:03:32'),(23,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',20000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 11:05:37','2018-06-26 11:05:37'),(24,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',10000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 11:17:46','2018-06-26 11:17:46'),(25,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',20000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 11:23:56','2018-06-26 11:23:56'),(26,0,'INV-2013-00',0,'ООО &quot;Ант-Снаб&quot;','http://ant-snab/',0,0,'Sergey Lapshin','Sergey Lapshin','wslapshin@gmail.com','(926) 812-3112','','[]','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','Sergey Lapshin','Sergey Lapshin','','56, Vavilova str','56, Vavilova str','','','',0,'',0,'','[]','','','',15000.0000,1,0,0.0000,0,'',1,1,'RUB',1.00000000,'127.0.0.1','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36','ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4','2018-06-26 11:43:27','2018-06-26 11:43:27');
/*!40000 ALTER TABLE `oc_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_custom_field`
--

DROP TABLE IF EXISTS `oc_order_custom_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_custom_field` (
  `order_custom_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `custom_field_id` int(11) NOT NULL,
  `custom_field_value_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `type` varchar(32) NOT NULL,
  `location` varchar(16) NOT NULL,
  PRIMARY KEY (`order_custom_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_custom_field`
--

LOCK TABLES `oc_order_custom_field` WRITE;
/*!40000 ALTER TABLE `oc_order_custom_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_order_custom_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_history`
--

DROP TABLE IF EXISTS `oc_order_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_history` (
  `order_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_status_id` int(11) NOT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`order_history_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_history`
--

LOCK TABLES `oc_order_history` WRITE;
/*!40000 ALTER TABLE `oc_order_history` DISABLE KEYS */;
INSERT INTO `oc_order_history` VALUES (1,16,1,1,'','2018-06-26 10:38:54'),(2,17,1,1,'','2018-06-26 10:40:06'),(3,18,1,1,'','2018-06-26 10:43:00'),(4,19,1,1,'','2018-06-26 10:49:25'),(5,20,1,1,'','2018-06-26 10:50:21'),(6,21,1,1,'','2018-06-26 11:01:40'),(7,22,1,1,'','2018-06-26 11:03:32'),(8,23,1,1,'','2018-06-26 11:05:37'),(9,24,1,1,'','2018-06-26 11:17:46'),(10,25,1,1,'','2018-06-26 11:23:56'),(11,26,1,1,'','2018-06-26 11:43:27');
/*!40000 ALTER TABLE `oc_order_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_option`
--

DROP TABLE IF EXISTS `oc_order_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_option` (
  `order_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_product_id` int(11) NOT NULL,
  `product_option_id` int(11) NOT NULL,
  `product_option_value_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`order_option_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_option`
--

LOCK TABLES `oc_order_option` WRITE;
/*!40000 ALTER TABLE `oc_order_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_order_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_product`
--

DROP TABLE IF EXISTS `oc_order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_product` (
  `order_product_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `model` varchar(64) NOT NULL,
  `quantity` int(4) NOT NULL,
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `tax` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `reward` int(8) NOT NULL,
  PRIMARY KEY (`order_product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_product`
--

LOCK TABLES `oc_order_product` WRITE;
/*!40000 ALTER TABLE `oc_order_product` DISABLE KEYS */;
INSERT INTO `oc_order_product` VALUES (1,3,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',10,1000.0000,10000.0000,0.0000,0),(2,4,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',10,1000.0000,10000.0000,0.0000,0),(3,5,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',20,1000.0000,20000.0000,0.0000,0),(4,6,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(5,7,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,500.0000,15000.0000,0.0000,0),(6,8,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,15000.0000,0.0000,0),(7,9,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',40,1000.0000,20000.0000,0.0000,0),(8,10,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',40,1000.0000,40000.0000,0.0000,0),(9,11,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',10,1000.0000,10000.0000,0.0000,0),(10,12,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(11,13,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',40,1000.0000,40000.0000,0.0000,0),(12,15,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',20,1000.0000,20000.0000,0.0000,0),(13,16,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(14,17,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(15,18,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(16,19,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(17,20,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(18,21,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(19,22,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0),(20,23,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',20,1000.0000,20000.0000,0.0000,0),(21,24,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',10,1000.0000,10000.0000,0.0000,0),(22,25,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',20,1000.0000,20000.0000,0.0000,0),(23,26,51,'Эластоизол Премиум ТКП-5,0','ТКП-5,0',30,1000.0000,30000.0000,0.0000,0);
/*!40000 ALTER TABLE `oc_order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_recurring`
--

DROP TABLE IF EXISTS `oc_order_recurring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_recurring` (
  `order_recurring_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `recurring_id` int(11) NOT NULL,
  `recurring_name` varchar(255) NOT NULL,
  `recurring_description` varchar(255) NOT NULL,
  `recurring_frequency` varchar(25) NOT NULL,
  `recurring_cycle` smallint(6) NOT NULL,
  `recurring_duration` smallint(6) NOT NULL,
  `recurring_price` decimal(10,4) NOT NULL,
  `trial` tinyint(1) NOT NULL,
  `trial_frequency` varchar(25) NOT NULL,
  `trial_cycle` smallint(6) NOT NULL,
  `trial_duration` smallint(6) NOT NULL,
  `trial_price` decimal(10,4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`order_recurring_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_recurring`
--

LOCK TABLES `oc_order_recurring` WRITE;
/*!40000 ALTER TABLE `oc_order_recurring` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_order_recurring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_recurring_transaction`
--

DROP TABLE IF EXISTS `oc_order_recurring_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_recurring_transaction` (
  `order_recurring_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_recurring_id` int(11) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` decimal(10,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`order_recurring_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_recurring_transaction`
--

LOCK TABLES `oc_order_recurring_transaction` WRITE;
/*!40000 ALTER TABLE `oc_order_recurring_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_order_recurring_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_status`
--

DROP TABLE IF EXISTS `oc_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_status` (
  `order_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`order_status_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_status`
--

LOCK TABLES `oc_order_status` WRITE;
/*!40000 ALTER TABLE `oc_order_status` DISABLE KEYS */;
INSERT INTO `oc_order_status` VALUES (1,1,'Ожидание'),(2,1,'В обработке'),(3,1,'Доставлено'),(7,1,'Отменено'),(5,1,'Сделка завершена'),(8,1,'Возврат'),(9,1,'Отмена и аннулирование'),(10,1,'Неудавшийся'),(11,1,'Возмещенный'),(12,1,'Полностью измененный'),(13,1,'Полный возврат');
/*!40000 ALTER TABLE `oc_order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_total`
--

DROP TABLE IF EXISTS `oc_order_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_total` (
  `order_total_id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `value` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`order_total_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_total`
--

LOCK TABLES `oc_order_total` WRITE;
/*!40000 ALTER TABLE `oc_order_total` DISABLE KEYS */;
INSERT INTO `oc_order_total` VALUES (1,3,'sub_total','Предварительная стоимость',10000.0000,0),(2,3,'total','Итого',10000.0000,2),(3,3,'wholesale','Итого',0.0000,2),(4,4,'sub_total','Предварительная стоимость',10000.0000,0),(5,4,'total','Итого',10000.0000,2),(6,4,'wholesale','Итого',0.0000,2),(7,5,'sub_total','Предварительная стоимость',20000.0000,0),(8,5,'total','Итого',20000.0000,2),(9,5,'wholesale','Итого',0.0000,2),(10,6,'sub_total','Предварительная стоимость',30000.0000,0),(11,6,'total','Итого',15000.0000,2),(12,6,'wholesale','Итого',-15000.0000,2),(13,7,'sub_total','Предварительная стоимость',15000.0000,0),(14,7,'total','Итого',15000.0000,2),(15,7,'wholesale','Итого',0.0000,2),(16,8,'sub_total','Предварительная стоимость',15000.0000,0),(17,8,'total','Итого',0.0000,2),(18,8,'wholesale','Итого',-15000.0000,2),(19,9,'sub_total','Предварительная стоимость',20000.0000,0),(20,9,'total','Итого',0.0000,2),(21,9,'wholesale','Итого',-20000.0000,2),(22,10,'sub_total','Предварительная стоимость',40000.0000,0),(23,10,'total','Итого',20000.0000,2),(24,10,'wholesale','Итого (опт)',-20000.0000,2),(25,11,'sub_total','Предварительная стоимость',10000.0000,0),(26,11,'total','Итого',10000.0000,2),(27,11,'wholesale','Итого (опт)',0.0000,2),(28,12,'sub_total','Предварительная стоимость',30000.0000,0),(29,12,'total','Итого',15000.0000,2),(30,12,'wholesale','Итого (опт)',-15000.0000,2),(31,13,'sub_total','Предварительная стоимость',40000.0000,0),(32,13,'total','Итого',20000.0000,2),(33,13,'wholesale','Итого (опт)',-20000.0000,2),(34,15,'sub_total','Предварительная стоимость',20000.0000,0),(35,15,'total','Итого',20000.0000,2),(36,15,'wholesale','Итого (опт)',0.0000,2),(37,16,'sub_total','Предварительная стоимость',30000.0000,0),(38,16,'total','Итого',15000.0000,2),(39,16,'wholesale','Итого (опт)',-15000.0000,2),(40,17,'sub_total','Предварительная стоимость',30000.0000,0),(41,17,'total','Итого',15000.0000,2),(42,17,'wholesale','Итого (опт)',-15000.0000,2),(43,18,'sub_total','Предварительная стоимость',30000.0000,0),(44,18,'total','Итого',15000.0000,2),(45,18,'wholesale','Итого (опт)',-15000.0000,2),(46,19,'sub_total','Предварительная стоимость',30000.0000,0),(47,19,'total','Итого',15000.0000,2),(48,19,'wholesale','Итого (опт)',-15000.0000,2),(49,20,'sub_total','Предварительная стоимость',30000.0000,0),(50,20,'total','Итого',15000.0000,2),(51,20,'wholesale','Итого (опт)',-15000.0000,2),(52,21,'sub_total','Предварительная стоимость',30000.0000,0),(53,21,'total','Итого',15000.0000,2),(54,21,'wholesale','Итого (опт)',-15000.0000,2),(55,22,'sub_total','Предварительная стоимость',30000.0000,0),(56,22,'total','Итого',15000.0000,2),(57,22,'wholesale','Итого (опт)',-15000.0000,2),(58,23,'sub_total','Предварительная стоимость',20000.0000,0),(59,23,'total','Итого',20000.0000,2),(60,23,'wholesale','Итого (опт)',0.0000,2),(61,24,'sub_total','Предварительная стоимость',10000.0000,0),(62,24,'total','Итого',10000.0000,2),(63,24,'wholesale','Итого (опт)',0.0000,2),(64,25,'sub_total','Предварительная стоимость',20000.0000,0),(65,25,'total','Итого',20000.0000,2),(66,25,'wholesale','Итого (опт)',0.0000,2),(67,26,'sub_total','Предварительная стоимость',30000.0000,0),(68,26,'total','Итого',15000.0000,2),(69,26,'wholesale','Итого (опт)',-15000.0000,2);
/*!40000 ALTER TABLE `oc_order_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_order_voucher`
--

DROP TABLE IF EXISTS `oc_order_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_order_voucher` (
  `order_voucher_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `voucher_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `code` varchar(10) NOT NULL,
  `from_name` varchar(64) NOT NULL,
  `from_email` varchar(96) NOT NULL,
  `to_name` varchar(64) NOT NULL,
  `to_email` varchar(96) NOT NULL,
  `voucher_theme_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  PRIMARY KEY (`order_voucher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_order_voucher`
--

LOCK TABLES `oc_order_voucher` WRITE;
/*!40000 ALTER TABLE `oc_order_voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_order_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product`
--

DROP TABLE IF EXISTS `oc_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(64) NOT NULL,
  `sku` varchar(64) NOT NULL,
  `upc` varchar(12) NOT NULL,
  `ean` varchar(14) NOT NULL,
  `jan` varchar(13) NOT NULL,
  `isbn` varchar(17) NOT NULL,
  `mpn` varchar(64) NOT NULL,
  `location` varchar(128) NOT NULL,
  `quantity` int(4) NOT NULL DEFAULT '0',
  `stock_status_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `manufacturer_id` int(11) NOT NULL,
  `shipping` tinyint(1) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `points` int(8) NOT NULL DEFAULT '0',
  `tax_class_id` int(11) NOT NULL,
  `date_available` date NOT NULL DEFAULT '0000-00-00',
  `weight` decimal(15,2) NOT NULL DEFAULT '0.00',
  `weight_class_id` int(11) NOT NULL DEFAULT '0',
  `length` decimal(15,2) NOT NULL DEFAULT '0.00',
  `width` decimal(15,2) NOT NULL DEFAULT '0.00',
  `height` decimal(15,2) NOT NULL DEFAULT '0.00',
  `length_class_id` int(11) NOT NULL DEFAULT '0',
  `subtract` tinyint(1) NOT NULL DEFAULT '1',
  `minimum` int(10) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `viewed` int(5) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `showInSummary` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `price_wholesale` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `wholesale_threshold` float(10,4) DEFAULT NULL,
  `produnit_template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product`
--

LOCK TABLES `oc_product` WRITE;
/*!40000 ALTER TABLE `oc_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_attribute`
--

DROP TABLE IF EXISTS `oc_product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_attribute` (
  `product_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`product_id`,`attribute_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_attribute`
--

LOCK TABLES `oc_product_attribute` WRITE;
/*!40000 ALTER TABLE `oc_product_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_description`
--

DROP TABLE IF EXISTS `oc_product_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_description` (
  `product_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `tag` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_h1` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL,
  `description_mini` text,
  PRIMARY KEY (`product_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_description`
--

LOCK TABLES `oc_product_description` WRITE;
/*!40000 ALTER TABLE `oc_product_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_discount`
--

DROP TABLE IF EXISTS `oc_product_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_discount` (
  `product_discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `quantity` int(4) NOT NULL DEFAULT '0',
  `priority` int(5) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`product_discount_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=636 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_discount`
--

LOCK TABLES `oc_product_discount` WRITE;
/*!40000 ALTER TABLE `oc_product_discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_filter`
--

DROP TABLE IF EXISTS `oc_product_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_filter` (
  `product_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_filter`
--

LOCK TABLES `oc_product_filter` WRITE;
/*!40000 ALTER TABLE `oc_product_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_image`
--

DROP TABLE IF EXISTS `oc_product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_image` (
  `product_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_image_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2784 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_image`
--

LOCK TABLES `oc_product_image` WRITE;
/*!40000 ALTER TABLE `oc_product_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_option`
--

DROP TABLE IF EXISTS `oc_product_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_option` (
  `product_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `value` text NOT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`product_option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=227 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_option`
--

LOCK TABLES `oc_product_option` WRITE;
/*!40000 ALTER TABLE `oc_product_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_option_value`
--

DROP TABLE IF EXISTS `oc_product_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_option_value` (
  `product_option_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `option_value_id` int(11) NOT NULL,
  `quantity` int(3) NOT NULL,
  `subtract` tinyint(1) NOT NULL,
  `price` decimal(15,4) NOT NULL,
  `price_prefix` varchar(1) NOT NULL,
  `points` int(8) NOT NULL,
  `points_prefix` varchar(1) NOT NULL,
  `weight` decimal(15,2) NOT NULL,
  `weight_prefix` varchar(1) NOT NULL,
  PRIMARY KEY (`product_option_value_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_option_value`
--

LOCK TABLES `oc_product_option_value` WRITE;
/*!40000 ALTER TABLE `oc_product_option_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_recurring`
--

DROP TABLE IF EXISTS `oc_product_recurring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_recurring` (
  `product_id` int(11) NOT NULL,
  `recurring_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`recurring_id`,`customer_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_recurring`
--

LOCK TABLES `oc_product_recurring` WRITE;
/*!40000 ALTER TABLE `oc_product_recurring` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_recurring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_related`
--

DROP TABLE IF EXISTS `oc_product_related`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_related` (
  `product_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`related_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_related`
--

LOCK TABLES `oc_product_related` WRITE;
/*!40000 ALTER TABLE `oc_product_related` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_related` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_reward`
--

DROP TABLE IF EXISTS `oc_product_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_reward` (
  `product_reward_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) NOT NULL DEFAULT '0',
  `points` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_reward_id`)
) ENGINE=MyISAM AUTO_INCREMENT=635 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_reward`
--

LOCK TABLES `oc_product_reward` WRITE;
/*!40000 ALTER TABLE `oc_product_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_special`
--

DROP TABLE IF EXISTS `oc_product_special`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_special` (
  `product_special_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `priority` int(5) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`product_special_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=547 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_special`
--

LOCK TABLES `oc_product_special` WRITE;
/*!40000 ALTER TABLE `oc_product_special` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_special` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_to_category`
--

DROP TABLE IF EXISTS `oc_product_to_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_to_category` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `main_category` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_to_category`
--

LOCK TABLES `oc_product_to_category` WRITE;
/*!40000 ALTER TABLE `oc_product_to_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_to_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_to_download`
--

DROP TABLE IF EXISTS `oc_product_to_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_to_download` (
  `product_id` int(11) NOT NULL,
  `download_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_to_download`
--

LOCK TABLES `oc_product_to_download` WRITE;
/*!40000 ALTER TABLE `oc_product_to_download` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_to_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_to_layout`
--

DROP TABLE IF EXISTS `oc_product_to_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_to_layout` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_to_layout`
--

LOCK TABLES `oc_product_to_layout` WRITE;
/*!40000 ALTER TABLE `oc_product_to_layout` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_to_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_product_to_store`
--

DROP TABLE IF EXISTS `oc_product_to_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_product_to_store` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_product_to_store`
--

LOCK TABLES `oc_product_to_store` WRITE;
/*!40000 ALTER TABLE `oc_product_to_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_product_to_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_recurring`
--

DROP TABLE IF EXISTS `oc_recurring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_recurring` (
  `recurring_id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,4) NOT NULL,
  `frequency` enum('day','week','semi_month','month','year') NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `cycle` int(10) unsigned NOT NULL,
  `trial_status` tinyint(4) NOT NULL,
  `trial_price` decimal(10,4) NOT NULL,
  `trial_frequency` enum('day','week','semi_month','month','year') NOT NULL,
  `trial_duration` int(10) unsigned NOT NULL,
  `trial_cycle` int(10) unsigned NOT NULL,
  `status` tinyint(4) NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`recurring_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_recurring`
--

LOCK TABLES `oc_recurring` WRITE;
/*!40000 ALTER TABLE `oc_recurring` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_recurring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_recurring_description`
--

DROP TABLE IF EXISTS `oc_recurring_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_recurring_description` (
  `recurring_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`recurring_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_recurring_description`
--

LOCK TABLES `oc_recurring_description` WRITE;
/*!40000 ALTER TABLE `oc_recurring_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_recurring_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_return`
--

DROP TABLE IF EXISTS `oc_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_return` (
  `return_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `product` varchar(255) NOT NULL,
  `model` varchar(64) NOT NULL,
  `quantity` int(4) NOT NULL,
  `opened` tinyint(1) NOT NULL,
  `return_reason_id` int(11) NOT NULL,
  `return_action_id` int(11) NOT NULL,
  `return_status_id` int(11) NOT NULL,
  `comment` text,
  `date_ordered` date NOT NULL DEFAULT '0000-00-00',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`return_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_return`
--

LOCK TABLES `oc_return` WRITE;
/*!40000 ALTER TABLE `oc_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_return_action`
--

DROP TABLE IF EXISTS `oc_return_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_return_action` (
  `return_action_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`return_action_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_return_action`
--

LOCK TABLES `oc_return_action` WRITE;
/*!40000 ALTER TABLE `oc_return_action` DISABLE KEYS */;
INSERT INTO `oc_return_action` VALUES (1,1,'Возвращены средства'),(2,1,'Выдан в кредит'),(3,1,'Отправлена замена (отправлен другой товар для замены)');
/*!40000 ALTER TABLE `oc_return_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_return_history`
--

DROP TABLE IF EXISTS `oc_return_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_return_history` (
  `return_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `return_id` int(11) NOT NULL,
  `return_status_id` int(11) NOT NULL,
  `notify` tinyint(1) NOT NULL,
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`return_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_return_history`
--

LOCK TABLES `oc_return_history` WRITE;
/*!40000 ALTER TABLE `oc_return_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_return_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_return_reason`
--

DROP TABLE IF EXISTS `oc_return_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_return_reason` (
  `return_reason_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`return_reason_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_return_reason`
--

LOCK TABLES `oc_return_reason` WRITE;
/*!40000 ALTER TABLE `oc_return_reason` DISABLE KEYS */;
INSERT INTO `oc_return_reason` VALUES (1,1,'Получен/доставлен неисправным (сломанным)'),(2,1,'Получен не тот (ошибочный) товар'),(4,1,'Ошибочный, пожалуйста, укажите/приложите подробности'),(5,1,'Другое (другая причина), пожалуйста, укажите/приложите подробности');
/*!40000 ALTER TABLE `oc_return_reason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_return_status`
--

DROP TABLE IF EXISTS `oc_return_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_return_status` (
  `return_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`return_status_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_return_status`
--

LOCK TABLES `oc_return_status` WRITE;
/*!40000 ALTER TABLE `oc_return_status` DISABLE KEYS */;
INSERT INTO `oc_return_status` VALUES (1,1,'В обработке'),(3,1,'Готов (к отправке) / или Завершен'),(2,1,'В ожидании');
/*!40000 ALTER TABLE `oc_return_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_review`
--

DROP TABLE IF EXISTS `oc_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `author` varchar(64) NOT NULL,
  `text` text NOT NULL,
  `rating` int(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `about` varchar(255) NOT NULL DEFAULT '',
  `moderator` varchar(100) NOT NULL DEFAULT '',
  `answer` varchar(2000) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `company` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`review_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_review`
--

LOCK TABLES `oc_review` WRITE;
/*!40000 ALTER TABLE `oc_review` DISABLE KEYS */;
INSERT INTO `oc_review` VALUES (21,0,0,'Людмила','Отличная компания Ант-Снаб!!!!! Сотрудники компетентны в своей работе, готовы придти всегда на помощь и водителю, и менеджеру, и диспетчеру. Приятно и надежно работать с ответственными людьми!!!!! Удачи вам и процветания!!!!!! Спасибо огромное Илье Кохану!!!!',5,1,'2018-03-31 10:31:04','0000-00-00 00:00:00','Сервисе','Илья Кохан','Большое спасибо за доверие и высокую оценку нашей работы. Будем стараться поддерживать этот уровень в дальнейшем!','',''),(20,0,0,'Алексей','В течение всего 2016 года покупали праймер и мастику в компании &quot;Ант-Снаб! Качество продукции и сервис на достойном уровне! Отдельное спасибо Гостеву Никите!!! Будем работать дальше!!!',5,1,'2018-03-31 10:30:09','0000-00-00 00:00:00','Сервисе','Гостев Никита','Спасибо и Вам, Алексей, надеюсь продолжить сотрудничество!','',''),(22,0,0,'Роман','Давно и очень плодотворно работаем с компанией Ант-Снаб,очень довольны качеством поставляемых в наш адрес мастик и праймеров.Ребят не возможно поставить в тупик,как мы не старались,любой объем в очень сжатые сроки.Особо хотелось бы отметить Гостева Никиту,приятно работать с человеком,который абсолютно компетентен,професиионален!Будем работать и впредь,объемы будем наращивать!',5,1,'2018-03-31 10:31:58','0000-00-00 00:00:00','Доставке','Гостев Никита','Роман, спасибо за Ваш отзыв, мы очень вас ценим и постараемся не обманывать ваших ожиданий и в дальнейшем.','',''),(23,0,0,'Иванович Павел ','Наша организация очень плотно работала с вашими муравьями в 2014, и нет предела наслаждения от общения с вами! Наличие такого грамотного, адекватного и главное(!!!) с невероятным чувством юмора Поставщика - это, как мы считаем, наша находка! Каждый раз, ведя рабочую переписку, общаясь по телефону или просто держа в руках копии платежных поручений (всегда оплачиваемых счетов от муравьёв) - невольно улыбаешься и прилив отличного настроения настраивает на дальнейшее сотрудничество с вашим муравейником в 2015г. Спасибо за ваш позитив и грамотный бизнес!',5,1,'2018-03-31 10:32:35','2018-04-02 10:09:24','Сервисе','Ант-Снаб','Павел, спасибо Вам за такой прекрасный отзыв. Надеемся и дальше радовать Вас как качеством нашей работы, так и качеством чувства юмора. С наступающим!','lt@mail.ru','Какая то ltd'),(24,0,0,'','Ант-Снаб - отличная компания!',0,0,'2018-04-02 23:17:08','0000-00-00 00:00:00','','','','wslapshin@gmail.com','ООО &quot;Вайс&quot;'),(25,0,0,'','Ант-Снаб - отличная компания! Да! Да!',0,0,'2018-04-02 23:17:58','0000-00-00 00:00:00','','','','wslapshin@gmail.com','ООО &quot;Вайс2&quot;'),(26,0,0,'Сергей3','Ант-Снаб - отличная компания! Да! Да!',0,0,'2018-04-02 23:19:25','0000-00-00 00:00:00','','','','wslapshin@gmail.com','ООО &quot;Вайс3&quot;'),(27,0,0,'Сергей34','Ант-Снаб - отличная компания! Да! Да!',5,0,'2018-04-02 23:22:00','0000-00-00 00:00:00','','','','wslapshin@gmail.com','ООО &quot;Вайс3&quot;'),(28,0,0,'sdfsdf','asdfasdfasdf adfasdfsadf',5,0,'2018-04-12 07:10:11','0000-00-00 00:00:00','','','','wslapshin@gmail.com','ltd');
/*!40000 ALTER TABLE `oc_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_setting`
--

DROP TABLE IF EXISTS `oc_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `code` varchar(32) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `serialized` tinyint(1) NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3643 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_setting`
--

LOCK TABLES `oc_setting` WRITE;
/*!40000 ALTER TABLE `oc_setting` DISABLE KEYS */;
INSERT INTO `oc_setting` VALUES (3612,0,'config','config_seo_url_include_path','0',0),(3613,0,'config','config_seo_url_postfix','',0),(3614,0,'config','config_seo_pro_utm','block\r\nfrommarket\r\ngclid\r\nkeyword\r\nlist_type\r\nopenstat\r\nopenstat_service\r\nopenstat_campaign\r\nopenstat_ad\r\nopenstat_source\r\nposition\r\nsource\r\ntracking\r\ntype\r\nyclid\r\nymclid\r\nuri\r\nurltype\r\nutm_source\r\nutm_medium\r\nutm_campaign\r\nutm_term\r\nutm_content',0),(3615,0,'config','config_robots','abot\r\ndbot\r\nebot\r\nhbot\r\nkbot\r\nlbot\r\nmbot\r\nnbot\r\nobot\r\npbot\r\nrbot\r\nsbot\r\ntbot\r\nvbot\r\nybot\r\nzbot\r\nbot.\r\nbot/\r\n_bot\r\n.bot\r\n/bot\r\n-bot\r\n:bot\r\n(bot\r\ncrawl\r\nslurp\r\nspider\r\nseek\r\naccoona\r\nacoon\r\nadressendeutschland\r\nah-ha.com\r\nahoy\r\naltavista\r\nananzi\r\nanthill\r\nappie\r\narachnophilia\r\narale\r\naraneo\r\naranha\r\narchitext\r\naretha\r\narks\r\nasterias\r\natlocal\r\natn\r\natomz\r\naugurfind\r\nbackrub\r\nbannana_bot\r\nbaypup\r\nbdfetch\r\nbig brother\r\nbiglotron\r\nbjaaland\r\nblackwidow\r\nblaiz\r\nblog\r\nblo.\r\nbloodhound\r\nboitho\r\nbooch\r\nbradley\r\nbutterfly\r\ncalif\r\ncassandra\r\nccubee\r\ncfetch\r\ncharlotte\r\nchurl\r\ncienciaficcion\r\ncmc\r\ncollective\r\ncomagent\r\ncombine\r\ncomputingsite\r\ncsci\r\ncurl\r\ncusco\r\ndaumoa\r\ndeepindex\r\ndelorie\r\ndepspid\r\ndeweb\r\ndie blinde kuh\r\ndigger\r\nditto\r\ndmoz\r\ndocomo\r\ndownload express\r\ndtaagent\r\ndwcp\r\nebiness\r\nebingbong\r\ne-collector\r\nejupiter\r\nemacs-w3 search engine\r\nesther\r\nevliya celebi\r\nezresult\r\nfalcon\r\nfelix ide\r\nferret\r\nfetchrover\r\nfido\r\nfindlinks\r\nfireball\r\nfish search\r\nfouineur\r\nfunnelweb\r\ngazz\r\ngcreep\r\ngenieknows\r\ngetterroboplus\r\ngeturl\r\nglx\r\ngoforit\r\ngolem\r\ngrabber\r\ngrapnel\r\ngralon\r\ngriffon\r\ngromit\r\ngrub\r\ngulliver\r\nhamahakki\r\nharvest\r\nhavindex\r\nhelix\r\nheritrix\r\nhku www octopus\r\nhomerweb\r\nhtdig\r\nhtml index\r\nhtml_analyzer\r\nhtmlgobble\r\nhubater\r\nhyper-decontextualizer\r\nia_archiver\r\nibm_planetwide\r\nichiro\r\niconsurf\r\niltrovatore\r\nimage.kapsi.net\r\nimagelock\r\nincywincy\r\nindexer\r\ninfobee\r\ninformant\r\ningrid\r\ninktomisearch.com\r\ninspector web\r\nintelliagent\r\ninternet shinchakubin\r\nip3000\r\niron33\r\nisraeli-search\r\nivia\r\njack\r\njakarta\r\njavabee\r\njetbot\r\njumpstation\r\nkatipo\r\nkdd-explorer\r\nkilroy\r\nknowledge\r\nkototoi\r\nkretrieve\r\nlabelgrabber\r\nlachesis\r\nlarbin\r\nlegs\r\nlibwww\r\nlinkalarm\r\nlink validator\r\nlinkscan\r\nlockon\r\nlwp\r\nlycos\r\nmagpie\r\nmantraagent\r\nmapoftheinternet\r\nmarvin/\r\nmattie\r\nmediafox\r\nmediapartners\r\nmercator\r\nmerzscope\r\nmicrosoft url control\r\nminirank\r\nmiva\r\nmj12\r\nmnogosearch\r\nmoget\r\nmonster\r\nmoose\r\nmotor\r\nmultitext\r\nmuncher\r\nmuscatferret\r\nmwd.search\r\nmyweb\r\nnajdi\r\nnameprotect\r\nnationaldirectory\r\nnazilla\r\nncsa beta\r\nnec-meshexplorer\r\nnederland.zoek\r\nnetcarta webmap engine\r\nnetmechanic\r\nnetresearchserver\r\nnetscoop\r\nnewscan-online\r\nnhse\r\nnokia6682/\r\nnomad\r\nnoyona\r\nnutch\r\nnzexplorer\r\nobjectssearch\r\noccam\r\nomni\r\nopen text\r\nopenfind\r\nopenintelligencedata\r\norb search\r\nosis-project\r\npack rat\r\npageboy\r\npagebull\r\npage_verifier\r\npanscient\r\nparasite\r\npartnersite\r\npatric\r\npear.\r\npegasus\r\nperegrinator\r\npgp key agent\r\nphantom\r\nphpdig\r\npicosearch\r\npiltdownman\r\npimptrain\r\npinpoint\r\npioneer\r\npiranha\r\nplumtreewebaccessor\r\npogodak\r\npoirot\r\npompos\r\npoppelsdorf\r\npoppi\r\npopular iconoclast\r\npsycheclone\r\npublisher\r\npython\r\nrambler\r\nraven search\r\nroach\r\nroad runner\r\nroadhouse\r\nrobbie\r\nrobofox\r\nrobozilla\r\nrules\r\nsalty\r\nsbider\r\nscooter\r\nscoutjet\r\nscrubby\r\nsearch.\r\nsearchprocess\r\nsemanticdiscovery\r\nsenrigan\r\nsg-scout\r\nshai\'hulud\r\nshark\r\nshopwiki\r\nsidewinder\r\nsift\r\nsilk\r\nsimmany\r\nsite searcher\r\nsite valet\r\nsitetech-rover\r\nskymob.com\r\nsleek\r\nsmartwit\r\nsna-\r\nsnappy\r\nsnooper\r\nsohu\r\nspeedfind\r\nsphere\r\nsphider\r\nspinner\r\nspyder\r\nsteeler/\r\nsuke\r\nsuntek\r\nsupersnooper\r\nsurfnomore\r\nsven\r\nsygol\r\nszukacz\r\ntach black widow\r\ntarantula\r\ntempleton\r\n/teoma\r\nt-h-u-n-d-e-r-s-t-o-n-e\r\ntheophrastus\r\ntitan\r\ntitin\r\ntkwww\r\ntoutatis\r\nt-rex\r\ntutorgig\r\ntwiceler\r\ntwisted\r\nucsd\r\nudmsearch\r\nurl check\r\nupdated\r\nvagabondo\r\nvalkyrie\r\nverticrawl\r\nvictoria\r\nvision-search\r\nvolcano\r\nvoyager/\r\nvoyager-hc\r\nw3c_validator\r\nw3m2\r\nw3mir\r\nwalker\r\nwallpaper\r\nwanderer\r\nwauuu\r\nwavefire\r\nweb core\r\nweb hopper\r\nweb wombat\r\nwebbandit\r\nwebcatcher\r\nwebcopy\r\nwebfoot\r\nweblayers\r\nweblinker\r\nweblog monitor\r\nwebmirror\r\nwebmonkey\r\nwebquest\r\nwebreaper\r\nwebsitepulse\r\nwebsnarf\r\nwebstolperer\r\nwebvac\r\nwebwalk\r\nwebwatch\r\nwebwombat\r\nwebzinger\r\nwhizbang\r\nwhowhere\r\nwild ferret\r\nworldlight\r\nwwwc\r\nwwwster\r\nxenu\r\nxget\r\nxift\r\nxirq\r\nyandex\r\nyanga\r\nyeti\r\nyodao\r\nzao\r\nzippp\r\nzyborg',0),(2406,0,'wholesale','wholesale_sort_order','1',0),(2252,0,'google_sitemap','google_sitemap_status','1',0),(3639,0,'config','config_meta_keyword','Интернет, магазин, онлайн, оффлайн, строительные, отделочные, материалы, стройматериалы, купить, цена, с доставкой, Москва, опт, розница, самовывоз, Ант-Снаб, ТК, ООО',0),(3634,0,'config','config_sms_message','',0),(3635,0,'config','config_sms_gate_username','',0),(3636,0,'config','config_sms_gate_password','',0),(3637,0,'config','config_meta_title','Ант-Снаб – интернет-магазин строительных и отделочных материалов с доставкой в Москве',0),(3638,0,'config','config_meta_description','Интернет-магазин строительных и отделочных материалов в Москве. Собственные склады, быстрая доставка, широкий ассортимент и доступные цены.',0),(3625,0,'config','config_file_mime_allowed','text/plain\r\nimage/png\r\nimage/jpeg\r\nimage/gif\r\nimage/bmp\r\nimage/tiff\r\nimage/svg+xml\r\napplication/zip\r\n&quot;application/zip&quot;\r\napplication/x-zip\r\n&quot;application/x-zip&quot;\r\napplication/x-zip-compressed\r\n&quot;application/x-zip-compressed&quot;\r\napplication/rar\r\n&quot;application/rar&quot;\r\napplication/x-rar\r\n&quot;application/x-rar&quot;\r\napplication/x-rar-compressed\r\n&quot;application/x-rar-compressed&quot;\r\napplication/octet-stream\r\n&quot;application/octet-stream&quot;\r\naudio/mpeg\r\nvideo/quicktime\r\napplication/pdf',0),(3633,0,'config','config_sms_copy','',0),(3632,0,'config','config_sms_to','',0),(3631,0,'config','config_sms_from','',0),(3630,0,'config','config_sms_gatename','testsms',0),(3626,0,'config','config_error_display','1',0),(3627,0,'config','config_error_log','1',0),(3628,0,'config','config_error_filename','error.log',0),(3629,0,'config','config_sms_alert','0',0),(3624,0,'config','config_file_ext_allowed','zip\r\ntxt\r\npng\r\njpe\r\njpeg\r\njpg\r\ngif\r\nbmp\r\nico\r\ntiff\r\ntif\r\nsvg\r\nsvgz\r\nzip\r\nrar\r\nmsi\r\ncab\r\nmp3\r\nqt\r\nmov\r\npdf\r\npsd\r\nai\r\neps\r\nps\r\ndoc',0),(3623,0,'config','config_file_max_size','300000',0),(3618,0,'config','config_editor_default','0',0),(3619,0,'config','config_secure','0',0),(3620,0,'config','config_password','1',0),(3621,0,'config','config_shared','0',0),(3622,0,'config','config_encryption','ek9YhtqHwUz3wUl7z9TRcxB1VSHxdUKLgFgWAPGZeENwTvllB8UA55ecrHiAQWTuO5bQ8eBtvqY3W9igtcRT8nSXIeSymMvhgs7Brv4ak6R7X1qNoTHIpbc0vmVCnghh5hmPtu7F2Ia0anBljAIOPRu3bPqNPq0WnGT2cfJ95qtqecq0sSHF9YGGUMZCum4okAxRruzMLWZHTSBAMRO8Ky0Ay0lVrRhy2RBSkhQH5nO0Q3bdwr4aIWeqDtqi1dLnu7wWiVAhRE4d3Vw1V80JiD8Z4IA12KKiYyqnW2YFUMXblWfUUaUtn4yo4ZxsRSVpngkjl0sOxOeuO20G3B2l4Zc0nr1HiLn3V8kLExwDGALgUvfQw2moLcSG5P2kiqipq9MbhTFQUA9vIQAjdgYBlx5L1rNMMP6tkcSGdrWS7VeHCWzkLlSfxivgJXE9Zfn7SynOUbEmmgiDo0osFrewTeC2peYg9RKxWCw5g3T3AkKl9ucZYHN7k478sVSmo8BO9v2CQ54cKhi27z9uJZSOBMp18YP5F1EsZy5pAGBBjvg0u6vXwEQquFA0neTdaM4FHsna4AOrCqUVv4xhu4DfqZWvbFjVoRKwT5vULiE5p1OStMcqD5MCbdgwFC0TLledCDsDNinn5YPCVQGRIREHnUyB1H9lSmNdgZgTVypFo6DsXxvrwoV51cz43mntLYx5EdO10tbtmQJs6pMEJaMZBw40WLcWz1u9CYsad0JWrkI61yrhppdqUbfYxsHmsqUyQDhaXabHkNCrXtbhVFYbd7h6hbpjLYiFzB1RT1hz76HYwt9Uz2FvQvF0GFhjONZvboC8C2znCzJiUXzR2xAl5q0WUhojap2Znq9oKODotLXZFs7qYh988LqsswS4Te2xA1xcXLhliYv5tQEfhYrYaYO5dNhILUi35flfh3UaukVJMzgzgRtkuWj4414o0jWbqRjecToTgeMWiBg82xaf4WcvyxeLLCNPiFphpT1Fw6kRUG4yVp50cylz0POvWtTf',0),(3616,0,'config','config_compression','0',0),(3617,0,'config','config_mail_regexp','/^[^@]+@.*.[a-z]{2,15}$/i',0),(96,0,'free_checkout','free_checkout_status','1',0),(97,0,'free_checkout','free_checkout_order_status_id','1',0),(3642,0,'config','config_address','',0),(2403,0,'sub_total','sub_total_status','1',0),(2405,0,'wholesale','wholesale_status','1',0),(2408,0,'total','total_sort_order','2',0),(2407,0,'total','total_status','1',0),(105,0,'free_checkout','free_checkout_sort_order','1',0),(106,0,'cod','cod_sort_order','5',0),(107,0,'cod','cod_total','0.01',0),(108,0,'cod','cod_order_status_id','1',0),(109,0,'cod','cod_geo_zone_id','0',0),(110,0,'cod','cod_status','1',0),(3640,0,'config','config_name','ООО &quot;Ант-Снаб&quot;',0),(3641,0,'config','config_owner','Никита Гостев',0),(115,0,'flat','flat_sort_order','1',0),(116,0,'flat','flat_status','1',0),(117,0,'flat','flat_geo_zone_id','0',0),(118,0,'flat','flat_tax_class_id','9',0),(119,0,'flat','flat_cost','5.00',0),(2404,0,'sub_total','sub_total_sort_order','0',0),(124,0,'category','category_status','1',0),(558,0,'account','account_status','1',0),(126,0,'affiliate','affiliate_status','1',0),(2432,0,'theme_default','theme_default_image_location_height','50',0),(2431,0,'theme_default','theme_default_image_location_width','268',0),(2430,0,'theme_default','theme_default_image_cart_height','95',0),(2429,0,'theme_default','theme_default_image_cart_width','95',0),(2428,0,'theme_default','theme_default_image_wishlist_height','47',0),(2427,0,'theme_default','theme_default_image_wishlist_width','47',0),(2426,0,'theme_default','theme_default_image_compare_height','90',0),(2425,0,'theme_default','theme_default_image_compare_width','90',0),(2424,0,'theme_default','theme_default_image_related_height','140',0),(2423,0,'theme_default','theme_default_image_related_width','140',0),(2422,0,'theme_default','theme_default_image_additional_height','75',0),(2421,0,'theme_default','theme_default_image_additional_width','88',0),(2420,0,'theme_default','theme_default_image_product_height','228',0),(2419,0,'theme_default','theme_default_image_product_width','228',0),(2418,0,'theme_default','theme_default_image_popup_height','500',0),(151,0,'dashboard_activity','dashboard_activity_status','1',0),(152,0,'dashboard_activity','dashboard_activity_sort_order','7',0),(153,0,'dashboard_sale','dashboard_sale_status','1',0),(154,0,'dashboard_sale','dashboard_sale_width','3',0),(155,0,'dashboard_chart','dashboard_chart_status','1',0),(156,0,'dashboard_chart','dashboard_chart_width','6',0),(157,0,'dashboard_customer','dashboard_customer_status','1',0),(158,0,'dashboard_customer','dashboard_customer_width','3',0),(159,0,'dashboard_map','dashboard_map_status','1',0),(160,0,'dashboard_map','dashboard_map_width','6',0),(161,0,'dashboard_online','dashboard_online_status','1',0),(162,0,'dashboard_online','dashboard_online_width','3',0),(163,0,'dashboard_order','dashboard_order_sort_order','1',0),(164,0,'dashboard_order','dashboard_order_status','1',0),(165,0,'dashboard_order','dashboard_order_width','3',0),(166,0,'dashboard_sale','dashboard_sale_sort_order','2',0),(167,0,'dashboard_customer','dashboard_customer_sort_order','3',0),(168,0,'dashboard_online','dashboard_online_sort_order','4',0),(169,0,'dashboard_map','dashboard_map_sort_order','5',0),(170,0,'dashboard_chart','dashboard_chart_sort_order','6',0),(171,0,'dashboard_recent','dashboard_recent_status','1',0),(172,0,'dashboard_recent','dashboard_recent_sort_order','8',0),(173,0,'dashboard_activity','dashboard_activity_width','4',0),(174,0,'dashboard_recent','dashboard_recent_width','8',0),(3611,0,'config','config_seo_url_type','seo_pro',0),(3610,0,'config','config_seo_url','1',0),(3609,0,'config','config_maintenance','0',0),(3608,0,'config','config_alert_email','',0),(3607,0,'config','config_mail_alert','[\"order\"]',1),(3606,0,'config','config_mail_smtp_timeout','5',0),(3605,0,'config','config_mail_smtp_port','25',0),(3604,0,'config','config_mail_smtp_password','google44',0),(3603,0,'config','config_mail_smtp_username','lapsergei',0),(3602,0,'config','config_mail_smtp_hostname','smtp.yandex.ru',0),(3601,0,'config','config_mail_parameter','',0),(2415,0,'theme_default','theme_default_image_thumb_width','364',0),(2417,0,'theme_default','theme_default_image_popup_width','500',0),(2416,0,'theme_default','theme_default_image_thumb_height','334',0),(3600,0,'config','config_mail_protocol','smtp',0),(3599,0,'config','config_ftp_status','0',0),(3598,0,'config','config_ftp_root','/some',0),(3597,0,'config','config_ftp_password','pswd',0),(3596,0,'config','config_ftp_username','login',0),(3594,0,'config','config_ftp_hostname','ant-snab',0),(3595,0,'config','config_ftp_port','21',0),(3591,0,'config','config_captcha_page','[\"review\",\"return\",\"contact\"]',1),(3592,0,'config','config_logo','catalog/antsnab/site/logo.png',0),(3593,0,'config','config_icon','catalog/antsnab/site/icons/favicon-16x16.png',0),(3590,0,'config','config_captcha','google_captcha',0),(3588,0,'config','config_return_id','0',0),(3589,0,'config','config_return_status_id','2',0),(3587,0,'config','config_affiliate_id','4',0),(3586,0,'config','config_affiliate_commission','5',0),(3585,0,'config','config_affiliate_auto','0',0),(3584,0,'config','config_affiliate_approval','0',0),(3583,0,'config','config_stock_checkout','0',0),(3582,0,'config','config_stock_warning','0',0),(3581,0,'config','config_stock_display','0',0),(3580,0,'config','config_api_id','1',0),(3579,0,'config','config_fraud_status_id','2',0),(2414,0,'theme_default','theme_default_image_category_height','200',0),(1472,0,'menu_editor','menu_editor_entries','[{\"position\":\"0\",\"href\":\"\\/\",\"names\":{\"1\":\"\\u0413\\u043b\\u0430\\u0432\\u043d\\u0430\\u044f\"},\"target\":\"_self\"},{\"position\":\"0\",\"href\":\"index.php?route=information\\/information&amp;information_id=4\",\"names\":{\"1\":\"\\u041e \\u043a\\u043e\\u043c\\u043f\\u0430\\u043d\\u0438\\u0438\"},\"target\":\"_self\"},{\"position\":\"0\",\"href\":\"index.php?route=product\\/price\",\"names\":{\"1\":\"\\u041f\\u0440\\u0430\\u0439\\u0441-\\u043b\\u0438\\u0441\\u0442\"},\"target\":\"_self\"},{\"position\":\"0\",\"href\":\"index.php?route=newsblog\\/category&amp;newsblog_path=2\",\"names\":{\"1\":\"\\u0421\\u0442\\u0430\\u0442\\u044c\\u0438\"},\"target\":\"_self\"},{\"position\":\"0\",\"href\":\"index.php?route=information\\/review\",\"names\":{\"1\":\"\\u041e\\u0442\\u0437\\u044b\\u0432\\u044b\"},\"target\":\"_self\"},{\"position\":\"0\",\"href\":\"index.php?route=information\\/information&amp;information_id=6\",\"names\":{\"1\":\"\\u041e\\u043f\\u043b\\u0430\\u0442\\u0430 \\u0438 \\u0434\\u043e\\u0441\\u0442\\u0430\\u0432\\u043a\\u0430\"},\"target\":\"_self\"},{\"position\":\"0\",\"href\":\"index.php?route=information\\/contact\",\"names\":{\"1\":\"\\u041a\\u043e\\u043d\\u0442\\u0430\\u043a\\u0442\\u044b\"},\"target\":\"_self\"}]',1),(3577,0,'config','config_processing_status','[\"2\",\"3\",\"1\",\"12\",\"5\"]',1),(3578,0,'config','config_complete_status','[\"3\",\"5\"]',1),(3576,0,'config','config_order_status_id','1',0),(3575,0,'config','config_checkout_id','5',0),(3574,0,'config','config_checkout_guest','1',0),(3573,0,'config','config_cart_weight','1',0),(3572,0,'config','config_invoice_prefix','INV-2013-00',0),(3571,0,'config','config_account_id','3',0),(3570,0,'config','config_login_attempts','5',0),(3569,0,'config','config_customer_price','0',0),(3568,0,'config','config_customer_group_display','[\"1\"]',1),(3567,0,'config','config_customer_group_id','1',0),(3566,0,'config','config_customer_search','1',0),(3565,0,'config','config_customer_activity','0',0),(3564,0,'config','config_customer_online','0',0),(3563,0,'config','config_tax_customer','shipping',0),(3562,0,'config','config_tax_default','shipping',0),(3561,0,'config','config_tax','1',0),(3560,0,'config','config_voucher_max','1000',0),(3559,0,'config','config_voucher_min','1',0),(3558,0,'config','config_review_guest','1',0),(3557,0,'config','config_review_status','1',0),(3556,0,'config','config_product_mpn_hide','1',0),(3555,0,'config','config_product_isbn_hide','1',0),(3554,0,'config','config_product_jan_hide','1',0),(3553,0,'config','config_product_ean_hide','1',0),(3552,0,'config','config_product_upc_hide','1',0),(3551,0,'config','config_limit_admin','6',0),(3550,0,'config','config_product_count','0',0),(3549,0,'config','config_weight_class_id','1',0),(3548,0,'config','config_length_class_id','1',0),(3547,0,'config','config_currency_auto','1',0),(3546,0,'config','config_currency','RUB',0),(3545,0,'config','config_admin_language','ru-ru',0),(3544,0,'config','config_language','ru-ru',0),(3543,0,'config','config_zone_id','2761',0),(3542,0,'config','config_country_id','176',0),(3541,0,'config','config_location','[\"1\",\"2\"]',1),(3540,0,'config','config_image','catalog/antsnab/site/logo.png',0),(3538,0,'config','config_telephone','+7 (495) 255-01-37',0),(3539,0,'config','config_fax','8 (800) 775-28-31',0),(3537,0,'config','config_email','lapsergei@yandex.ru',0),(3533,0,'config','config_langdata','{\"1\":{\"meta_title\":\"\\u0410\\u043d\\u0442-\\u0421\\u043d\\u0430\\u0431 \\u2013 \\u0438\\u043d\\u0442\\u0435\\u0440\\u043d\\u0435\\u0442-\\u043c\\u0430\\u0433\\u0430\\u0437\\u0438\\u043d \\u0441\\u0442\\u0440\\u043e\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u044b\\u0445 \\u0438 \\u043e\\u0442\\u0434\\u0435\\u043b\\u043e\\u0447\\u043d\\u044b\\u0445 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u043e\\u0432 \\u0441 \\u0434\\u043e\\u0441\\u0442\\u0430\\u0432\\u043a\\u043e\\u0439 \\u0432 \\u041c\\u043e\\u0441\\u043a\\u0432\\u0435\",\"meta_description\":\"\\u0418\\u043d\\u0442\\u0435\\u0440\\u043d\\u0435\\u0442-\\u043c\\u0430\\u0433\\u0430\\u0437\\u0438\\u043d \\u0441\\u0442\\u0440\\u043e\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u044b\\u0445 \\u0438 \\u043e\\u0442\\u0434\\u0435\\u043b\\u043e\\u0447\\u043d\\u044b\\u0445 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u043e\\u0432 \\u0432 \\u041c\\u043e\\u0441\\u043a\\u0432\\u0435. \\u0421\\u043e\\u0431\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0435 \\u0441\\u043a\\u043b\\u0430\\u0434\\u044b, \\u0431\\u044b\\u0441\\u0442\\u0440\\u0430\\u044f \\u0434\\u043e\\u0441\\u0442\\u0430\\u0432\\u043a\\u0430, \\u0448\\u0438\\u0440\\u043e\\u043a\\u0438\\u0439 \\u0430\\u0441\\u0441\\u043e\\u0440\\u0442\\u0438\\u043c\\u0435\\u043d\\u0442 \\u0438 \\u0434\\u043e\\u0441\\u0442\\u0443\\u043f\\u043d\\u044b\\u0435 \\u0446\\u0435\\u043d\\u044b.\",\"meta_keyword\":\"\\u0418\\u043d\\u0442\\u0435\\u0440\\u043d\\u0435\\u0442, \\u043c\\u0430\\u0433\\u0430\\u0437\\u0438\\u043d, \\u043e\\u043d\\u043b\\u0430\\u0439\\u043d, \\u043e\\u0444\\u0444\\u043b\\u0430\\u0439\\u043d, \\u0441\\u0442\\u0440\\u043e\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u044b\\u0435, \\u043e\\u0442\\u0434\\u0435\\u043b\\u043e\\u0447\\u043d\\u044b\\u0435, \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u044b, \\u0441\\u0442\\u0440\\u043e\\u0439\\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u044b, \\u043a\\u0443\\u043f\\u0438\\u0442\\u044c, \\u0446\\u0435\\u043d\\u0430, \\u0441 \\u0434\\u043e\\u0441\\u0442\\u0430\\u0432\\u043a\\u043e\\u0439, \\u041c\\u043e\\u0441\\u043a\\u0432\\u0430, \\u043e\\u043f\\u0442, \\u0440\\u043e\\u0437\\u043d\\u0438\\u0446\\u0430, \\u0441\\u0430\\u043c\\u043e\\u0432\\u044b\\u0432\\u043e\\u0437, \\u0410\\u043d\\u0442-\\u0421\\u043d\\u0430\\u0431, \\u0422\\u041a, \\u041e\\u041e\\u041e\",\"name\":\"\\u041e\\u041e\\u041e &quot;\\u0410\\u043d\\u0442-\\u0421\\u043d\\u0430\\u0431&quot;\",\"owner\":\"\\u041d\\u0438\\u043a\\u0438\\u0442\\u0430 \\u0413\\u043e\\u0441\\u0442\\u0435\\u0432\",\"address\":\"127566, \\u0433. \\u041c\\u043e\\u0441\\u043a\\u0432\\u0430, \\u0412\\u044b\\u0441\\u043e\\u043a\\u043e\\u0432\\u043e\\u043b\\u044c\\u0442\\u043d\\u044b\\u0439\\r\\n\\u043f\\u0440\\u043e\\u0435\\u0437\\u0434, \\u0434\\u043e\\u043c 1, \\u0441\\u0442\\u0440. 43\",\"open\":\"\\u041f\\u043d-\\u041f\\u0442: \\u0441 8.30 \\u0434\\u043e 18.30\\r\\n\\u0421\\u0431: \\u0441 12.00 \\u0434\\u043e 18.00\",\"comment\":\"\"}}',1),(3536,0,'config','config_geocode','55.873657, 37.592222',0),(2021,0,'review','review_visible','2',0),(2020,0,'review','review_count','4',0),(2019,0,'review','review_status','1',0),(1471,0,'menu_editor','menu_editor_enabled','1',0),(1093,0,'google_captcha','google_captcha_key','6Lf3WFAUAAAAAOpZAYRIERdMkiuMjZ4K50B9f_2A',0),(1094,0,'google_captcha','google_captcha_secret','6Lf3WFAUAAAAAOavkysIuMx66VmUm5439ZgVxI4g',0),(1095,0,'google_captcha','google_captcha_status','1',0),(3534,0,'config','config_theme','theme_default',0),(3535,0,'config','config_layout_id','1',0),(2413,0,'theme_default','theme_default_image_category_width','160',0),(2412,0,'theme_default','theme_default_product_description_length','100',0),(2411,0,'theme_default','theme_default_product_limit','15',0),(2410,0,'theme_default','theme_default_status','1',0),(2409,0,'theme_default','theme_default_directory','app',0);
/*!40000 ALTER TABLE `oc_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_stock_status`
--

DROP TABLE IF EXISTS `oc_stock_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_stock_status` (
  `stock_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`stock_status_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_stock_status`
--

LOCK TABLES `oc_stock_status` WRITE;
/*!40000 ALTER TABLE `oc_stock_status` DISABLE KEYS */;
INSERT INTO `oc_stock_status` VALUES (7,1,'В наличии'),(8,1,'Предзаказ'),(5,1,'Нет в наличии'),(6,1,'Ожидание 2-3 дня');
/*!40000 ALTER TABLE `oc_stock_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_store`
--

DROP TABLE IF EXISTS `oc_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_store` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `url` varchar(255) NOT NULL,
  `ssl` varchar(255) NOT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_store`
--

LOCK TABLES `oc_store` WRITE;
/*!40000 ALTER TABLE `oc_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_tax_class`
--

DROP TABLE IF EXISTS `oc_tax_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_tax_class` (
  `tax_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`tax_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_tax_class`
--

LOCK TABLES `oc_tax_class` WRITE;
/*!40000 ALTER TABLE `oc_tax_class` DISABLE KEYS */;
INSERT INTO `oc_tax_class` VALUES (9,'Налоги','Облагаемые налогом','2009-01-06 23:21:53','2011-03-09 21:17:10'),(10,'Цифровые товары','Цифровые','2011-09-21 22:19:39','2011-09-22 10:27:36');
/*!40000 ALTER TABLE `oc_tax_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_tax_rate`
--

DROP TABLE IF EXISTS `oc_tax_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_tax_rate` (
  `tax_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_zone_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL,
  `rate` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `type` char(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`tax_rate_id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_tax_rate`
--

LOCK TABLES `oc_tax_rate` WRITE;
/*!40000 ALTER TABLE `oc_tax_rate` DISABLE KEYS */;
INSERT INTO `oc_tax_rate` VALUES (86,3,'НДС (20%)',20.0000,'P','2011-03-09 21:17:10','2011-09-22 22:24:29'),(87,3,'Экологический налог (-2.00)',2.0000,'F','2011-09-21 21:49:23','2011-09-23 00:40:19');
/*!40000 ALTER TABLE `oc_tax_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_tax_rate_to_customer_group`
--

DROP TABLE IF EXISTS `oc_tax_rate_to_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_tax_rate_to_customer_group` (
  `tax_rate_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  PRIMARY KEY (`tax_rate_id`,`customer_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_tax_rate_to_customer_group`
--

LOCK TABLES `oc_tax_rate_to_customer_group` WRITE;
/*!40000 ALTER TABLE `oc_tax_rate_to_customer_group` DISABLE KEYS */;
INSERT INTO `oc_tax_rate_to_customer_group` VALUES (86,1),(87,1);
/*!40000 ALTER TABLE `oc_tax_rate_to_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_tax_rule`
--

DROP TABLE IF EXISTS `oc_tax_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_tax_rule` (
  `tax_rule_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_class_id` int(11) NOT NULL,
  `tax_rate_id` int(11) NOT NULL,
  `based` varchar(10) NOT NULL,
  `priority` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`tax_rule_id`)
) ENGINE=MyISAM AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_tax_rule`
--

LOCK TABLES `oc_tax_rule` WRITE;
/*!40000 ALTER TABLE `oc_tax_rule` DISABLE KEYS */;
INSERT INTO `oc_tax_rule` VALUES (121,10,86,'payment',1),(120,10,87,'store',0),(128,9,86,'shipping',1),(127,9,87,'shipping',2);
/*!40000 ALTER TABLE `oc_tax_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_theme`
--

DROP TABLE IF EXISTS `oc_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_theme` (
  `theme_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL,
  `theme` varchar(64) NOT NULL,
  `route` varchar(64) NOT NULL,
  `code` text NOT NULL,
  PRIMARY KEY (`theme_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_theme`
--

LOCK TABLES `oc_theme` WRITE;
/*!40000 ALTER TABLE `oc_theme` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_translation`
--

DROP TABLE IF EXISTS `oc_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_translation` (
  `translation_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `route` varchar(64) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`translation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_translation`
--

LOCK TABLES `oc_translation` WRITE;
/*!40000 ALTER TABLE `oc_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_upload`
--

DROP TABLE IF EXISTS `oc_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_upload` (
  `upload_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`upload_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_upload`
--

LOCK TABLES `oc_upload` WRITE;
/*!40000 ALTER TABLE `oc_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_url_alias`
--

DROP TABLE IF EXISTS `oc_url_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_url_alias` (
  `url_alias_id` int(11) NOT NULL AUTO_INCREMENT,
  `query` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`url_alias_id`),
  KEY `query` (`query`),
  KEY `keyword` (`keyword`)
) ENGINE=MyISAM AUTO_INCREMENT=1203 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_url_alias`
--

LOCK TABLES `oc_url_alias` WRITE;
/*!40000 ALTER TABLE `oc_url_alias` DISABLE KEYS */;
INSERT INTO `oc_url_alias` VALUES (601,'account/voucher','vouchers'),(602,'account/wishlist','wishlist'),(603,'account/account','my-account'),(604,'checkout/cart','cart'),(605,'checkout/checkout','checkout'),(606,'account/login','login'),(607,'account/logout','logout'),(608,'account/order','order-history'),(609,'account/newsletter','newsletter'),(610,'product/special','specials'),(611,'affiliate/account','affiliates'),(612,'checkout/voucher','gift-vouchers'),(613,'product/manufacturer','brands'),(614,'information/contact','contact-us'),(615,'account/return/insert','request-return'),(616,'information/sitemap','sitemap'),(617,'account/forgotten','forgot-password'),(618,'account/download','downloads'),(619,'account/return','returns'),(620,'account/transaction','transactions'),(621,'account/register','create-account'),(622,'product/compare','compare-products'),(623,'product/search','search'),(624,'account/edit','edit-account'),(625,'account/password','change-password'),(626,'account/address','address-book'),(627,'account/reward','reward-points'),(628,'affiliate/edit','edit-affiliate-account'),(629,'affiliate/password','change-affiliate-password'),(630,'affiliate/payment','affiliate-payment-options'),(631,'affiliate/tracking','affiliate-tracking-code'),(632,'affiliate/transaction','affiliate-transactions'),(633,'affiliate/logout','affiliate-logout'),(634,'affiliate/forgotten','affiliate-forgot-password'),(635,'affiliate/register','create-affiliate-account'),(636,'affiliate/login','affiliate-login'),(637,'account/return/add','add-return'),(638,'common/home',''),(1049,'manufacturer_id=8','apple'),(971,'information_id=4','about'),(1110,'category_id=71','products'),(828,'manufacturer_id=9','canon'),(829,'manufacturer_id=5','htc'),(830,'manufacturer_id=7','hewlett-packard'),(831,'manufacturer_id=6','palm'),(832,'manufacturer_id=10','sony'),(927,'information_id=6','dostavka_i_oplata'),(929,'information_id=3','privacy'),(911,'information_id=5','terms'),(1108,'category_id=0','root'),(979,'newsblog_category_id=1','news'),(948,'newsblog_category_id=2','articles'),(885,'newsblog_article_id=1','fiks-all-klassik-i-fiks-all-fleksi-v-chem-raznica'),(884,'newsblog_article_id=2','ognestojkaya-montazhnaya-pena'),(871,'newsblog_article_id=3',''),(887,'newsblog_article_id=4','fiks-all-klassik-i-fiks-all-fleksi-v-chem-raznitsa-4'),(969,'newsblog_article_id=5','5ognestoykaya-montagnaya-pena-chto-eto-takoe-i-zachem-ona-nugna'),(970,'newsblog_article_id=6','6ognestoykaya-montagnaya-pena-chto-eto-takoe-i-zachem-ona-nugna'),(886,'newsblog_article_id=7','fiks-all-klassik-i-fiks-all-fleksi-v-chem-raznitsa'),(876,'newsblog_article_id=8',''),(962,'newsblog_article_id=14','14fiks-all-klassik-i-fiks-all-fleksi-v-chem-raznitsa'),(952,'newsblog_article_id=15','nebolshoj-test-mastiki-pruf-ot-goshi-peskova'),(890,'newsblog_article_id=16','povyshenie-cen-na-pergamin-s-19032018'),(891,'newsblog_article_id=17',''),(892,'newsblog_article_id=18',''),(893,'newsblog_article_id=19',''),(895,'newsblog_article_id=20',''),(925,'newsblog_article_id=21','povishenie-tsen-na-pergamin-s-19032018'),(945,'newsblog_article_id=22','chto-takoe-pergamin'),(953,'newsblog_article_id=23','nebolshoj-test-mastiki-pruf-ot-goshi-peskova-23'),(956,'newsblog_category_id=3','common_articles'),(967,'newsblog_category_id=4','sealants'),(963,'newsblog_article_id=9','9ognestoykaya-montagnaya-pena-chto-eto-takoe-i-zachem-ona-nugna'),(966,'newsblog_article_id=13','13fiks-all-klassik-i-fiks-all-fleksi-v-chem-raznitsa'),(964,'newsblog_article_id=11','11ognestoykaya-montagnaya-pena-chto-eto-takoe-i-zachem-ona-nugna'),(965,'newsblog_article_id=12','12ognestoykaya-montagnaya-pena-chto-eto-takoe-i-zachem-ona-nugna'),(972,'newsblog_article_id=10','10ognestoykaya-montagnaya-pena-chto-eto-takoe-i-zachem-ona-nugna'),(1113,'category_id=73','roll'),(1114,'category_id=74','mastics'),(1115,'category_id=75','sealants'),(1116,'category_id=76','geo'),(1117,'category_id=77','fanera'),(1118,'category_id=78','osb-3'),(1119,'category_id=79','orgalit'),(1120,'category_id=80','instrumenty'),(1121,'category_id=81','teplonositeli'),(1122,'category_id=82','kraski'),(1123,'category_id=83','smesi'),(1124,'category_id=84','metizy'),(1125,'category_id=85','orgkrovlya'),(1126,'category_id=86','krz'),(1127,'category_id=87','tehnonicol'),(1128,'category_id=88','ruberoid'),(1129,'category_id=89','pergamin'),(1130,'category_id=90','hot'),(1131,'category_id=91','bitum'),(1132,'category_id=92','cold'),(1133,'category_id=93','praimers'),(1134,'category_id=94','montajnye-peny'),(1135,'category_id=95','klei'),(1136,'category_id=96','germetiki'),(1137,'category_id=97','planter'),(1138,'category_id=98','geotekstil'),(1139,'category_id=99','fk'),(1140,'category_id=100','fsf'),(1141,'category_id=101','laminirovannaya'),(1142,'category_id=102','talion'),(1143,'category_id=103','ts'),(1144,'category_id=104','etilenglikol'),(1145,'category_id=105','propilenglikol'),(1146,'category_id=106','pf-115'),(1147,'category_id=107','dlya-mastiki'),(1148,'category_id=108','dlya-germetikov'),(1149,'category_id=109','dlya-montajnoi-peny'),(1150,'category_id=110','malyarnyi'),(1151,'category_id=111','rastvoriteli'),(1152,'category_id=112','rashodniki'),(1153,'category_id=113','shtukaturki'),(1154,'category_id=114','shpatlevki'),(1155,'category_id=115','universalnye'),(1156,'category_id=116','kladochnye'),(1157,'category_id=117','dlya-pola'),(1158,'category_id=118','plitochnyi-klei'),(1159,'category_id=119','obmazochnaya-gidroizolyaciya'),(1160,'category_id=120','samorezy'),(1161,'category_id=121','dubel-gvozdi'),(1162,'category_id=122','krepej-dlya-izolyacii'),(1163,'category_id=123','stekloizol'),(1164,'category_id=124','steklokrom'),(1165,'category_id=125','steklofleks'),(1166,'category_id=126','elastobit'),(1167,'category_id=127','stekloelast'),(1168,'category_id=128','rubiteks'),(1169,'category_id=129','elastoizol-premium'),(1170,'category_id=130','elastoizol-biznes'),(1171,'category_id=131','elastoizol-prof'),(1172,'category_id=132','elastoizol-standart'),(1173,'category_id=133','elastoizol-optim'),(1174,'category_id=134','gidrostekloizol'),(1175,'category_id=135','steklomast'),(1176,'category_id=136','gidrobarier'),(1177,'category_id=137','gidroizol'),(1178,'category_id=138','rubemast'),(1179,'category_id=139','tehnoelast'),(1180,'category_id=140','uniflex'),(1181,'category_id=141','bipol'),(1182,'category_id=142','linokrom'),(1183,'category_id=143','bikrost'),(1184,'category_id=144','tehnoelast-akustik'),(1185,'category_id=145','stekloizol-r'),(1186,'category_id=146','butilenovye'),(1187,'category_id=147','krovlya'),(1188,'category_id=148','tiokolovye'),(1189,'category_id=149','ms-polymer'),(1190,'category_id=150','poliuretanovye'),(1191,'category_id=151','silikonovye'),(1192,'category_id=152','akrilovye'),(1193,'category_id=153','butilkauchukovye'),(1194,'category_id=154','termo'),(1195,'category_id=155','bytovye'),(1196,'category_id=156','professionalnye'),(1197,'category_id=157','ognestoikie'),(1198,'category_id=158','zimnie'),(1199,'category_id=159','ochistiteli'),(1200,'category_id=160','jidkie-gvozdi'),(1201,'category_id=161','himicheskie-ankery'),(1202,'category_id=162','klei-pena');
/*!40000 ALTER TABLE `oc_url_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user`
--

DROP TABLE IF EXISTS `oc_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_group_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `image` varchar(255) NOT NULL,
  `code` varchar(40) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user`
--

LOCK TABLES `oc_user` WRITE;
/*!40000 ALTER TABLE `oc_user` DISABLE KEYS */;
INSERT INTO `oc_user` VALUES (1,1,'admin','d1b6589fabe6a4320f8d1f44151cf39c4089e7e2','knADZTTU7','Никита','Гостев','wslapshin@gmail.com','catalog/antsnab/site/logo.png','','127.0.0.1',1,'2018-02-25 21:06:06');
/*!40000 ALTER TABLE `oc_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user_group`
--

DROP TABLE IF EXISTS `oc_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_user_group` (
  `user_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `permission` text NOT NULL,
  PRIMARY KEY (`user_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user_group`
--

LOCK TABLES `oc_user_group` WRITE;
/*!40000 ALTER TABLE `oc_user_group` DISABLE KEYS */;
INSERT INTO `oc_user_group` VALUES (1,'Administrator','{\"access\":[\"catalog\\/attribute\",\"catalog\\/attribute_group\",\"catalog\\/category\",\"catalog\\/download\",\"catalog\\/filter\",\"catalog\\/information\",\"catalog\\/manufacturer\",\"catalog\\/option\",\"catalog\\/product\",\"catalog\\/recurring\",\"catalog\\/review\",\"common\\/column_left\",\"common\\/filemanager\",\"customer\\/custom_field\",\"customer\\/customer\",\"customer\\/customer_group\",\"design\\/banner\",\"design\\/language\",\"design\\/layout\",\"design\\/menu\",\"design\\/theme\",\"design\\/translation\",\"event\\/compatibility\",\"event\\/theme\",\"extension\\/analytics\\/google_analytics\",\"extension\\/captcha\\/basic_captcha\",\"extension\\/captcha\\/google_captcha\",\"extension\\/dashboard\\/activity\",\"extension\\/dashboard\\/chart\",\"extension\\/dashboard\\/customer\",\"extension\\/dashboard\\/map\",\"extension\\/dashboard\\/online\",\"extension\\/dashboard\\/order\",\"extension\\/dashboard\\/recent\",\"extension\\/dashboard\\/sale\",\"extension\\/event\",\"extension\\/extension\",\"extension\\/extension\\/analytics\",\"extension\\/extension\\/captcha\",\"extension\\/extension\\/dashboard\",\"extension\\/extension\\/feed\",\"extension\\/extension\\/fraud\",\"extension\\/extension\\/module\",\"extension\\/extension\\/payment\",\"extension\\/extension\\/shipping\",\"extension\\/extension\\/theme\",\"extension\\/extension\\/total\",\"extension\\/feed\\/google_base\",\"extension\\/feed\\/google_sitemap\",\"extension\\/feed\\/openbaypro\",\"extension\\/feed\\/unisender\",\"extension\\/fraud\\/fraudlabspro\",\"extension\\/fraud\\/ip\",\"extension\\/fraud\\/maxmind\",\"extension\\/installer\",\"extension\\/modification\",\"extension\\/module\\/account\",\"extension\\/module\\/affiliate\",\"extension\\/module\\/amazon_login\",\"extension\\/module\\/amazon_pay\",\"extension\\/module\\/banner\",\"extension\\/module\\/bestseller\",\"extension\\/module\\/carousel\",\"extension\\/module\\/category\",\"extension\\/module\\/d_admin_menu\",\"extension\\/module\\/divido_calculator\",\"extension\\/module\\/ebay_listing\",\"extension\\/module\\/featured\",\"extension\\/module\\/filter\",\"extension\\/module\\/google_hangouts\",\"extension\\/module\\/html\",\"extension\\/module\\/information\",\"extension\\/module\\/klarna_checkout_module\",\"extension\\/module\\/latest\",\"extension\\/module\\/laybuy_layout\",\"extension\\/module\\/menu_editor\",\"extension\\/module\\/newsblog_articles\",\"extension\\/module\\/pilibaba_button\",\"extension\\/module\\/pp_button\",\"extension\\/module\\/pp_login\",\"extension\\/module\\/prodproperties\",\"extension\\/module\\/prodtabs\",\"extension\\/module\\/produnits\",\"extension\\/module\\/review\",\"extension\\/module\\/sagepay_direct_cards\",\"extension\\/module\\/sagepay_server_cards\",\"extension\\/module\\/slideshow\",\"extension\\/module\\/special\",\"extension\\/module\\/store\",\"extension\\/openbay\",\"extension\\/openbay\\/amazon\",\"extension\\/openbay\\/amazon_listing\",\"extension\\/openbay\\/amazon_product\",\"extension\\/openbay\\/amazonus\",\"extension\\/openbay\\/amazonus_listing\",\"extension\\/openbay\\/amazonus_product\",\"extension\\/openbay\\/ebay\",\"extension\\/openbay\\/ebay_profile\",\"extension\\/openbay\\/ebay_template\",\"extension\\/openbay\\/etsy\",\"extension\\/openbay\\/etsy_product\",\"extension\\/openbay\\/etsy_shipping\",\"extension\\/openbay\\/etsy_shop\",\"extension\\/openbay\\/fba\",\"extension\\/payment\\/amazon_login_pay\",\"extension\\/payment\\/authorizenet_aim\",\"extension\\/payment\\/authorizenet_sim\",\"extension\\/payment\\/bank_transfer\",\"extension\\/payment\\/bluepay_hosted\",\"extension\\/payment\\/bluepay_redirect\",\"extension\\/payment\\/cardconnect\",\"extension\\/payment\\/cardinity\",\"extension\\/payment\\/cheque\",\"extension\\/payment\\/cod\",\"extension\\/payment\\/divido\",\"extension\\/payment\\/eway\",\"extension\\/payment\\/firstdata\",\"extension\\/payment\\/firstdata_remote\",\"extension\\/payment\\/free_checkout\",\"extension\\/payment\\/g2apay\",\"extension\\/payment\\/globalpay\",\"extension\\/payment\\/globalpay_remote\",\"extension\\/payment\\/klarna_account\",\"extension\\/payment\\/klarna_checkout\",\"extension\\/payment\\/klarna_invoice\",\"extension\\/payment\\/laybuy\",\"extension\\/payment\\/liqpay\",\"extension\\/payment\\/nochex\",\"extension\\/payment\\/ocstore_payeer\",\"extension\\/payment\\/ocstore_w1\",\"extension\\/payment\\/ocstore_yk\",\"extension\\/payment\\/ocstore_yk_company_AB\",\"extension\\/payment\\/ocstore_yk_company_AC\",\"extension\\/payment\\/ocstore_yk_company_EP\",\"extension\\/payment\\/ocstore_yk_company_GP\",\"extension\\/payment\\/ocstore_yk_company_MA\",\"extension\\/payment\\/ocstore_yk_company_MC\",\"extension\\/payment\\/ocstore_yk_company_MP\",\"extension\\/payment\\/ocstore_yk_company_PB\",\"extension\\/payment\\/ocstore_yk_company_PC\",\"extension\\/payment\\/ocstore_yk_company_QW\",\"extension\\/payment\\/ocstore_yk_company_SB\",\"extension\\/payment\\/ocstore_yk_company_WM\",\"extension\\/payment\\/ocstore_yk_physical_AC\",\"extension\\/payment\\/ocstore_yk_physical_PC\",\"extension\\/payment\\/paymate\",\"extension\\/payment\\/paypoint\",\"extension\\/payment\\/payza\",\"extension\\/payment\\/perpetual_payments\",\"extension\\/payment\\/pilibaba\",\"extension\\/payment\\/pp_express\",\"extension\\/payment\\/pp_payflow\",\"extension\\/payment\\/pp_payflow_iframe\",\"extension\\/payment\\/pp_pro\",\"extension\\/payment\\/pp_pro_iframe\",\"extension\\/payment\\/pp_standard\",\"extension\\/payment\\/qiwi_rest\",\"extension\\/payment\\/realex\",\"extension\\/payment\\/realex_remote\",\"extension\\/payment\\/sagepay_direct\",\"extension\\/payment\\/sagepay_server\",\"extension\\/payment\\/sagepay_us\",\"extension\\/payment\\/sberbank_transfer\",\"extension\\/payment\\/securetrading_pp\",\"extension\\/payment\\/securetrading_ws\",\"extension\\/payment\\/skrill\",\"extension\\/payment\\/twocheckout\",\"extension\\/payment\\/web_payment_software\",\"extension\\/payment\\/webmoney_wmb\",\"extension\\/payment\\/webmoney_wme\",\"extension\\/payment\\/webmoney_wmk\",\"extension\\/payment\\/webmoney_wmr\",\"extension\\/payment\\/webmoney_wmu\",\"extension\\/payment\\/webmoney_wmz\",\"extension\\/payment\\/worldpay\",\"extension\\/shipping\\/auspost\",\"extension\\/shipping\\/by_total\",\"extension\\/shipping\\/citylink\",\"extension\\/shipping\\/fedex\",\"extension\\/shipping\\/flat\",\"extension\\/shipping\\/free\",\"extension\\/shipping\\/item\",\"extension\\/shipping\\/parcelforce_48\",\"extension\\/shipping\\/pickup\",\"extension\\/shipping\\/royal_mail\",\"extension\\/shipping\\/track_no\",\"extension\\/shipping\\/ups\",\"extension\\/shipping\\/usps\",\"extension\\/shipping\\/weight\",\"extension\\/store\",\"extension\\/theme\\/theme_default\",\"extension\\/total\\/coupon\",\"extension\\/total\\/credit\",\"extension\\/total\\/handling\",\"extension\\/total\\/klarna_fee\",\"extension\\/total\\/low_order_fee\",\"extension\\/total\\/reward\",\"extension\\/total\\/shipping\",\"extension\\/total\\/sub_total\",\"extension\\/total\\/tax\",\"extension\\/total\\/total\",\"extension\\/total\\/voucher\",\"localisation\\/country\",\"localisation\\/currency\",\"localisation\\/geo_zone\",\"localisation\\/language\",\"localisation\\/length_class\",\"localisation\\/location\",\"localisation\\/order_status\",\"localisation\\/return_action\",\"localisation\\/return_reason\",\"localisation\\/return_status\",\"localisation\\/stock_status\",\"localisation\\/tax_class\",\"localisation\\/tax_rate\",\"localisation\\/weight_class\",\"localisation\\/zone\",\"marketing\\/affiliate\",\"marketing\\/contact\",\"marketing\\/coupon\",\"marketing\\/marketing\",\"newsblog\\/article\",\"newsblog\\/category\",\"octeam\\/toolset\",\"octeam_tools\\/cache\",\"octeam_tools\\/seo_manager\",\"report\\/affiliate\",\"report\\/affiliate_activity\",\"report\\/affiliate_login\",\"report\\/customer_activity\",\"report\\/customer_credit\",\"report\\/customer_login\",\"report\\/customer_online\",\"report\\/customer_order\",\"report\\/customer_reward\",\"report\\/customer_search\",\"report\\/marketing\",\"report\\/product_purchased\",\"report\\/product_viewed\",\"report\\/sale_coupon\",\"report\\/sale_order\",\"report\\/sale_return\",\"report\\/sale_shipping\",\"report\\/sale_tax\",\"sale\\/order\",\"sale\\/recurring\",\"sale\\/return\",\"sale\\/voucher\",\"sale\\/voucher_theme\",\"setting\\/setting\",\"setting\\/store\",\"startup\\/compatibility\",\"startup\\/error\",\"startup\\/event\",\"startup\\/login\",\"startup\\/permission\",\"startup\\/router\",\"startup\\/sass\",\"startup\\/startup\",\"tool\\/backup\",\"tool\\/log\",\"tool\\/upload\",\"user\\/api\",\"user\\/user\",\"user\\/user_permission\",\"extension\\/module\\/prodproperties\",\"extension\\/module\\/prodtabs\",\"extension\\/total\\/wholesale\",\"extension\\/total\\/sub_total\"],\"modify\":[\"catalog\\/attribute\",\"catalog\\/attribute_group\",\"catalog\\/category\",\"catalog\\/download\",\"catalog\\/filter\",\"catalog\\/information\",\"catalog\\/manufacturer\",\"catalog\\/option\",\"catalog\\/product\",\"catalog\\/recurring\",\"catalog\\/review\",\"common\\/column_left\",\"common\\/filemanager\",\"customer\\/custom_field\",\"customer\\/customer\",\"customer\\/customer_group\",\"design\\/banner\",\"design\\/language\",\"design\\/layout\",\"design\\/menu\",\"design\\/theme\",\"design\\/translation\",\"event\\/compatibility\",\"event\\/theme\",\"extension\\/analytics\\/google_analytics\",\"extension\\/captcha\\/basic_captcha\",\"extension\\/captcha\\/google_captcha\",\"extension\\/dashboard\\/activity\",\"extension\\/dashboard\\/chart\",\"extension\\/dashboard\\/customer\",\"extension\\/dashboard\\/map\",\"extension\\/dashboard\\/online\",\"extension\\/dashboard\\/order\",\"extension\\/dashboard\\/recent\",\"extension\\/dashboard\\/sale\",\"extension\\/event\",\"extension\\/extension\",\"extension\\/extension\\/analytics\",\"extension\\/extension\\/captcha\",\"extension\\/extension\\/dashboard\",\"extension\\/extension\\/feed\",\"extension\\/extension\\/fraud\",\"extension\\/extension\\/module\",\"extension\\/extension\\/payment\",\"extension\\/extension\\/shipping\",\"extension\\/extension\\/theme\",\"extension\\/extension\\/total\",\"extension\\/feed\\/google_base\",\"extension\\/feed\\/google_sitemap\",\"extension\\/feed\\/openbaypro\",\"extension\\/feed\\/unisender\",\"extension\\/fraud\\/fraudlabspro\",\"extension\\/fraud\\/ip\",\"extension\\/fraud\\/maxmind\",\"extension\\/installer\",\"extension\\/modification\",\"extension\\/module\\/account\",\"extension\\/module\\/affiliate\",\"extension\\/module\\/amazon_login\",\"extension\\/module\\/amazon_pay\",\"extension\\/module\\/banner\",\"extension\\/module\\/bestseller\",\"extension\\/module\\/carousel\",\"extension\\/module\\/category\",\"extension\\/module\\/d_admin_menu\",\"extension\\/module\\/divido_calculator\",\"extension\\/module\\/ebay_listing\",\"extension\\/module\\/featured\",\"extension\\/module\\/filter\",\"extension\\/module\\/google_hangouts\",\"extension\\/module\\/html\",\"extension\\/module\\/information\",\"extension\\/module\\/klarna_checkout_module\",\"extension\\/module\\/latest\",\"extension\\/module\\/laybuy_layout\",\"extension\\/module\\/menu_editor\",\"extension\\/module\\/newsblog_articles\",\"extension\\/module\\/pilibaba_button\",\"extension\\/module\\/pp_button\",\"extension\\/module\\/pp_login\",\"extension\\/module\\/prodproperties\",\"extension\\/module\\/prodtabs\",\"extension\\/module\\/produnits\",\"extension\\/module\\/review\",\"extension\\/module\\/sagepay_direct_cards\",\"extension\\/module\\/sagepay_server_cards\",\"extension\\/module\\/slideshow\",\"extension\\/module\\/special\",\"extension\\/module\\/store\",\"extension\\/openbay\",\"extension\\/openbay\\/amazon\",\"extension\\/openbay\\/amazon_listing\",\"extension\\/openbay\\/amazon_product\",\"extension\\/openbay\\/amazonus\",\"extension\\/openbay\\/amazonus_listing\",\"extension\\/openbay\\/amazonus_product\",\"extension\\/openbay\\/ebay\",\"extension\\/openbay\\/ebay_profile\",\"extension\\/openbay\\/ebay_template\",\"extension\\/openbay\\/etsy\",\"extension\\/openbay\\/etsy_product\",\"extension\\/openbay\\/etsy_shipping\",\"extension\\/openbay\\/etsy_shop\",\"extension\\/openbay\\/fba\",\"extension\\/payment\\/amazon_login_pay\",\"extension\\/payment\\/authorizenet_aim\",\"extension\\/payment\\/authorizenet_sim\",\"extension\\/payment\\/bank_transfer\",\"extension\\/payment\\/bluepay_hosted\",\"extension\\/payment\\/bluepay_redirect\",\"extension\\/payment\\/cardconnect\",\"extension\\/payment\\/cardinity\",\"extension\\/payment\\/cheque\",\"extension\\/payment\\/cod\",\"extension\\/payment\\/divido\",\"extension\\/payment\\/eway\",\"extension\\/payment\\/firstdata\",\"extension\\/payment\\/firstdata_remote\",\"extension\\/payment\\/free_checkout\",\"extension\\/payment\\/g2apay\",\"extension\\/payment\\/globalpay\",\"extension\\/payment\\/globalpay_remote\",\"extension\\/payment\\/klarna_account\",\"extension\\/payment\\/klarna_checkout\",\"extension\\/payment\\/klarna_invoice\",\"extension\\/payment\\/laybuy\",\"extension\\/payment\\/liqpay\",\"extension\\/payment\\/nochex\",\"extension\\/payment\\/ocstore_payeer\",\"extension\\/payment\\/ocstore_w1\",\"extension\\/payment\\/ocstore_yk\",\"extension\\/payment\\/ocstore_yk_company_AB\",\"extension\\/payment\\/ocstore_yk_company_AC\",\"extension\\/payment\\/ocstore_yk_company_EP\",\"extension\\/payment\\/ocstore_yk_company_GP\",\"extension\\/payment\\/ocstore_yk_company_MA\",\"extension\\/payment\\/ocstore_yk_company_MC\",\"extension\\/payment\\/ocstore_yk_company_MP\",\"extension\\/payment\\/ocstore_yk_company_PB\",\"extension\\/payment\\/ocstore_yk_company_PC\",\"extension\\/payment\\/ocstore_yk_company_QW\",\"extension\\/payment\\/ocstore_yk_company_SB\",\"extension\\/payment\\/ocstore_yk_company_WM\",\"extension\\/payment\\/ocstore_yk_physical_AC\",\"extension\\/payment\\/ocstore_yk_physical_PC\",\"extension\\/payment\\/paymate\",\"extension\\/payment\\/paypoint\",\"extension\\/payment\\/payza\",\"extension\\/payment\\/perpetual_payments\",\"extension\\/payment\\/pilibaba\",\"extension\\/payment\\/pp_express\",\"extension\\/payment\\/pp_payflow\",\"extension\\/payment\\/pp_payflow_iframe\",\"extension\\/payment\\/pp_pro\",\"extension\\/payment\\/pp_pro_iframe\",\"extension\\/payment\\/pp_standard\",\"extension\\/payment\\/qiwi_rest\",\"extension\\/payment\\/realex\",\"extension\\/payment\\/realex_remote\",\"extension\\/payment\\/sagepay_direct\",\"extension\\/payment\\/sagepay_server\",\"extension\\/payment\\/sagepay_us\",\"extension\\/payment\\/sberbank_transfer\",\"extension\\/payment\\/securetrading_pp\",\"extension\\/payment\\/securetrading_ws\",\"extension\\/payment\\/skrill\",\"extension\\/payment\\/twocheckout\",\"extension\\/payment\\/web_payment_software\",\"extension\\/payment\\/webmoney_wmb\",\"extension\\/payment\\/webmoney_wme\",\"extension\\/payment\\/webmoney_wmk\",\"extension\\/payment\\/webmoney_wmr\",\"extension\\/payment\\/webmoney_wmu\",\"extension\\/payment\\/webmoney_wmz\",\"extension\\/payment\\/worldpay\",\"extension\\/shipping\\/auspost\",\"extension\\/shipping\\/by_total\",\"extension\\/shipping\\/citylink\",\"extension\\/shipping\\/fedex\",\"extension\\/shipping\\/flat\",\"extension\\/shipping\\/free\",\"extension\\/shipping\\/item\",\"extension\\/shipping\\/parcelforce_48\",\"extension\\/shipping\\/pickup\",\"extension\\/shipping\\/royal_mail\",\"extension\\/shipping\\/track_no\",\"extension\\/shipping\\/ups\",\"extension\\/shipping\\/usps\",\"extension\\/shipping\\/weight\",\"extension\\/store\",\"extension\\/theme\\/theme_default\",\"extension\\/total\\/coupon\",\"extension\\/total\\/credit\",\"extension\\/total\\/handling\",\"extension\\/total\\/klarna_fee\",\"extension\\/total\\/low_order_fee\",\"extension\\/total\\/reward\",\"extension\\/total\\/shipping\",\"extension\\/total\\/sub_total\",\"extension\\/total\\/tax\",\"extension\\/total\\/total\",\"extension\\/total\\/voucher\",\"localisation\\/country\",\"localisation\\/currency\",\"localisation\\/geo_zone\",\"localisation\\/language\",\"localisation\\/length_class\",\"localisation\\/location\",\"localisation\\/order_status\",\"localisation\\/return_action\",\"localisation\\/return_reason\",\"localisation\\/return_status\",\"localisation\\/stock_status\",\"localisation\\/tax_class\",\"localisation\\/tax_rate\",\"localisation\\/weight_class\",\"localisation\\/zone\",\"marketing\\/affiliate\",\"marketing\\/contact\",\"marketing\\/coupon\",\"marketing\\/marketing\",\"newsblog\\/article\",\"newsblog\\/category\",\"octeam\\/toolset\",\"octeam_tools\\/cache\",\"octeam_tools\\/seo_manager\",\"report\\/affiliate\",\"report\\/affiliate_activity\",\"report\\/affiliate_login\",\"report\\/customer_activity\",\"report\\/customer_credit\",\"report\\/customer_login\",\"report\\/customer_online\",\"report\\/customer_order\",\"report\\/customer_reward\",\"report\\/customer_search\",\"report\\/marketing\",\"report\\/product_purchased\",\"report\\/product_viewed\",\"report\\/sale_coupon\",\"report\\/sale_order\",\"report\\/sale_return\",\"report\\/sale_shipping\",\"report\\/sale_tax\",\"sale\\/order\",\"sale\\/recurring\",\"sale\\/return\",\"sale\\/voucher\",\"sale\\/voucher_theme\",\"setting\\/setting\",\"setting\\/store\",\"startup\\/compatibility\",\"startup\\/error\",\"startup\\/event\",\"startup\\/login\",\"startup\\/permission\",\"startup\\/router\",\"startup\\/sass\",\"startup\\/startup\",\"tool\\/backup\",\"tool\\/log\",\"tool\\/upload\",\"user\\/api\",\"user\\/user\",\"user\\/user_permission\",\"extension\\/module\\/prodproperties\",\"extension\\/module\\/prodtabs\",\"extension\\/total\\/wholesale\",\"extension\\/total\\/sub_total\"],\"hiden\":[\"extension\\/module\\/amazon_login\",\"extension\\/module\\/amazon_pay\",\"extension\\/module\\/divido_calculator\",\"extension\\/module\\/ebay_listing\",\"extension\\/module\\/klarna_checkout_module\",\"extension\\/module\\/laybuy_layout\",\"extension\\/module\\/pilibaba_button\",\"extension\\/module\\/pp_button\",\"extension\\/module\\/pp_login\",\"extension\\/module\\/sagepay_direct_cards\",\"extension\\/module\\/sagepay_server_cards\",\"extension\\/payment\\/amazon_login_pay\",\"extension\\/payment\\/authorizenet_aim\",\"extension\\/payment\\/authorizenet_sim\",\"extension\\/payment\\/bluepay_hosted\",\"extension\\/payment\\/bluepay_redirect\",\"extension\\/payment\\/cardconnect\",\"extension\\/payment\\/cardinity\",\"extension\\/payment\\/cheque\",\"extension\\/payment\\/divido\",\"extension\\/payment\\/eway\",\"extension\\/payment\\/firstdata\",\"extension\\/payment\\/firstdata_remote\",\"extension\\/payment\\/g2apay\",\"extension\\/payment\\/globalpay\",\"extension\\/payment\\/globalpay_remote\",\"extension\\/payment\\/klarna_account\",\"extension\\/payment\\/klarna_checkout\",\"extension\\/payment\\/klarna_invoice\",\"extension\\/payment\\/laybuy\",\"extension\\/payment\\/nochex\",\"extension\\/payment\\/ocstore_yk_company_AB\",\"extension\\/payment\\/ocstore_yk_company_AC\",\"extension\\/payment\\/ocstore_yk_company_EP\",\"extension\\/payment\\/ocstore_yk_company_GP\",\"extension\\/payment\\/ocstore_yk_company_MA\",\"extension\\/payment\\/ocstore_yk_company_MC\",\"extension\\/payment\\/ocstore_yk_company_MP\",\"extension\\/payment\\/ocstore_yk_company_PB\",\"extension\\/payment\\/ocstore_yk_company_PC\",\"extension\\/payment\\/ocstore_yk_company_QW\",\"extension\\/payment\\/ocstore_yk_company_SB\",\"extension\\/payment\\/ocstore_yk_company_WM\",\"extension\\/payment\\/ocstore_yk_physical_AC\",\"extension\\/payment\\/ocstore_yk_physical_PC\",\"extension\\/payment\\/paymate\",\"extension\\/payment\\/paypoint\",\"extension\\/payment\\/payza\",\"extension\\/payment\\/perpetual_payments\",\"extension\\/payment\\/pilibaba\",\"extension\\/payment\\/pp_express\",\"extension\\/payment\\/pp_payflow\",\"extension\\/payment\\/pp_payflow_iframe\",\"extension\\/payment\\/pp_pro\",\"extension\\/payment\\/pp_pro_iframe\",\"extension\\/payment\\/realex\",\"extension\\/payment\\/realex_remote\",\"extension\\/payment\\/sagepay_direct\",\"extension\\/payment\\/sagepay_server\",\"extension\\/payment\\/sagepay_us\",\"extension\\/payment\\/securetrading_pp\",\"extension\\/payment\\/securetrading_ws\",\"extension\\/payment\\/skrill\",\"extension\\/payment\\/twocheckout\",\"extension\\/payment\\/web_payment_software\",\"extension\\/payment\\/worldpay\",\"extension\\/shipping\\/auspost\",\"extension\\/shipping\\/fedex\",\"extension\\/shipping\\/royal_mail\",\"extension\\/shipping\\/ups\",\"extension\\/shipping\\/usps\"]}'),(10,'Demonstration','');
/*!40000 ALTER TABLE `oc_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_voucher`
--

DROP TABLE IF EXISTS `oc_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_voucher` (
  `voucher_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `from_name` varchar(64) NOT NULL,
  `from_email` varchar(96) NOT NULL,
  `to_name` varchar(64) NOT NULL,
  `to_email` varchar(96) NOT NULL,
  `voucher_theme_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`voucher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_voucher`
--

LOCK TABLES `oc_voucher` WRITE;
/*!40000 ALTER TABLE `oc_voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_voucher_history`
--

DROP TABLE IF EXISTS `oc_voucher_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_voucher_history` (
  `voucher_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `voucher_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`voucher_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_voucher_history`
--

LOCK TABLES `oc_voucher_history` WRITE;
/*!40000 ALTER TABLE `oc_voucher_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_voucher_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_voucher_theme`
--

DROP TABLE IF EXISTS `oc_voucher_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_voucher_theme` (
  `voucher_theme_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`voucher_theme_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_voucher_theme`
--

LOCK TABLES `oc_voucher_theme` WRITE;
/*!40000 ALTER TABLE `oc_voucher_theme` DISABLE KEYS */;
INSERT INTO `oc_voucher_theme` VALUES (8,'catalog/demo/canon_eos_5d_2.jpg'),(7,'catalog/demo/gift-voucher-birthday.jpg'),(6,'catalog/demo/apple_logo.jpg');
/*!40000 ALTER TABLE `oc_voucher_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_voucher_theme_description`
--

DROP TABLE IF EXISTS `oc_voucher_theme_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_voucher_theme_description` (
  `voucher_theme_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`voucher_theme_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_voucher_theme_description`
--

LOCK TABLES `oc_voucher_theme_description` WRITE;
/*!40000 ALTER TABLE `oc_voucher_theme_description` DISABLE KEYS */;
INSERT INTO `oc_voucher_theme_description` VALUES (6,1,'Рождество'),(7,1,'День рождения'),(8,1,'Основной');
/*!40000 ALTER TABLE `oc_voucher_theme_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_weight_class`
--

DROP TABLE IF EXISTS `oc_weight_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_weight_class` (
  `weight_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`weight_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_weight_class`
--

LOCK TABLES `oc_weight_class` WRITE;
/*!40000 ALTER TABLE `oc_weight_class` DISABLE KEYS */;
INSERT INTO `oc_weight_class` VALUES (1,1.00),(2,1000.00),(5,2.20),(6,35.27);
/*!40000 ALTER TABLE `oc_weight_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_weight_class_description`
--

DROP TABLE IF EXISTS `oc_weight_class_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_weight_class_description` (
  `weight_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `unit` varchar(4) NOT NULL,
  PRIMARY KEY (`weight_class_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_weight_class_description`
--

LOCK TABLES `oc_weight_class_description` WRITE;
/*!40000 ALTER TABLE `oc_weight_class_description` DISABLE KEYS */;
INSERT INTO `oc_weight_class_description` VALUES (1,1,'Килограммы','кг'),(2,1,'Граммы','г');
/*!40000 ALTER TABLE `oc_weight_class_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_zone`
--

DROP TABLE IF EXISTS `oc_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_zone` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `code` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4236 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_zone`
--

LOCK TABLES `oc_zone` WRITE;
/*!40000 ALTER TABLE `oc_zone` DISABLE KEYS */;
INSERT INTO `oc_zone` VALUES (1,1,'Бадахшан','BDS',1),(2,1,'Бадгис','BDG',1),(3,1,'Баглан','BGL',1),(4,1,'Балх','BAL',1),(5,1,'Бамиан','BAM',1),(6,1,'Фарах','FRA',1),(7,1,'Фарьяб','FYB',1),(8,1,'Газни','GHA',1),(9,1,'Гор','GHO',1),(10,1,'Гильменд','HEL',1),(11,1,'Герат','HER',1),(12,1,'Джаузджан','JOW',1),(13,1,'Кабул','KAB',1),(14,1,'Кандагар','KAN',1),(15,1,'Каписа','KAP',1),(16,1,'Хост','KHO',1),(17,1,'Кунар','KNR',1),(18,1,'Кундуз','KDZ',1),(19,1,'Лагман','LAG',1),(20,1,'Логар','LOW',1),(21,1,'Нангархар','NAN',1),(22,1,'Нимроз','NIM',1),(23,1,'Нуристан','NUR',1),(24,1,'Урузган','ORU',1),(25,1,'Пактия','PIA',1),(26,1,'Пактика','PKA',1),(27,1,'Парван','PAR',1),(28,1,'Саманган','SAM',1),(29,1,'Сари-Пуль','SAR',1),(30,1,'Тахар','TAK',1),(31,1,'Вардак','WAR',1),(32,1,'Забуль','ZAB',1),(33,2,'Берат','BR',1),(34,2,'Булькиза','BU',1),(35,2,'Дельвина','DL',1),(36,2,'Девол','DV',1),(37,2,'Дибра','DI',1),(38,2,'Дуррес','DR',1),(39,2,'Эльбасан','EL',1),(40,2,'Колёня','ER',1),(41,2,'Фиери','FR',1),(42,2,'Гирокастра','GJ',1),(43,2,'Грамши','GR',1),(44,2,'Хас','HA',1),(45,2,'Кавая','KA',1),(46,2,'Курбин','KB',1),(47,2,'Кучова','KC',1),(48,2,'Корча','KO',1),(49,2,'Круя','KR',1),(50,2,'Кукес','KU',1),(51,2,'Либражди','LB',1),(52,2,'Лежа','LE',1),(53,2,'Люшня','LU',1),(54,2,'Мальси-э-Мади','MM',1),(55,2,'Малакастра','MK',1),(56,2,'Мати','MT',1),(57,2,'Мирдита','MR',1),(58,2,'Пекини','PQ',1),(59,2,'Пермети','PR',1),(60,2,'Поградец','PG',1),(61,2,'Пука','PU',1),(62,2,'Шкодер','SH',1),(63,2,'Скрапари','SK',1),(64,2,'Саранда','SR',1),(65,2,'Тепелена','TE',1),(66,2,'Тропоя','TP',1),(67,2,'Тирана','TR',1),(68,2,'Влёра','VL',1),(69,3,'Адрар','ADR',1),(70,3,'Айн-Дефла','ADE',1),(71,3,'Айн-Темухент','ATE',1),(72,3,'Алжир','ALG',1),(73,3,'Аннаба','ANN',1),(74,3,'Батна','BAT',1),(75,3,'Бешар','BEC',1),(76,3,'Беджая','BEJ',1),(77,3,'Бискра','BIS',1),(78,3,'Блида','BLI',1),(79,3,'Бордж-Бу-Арреридж','BBA',1),(80,3,'Буйра','BOA',1),(81,3,'Бумердес','BMD',1),(82,3,'Шлеф','CHL',1),(83,3,'Константина','CON',1),(84,3,'Джельфа','DJE',1),(85,3,'Эль-Баяд','EBA',1),(86,3,'Эль-Уэд','EOU',1),(87,3,'Эль-Тарф','ETA',1),(88,3,'Гардая','GHA',1),(89,3,'Гуэльма','GUE',1),(90,3,'Иллизи','ILL',1),(91,3,'Джиджель','JIJ',1),(92,3,'Хеншела','KHE',1),(93,3,'Лагуат','LAG',1),(94,3,'Маскара','MUA',1),(95,3,'Медеа','MED',1),(96,3,'Мила','MIL',1),(97,3,'Мостаганем','MOS',1),(98,3,'Мсила','MSI',1),(99,3,'Наама','NAA',1),(100,3,'Оран','ORA',1),(101,3,'Уаргла','OUA',1),(102,3,'Ум Эль-Буахи','OEB',1),(103,3,'Релизан','REL',1),(104,3,'Саида','SAI',1),(105,3,'Сетиф','SET',1),(106,3,'Сиди-Бель-Аббес','SBA',1),(107,3,'Скикда','SKI',1),(108,3,'Сук-Ахрас','SAH',1),(109,3,'Таменрассет','TAM',1),(110,3,'Тебесса','TEB',1),(111,3,'Тиарет','TIA',1),(112,3,'Тиндуф','TIN',1),(113,3,'Типаза','TIP',1),(114,3,'Тиссемсилт','TIS',1),(115,3,'Тизи-Узу','TOU',1),(116,3,'Тлемсен','TLE',1),(117,4,'Восточный округ','E',1),(118,4,'Мануа','M',1),(119,4,'Остров Роз','R',1),(120,4,'Остров Суэйнс','S',1),(121,4,'Западный округ','W',1),(122,5,'Андорра-ла-Велья','ALV',1),(123,5,'Канильо','CAN',1),(124,5,'Энкамп','ENC',1),(125,5,'Эскальдес-Энгордань','ESE',1),(126,5,'Ла-Массана','LMA',1),(127,5,'Ордино','ORD',1),(128,5,'Сант-Жулия-де-Лория','SJL',1),(129,6,'Бенго','BGO',1),(130,6,'Бенгела','BGU',1),(131,6,'Бие','BIE',1),(132,6,'Кабинда','CAB',1),(133,6,'Квандо-Кубанго','CCU',1),(134,6,'Северная Кванза','CNO',1),(135,6,'Южная Кванза','CUS',1),(136,6,'Кунене','CNN',1),(137,6,'Уамбо','HUA',1),(138,6,'Уила','HUI',1),(139,6,'Луанда','LUA',1),(140,6,'Северная Лунда','LNO',1),(141,6,'Южная Лунда','LSU',1),(142,6,'Маланже','MAL',1),(143,6,'Мошико','MOX',1),(144,6,'Намибе','NAM',1),(145,6,'Уиже','UIG',1),(146,6,'Заире','ZAI',1),(147,9,'Сент-Джордж','ASG',1),(148,9,'Сент-Джон','ASJ',1),(149,9,'Сент-Мери','ASM',1),(150,9,'Сент-Пол','ASL',1),(151,9,'Сент-Петер','ASR',1),(152,9,'Сент-Филип','ASH',1),(153,9,'Барбуда','BAR',1),(154,9,'Редонда','RED',1),(155,10,'Антарктида и острова Южной Атлантики','AN',1),(156,10,'Буэнос-Айрес','BA',1),(157,10,'Катамарка','CA',1),(158,10,'Чако','CH',1),(159,10,'Чубут','CU',1),(160,10,'Кордова','CO',1),(161,10,'Корриентес','CR',1),(162,10,'Федеральный округ','DF',1),(163,10,'Энтре-Риос','ER',1),(164,10,'Формоса','FO',1),(165,10,'Жужуй','JU',1),(166,10,'Ла-Пампа','LP',1),(167,10,'Ла-Риоха','LR',1),(168,10,'Мендоса','ME',1),(169,10,'Мисьонес','MI',1),(170,10,'Неукен','NE',1),(171,10,'Рио-Негро','RN',1),(172,10,'Сальта','SA',1),(173,10,'Сан-Хуан','SJ',1),(174,10,'Сан-Луис','SL',1),(175,10,'Санта-Крус','SC',1),(176,10,'Санта-Фе','SF',1),(177,10,'Сантьяго-дель-Эстеро','SD',1),(178,10,'Тьерра-дель-Фуэго','TF',1),(179,10,'Тукуман','TU',1),(180,11,'Арагацотн','AGT',1),(181,11,'Арарат','ARR',1),(182,11,'Армавир','ARM',1),(183,11,'Гегаркуник','GEG',1),(184,11,'Котайк','KOT',1),(185,11,'Лори','LOR',1),(186,11,'Ширак','SHI',1),(187,11,'Сюник','SYU',1),(188,11,'Тавуш','TAV',1),(189,11,'Вайоц Дзор','VAY',1),(190,11,'Ереван','YER',1),(191,13,'Австралийская столичная территория','ACT',1),(192,13,'Новый Южный Уэльс','NSW',1),(193,13,'Северная территория','NT',1),(194,13,'Квинсленд','QLD',1),(195,13,'Южная Австралия','SA',1),(196,13,'Тасмания','TAS',1),(197,13,'Виктория','VIC',1),(198,13,'Западная Австралия','WA',1),(199,14,'Бургенланд','BUR',1),(200,14,'Каринтия','KAR',1),(201,14,'Нижняя Австрия','NOS',1),(202,14,'Верхняя Австрия','OOS',1),(203,14,'Зальцбург','SAL',1),(204,14,'Штирия','STE',1),(205,14,'Тироль','TIR',1),(206,14,'Форарльберг','VOR',1),(207,14,'Вена','WIE',1),(208,15,'Ali Bayramli','AB',1),(209,15,'Abseron','ABS',1),(210,15,'AgcabAdi','AGC',1),(211,15,'Agdam','AGM',1),(212,15,'Agdas','AGS',1),(213,15,'Agstafa','AGA',1),(214,15,'Agsu','AGU',1),(215,15,'Astara','AST',1),(216,15,'Baki','BA',1),(217,15,'BabAk','BAB',1),(218,15,'BalakAn','BAL',1),(219,15,'BArdA','BAR',1),(220,15,'Beylaqan','BEY',1),(221,15,'Bilasuvar','BIL',1),(222,15,'Cabrayil','CAB',1),(223,15,'Calilabab','CAL',1),(224,15,'Culfa','CUL',1),(225,15,'Daskasan','DAS',1),(226,15,'Davaci','DAV',1),(227,15,'Fuzuli','FUZ',1),(228,15,'Ganca','GA',1),(229,15,'Gadabay','GAD',1),(230,15,'Goranboy','GOR',1),(231,15,'Goycay','GOY',1),(232,15,'Haciqabul','HAC',1),(233,15,'Imisli','IMI',1),(234,15,'Ismayilli','ISM',1),(235,15,'Kalbacar','KAL',1),(236,15,'Kurdamir','KUR',1),(237,15,'Lankaran','LA',1),(238,15,'Lacin','LAC',1),(239,15,'Lankaran','LAN',1),(240,15,'Lerik','LER',1),(241,15,'Masalli','MAS',1),(242,15,'Mingacevir','MI',1),(243,15,'Naftalan','NA',1),(244,15,'Neftcala','NEF',1),(245,15,'Oguz','OGU',1),(246,15,'Ordubad','ORD',1),(247,15,'Qabala','QAB',1),(248,15,'Qax','QAX',1),(249,15,'Qazax','QAZ',1),(250,15,'Qobustan','QOB',1),(251,15,'Quba','QBA',1),(252,15,'Qubadli','QBI',1),(253,15,'Qusar','QUS',1),(254,15,'Saki','SA',1),(255,15,'Saatli','SAT',1),(256,15,'Sabirabad','SAB',1),(257,15,'Sadarak','SAD',1),(258,15,'Sahbuz','SAH',1),(259,15,'Saki','SAK',1),(260,15,'Salyan','SAL',1),(261,15,'Sumqayit','SM',1),(262,15,'Samaxi','SMI',1),(263,15,'Samkir','SKR',1),(264,15,'Samux','SMX',1),(265,15,'Sarur','SAR',1),(266,15,'Siyazan','SIY',1),(267,15,'Susa','SS',1),(268,15,'Susa','SUS',1),(269,15,'Tartar','TAR',1),(270,15,'Tovuz','TOV',1),(271,15,'Ucar','UCA',1),(272,15,'Xankandi','XA',1),(273,15,'Xacmaz','XAC',1),(274,15,'Xanlar','XAN',1),(275,15,'Xizi','XIZ',1),(276,15,'Xocali','XCI',1),(277,15,'Xocavand','XVD',1),(278,15,'Yardimli','YAR',1),(279,15,'Yevlax','YEV',1),(280,15,'Zangilan','ZAN',1),(281,15,'Zaqatala','ZAQ',1),(282,15,'Zardab','ZAR',1),(283,15,'Naxcivan','NX',1),(284,16,'Acklins','ACK',1),(285,16,'Berry Islands','BER',1),(286,16,'Bimini','BIM',1),(287,16,'Black Point','BLK',1),(288,16,'Cat Island','CAT',1),(289,16,'Central Abaco','CAB',1),(290,16,'Central Andros','CAN',1),(291,16,'Central Eleuthera','CEL',1),(292,16,'City of Freeport','FRE',1),(293,16,'Crooked Island','CRO',1),(294,16,'East Grand Bahama','EGB',1),(295,16,'Exuma','EXU',1),(296,16,'Grand Cay','GRD',1),(297,16,'Harbour Island','HAR',1),(298,16,'Hope Town','HOP',1),(299,16,'Inagua','INA',1),(300,16,'Long Island','LNG',1),(301,16,'Mangrove Cay','MAN',1),(302,16,'Mayaguana','MAY',1),(303,16,'Moore\'s Island','MOO',1),(304,16,'North Abaco','NAB',1),(305,16,'North Andros','NAN',1),(306,16,'North Eleuthera','NEL',1),(307,16,'Ragged Island','RAG',1),(308,16,'Rum Cay','RUM',1),(309,16,'San Salvador','SAL',1),(310,16,'South Abaco','SAB',1),(311,16,'South Andros','SAN',1),(312,16,'South Eleuthera','SEL',1),(313,16,'Spanish Wells','SWE',1),(314,16,'West Grand Bahama','WGB',1),(315,17,'Capital','CAP',1),(316,17,'Central','CEN',1),(317,17,'Muharraq','MUH',1),(318,17,'Northern','NOR',1),(319,17,'Southern','SOU',1),(320,18,'Barisal','BAR',1),(321,18,'Chittagong','CHI',1),(322,18,'Dhaka','DHA',1),(323,18,'Khulna','KHU',1),(324,18,'Rajshahi','RAJ',1),(325,18,'Sylhet','SYL',1),(326,19,'Christ Church','CC',1),(327,19,'Saint Andrew','AND',1),(328,19,'Saint George','GEO',1),(329,19,'Saint James','JAM',1),(330,19,'Saint John','JOH',1),(331,19,'Saint Joseph','JOS',1),(332,19,'Saint Lucy','LUC',1),(333,19,'Saint Michael','MIC',1),(334,19,'Saint Peter','PET',1),(335,19,'Saint Philip','PHI',1),(336,19,'Saint Thomas','THO',1),(337,20,'Брест','BR',1),(338,20,'Гомель','HO',1),(339,20,'Минск','HM',1),(340,20,'Гродно','HR',1),(341,20,'Могилев','MA',1),(342,20,'Минская область','MI',1),(343,20,'Витебск','VI',1),(344,21,'Antwerpen','VAN',1),(345,21,'Brabant Wallon','WBR',1),(346,21,'Hainaut','WHT',1),(347,21,'Liege','WLG',1),(348,21,'Limburg','VLI',1),(349,21,'Luxembourg','WLX',1),(350,21,'Namur','WNA',1),(351,21,'Oost-Vlaanderen','VOV',1),(352,21,'Vlaams Brabant','VBR',1),(353,21,'West-Vlaanderen','VWV',1),(354,22,'Belize','BZ',1),(355,22,'Cayo','CY',1),(356,22,'Corozal','CR',1),(357,22,'Orange Walk','OW',1),(358,22,'Stann Creek','SC',1),(359,22,'Toledo','TO',1),(360,23,'Alibori','AL',1),(361,23,'Atakora','AK',1),(362,23,'Atlantique','AQ',1),(363,23,'Borgou','BO',1),(364,23,'Collines','CO',1),(365,23,'Donga','DO',1),(366,23,'Kouffo','KO',1),(367,23,'Littoral','LI',1),(368,23,'Mono','MO',1),(369,23,'Oueme','OU',1),(370,23,'Plateau','PL',1),(371,23,'Zou','ZO',1),(372,24,'Devonshire','DS',1),(373,24,'Hamilton City','HC',1),(374,24,'Hamilton','HA',1),(375,24,'Paget','PG',1),(376,24,'Pembroke','PB',1),(377,24,'Saint George City','GC',1),(378,24,'Saint George\'s','SG',1),(379,24,'Sandys','SA',1),(380,24,'Smith\'s','SM',1),(381,24,'Southampton','SH',1),(382,24,'Warwick','WA',1),(383,25,'Bumthang','BUM',1),(384,25,'Chukha','CHU',1),(385,25,'Dagana','DAG',1),(386,25,'Gasa','GAS',1),(387,25,'Haa','HAA',1),(388,25,'Lhuntse','LHU',1),(389,25,'Mongar','MON',1),(390,25,'Paro','PAR',1),(391,25,'Pemagatshel','PEM',1),(392,25,'Punakha','PUN',1),(393,25,'Samdrup Jongkhar','SJO',1),(394,25,'Samtse','SAT',1),(395,25,'Sarpang','SAR',1),(396,25,'Thimphu','THI',1),(397,25,'Trashigang','TRG',1),(398,25,'Trashiyangste','TRY',1),(399,25,'Trongsa','TRO',1),(400,25,'Tsirang','TSI',1),(401,25,'Wangdue Phodrang','WPH',1),(402,25,'Zhemgang','ZHE',1),(403,26,'Beni','BEN',1),(404,26,'Chuquisaca','CHU',1),(405,26,'Cochabamba','COC',1),(406,26,'La Paz','LPZ',1),(407,26,'Oruro','ORU',1),(408,26,'Pando','PAN',1),(409,26,'Potosi','POT',1),(410,26,'Santa Cruz','SCZ',1),(411,26,'Tarija','TAR',1),(412,27,'Brcko district','BRO',1),(413,27,'Unsko-Sanski Kanton','FUS',1),(414,27,'Posavski Kanton','FPO',1),(415,27,'Tuzlanski Kanton','FTU',1),(416,27,'Zenicko-Dobojski Kanton','FZE',1),(417,27,'Bosanskopodrinjski Kanton','FBP',1),(418,27,'Srednjebosanski Kanton','FSB',1),(419,27,'Hercegovacko-neretvanski Kanton','FHN',1),(420,27,'Zapadnohercegovacka Zupanija','FZH',1),(421,27,'Kanton Sarajevo','FSA',1),(422,27,'Zapadnobosanska','FZA',1),(423,27,'Banja Luka','SBL',1),(424,27,'Doboj','SDO',1),(425,27,'Bijeljina','SBI',1),(426,27,'Vlasenica','SVL',1),(427,27,'Sarajevo-Romanija or Sokolac','SSR',1),(428,27,'Foca','SFO',1),(429,27,'Trebinje','STR',1),(430,28,'Central','CE',1),(431,28,'Ghanzi','GH',1),(432,28,'Kgalagadi','KD',1),(433,28,'Kgatleng','KT',1),(434,28,'Kweneng','KW',1),(435,28,'Ngamiland','NG',1),(436,28,'North East','NE',1),(437,28,'North West','NW',1),(438,28,'South East','SE',1),(439,28,'Southern','SO',1),(440,30,'Acre','AC',1),(441,30,'Alagoas','AL',1),(442,30,'Amapa','AP',1),(443,30,'Amazonas','AM',1),(444,30,'Bahia','BA',1),(445,30,'Ceara','CE',1),(446,30,'Distrito Federal','DF',1),(447,30,'Espirito Santo','ES',1),(448,30,'Goias','GO',1),(449,30,'Maranhao','MA',1),(450,30,'Mato Grosso','MT',1),(451,30,'Mato Grosso do Sul','MS',1),(452,30,'Minas Gerais','MG',1),(453,30,'Para','PA',1),(454,30,'Paraiba','PB',1),(455,30,'Parana','PR',1),(456,30,'Pernambuco','PE',1),(457,30,'Piaui','PI',1),(458,30,'Rio de Janeiro','RJ',1),(459,30,'Rio Grande do Norte','RN',1),(460,30,'Rio Grande do Sul','RS',1),(461,30,'Rondonia','RO',1),(462,30,'Roraima','RR',1),(463,30,'Santa Catarina','SC',1),(464,30,'Sao Paulo','SP',1),(465,30,'Sergipe','SE',1),(466,30,'Tocantins','TO',1),(467,31,'Peros Banhos','PB',1),(468,31,'Salomon Islands','SI',1),(469,31,'Nelsons Island','NI',1),(470,31,'Three Brothers','TB',1),(471,31,'Eagle Islands','EA',1),(472,31,'Danger Island','DI',1),(473,31,'Egmont Islands','EG',1),(474,31,'Diego Garcia','DG',1),(475,32,'Belait','BEL',1),(476,32,'Brunei and Muara','BRM',1),(477,32,'Temburong','TEM',1),(478,32,'Tutong','TUT',1),(479,33,'Blagoevgrad','',1),(480,33,'Burgas','',1),(481,33,'Dobrich','',1),(482,33,'Gabrovo','',1),(483,33,'Haskovo','',1),(484,33,'Kardjali','',1),(485,33,'Kyustendil','',1),(486,33,'Lovech','',1),(487,33,'Montana','',1),(488,33,'Pazardjik','',1),(489,33,'Pernik','',1),(490,33,'Pleven','',1),(491,33,'Plovdiv','',1),(492,33,'Razgrad','',1),(493,33,'Shumen','',1),(494,33,'Silistra','',1),(495,33,'Sliven','',1),(496,33,'Smolyan','',1),(497,33,'Sofia','',1),(498,33,'Sofia - town','',1),(499,33,'Stara Zagora','',1),(500,33,'Targovishte','',1),(501,33,'Varna','',1),(502,33,'Veliko Tarnovo','',1),(503,33,'Vidin','',1),(504,33,'Vratza','',1),(505,33,'Yambol','',1),(506,34,'Bale','BAL',1),(507,34,'Bam','BAM',1),(508,34,'Banwa','BAN',1),(509,34,'Bazega','BAZ',1),(510,34,'Bougouriba','BOR',1),(511,34,'Boulgou','BLG',1),(512,34,'Boulkiemde','BOK',1),(513,34,'Comoe','COM',1),(514,34,'Ganzourgou','GAN',1),(515,34,'Gnagna','GNA',1),(516,34,'Gourma','GOU',1),(517,34,'Houet','HOU',1),(518,34,'Ioba','IOA',1),(519,34,'Kadiogo','KAD',1),(520,34,'Kenedougou','KEN',1),(521,34,'Komondjari','KOD',1),(522,34,'Kompienga','KOP',1),(523,34,'Kossi','KOS',1),(524,34,'Koulpelogo','KOL',1),(525,34,'Kouritenga','KOT',1),(526,34,'Kourweogo','KOW',1),(527,34,'Leraba','LER',1),(528,34,'Loroum','LOR',1),(529,34,'Mouhoun','MOU',1),(530,34,'Nahouri','NAH',1),(531,34,'Namentenga','NAM',1),(532,34,'Nayala','NAY',1),(533,34,'Noumbiel','NOU',1),(534,34,'Oubritenga','OUB',1),(535,34,'Oudalan','OUD',1),(536,34,'Passore','PAS',1),(537,34,'Poni','PON',1),(538,34,'Sanguie','SAG',1),(539,34,'Sanmatenga','SAM',1),(540,34,'Seno','SEN',1),(541,34,'Sissili','SIS',1),(542,34,'Soum','SOM',1),(543,34,'Sourou','SOR',1),(544,34,'Tapoa','TAP',1),(545,34,'Tuy','TUY',1),(546,34,'Yagha','YAG',1),(547,34,'Yatenga','YAT',1),(548,34,'Ziro','ZIR',1),(549,34,'Zondoma','ZOD',1),(550,34,'Zoundweogo','ZOW',1),(551,35,'Bubanza','BB',1),(552,35,'Bujumbura','BJ',1),(553,35,'Bururi','BR',1),(554,35,'Cankuzo','CA',1),(555,35,'Cibitoke','CI',1),(556,35,'Gitega','GI',1),(557,35,'Karuzi','KR',1),(558,35,'Kayanza','KY',1),(559,35,'Kirundo','KI',1),(560,35,'Makamba','MA',1),(561,35,'Muramvya','MU',1),(562,35,'Muyinga','MY',1),(563,35,'Mwaro','MW',1),(564,35,'Ngozi','NG',1),(565,35,'Rutana','RT',1),(566,35,'Ruyigi','RY',1),(567,36,'Phnom Penh','PP',1),(568,36,'Preah Seihanu (Kompong Som or Sihanoukville)','PS',1),(569,36,'Pailin','PA',1),(570,36,'Keb','KB',1),(571,36,'Banteay Meanchey','BM',1),(572,36,'Battambang','BA',1),(573,36,'Kampong Cham','KM',1),(574,36,'Kampong Chhnang','KN',1),(575,36,'Kampong Speu','KU',1),(576,36,'Kampong Som','KO',1),(577,36,'Kampong Thom','KT',1),(578,36,'Kampot','KP',1),(579,36,'Kandal','KL',1),(580,36,'Kaoh Kong','KK',1),(581,36,'Kratie','KR',1),(582,36,'Mondul Kiri','MK',1),(583,36,'Oddar Meancheay','OM',1),(584,36,'Pursat','PU',1),(585,36,'Preah Vihear','PR',1),(586,36,'Prey Veng','PG',1),(587,36,'Ratanak Kiri','RK',1),(588,36,'Siemreap','SI',1),(589,36,'Stung Treng','ST',1),(590,36,'Svay Rieng','SR',1),(591,36,'Takeo','TK',1),(592,37,'Adamawa (Adamaoua)','ADA',1),(593,37,'Centre','CEN',1),(594,37,'East (Est)','EST',1),(595,37,'Extreme North (Extreme-Nord)','EXN',1),(596,37,'Littoral','LIT',1),(597,37,'North (Nord)','NOR',1),(598,37,'Northwest (Nord-Ouest)','NOT',1),(599,37,'West (Ouest)','OUE',1),(600,37,'South (Sud)','SUD',1),(601,37,'Southwest (Sud-Ouest).','SOU',1),(602,38,'Alberta','AB',1),(603,38,'British Columbia','BC',1),(604,38,'Manitoba','MB',1),(605,38,'New Brunswick','NB',1),(606,38,'Newfoundland and Labrador','NL',1),(607,38,'Northwest Territories','NT',1),(608,38,'Nova Scotia','NS',1),(609,38,'Nunavut','NU',1),(610,38,'Ontario','ON',1),(611,38,'Prince Edward Island','PE',1),(612,38,'Qu&eacute;bec','QC',1),(613,38,'Saskatchewan','SK',1),(614,38,'Yukon Territory','YT',1),(615,39,'Boa Vista','BV',1),(616,39,'Brava','BR',1),(617,39,'Calheta de Sao Miguel','CS',1),(618,39,'Maio','MA',1),(619,39,'Mosteiros','MO',1),(620,39,'Paul','PA',1),(621,39,'Porto Novo','PN',1),(622,39,'Praia','PR',1),(623,39,'Ribeira Grande','RG',1),(624,39,'Sal','SL',1),(625,39,'Santa Catarina','CA',1),(626,39,'Santa Cruz','CR',1),(627,39,'Sao Domingos','SD',1),(628,39,'Sao Filipe','SF',1),(629,39,'Sao Nicolau','SN',1),(630,39,'Sao Vicente','SV',1),(631,39,'Tarrafal','TA',1),(632,40,'Creek','CR',1),(633,40,'Eastern','EA',1),(634,40,'Midland','ML',1),(635,40,'South Town','ST',1),(636,40,'Spot Bay','SP',1),(637,40,'Stake Bay','SK',1),(638,40,'West End','WD',1),(639,40,'Western','WN',1),(640,41,'Bamingui-Bangoran','BBA',1),(641,41,'Basse-Kotto','BKO',1),(642,41,'Haute-Kotto','HKO',1),(643,41,'Haut-Mbomou','HMB',1),(644,41,'Kemo','KEM',1),(645,41,'Lobaye','LOB',1),(646,41,'Mambere-KadeÔ','MKD',1),(647,41,'Mbomou','MBO',1),(648,41,'Nana-Mambere','NMM',1),(649,41,'Ombella-M\'Poko','OMP',1),(650,41,'Ouaka','OUK',1),(651,41,'Ouham','OUH',1),(652,41,'Ouham-Pende','OPE',1),(653,41,'Vakaga','VAK',1),(654,41,'Nana-Grebizi','NGR',1),(655,41,'Sangha-Mbaere','SMB',1),(656,41,'Bangui','BAN',1),(657,42,'Batha','BA',1),(658,42,'Biltine','BI',1),(659,42,'Borkou-Ennedi-Tibesti','BE',1),(660,42,'Chari-Baguirmi','CB',1),(661,42,'Guera','GU',1),(662,42,'Kanem','KA',1),(663,42,'Lac','LA',1),(664,42,'Logone Occidental','LC',1),(665,42,'Logone Oriental','LR',1),(666,42,'Mayo-Kebbi','MK',1),(667,42,'Moyen-Chari','MC',1),(668,42,'Ouaddai','OU',1),(669,42,'Salamat','SA',1),(670,42,'Tandjile','TA',1),(671,43,'Aisen del General Carlos Ibanez','AI',1),(672,43,'Antofagasta','AN',1),(673,43,'Araucania','AR',1),(674,43,'Atacama','AT',1),(675,43,'Bio-Bio','BI',1),(676,43,'Coquimbo','CO',1),(677,43,'Libertador General Bernardo O\'Hi','LI',1),(678,43,'Los Lagos','LL',1),(679,43,'Magallanes y de la Antartica Chi','MA',1),(680,43,'Maule','ML',1),(681,43,'Region Metropolitana','RM',1),(682,43,'Tarapaca','TA',1),(683,43,'Valparaiso','VS',1),(684,44,'Anhui','AN',1),(685,44,'Beijing','BE',1),(686,44,'Chongqing','CH',1),(687,44,'Fujian','FU',1),(688,44,'Gansu','GA',1),(689,44,'Guangdong','GU',1),(690,44,'Guangxi','GX',1),(691,44,'Guizhou','GZ',1),(692,44,'Hainan','HA',1),(693,44,'Hebei','HB',1),(694,44,'Heilongjiang','HL',1),(695,44,'Henan','HE',1),(696,44,'Hong Kong','HK',1),(697,44,'Hubei','HU',1),(698,44,'Hunan','HN',1),(699,44,'Inner Mongolia','IM',1),(700,44,'Jiangsu','JI',1),(701,44,'Jiangxi','JX',1),(702,44,'Jilin','JL',1),(703,44,'Liaoning','LI',1),(704,44,'Macau','MA',1),(705,44,'Ningxia','NI',1),(706,44,'Shaanxi','SH',1),(707,44,'Shandong','SA',1),(708,44,'Shanghai','SG',1),(709,44,'Shanxi','SX',1),(710,44,'Sichuan','SI',1),(711,44,'Tianjin','TI',1),(712,44,'Xinjiang','XI',1),(713,44,'Yunnan','YU',1),(714,44,'Zhejiang','ZH',1),(715,46,'Direction Island','D',1),(716,46,'Home Island','H',1),(717,46,'Horsburgh Island','O',1),(718,46,'South Island','S',1),(719,46,'West Island','W',1),(720,47,'Amazonas','AMZ',1),(721,47,'Antioquia','ANT',1),(722,47,'Arauca','ARA',1),(723,47,'Atlantico','ATL',1),(724,47,'Bogota D.C.','BDC',1),(725,47,'Bolivar','BOL',1),(726,47,'Boyaca','BOY',1),(727,47,'Caldas','CAL',1),(728,47,'Caqueta','CAQ',1),(729,47,'Casanare','CAS',1),(730,47,'Cauca','CAU',1),(731,47,'Cesar','CES',1),(732,47,'Choco','CHO',1),(733,47,'Cordoba','COR',1),(734,47,'Cundinamarca','CAM',1),(735,47,'Guainia','GNA',1),(736,47,'Guajira','GJR',1),(737,47,'Guaviare','GVR',1),(738,47,'Huila','HUI',1),(739,47,'Magdalena','MAG',1),(740,47,'Meta','MET',1),(741,47,'Narino','NAR',1),(742,47,'Norte de Santander','NDS',1),(743,47,'Putumayo','PUT',1),(744,47,'Quindio','QUI',1),(745,47,'Risaralda','RIS',1),(746,47,'San Andres y Providencia','SAP',1),(747,47,'Santander','SAN',1),(748,47,'Sucre','SUC',1),(749,47,'Tolima','TOL',1),(750,47,'Valle del Cauca','VDC',1),(751,47,'Vaupes','VAU',1),(752,47,'Vichada','VIC',1),(753,48,'Grande Comore','G',1),(754,48,'Anjouan','A',1),(755,48,'Moheli','M',1),(756,49,'Bouenza','BO',1),(757,49,'Brazzaville','BR',1),(758,49,'Cuvette','CU',1),(759,49,'Cuvette-Ouest','CO',1),(760,49,'Kouilou','KO',1),(761,49,'Lekoumou','LE',1),(762,49,'Likouala','LI',1),(763,49,'Niari','NI',1),(764,49,'Plateaux','PL',1),(765,49,'Pool','PO',1),(766,49,'Sangha','SA',1),(767,50,'Pukapuka','PU',1),(768,50,'Rakahanga','RK',1),(769,50,'Manihiki','MK',1),(770,50,'Penrhyn','PE',1),(771,50,'Nassau Island','NI',1),(772,50,'Surwarrow','SU',1),(773,50,'Palmerston','PA',1),(774,50,'Aitutaki','AI',1),(775,50,'Manuae','MA',1),(776,50,'Takutea','TA',1),(777,50,'Mitiaro','MT',1),(778,50,'Atiu','AT',1),(779,50,'Mauke','MU',1),(780,50,'Rarotonga','RR',1),(781,50,'Mangaia','MG',1),(782,51,'Alajuela','AL',1),(783,51,'Cartago','CA',1),(784,51,'Guanacaste','GU',1),(785,51,'Heredia','HE',1),(786,51,'Limon','LI',1),(787,51,'Puntarenas','PU',1),(788,51,'San Jose','SJ',1),(789,52,'Abengourou','ABE',1),(790,52,'Abidjan','ABI',1),(791,52,'Aboisso','ABO',1),(792,52,'Adiake','ADI',1),(793,52,'Adzope','ADZ',1),(794,52,'Agboville','AGB',1),(795,52,'Agnibilekrou','AGN',1),(796,52,'Alepe','ALE',1),(797,52,'Bocanda','BOC',1),(798,52,'Bangolo','BAN',1),(799,52,'Beoumi','BEO',1),(800,52,'Biankouma','BIA',1),(801,52,'Bondoukou','BDK',1),(802,52,'Bongouanou','BGN',1),(803,52,'Bouafle','BFL',1),(804,52,'Bouake','BKE',1),(805,52,'Bouna','BNA',1),(806,52,'Boundiali','BDL',1),(807,52,'Dabakala','DKL',1),(808,52,'Dabou','DBU',1),(809,52,'Daloa','DAL',1),(810,52,'Danane','DAN',1),(811,52,'Daoukro','DAO',1),(812,52,'Dimbokro','DIM',1),(813,52,'Divo','DIV',1),(814,52,'Duekoue','DUE',1),(815,52,'Ferkessedougou','FER',1),(816,52,'Gagnoa','GAG',1),(817,52,'Grand-Bassam','GBA',1),(818,52,'Grand-Lahou','GLA',1),(819,52,'Guiglo','GUI',1),(820,52,'Issia','ISS',1),(821,52,'Jacqueville','JAC',1),(822,52,'Katiola','KAT',1),(823,52,'Korhogo','KOR',1),(824,52,'Lakota','LAK',1),(825,52,'Man','MAN',1),(826,52,'Mankono','MKN',1),(827,52,'Mbahiakro','MBA',1),(828,52,'Odienne','ODI',1),(829,52,'Oume','OUM',1),(830,52,'Sakassou','SAK',1),(831,52,'San-Pedro','SPE',1),(832,52,'Sassandra','SAS',1),(833,52,'Seguela','SEG',1),(834,52,'Sinfra','SIN',1),(835,52,'Soubre','SOU',1),(836,52,'Tabou','TAB',1),(837,52,'Tanda','TAN',1),(838,52,'Tiebissou','TIE',1),(839,52,'Tingrela','TIN',1),(840,52,'Tiassale','TIA',1),(841,52,'Touba','TBA',1),(842,52,'Toulepleu','TLP',1),(843,52,'Toumodi','TMD',1),(844,52,'Vavoua','VAV',1),(845,52,'Yamoussoukro','YAM',1),(846,52,'Zuenoula','ZUE',1),(847,53,'Bjelovar-Bilogora','BB',1),(848,53,'City of Zagreb','CZ',1),(849,53,'Dubrovnik-Neretva','DN',1),(850,53,'Istra','IS',1),(851,53,'Karlovac','KA',1),(852,53,'Koprivnica-Krizevci','KK',1),(853,53,'Krapina-Zagorje','KZ',1),(854,53,'Lika-Senj','LS',1),(855,53,'Medimurje','ME',1),(856,53,'Osijek-Baranja','OB',1),(857,53,'Pozega-Slavonia','PS',1),(858,53,'Primorje-Gorski Kotar','PG',1),(859,53,'Sibenik','SI',1),(860,53,'Sisak-Moslavina','SM',1),(861,53,'Slavonski Brod-Posavina','SB',1),(862,53,'Split-Dalmatia','SD',1),(863,53,'Varazdin','VA',1),(864,53,'Virovitica-Podravina','VP',1),(865,53,'Vukovar-Srijem','VS',1),(866,53,'Zadar-Knin','ZK',1),(867,53,'Zagreb','ZA',1),(868,54,'Camaguey','CA',1),(869,54,'Ciego de Avila','CD',1),(870,54,'Cienfuegos','CI',1),(871,54,'Ciudad de La Habana','CH',1),(872,54,'Granma','GR',1),(873,54,'Guantanamo','GU',1),(874,54,'Holguin','HO',1),(875,54,'Isla de la Juventud','IJ',1),(876,54,'La Habana','LH',1),(877,54,'Las Tunas','LT',1),(878,54,'Matanzas','MA',1),(879,54,'Pinar del Rio','PR',1),(880,54,'Sancti Spiritus','SS',1),(881,54,'Santiago de Cuba','SC',1),(882,54,'Villa Clara','VC',1),(883,55,'Famagusta','F',1),(884,55,'Kyrenia','K',1),(885,55,'Larnaca','A',1),(886,55,'Limassol','I',1),(887,55,'Nicosia','N',1),(888,55,'Paphos','P',1),(889,56,'Ústecký','U',1),(890,56,'Jihočeský','C',1),(891,56,'Jihomoravský','B',1),(892,56,'Karlovarský','K',1),(893,56,'Královehradecký','H',1),(894,56,'Liberecký','L',1),(895,56,'Moravskoslezský','T',1),(896,56,'Olomoucký','M',1),(897,56,'Pardubický','E',1),(898,56,'Plzeňský','P',1),(899,56,'Praha','A',1),(900,56,'Středočeský','S',1),(901,56,'Vysočina','J',1),(902,56,'Zlínský','Z',1),(903,57,'Arhus','AR',1),(904,57,'Bornholm','BH',1),(905,57,'Copenhagen','CO',1),(906,57,'Faroe Islands','FO',1),(907,57,'Frederiksborg','FR',1),(908,57,'Fyn','FY',1),(909,57,'Kobenhavn','KO',1),(910,57,'Nordjylland','NO',1),(911,57,'Ribe','RI',1),(912,57,'Ringkobing','RK',1),(913,57,'Roskilde','RO',1),(914,57,'Sonderjylland','SO',1),(915,57,'Storstrom','ST',1),(916,57,'Vejle','VK',1),(917,57,'Vestj&aelig;lland','VJ',1),(918,57,'Viborg','VB',1),(919,58,'\'Ali Sabih','S',1),(920,58,'Dikhil','K',1),(921,58,'Djibouti','J',1),(922,58,'Obock','O',1),(923,58,'Tadjoura','T',1),(924,59,'Saint Andrew Parish','AND',1),(925,59,'Saint David Parish','DAV',1),(926,59,'Saint George Parish','GEO',1),(927,59,'Saint John Parish','JOH',1),(928,59,'Saint Joseph Parish','JOS',1),(929,59,'Saint Luke Parish','LUK',1),(930,59,'Saint Mark Parish','MAR',1),(931,59,'Saint Patrick Parish','PAT',1),(932,59,'Saint Paul Parish','PAU',1),(933,59,'Saint Peter Parish','PET',1),(934,60,'Distrito Nacional','DN',1),(935,60,'Azua','AZ',1),(936,60,'Baoruco','BC',1),(937,60,'Barahona','BH',1),(938,60,'Dajabon','DJ',1),(939,60,'Duarte','DU',1),(940,60,'Elias Pina','EL',1),(941,60,'El Seybo','SY',1),(942,60,'Espaillat','ET',1),(943,60,'Hato Mayor','HM',1),(944,60,'Independencia','IN',1),(945,60,'La Altagracia','AL',1),(946,60,'La Romana','RO',1),(947,60,'La Vega','VE',1),(948,60,'Maria Trinidad Sanchez','MT',1),(949,60,'Monsenor Nouel','MN',1),(950,60,'Monte Cristi','MC',1),(951,60,'Monte Plata','MP',1),(952,60,'Pedernales','PD',1),(953,60,'Peravia (Bani)','PR',1),(954,60,'Puerto Plata','PP',1),(955,60,'Salcedo','SL',1),(956,60,'Samana','SM',1),(957,60,'Sanchez Ramirez','SH',1),(958,60,'San Cristobal','SC',1),(959,60,'San Jose de Ocoa','JO',1),(960,60,'San Juan','SJ',1),(961,60,'San Pedro de Macoris','PM',1),(962,60,'Santiago','SA',1),(963,60,'Santiago Rodriguez','ST',1),(964,60,'Santo Domingo','SD',1),(965,60,'Valverde','VA',1),(966,61,'Aileu','AL',1),(967,61,'Ainaro','AN',1),(968,61,'Baucau','BA',1),(969,61,'Bobonaro','BO',1),(970,61,'Cova Lima','CO',1),(971,61,'Dili','DI',1),(972,61,'Ermera','ER',1),(973,61,'Lautem','LA',1),(974,61,'Liquica','LI',1),(975,61,'Manatuto','MT',1),(976,61,'Manufahi','MF',1),(977,61,'Oecussi','OE',1),(978,61,'Viqueque','VI',1),(979,62,'Azuay','AZU',1),(980,62,'Bolivar','BOL',1),(981,62,'Ca&ntilde;ar','CAN',1),(982,62,'Carchi','CAR',1),(983,62,'Chimborazo','CHI',1),(984,62,'Cotopaxi','COT',1),(985,62,'El Oro','EOR',1),(986,62,'Esmeraldas','ESM',1),(987,62,'Gal&aacute;pagos','GPS',1),(988,62,'Guayas','GUA',1),(989,62,'Imbabura','IMB',1),(990,62,'Loja','LOJ',1),(991,62,'Los Rios','LRO',1),(992,62,'Manab&iacute;','MAN',1),(993,62,'Morona Santiago','MSA',1),(994,62,'Napo','NAP',1),(995,62,'Orellana','ORE',1),(996,62,'Pastaza','PAS',1),(997,62,'Pichincha','PIC',1),(998,62,'Sucumb&iacute;os','SUC',1),(999,62,'Tungurahua','TUN',1),(1000,62,'Zamora Chinchipe','ZCH',1),(1001,63,'Ad Daqahliyah','DHY',1),(1002,63,'Al Bahr al Ahmar','BAM',1),(1003,63,'Al Buhayrah','BHY',1),(1004,63,'Al Fayyum','FYM',1),(1005,63,'Al Gharbiyah','GBY',1),(1006,63,'Al Iskandariyah','IDR',1),(1007,63,'Al Isma\'iliyah','IML',1),(1008,63,'Al Jizah','JZH',1),(1009,63,'Al Minufiyah','MFY',1),(1010,63,'Al Minya','MNY',1),(1011,63,'Al Qahirah','QHR',1),(1012,63,'Al Qalyubiyah','QLY',1),(1013,63,'Al Wadi al Jadid','WJD',1),(1014,63,'Ash Sharqiyah','SHQ',1),(1015,63,'As Suways','SWY',1),(1016,63,'Aswan','ASW',1),(1017,63,'Asyut','ASY',1),(1018,63,'Bani Suwayf','BSW',1),(1019,63,'Bur Sa\'id','BSD',1),(1020,63,'Dumyat','DMY',1),(1021,63,'Janub Sina\'','JNS',1),(1022,63,'Kafr ash Shaykh','KSH',1),(1023,63,'Matruh','MAT',1),(1024,63,'Qina','QIN',1),(1025,63,'Shamal Sina\'','SHS',1),(1026,63,'Suhaj','SUH',1),(1027,64,'Ahuachapan','AH',1),(1028,64,'Cabanas','CA',1),(1029,64,'Chalatenango','CH',1),(1030,64,'Cuscatlan','CU',1),(1031,64,'La Libertad','LB',1),(1032,64,'La Paz','PZ',1),(1033,64,'La Union','UN',1),(1034,64,'Morazan','MO',1),(1035,64,'San Miguel','SM',1),(1036,64,'San Salvador','SS',1),(1037,64,'San Vicente','SV',1),(1038,64,'Santa Ana','SA',1),(1039,64,'Sonsonate','SO',1),(1040,64,'Usulutan','US',1),(1041,65,'Provincia Annobon','AN',1),(1042,65,'Provincia Bioko Norte','BN',1),(1043,65,'Provincia Bioko Sur','BS',1),(1044,65,'Provincia Centro Sur','CS',1),(1045,65,'Provincia Kie-Ntem','KN',1),(1046,65,'Provincia Litoral','LI',1),(1047,65,'Provincia Wele-Nzas','WN',1),(1048,66,'Central (Maekel)','MA',1),(1049,66,'Anseba (Keren)','KE',1),(1050,66,'Southern Red Sea (Debub-Keih-Bahri)','DK',1),(1051,66,'Northern Red Sea (Semien-Keih-Bahri)','SK',1),(1052,66,'Southern (Debub)','DE',1),(1053,66,'Gash-Barka (Barentu)','BR',1),(1054,67,'Harjumaa (Tallinn)','HA',1),(1055,67,'Hiiumaa (Kardla)','HI',1),(1056,67,'Ida-Virumaa (Johvi)','IV',1),(1057,67,'Jarvamaa (Paide)','JA',1),(1058,67,'Jogevamaa (Jogeva)','JO',1),(1059,67,'Laane-Virumaa (Rakvere)','LV',1),(1060,67,'Laanemaa (Haapsalu)','LA',1),(1061,67,'Parnumaa (Parnu)','PA',1),(1062,67,'Polvamaa (Polva)','PO',1),(1063,67,'Raplamaa (Rapla)','RA',1),(1064,67,'Saaremaa (Kuessaare)','SA',1),(1065,67,'Tartumaa (Tartu)','TA',1),(1066,67,'Valgamaa (Valga)','VA',1),(1067,67,'Viljandimaa (Viljandi)','VI',1),(1068,67,'Vorumaa (Voru)','VO',1),(1069,68,'Afar','AF',1),(1070,68,'Amhara','AH',1),(1071,68,'Benishangul-Gumaz','BG',1),(1072,68,'Gambela','GB',1),(1073,68,'Hariai','HR',1),(1074,68,'Oromia','OR',1),(1075,68,'Somali','SM',1),(1076,68,'Southern Nations - Nationalities and Peoples Region','SN',1),(1077,68,'Tigray','TG',1),(1078,68,'Addis Ababa','AA',1),(1079,68,'Dire Dawa','DD',1),(1080,71,'Central Division','C',1),(1081,71,'Northern Division','N',1),(1082,71,'Eastern Division','E',1),(1083,71,'Western Division','W',1),(1084,71,'Rotuma','R',1),(1085,72,'Ahvenanmaan Laani','AL',1),(1086,72,'Etela-Suomen Laani','ES',1),(1087,72,'Ita-Suomen Laani','IS',1),(1088,72,'Lansi-Suomen Laani','LS',1),(1089,72,'Lapin Lanani','LA',1),(1090,72,'Oulun Laani','OU',1),(1091,73,'Alsace','AL',1),(1092,73,'Aquitaine','AQ',1),(1093,73,'Auvergne','AU',1),(1094,73,'Brittany','BR',1),(1095,73,'Burgundy','BU',1),(1096,73,'Center Loire Valley','CE',1),(1097,73,'Champagne','CH',1),(1098,73,'Corse','CO',1),(1099,73,'France Comte','FR',1),(1100,73,'Languedoc Roussillon','LA',1),(1101,73,'Limousin','LI',1),(1102,73,'Lorraine','LO',1),(1103,73,'Midi Pyrenees','MI',1),(1104,73,'Nord Pas de Calais','NO',1),(1105,73,'Normandy','NR',1),(1106,73,'Paris / Ill de France','PA',1),(1107,73,'Picardie','PI',1),(1108,73,'Poitou Charente','PO',1),(1109,73,'Provence','PR',1),(1110,73,'Rhone Alps','RH',1),(1111,73,'Riviera','RI',1),(1112,73,'Western Loire Valley','WE',1),(1113,74,'Etranger','Et',1),(1114,74,'Ain','01',1),(1115,74,'Aisne','02',1),(1116,74,'Allier','03',1),(1117,74,'Alpes de Haute Provence','04',1),(1118,74,'Hautes-Alpes','05',1),(1119,74,'Alpes Maritimes','06',1),(1120,74,'Ard&egrave;che','07',1),(1121,74,'Ardennes','08',1),(1122,74,'Ari&egrave;ge','09',1),(1123,74,'Aube','10',1),(1124,74,'Aude','11',1),(1125,74,'Aveyron','12',1),(1126,74,'Bouches du Rh&ocirc;ne','13',1),(1127,74,'Calvados','14',1),(1128,74,'Cantal','15',1),(1129,74,'Charente','16',1),(1130,74,'Charente Maritime','17',1),(1131,74,'Cher','18',1),(1132,74,'Corr&egrave;ze','19',1),(1133,74,'Corse du Sud','2A',1),(1134,74,'Haute Corse','2B',1),(1135,74,'C&ocirc;te d&#039;or','21',1),(1136,74,'C&ocirc;tes d&#039;Armor','22',1),(1137,74,'Creuse','23',1),(1138,74,'Dordogne','24',1),(1139,74,'Doubs','25',1),(1140,74,'Dr&ocirc;me','26',1),(1141,74,'Eure','27',1),(1142,74,'Eure et Loir','28',1),(1143,74,'Finist&egrave;re','29',1),(1144,74,'Gard','30',1),(1145,74,'Haute Garonne','31',1),(1146,74,'Gers','32',1),(1147,74,'Gironde','33',1),(1148,74,'H&eacute;rault','34',1),(1149,74,'Ille et Vilaine','35',1),(1150,74,'Indre','36',1),(1151,74,'Indre et Loire','37',1),(1152,74,'Is&eacute;re','38',1),(1153,74,'Jura','39',1),(1154,74,'Landes','40',1),(1155,74,'Loir et Cher','41',1),(1156,74,'Loire','42',1),(1157,74,'Haute Loire','43',1),(1158,74,'Loire Atlantique','44',1),(1159,74,'Loiret','45',1),(1160,74,'Lot','46',1),(1161,74,'Lot et Garonne','47',1),(1162,74,'Loz&egrave;re','48',1),(1163,74,'Maine et Loire','49',1),(1164,74,'Manche','50',1),(1165,74,'Marne','51',1),(1166,74,'Haute Marne','52',1),(1167,74,'Mayenne','53',1),(1168,74,'Meurthe et Moselle','54',1),(1169,74,'Meuse','55',1),(1170,74,'Morbihan','56',1),(1171,74,'Moselle','57',1),(1172,74,'Ni&egrave;vre','58',1),(1173,74,'Nord','59',1),(1174,74,'Oise','60',1),(1175,74,'Orne','61',1),(1176,74,'Pas de Calais','62',1),(1177,74,'Puy de D&ocirc;me','63',1),(1178,74,'Pyr&eacute;n&eacute;es Atlantiques','64',1),(1179,74,'Hautes Pyr&eacute;n&eacute;es','65',1),(1180,74,'Pyr&eacute;n&eacute;es Orientales','66',1),(1181,74,'Bas Rhin','67',1),(1182,74,'Haut Rhin','68',1),(1183,74,'Rh&ocirc;ne','69',1),(1184,74,'Haute Sa&ocirc;ne','70',1),(1185,74,'Sa&ocirc;ne et Loire','71',1),(1186,74,'Sarthe','72',1),(1187,74,'Savoie','73',1),(1188,74,'Haute Savoie','74',1),(1189,74,'Paris','75',1),(1190,74,'Seine Maritime','76',1),(1191,74,'Seine et Marne','77',1),(1192,74,'Yvelines','78',1),(1193,74,'Deux S&egrave;vres','79',1),(1194,74,'Somme','80',1),(1195,74,'Tarn','81',1),(1196,74,'Tarn et Garonne','82',1),(1197,74,'Var','83',1),(1198,74,'Vaucluse','84',1),(1199,74,'Vend&eacute;e','85',1),(1200,74,'Vienne','86',1),(1201,74,'Haute Vienne','87',1),(1202,74,'Vosges','88',1),(1203,74,'Yonne','89',1),(1204,74,'Territoire de Belfort','90',1),(1205,74,'Essonne','91',1),(1206,74,'Hauts de Seine','92',1),(1207,74,'Seine St-Denis','93',1),(1208,74,'Val de Marne','94',1),(1209,74,'Val d\'Oise','95',1),(1210,76,'Archipel des Marquises','M',1),(1211,76,'Archipel des Tuamotu','T',1),(1212,76,'Archipel des Tubuai','I',1),(1213,76,'Iles du Vent','V',1),(1214,76,'Iles Sous-le-Vent','S',1),(1215,77,'Iles Crozet','C',1),(1216,77,'Iles Kerguelen','K',1),(1217,77,'Ile Amsterdam','A',1),(1218,77,'Ile Saint-Paul','P',1),(1219,77,'Adelie Land','D',1),(1220,78,'Estuaire','ES',1),(1221,78,'Haut-Ogooue','HO',1),(1222,78,'Moyen-Ogooue','MO',1),(1223,78,'Ngounie','NG',1),(1224,78,'Nyanga','NY',1),(1225,78,'Ogooue-Ivindo','OI',1),(1226,78,'Ogooue-Lolo','OL',1),(1227,78,'Ogooue-Maritime','OM',1),(1228,78,'Woleu-Ntem','WN',1),(1229,79,'Banjul','BJ',1),(1230,79,'Basse','BS',1),(1231,79,'Brikama','BR',1),(1232,79,'Janjangbure','JA',1),(1233,79,'Kanifeng','KA',1),(1234,79,'Kerewan','KE',1),(1235,79,'Kuntaur','KU',1),(1236,79,'Mansakonko','MA',1),(1237,79,'Lower River','LR',1),(1238,79,'Central River','CR',1),(1239,79,'North Bank','NB',1),(1240,79,'Upper River','UR',1),(1241,79,'Western','WE',1),(1242,80,'Abkhazia','AB',1),(1243,80,'Ajaria','AJ',1),(1244,80,'Tbilisi','TB',1),(1245,80,'Guria','GU',1),(1246,80,'Imereti','IM',1),(1247,80,'Kakheti','KA',1),(1248,80,'Kvemo Kartli','KK',1),(1249,80,'Mtskheta-Mtianeti','MM',1),(1250,80,'Racha Lechkhumi and Kvemo Svanet','RL',1),(1251,80,'Samegrelo-Zemo Svaneti','SZ',1),(1252,80,'Samtskhe-Javakheti','SJ',1),(1253,80,'Shida Kartli','SK',1),(1254,81,'Baden-W&uuml;rttemberg','BAW',1),(1255,81,'Bayern','BAY',1),(1256,81,'Berlin','BER',1),(1257,81,'Brandenburg','BRG',1),(1258,81,'Bremen','BRE',1),(1259,81,'Hamburg','HAM',1),(1260,81,'Hessen','HES',1),(1261,81,'Mecklenburg-Vorpommern','MEC',1),(1262,81,'Niedersachsen','NDS',1),(1263,81,'Nordrhein-Westfalen','NRW',1),(1264,81,'Rheinland-Pfalz','RHE',1),(1265,81,'Saarland','SAR',1),(1266,81,'Sachsen','SAS',1),(1267,81,'Sachsen-Anhalt','SAC',1),(1268,81,'Schleswig-Holstein','SCN',1),(1269,81,'Th&uuml;ringen','THE',1),(1270,82,'Ashanti Region','AS',1),(1271,82,'Brong-Ahafo Region','BA',1),(1272,82,'Central Region','CE',1),(1273,82,'Eastern Region','EA',1),(1274,82,'Greater Accra Region','GA',1),(1275,82,'Northern Region','NO',1),(1276,82,'Upper East Region','UE',1),(1277,82,'Upper West Region','UW',1),(1278,82,'Volta Region','VO',1),(1279,82,'Western Region','WE',1),(1280,84,'Attica','AT',1),(1281,84,'Central Greece','CN',1),(1282,84,'Central Macedonia','CM',1),(1283,84,'Crete','CR',1),(1284,84,'East Macedonia and Thrace','EM',1),(1285,84,'Epirus','EP',1),(1286,84,'Ionian Islands','II',1),(1287,84,'North Aegean','NA',1),(1288,84,'Peloponnesos','PP',1),(1289,84,'South Aegean','SA',1),(1290,84,'Thessaly','TH',1),(1291,84,'West Greece','WG',1),(1292,84,'West Macedonia','WM',1),(1293,85,'Avannaa','A',1),(1294,85,'Tunu','T',1),(1295,85,'Kitaa','K',1),(1296,86,'Saint Andrew','A',1),(1297,86,'Saint David','D',1),(1298,86,'Saint George','G',1),(1299,86,'Saint John','J',1),(1300,86,'Saint Mark','M',1),(1301,86,'Saint Patrick','P',1),(1302,86,'Carriacou','C',1),(1303,86,'Petit Martinique','Q',1),(1304,89,'Alta Verapaz','AV',1),(1305,89,'Baja Verapaz','BV',1),(1306,89,'Chimaltenango','CM',1),(1307,89,'Chiquimula','CQ',1),(1308,89,'El Peten','PE',1),(1309,89,'El Progreso','PR',1),(1310,89,'El Quiche','QC',1),(1311,89,'Escuintla','ES',1),(1312,89,'Guatemala','GU',1),(1313,89,'Huehuetenango','HU',1),(1314,89,'Izabal','IZ',1),(1315,89,'Jalapa','JA',1),(1316,89,'Jutiapa','JU',1),(1317,89,'Quetzaltenango','QZ',1),(1318,89,'Retalhuleu','RE',1),(1319,89,'Sacatepequez','ST',1),(1320,89,'San Marcos','SM',1),(1321,89,'Santa Rosa','SR',1),(1322,89,'Solola','SO',1),(1323,89,'Suchitepequez','SU',1),(1324,89,'Totonicapan','TO',1),(1325,89,'Zacapa','ZA',1),(1326,90,'Conakry','CNK',1),(1327,90,'Beyla','BYL',1),(1328,90,'Boffa','BFA',1),(1329,90,'Boke','BOK',1),(1330,90,'Coyah','COY',1),(1331,90,'Dabola','DBL',1),(1332,90,'Dalaba','DLB',1),(1333,90,'Dinguiraye','DGR',1),(1334,90,'Dubreka','DBR',1),(1335,90,'Faranah','FRN',1),(1336,90,'Forecariah','FRC',1),(1337,90,'Fria','FRI',1),(1338,90,'Gaoual','GAO',1),(1339,90,'Gueckedou','GCD',1),(1340,90,'Kankan','KNK',1),(1341,90,'Kerouane','KRN',1),(1342,90,'Kindia','KND',1),(1343,90,'Kissidougou','KSD',1),(1344,90,'Koubia','KBA',1),(1345,90,'Koundara','KDA',1),(1346,90,'Kouroussa','KRA',1),(1347,90,'Labe','LAB',1),(1348,90,'Lelouma','LLM',1),(1349,90,'Lola','LOL',1),(1350,90,'Macenta','MCT',1),(1351,90,'Mali','MAL',1),(1352,90,'Mamou','MAM',1),(1353,90,'Mandiana','MAN',1),(1354,90,'Nzerekore','NZR',1),(1355,90,'Pita','PIT',1),(1356,90,'Siguiri','SIG',1),(1357,90,'Telimele','TLM',1),(1358,90,'Tougue','TOG',1),(1359,90,'Yomou','YOM',1),(1360,91,'Bafata Region','BF',1),(1361,91,'Biombo Region','BB',1),(1362,91,'Bissau Region','BS',1),(1363,91,'Bolama Region','BL',1),(1364,91,'Cacheu Region','CA',1),(1365,91,'Gabu Region','GA',1),(1366,91,'Oio Region','OI',1),(1367,91,'Quinara Region','QU',1),(1368,91,'Tombali Region','TO',1),(1369,92,'Barima-Waini','BW',1),(1370,92,'Cuyuni-Mazaruni','CM',1),(1371,92,'Demerara-Mahaica','DM',1),(1372,92,'East Berbice-Corentyne','EC',1),(1373,92,'Essequibo Islands-West Demerara','EW',1),(1374,92,'Mahaica-Berbice','MB',1),(1375,92,'Pomeroon-Supenaam','PM',1),(1376,92,'Potaro-Siparuni','PI',1),(1377,92,'Upper Demerara-Berbice','UD',1),(1378,92,'Upper Takutu-Upper Essequibo','UT',1),(1379,93,'Artibonite','AR',1),(1380,93,'Centre','CE',1),(1381,93,'Grand\'Anse','GA',1),(1382,93,'Nord','ND',1),(1383,93,'Nord-Est','NE',1),(1384,93,'Nord-Ouest','NO',1),(1385,93,'Ouest','OU',1),(1386,93,'Sud','SD',1),(1387,93,'Sud-Est','SE',1),(1388,94,'Flat Island','F',1),(1389,94,'McDonald Island','M',1),(1390,94,'Shag Island','S',1),(1391,94,'Heard Island','H',1),(1392,95,'Atlantida','AT',1),(1393,95,'Choluteca','CH',1),(1394,95,'Colon','CL',1),(1395,95,'Comayagua','CM',1),(1396,95,'Copan','CP',1),(1397,95,'Cortes','CR',1),(1398,95,'El Paraiso','PA',1),(1399,95,'Francisco Morazan','FM',1),(1400,95,'Gracias a Dios','GD',1),(1401,95,'Intibuca','IN',1),(1402,95,'Islas de la Bahia (Bay Islands)','IB',1),(1403,95,'La Paz','PZ',1),(1404,95,'Lempira','LE',1),(1405,95,'Ocotepeque','OC',1),(1406,95,'Olancho','OL',1),(1407,95,'Santa Barbara','SB',1),(1408,95,'Valle','VA',1),(1409,95,'Yoro','YO',1),(1410,96,'Central and Western Hong Kong Island','HCW',1),(1411,96,'Eastern Hong Kong Island','HEA',1),(1412,96,'Southern Hong Kong Island','HSO',1),(1413,96,'Wan Chai Hong Kong Island','HWC',1),(1414,96,'Kowloon City Kowloon','KKC',1),(1415,96,'Kwun Tong Kowloon','KKT',1),(1416,96,'Sham Shui Po Kowloon','KSS',1),(1417,96,'Wong Tai Sin Kowloon','KWT',1),(1418,96,'Yau Tsim Mong Kowloon','KYT',1),(1419,96,'Islands New Territories','NIS',1),(1420,96,'Kwai Tsing New Territories','NKT',1),(1421,96,'North New Territories','NNO',1),(1422,96,'Sai Kung New Territories','NSK',1),(1423,96,'Sha Tin New Territories','NST',1),(1424,96,'Tai Po New Territories','NTP',1),(1425,96,'Tsuen Wan New Territories','NTW',1),(1426,96,'Tuen Mun New Territories','NTM',1),(1427,96,'Yuen Long New Territories','NYL',1),(1428,97,'Bacs-Kiskun','BK',1),(1429,97,'Baranya','BA',1),(1430,97,'Bekes','BE',1),(1431,97,'Bekescsaba','BS',1),(1432,97,'Borsod-Abauj-Zemplen','BZ',1),(1433,97,'Budapest','BU',1),(1434,97,'Csongrad','CS',1),(1435,97,'Debrecen','DE',1),(1436,97,'Dunaujvaros','DU',1),(1437,97,'Eger','EG',1),(1438,97,'Fejer','FE',1),(1439,97,'Gyor','GY',1),(1440,97,'Gyor-Moson-Sopron','GM',1),(1441,97,'Hajdu-Bihar','HB',1),(1442,97,'Heves','HE',1),(1443,97,'Hodmezovasarhely','HO',1),(1444,97,'Jasz-Nagykun-Szolnok','JN',1),(1445,97,'Kaposvar','KA',1),(1446,97,'Kecskemet','KE',1),(1447,97,'Komarom-Esztergom','KO',1),(1448,97,'Miskolc','MI',1),(1449,97,'Nagykanizsa','NA',1),(1450,97,'Nograd','NO',1),(1451,97,'Nyiregyhaza','NY',1),(1452,97,'Pecs','PE',1),(1453,97,'Pest','PS',1),(1454,97,'Somogy','SO',1),(1455,97,'Sopron','SP',1),(1456,97,'Szabolcs-Szatmar-Bereg','SS',1),(1457,97,'Szeged','SZ',1),(1458,97,'Szekesfehervar','SE',1),(1459,97,'Szolnok','SL',1),(1460,97,'Szombathely','SM',1),(1461,97,'Tatabanya','TA',1),(1462,97,'Tolna','TO',1),(1463,97,'Vas','VA',1),(1464,97,'Veszprem','VE',1),(1465,97,'Zala','ZA',1),(1466,97,'Zalaegerszeg','ZZ',1),(1467,98,'Austurland','AL',1),(1468,98,'Hofuoborgarsvaeoi','HF',1),(1469,98,'Norourland eystra','NE',1),(1470,98,'Norourland vestra','NV',1),(1471,98,'Suourland','SL',1),(1472,98,'Suournes','SN',1),(1473,98,'Vestfiroir','VF',1),(1474,98,'Vesturland','VL',1),(1475,99,'Andaman and Nicobar Islands','AN',1),(1476,99,'Andhra Pradesh','AP',1),(1477,99,'Arunachal Pradesh','AR',1),(1478,99,'Assam','AS',1),(1479,99,'Bihar','BI',1),(1480,99,'Chandigarh','CH',1),(1481,99,'Dadra and Nagar Haveli','DA',1),(1482,99,'Daman and Diu','DM',1),(1483,99,'Delhi','DE',1),(1484,99,'Goa','GO',1),(1485,99,'Gujarat','GU',1),(1486,99,'Haryana','HA',1),(1487,99,'Himachal Pradesh','HP',1),(1488,99,'Jammu and Kashmir','JA',1),(1489,99,'Karnataka','KA',1),(1490,99,'Kerala','KE',1),(1491,99,'Lakshadweep Islands','LI',1),(1492,99,'Madhya Pradesh','MP',1),(1493,99,'Maharashtra','MA',1),(1494,99,'Manipur','MN',1),(1495,99,'Meghalaya','ME',1),(1496,99,'Mizoram','MI',1),(1497,99,'Nagaland','NA',1),(1498,99,'Orissa','OR',1),(1499,99,'Pondicherry','PO',1),(1500,99,'Punjab','PU',1),(1501,99,'Rajasthan','RA',1),(1502,99,'Sikkim','SI',1),(1503,99,'Tamil Nadu','TN',1),(1504,99,'Tripura','TR',1),(1505,99,'Uttar Pradesh','UP',1),(1506,99,'West Bengal','WB',1),(1507,100,'Aceh','AC',1),(1508,100,'Bali','BA',1),(1509,100,'Banten','BT',1),(1510,100,'Bengkulu','BE',1),(1511,100,'BoDeTaBek','BD',1),(1512,100,'Gorontalo','GO',1),(1513,100,'Jakarta Raya','JK',1),(1514,100,'Jambi','JA',1),(1515,100,'Jawa Barat','JB',1),(1516,100,'Jawa Tengah','JT',1),(1517,100,'Jawa Timur','JI',1),(1518,100,'Kalimantan Barat','KB',1),(1519,100,'Kalimantan Selatan','KS',1),(1520,100,'Kalimantan Tengah','KT',1),(1521,100,'Kalimantan Timur','KI',1),(1522,100,'Kepulauan Bangka Belitung','BB',1),(1523,100,'Lampung','LA',1),(1524,100,'Maluku','MA',1),(1525,100,'Maluku Utara','MU',1),(1526,100,'Nusa Tenggara Barat','NB',1),(1527,100,'Nusa Tenggara Timur','NT',1),(1528,100,'Papua','PA',1),(1529,100,'Riau','RI',1),(1530,100,'Sulawesi Selatan','SN',1),(1531,100,'Sulawesi Tengah','ST',1),(1532,100,'Sulawesi Tenggara','SG',1),(1533,100,'Sulawesi Utara','SA',1),(1534,100,'Sumatera Barat','SB',1),(1535,100,'Sumatera Selatan','SS',1),(1536,100,'Sumatera Utara','SU',1),(1537,100,'Yogyakarta','YO',1),(1538,101,'Tehran','TEH',1),(1539,101,'Qom','QOM',1),(1540,101,'Markazi','MKZ',1),(1541,101,'Qazvin','QAZ',1),(1542,101,'Gilan','GIL',1),(1543,101,'Ardabil','ARD',1),(1544,101,'Zanjan','ZAN',1),(1545,101,'East Azarbaijan','EAZ',1),(1546,101,'West Azarbaijan','WEZ',1),(1547,101,'Kurdistan','KRD',1),(1548,101,'Hamadan','HMD',1),(1549,101,'Kermanshah','KRM',1),(1550,101,'Ilam','ILM',1),(1551,101,'Lorestan','LRS',1),(1552,101,'Khuzestan','KZT',1),(1553,101,'Chahar Mahaal and Bakhtiari','CMB',1),(1554,101,'Kohkiluyeh and Buyer Ahmad','KBA',1),(1555,101,'Bushehr','BSH',1),(1556,101,'Fars','FAR',1),(1557,101,'Hormozgan','HRM',1),(1558,101,'Sistan and Baluchistan','SBL',1),(1559,101,'Kerman','KRB',1),(1560,101,'Yazd','YZD',1),(1561,101,'Esfahan','EFH',1),(1562,101,'Semnan','SMN',1),(1563,101,'Mazandaran','MZD',1),(1564,101,'Golestan','GLS',1),(1565,101,'North Khorasan','NKH',1),(1566,101,'Razavi Khorasan','RKH',1),(1567,101,'South Khorasan','SKH',1),(1568,102,'Baghdad','BD',1),(1569,102,'Salah ad Din','SD',1),(1570,102,'Diyala','DY',1),(1571,102,'Wasit','WS',1),(1572,102,'Maysan','MY',1),(1573,102,'Al Basrah','BA',1),(1574,102,'Dhi Qar','DQ',1),(1575,102,'Al Muthanna','MU',1),(1576,102,'Al Qadisyah','QA',1),(1577,102,'Babil','BB',1),(1578,102,'Al Karbala','KB',1),(1579,102,'An Najaf','NJ',1),(1580,102,'Al Anbar','AB',1),(1581,102,'Ninawa','NN',1),(1582,102,'Dahuk','DH',1),(1583,102,'Arbil','AL',1),(1584,102,'At Ta\'mim','TM',1),(1585,102,'As Sulaymaniyah','SL',1),(1586,103,'Carlow','CA',1),(1587,103,'Cavan','CV',1),(1588,103,'Clare','CL',1),(1589,103,'Cork','CO',1),(1590,103,'Donegal','DO',1),(1591,103,'Dublin','DU',1),(1592,103,'Galway','GA',1),(1593,103,'Kerry','KE',1),(1594,103,'Kildare','KI',1),(1595,103,'Kilkenny','KL',1),(1596,103,'Laois','LA',1),(1597,103,'Leitrim','LE',1),(1598,103,'Limerick','LI',1),(1599,103,'Longford','LO',1),(1600,103,'Louth','LU',1),(1601,103,'Mayo','MA',1),(1602,103,'Meath','ME',1),(1603,103,'Monaghan','MO',1),(1604,103,'Offaly','OF',1),(1605,103,'Roscommon','RO',1),(1606,103,'Sligo','SL',1),(1607,103,'Tipperary','TI',1),(1608,103,'Waterford','WA',1),(1609,103,'Westmeath','WE',1),(1610,103,'Wexford','WX',1),(1611,103,'Wicklow','WI',1),(1612,104,'Be\'er Sheva','BS',1),(1613,104,'Bika\'at Hayarden','BH',1),(1614,104,'Eilat and Arava','EA',1),(1615,104,'Galil','GA',1),(1616,104,'Haifa','HA',1),(1617,104,'Jehuda Mountains','JM',1),(1618,104,'Jerusalem','JE',1),(1619,104,'Negev','NE',1),(1620,104,'Semaria','SE',1),(1621,104,'Sharon','SH',1),(1622,104,'Tel Aviv (Gosh Dan)','TA',1),(3860,105,'Caltanissetta','CL',1),(3842,105,'Agrigento','AG',1),(3843,105,'Alessandria','AL',1),(3844,105,'Ancona','AN',1),(3845,105,'Aosta','AO',1),(3846,105,'Arezzo','AR',1),(3847,105,'Ascoli Piceno','AP',1),(3848,105,'Asti','AT',1),(3849,105,'Avellino','AV',1),(3850,105,'Bari','BA',1),(3851,105,'Belluno','BL',1),(3852,105,'Benevento','BN',1),(3853,105,'Bergamo','BG',1),(3854,105,'Biella','BI',1),(3855,105,'Bologna','BO',1),(3856,105,'Bolzano','BZ',1),(3857,105,'Brescia','BS',1),(3858,105,'Brindisi','BR',1),(3859,105,'Cagliari','CA',1),(1643,106,'Clarendon Parish','CLA',1),(1644,106,'Hanover Parish','HAN',1),(1645,106,'Kingston Parish','KIN',1),(1646,106,'Manchester Parish','MAN',1),(1647,106,'Portland Parish','POR',1),(1648,106,'Saint Andrew Parish','AND',1),(1649,106,'Saint Ann Parish','ANN',1),(1650,106,'Saint Catherine Parish','CAT',1),(1651,106,'Saint Elizabeth Parish','ELI',1),(1652,106,'Saint James Parish','JAM',1),(1653,106,'Saint Mary Parish','MAR',1),(1654,106,'Saint Thomas Parish','THO',1),(1655,106,'Trelawny Parish','TRL',1),(1656,106,'Westmoreland Parish','WML',1),(1657,107,'Aichi','AI',1),(1658,107,'Akita','AK',1),(1659,107,'Aomori','AO',1),(1660,107,'Chiba','CH',1),(1661,107,'Ehime','EH',1),(1662,107,'Fukui','FK',1),(1663,107,'Fukuoka','FU',1),(1664,107,'Fukushima','FS',1),(1665,107,'Gifu','GI',1),(1666,107,'Gumma','GU',1),(1667,107,'Hiroshima','HI',1),(1668,107,'Hokkaido','HO',1),(1669,107,'Hyogo','HY',1),(1670,107,'Ibaraki','IB',1),(1671,107,'Ishikawa','IS',1),(1672,107,'Iwate','IW',1),(1673,107,'Kagawa','KA',1),(1674,107,'Kagoshima','KG',1),(1675,107,'Kanagawa','KN',1),(1676,107,'Kochi','KO',1),(1677,107,'Kumamoto','KU',1),(1678,107,'Kyoto','KY',1),(1679,107,'Mie','MI',1),(1680,107,'Miyagi','MY',1),(1681,107,'Miyazaki','MZ',1),(1682,107,'Nagano','NA',1),(1683,107,'Nagasaki','NG',1),(1684,107,'Nara','NR',1),(1685,107,'Niigata','NI',1),(1686,107,'Oita','OI',1),(1687,107,'Okayama','OK',1),(1688,107,'Okinawa','ON',1),(1689,107,'Osaka','OS',1),(1690,107,'Saga','SA',1),(1691,107,'Saitama','SI',1),(1692,107,'Shiga','SH',1),(1693,107,'Shimane','SM',1),(1694,107,'Shizuoka','SZ',1),(1695,107,'Tochigi','TO',1),(1696,107,'Tokushima','TS',1),(1697,107,'Tokyo','TK',1),(1698,107,'Tottori','TT',1),(1699,107,'Toyama','TY',1),(1700,107,'Wakayama','WA',1),(1701,107,'Yamagata','YA',1),(1702,107,'Yamaguchi','YM',1),(1703,107,'Yamanashi','YN',1),(1704,108,'\'Amman','AM',1),(1705,108,'Ajlun','AJ',1),(1706,108,'Al \'Aqabah','AA',1),(1707,108,'Al Balqa\'','AB',1),(1708,108,'Al Karak','AK',1),(1709,108,'Al Mafraq','AL',1),(1710,108,'At Tafilah','AT',1),(1711,108,'Az Zarqa\'','AZ',1),(1712,108,'Irbid','IR',1),(1713,108,'Jarash','JA',1),(1714,108,'Ma\'an','MA',1),(1715,108,'Madaba','MD',1),(1716,109,'Алматинская область','AL',1),(1717,109,'Алматы - город республ-го значения','AC',1),(1718,109,'Акмолинская область','AM',1),(1719,109,'Актюбинская область','AQ',1),(1720,109,'Астана - город республ-го значения','AS',1),(1721,109,'Атырауская область','AT',1),(1722,109,'Западно-Казахстанская область','BA',1),(1723,109,'Байконур - город республ-го значения','BY',1),(1724,109,'Мангистауская область','MA',1),(1725,109,'Южно-Казахстанская область','ON',1),(1726,109,'Павлодарская область','PA',1),(1727,109,'Карагандинская область','QA',1),(1728,109,'Костанайская область','QO',1),(1729,109,'Кызылординская область','QY',1),(1730,109,'Восточно-Казахстанская область','SH',1),(1731,109,'Северо-Казахстанская область','SO',1),(1732,109,'Жамбылская область','ZH',1),(1733,110,'Central','CE',1),(1734,110,'Coast','CO',1),(1735,110,'Eastern','EA',1),(1736,110,'Nairobi Area','NA',1),(1737,110,'North Eastern','NE',1),(1738,110,'Nyanza','NY',1),(1739,110,'Rift Valley','RV',1),(1740,110,'Western','WE',1),(1741,111,'Abaiang','AG',1),(1742,111,'Abemama','AM',1),(1743,111,'Aranuka','AK',1),(1744,111,'Arorae','AO',1),(1745,111,'Banaba','BA',1),(1746,111,'Beru','BE',1),(1747,111,'Butaritari','bT',1),(1748,111,'Kanton','KA',1),(1749,111,'Kiritimati','KR',1),(1750,111,'Kuria','KU',1),(1751,111,'Maiana','MI',1),(1752,111,'Makin','MN',1),(1753,111,'Marakei','ME',1),(1754,111,'Nikunau','NI',1),(1755,111,'Nonouti','NO',1),(1756,111,'Onotoa','ON',1),(1757,111,'Tabiteuea','TT',1),(1758,111,'Tabuaeran','TR',1),(1759,111,'Tamana','TM',1),(1760,111,'Tarawa','TW',1),(1761,111,'Teraina','TE',1),(1762,112,'Chagang-do','CHA',1),(1763,112,'Hamgyong-bukto','HAB',1),(1764,112,'Hamgyong-namdo','HAN',1),(1765,112,'Hwanghae-bukto','HWB',1),(1766,112,'Hwanghae-namdo','HWN',1),(1767,112,'Kangwon-do','KAN',1),(1768,112,'P\'yongan-bukto','PYB',1),(1769,112,'P\'yongan-namdo','PYN',1),(1770,112,'Ryanggang-do (Yanggang-do)','YAN',1),(1771,112,'Rason Directly Governed City','NAJ',1),(1772,112,'P\'yongyang Special City','PYO',1),(1773,113,'Ch\'ungch\'ong-bukto','CO',1),(1774,113,'Ch\'ungch\'ong-namdo','CH',1),(1775,113,'Cheju-do','CD',1),(1776,113,'Cholla-bukto','CB',1),(1777,113,'Cholla-namdo','CN',1),(1778,113,'Inch\'on-gwangyoksi','IG',1),(1779,113,'Kangwon-do','KA',1),(1780,113,'Kwangju-gwangyoksi','KG',1),(1781,113,'Kyonggi-do','KD',1),(1782,113,'Kyongsang-bukto','KB',1),(1783,113,'Kyongsang-namdo','KN',1),(1784,113,'Pusan-gwangyoksi','PG',1),(1785,113,'Soul-t\'ukpyolsi','SO',1),(1786,113,'Taegu-gwangyoksi','TA',1),(1787,113,'Taejon-gwangyoksi','TG',1),(1788,114,'Al \'Asimah','AL',1),(1789,114,'Al Ahmadi','AA',1),(1790,114,'Al Farwaniyah','AF',1),(1791,114,'Al Jahra\'','AJ',1),(1792,114,'Hawalli','HA',1),(1793,115,'Bishkek','GB',1),(1794,115,'Batken','B',1),(1795,115,'Chu','C',1),(1796,115,'Jalal-Abad','J',1),(1797,115,'Naryn','N',1),(1798,115,'Osh','O',1),(1799,115,'Talas','T',1),(1800,115,'Ysyk-Kol','Y',1),(1801,116,'Vientiane','VT',1),(1802,116,'Attapu','AT',1),(1803,116,'Bokeo','BK',1),(1804,116,'Bolikhamxai','BL',1),(1805,116,'Champasak','CH',1),(1806,116,'Houaphan','HO',1),(1807,116,'Khammouan','KH',1),(1808,116,'Louang Namtha','LM',1),(1809,116,'Louangphabang','LP',1),(1810,116,'Oudomxai','OU',1),(1811,116,'Phongsali','PH',1),(1812,116,'Salavan','SL',1),(1813,116,'Savannakhet','SV',1),(1814,116,'Vientiane','VI',1),(1815,116,'Xaignabouli','XA',1),(1816,116,'Xekong','XE',1),(1817,116,'Xiangkhoang','XI',1),(1818,116,'Xaisomboun','XN',1),(1819,117,'Aizkraukles Rajons','AIZ',1),(1820,117,'Aluksnes Rajons','ALU',1),(1821,117,'Balvu Rajons','BAL',1),(1822,117,'Bauskas Rajons','BAU',1),(1823,117,'Cesu Rajons','CES',1),(1824,117,'Daugavpils Rajons','DGR',1),(1825,117,'Dobeles Rajons','DOB',1),(1826,117,'Gulbenes Rajons','GUL',1),(1827,117,'Jekabpils Rajons','JEK',1),(1828,117,'Jelgavas Rajons','JGR',1),(1829,117,'Kraslavas Rajons','KRA',1),(1830,117,'Kuldigas Rajons','KUL',1),(1831,117,'Liepajas Rajons','LPR',1),(1832,117,'Limbazu Rajons','LIM',1),(1833,117,'Ludzas Rajons','LUD',1),(1834,117,'Madonas Rajons','MAD',1),(1835,117,'Ogres Rajons','OGR',1),(1836,117,'Preilu Rajons','PRE',1),(1837,117,'Rezeknes Rajons','RZR',1),(1838,117,'Rigas Rajons','RGR',1),(1839,117,'Saldus Rajons','SAL',1),(1840,117,'Talsu Rajons','TAL',1),(1841,117,'Tukuma Rajons','TUK',1),(1842,117,'Valkas Rajons','VLK',1),(1843,117,'Valmieras Rajons','VLM',1),(1844,117,'Ventspils Rajons','VSR',1),(1845,117,'Daugavpils','DGV',1),(1846,117,'Jelgava','JGV',1),(1847,117,'Jurmala','JUR',1),(1848,117,'Liepaja','LPK',1),(1849,117,'Rezekne','RZK',1),(1850,117,'Riga','RGA',1),(1851,117,'Ventspils','VSL',1),(1852,119,'Berea','BE',1),(1853,119,'Butha-Buthe','BB',1),(1854,119,'Leribe','LE',1),(1855,119,'Mafeteng','MF',1),(1856,119,'Maseru','MS',1),(1857,119,'Mohale\'s Hoek','MH',1),(1858,119,'Mokhotlong','MK',1),(1859,119,'Qacha\'s Nek','QN',1),(1860,119,'Quthing','QT',1),(1861,119,'Thaba-Tseka','TT',1),(1862,120,'Bomi','BI',1),(1863,120,'Bong','BG',1),(1864,120,'Grand Bassa','GB',1),(1865,120,'Grand Cape Mount','CM',1),(1866,120,'Grand Gedeh','GG',1),(1867,120,'Grand Kru','GK',1),(1868,120,'Lofa','LO',1),(1869,120,'Margibi','MG',1),(1870,120,'Maryland','ML',1),(1871,120,'Montserrado','MS',1),(1872,120,'Nimba','NB',1),(1873,120,'River Cess','RC',1),(1874,120,'Sinoe','SN',1),(1875,121,'Ajdabiya','AJ',1),(1876,121,'Al \'Aziziyah','AZ',1),(1877,121,'Al Fatih','FA',1),(1878,121,'Al Jabal al Akhdar','JA',1),(1879,121,'Al Jufrah','JU',1),(1880,121,'Al Khums','KH',1),(1881,121,'Al Kufrah','KU',1),(1882,121,'An Nuqat al Khams','NK',1),(1883,121,'Ash Shati\'','AS',1),(1884,121,'Awbari','AW',1),(1885,121,'Az Zawiyah','ZA',1),(1886,121,'Banghazi','BA',1),(1887,121,'Darnah','DA',1),(1888,121,'Ghadamis','GD',1),(1889,121,'Gharyan','GY',1),(1890,121,'Misratah','MI',1),(1891,121,'Murzuq','MZ',1),(1892,121,'Sabha','SB',1),(1893,121,'Sawfajjin','SW',1),(1894,121,'Surt','SU',1),(1895,121,'Tarabulus (Tripoli)','TL',1),(1896,121,'Tarhunah','TH',1),(1897,121,'Tubruq','TU',1),(1898,121,'Yafran','YA',1),(1899,121,'Zlitan','ZL',1),(1900,122,'Vaduz','V',1),(1901,122,'Schaan','A',1),(1902,122,'Balzers','B',1),(1903,122,'Triesen','N',1),(1904,122,'Eschen','E',1),(1905,122,'Mauren','M',1),(1906,122,'Triesenberg','T',1),(1907,122,'Ruggell','R',1),(1908,122,'Gamprin','G',1),(1909,122,'Schellenberg','L',1),(1910,122,'Planken','P',1),(1911,123,'Alytus','AL',1),(1912,123,'Kaunas','KA',1),(1913,123,'Klaipeda','KL',1),(1914,123,'Marijampole','MA',1),(1915,123,'Panevezys','PA',1),(1916,123,'Siauliai','SI',1),(1917,123,'Taurage','TA',1),(1918,123,'Telsiai','TE',1),(1919,123,'Utena','UT',1),(1920,123,'Vilnius','VI',1),(1921,124,'Diekirch','DD',1),(1922,124,'Clervaux','DC',1),(1923,124,'Redange','DR',1),(1924,124,'Vianden','DV',1),(1925,124,'Wiltz','DW',1),(1926,124,'Grevenmacher','GG',1),(1927,124,'Echternach','GE',1),(1928,124,'Remich','GR',1),(1929,124,'Luxembourg','LL',1),(1930,124,'Capellen','LC',1),(1931,124,'Esch-sur-Alzette','LE',1),(1932,124,'Mersch','LM',1),(1933,125,'Our Lady Fatima Parish','OLF',1),(1934,125,'St. Anthony Parish','ANT',1),(1935,125,'St. Lazarus Parish','LAZ',1),(1936,125,'Cathedral Parish','CAT',1),(1937,125,'St. Lawrence Parish','LAW',1),(1938,127,'Antananarivo','AN',1),(1939,127,'Antsiranana','AS',1),(1940,127,'Fianarantsoa','FN',1),(1941,127,'Mahajanga','MJ',1),(1942,127,'Toamasina','TM',1),(1943,127,'Toliara','TL',1),(1944,128,'Balaka','BLK',1),(1945,128,'Blantyre','BLT',1),(1946,128,'Chikwawa','CKW',1),(1947,128,'Chiradzulu','CRD',1),(1948,128,'Chitipa','CTP',1),(1949,128,'Dedza','DDZ',1),(1950,128,'Dowa','DWA',1),(1951,128,'Karonga','KRG',1),(1952,128,'Kasungu','KSG',1),(1953,128,'Likoma','LKM',1),(1954,128,'Lilongwe','LLG',1),(1955,128,'Machinga','MCG',1),(1956,128,'Mangochi','MGC',1),(1957,128,'Mchinji','MCH',1),(1958,128,'Mulanje','MLJ',1),(1959,128,'Mwanza','MWZ',1),(1960,128,'Mzimba','MZM',1),(1961,128,'Ntcheu','NTU',1),(1962,128,'Nkhata Bay','NKB',1),(1963,128,'Nkhotakota','NKH',1),(1964,128,'Nsanje','NSJ',1),(1965,128,'Ntchisi','NTI',1),(1966,128,'Phalombe','PHL',1),(1967,128,'Rumphi','RMP',1),(1968,128,'Salima','SLM',1),(1969,128,'Thyolo','THY',1),(1970,128,'Zomba','ZBA',1),(1971,129,'Johor','JO',1),(1972,129,'Kedah','KE',1),(1973,129,'Kelantan','KL',1),(1974,129,'Labuan','LA',1),(1975,129,'Melaka','ME',1),(1976,129,'Negeri Sembilan','NS',1),(1977,129,'Pahang','PA',1),(1978,129,'Perak','PE',1),(1979,129,'Perlis','PR',1),(1980,129,'Pulau Pinang','PP',1),(1981,129,'Sabah','SA',1),(1982,129,'Sarawak','SR',1),(1983,129,'Selangor','SE',1),(1984,129,'Terengganu','TE',1),(1985,129,'Wilayah Persekutuan','WP',1),(1986,130,'Thiladhunmathi Uthuru','THU',1),(1987,130,'Thiladhunmathi Dhekunu','THD',1),(1988,130,'Miladhunmadulu Uthuru','MLU',1),(1989,130,'Miladhunmadulu Dhekunu','MLD',1),(1990,130,'Maalhosmadulu Uthuru','MAU',1),(1991,130,'Maalhosmadulu Dhekunu','MAD',1),(1992,130,'Faadhippolhu','FAA',1),(1993,130,'Male Atoll','MAA',1),(1994,130,'Ari Atoll Uthuru','AAU',1),(1995,130,'Ari Atoll Dheknu','AAD',1),(1996,130,'Felidhe Atoll','FEA',1),(1997,130,'Mulaku Atoll','MUA',1),(1998,130,'Nilandhe Atoll Uthuru','NAU',1),(1999,130,'Nilandhe Atoll Dhekunu','NAD',1),(2000,130,'Kolhumadulu','KLH',1),(2001,130,'Hadhdhunmathi','HDH',1),(2002,130,'Huvadhu Atoll Uthuru','HAU',1),(2003,130,'Huvadhu Atoll Dhekunu','HAD',1),(2004,130,'Fua Mulaku','FMU',1),(2005,130,'Addu','ADD',1),(2006,131,'Gao','GA',1),(2007,131,'Kayes','KY',1),(2008,131,'Kidal','KD',1),(2009,131,'Koulikoro','KL',1),(2010,131,'Mopti','MP',1),(2011,131,'Segou','SG',1),(2012,131,'Sikasso','SK',1),(2013,131,'Tombouctou','TB',1),(2014,131,'Bamako Capital District','CD',1),(2015,132,'Attard','ATT',1),(2016,132,'Balzan','BAL',1),(2017,132,'Birgu','BGU',1),(2018,132,'Birkirkara','BKK',1),(2019,132,'Birzebbuga','BRZ',1),(2020,132,'Bormla','BOR',1),(2021,132,'Dingli','DIN',1),(2022,132,'Fgura','FGU',1),(2023,132,'Floriana','FLO',1),(2024,132,'Gudja','GDJ',1),(2025,132,'Gzira','GZR',1),(2026,132,'Gargur','GRG',1),(2027,132,'Gaxaq','GXQ',1),(2028,132,'Hamrun','HMR',1),(2029,132,'Iklin','IKL',1),(2030,132,'Isla','ISL',1),(2031,132,'Kalkara','KLK',1),(2032,132,'Kirkop','KRK',1),(2033,132,'Lija','LIJ',1),(2034,132,'Luqa','LUQ',1),(2035,132,'Marsa','MRS',1),(2036,132,'Marsaskala','MKL',1),(2037,132,'Marsaxlokk','MXL',1),(2038,132,'Mdina','MDN',1),(2039,132,'Melliea','MEL',1),(2040,132,'Mgarr','MGR',1),(2041,132,'Mosta','MST',1),(2042,132,'Mqabba','MQA',1),(2043,132,'Msida','MSI',1),(2044,132,'Mtarfa','MTF',1),(2045,132,'Naxxar','NAX',1),(2046,132,'Paola','PAO',1),(2047,132,'Pembroke','PEM',1),(2048,132,'Pieta','PIE',1),(2049,132,'Qormi','QOR',1),(2050,132,'Qrendi','QRE',1),(2051,132,'Rabat','RAB',1),(2052,132,'Safi','SAF',1),(2053,132,'San Giljan','SGI',1),(2054,132,'Santa Lucija','SLU',1),(2055,132,'San Pawl il-Bahar','SPB',1),(2056,132,'San Gwann','SGW',1),(2057,132,'Santa Venera','SVE',1),(2058,132,'Siggiewi','SIG',1),(2059,132,'Sliema','SLM',1),(2060,132,'Swieqi','SWQ',1),(2061,132,'Ta Xbiex','TXB',1),(2062,132,'Tarxien','TRX',1),(2063,132,'Valletta','VLT',1),(2064,132,'Xgajra','XGJ',1),(2065,132,'Zabbar','ZBR',1),(2066,132,'Zebbug','ZBG',1),(2067,132,'Zejtun','ZJT',1),(2068,132,'Zurrieq','ZRQ',1),(2069,132,'Fontana','FNT',1),(2070,132,'Ghajnsielem','GHJ',1),(2071,132,'Gharb','GHR',1),(2072,132,'Ghasri','GHS',1),(2073,132,'Kercem','KRC',1),(2074,132,'Munxar','MUN',1),(2075,132,'Nadur','NAD',1),(2076,132,'Qala','QAL',1),(2077,132,'Victoria','VIC',1),(2078,132,'San Lawrenz','SLA',1),(2079,132,'Sannat','SNT',1),(2080,132,'Xagra','ZAG',1),(2081,132,'Xewkija','XEW',1),(2082,132,'Zebbug','ZEB',1),(2083,133,'Ailinginae','ALG',1),(2084,133,'Ailinglaplap','ALL',1),(2085,133,'Ailuk','ALK',1),(2086,133,'Arno','ARN',1),(2087,133,'Aur','AUR',1),(2088,133,'Bikar','BKR',1),(2089,133,'Bikini','BKN',1),(2090,133,'Bokak','BKK',1),(2091,133,'Ebon','EBN',1),(2092,133,'Enewetak','ENT',1),(2093,133,'Erikub','EKB',1),(2094,133,'Jabat','JBT',1),(2095,133,'Jaluit','JLT',1),(2096,133,'Jemo','JEM',1),(2097,133,'Kili','KIL',1),(2098,133,'Kwajalein','KWJ',1),(2099,133,'Lae','LAE',1),(2100,133,'Lib','LIB',1),(2101,133,'Likiep','LKP',1),(2102,133,'Majuro','MJR',1),(2103,133,'Maloelap','MLP',1),(2104,133,'Mejit','MJT',1),(2105,133,'Mili','MIL',1),(2106,133,'Namorik','NMK',1),(2107,133,'Namu','NAM',1),(2108,133,'Rongelap','RGL',1),(2109,133,'Rongrik','RGK',1),(2110,133,'Toke','TOK',1),(2111,133,'Ujae','UJA',1),(2112,133,'Ujelang','UJL',1),(2113,133,'Utirik','UTK',1),(2114,133,'Wotho','WTH',1),(2115,133,'Wotje','WTJ',1),(2116,135,'Adrar','AD',1),(2117,135,'Assaba','AS',1),(2118,135,'Brakna','BR',1),(2119,135,'Dakhlet Nouadhibou','DN',1),(2120,135,'Gorgol','GO',1),(2121,135,'Guidimaka','GM',1),(2122,135,'Hodh Ech Chargui','HC',1),(2123,135,'Hodh El Gharbi','HG',1),(2124,135,'Inchiri','IN',1),(2125,135,'Tagant','TA',1),(2126,135,'Tiris Zemmour','TZ',1),(2127,135,'Trarza','TR',1),(2128,135,'Nouakchott','NO',1),(2129,136,'Beau Bassin-Rose Hill','BR',1),(2130,136,'Curepipe','CU',1),(2131,136,'Port Louis','PU',1),(2132,136,'Quatre Bornes','QB',1),(2133,136,'Vacoas-Phoenix','VP',1),(2134,136,'Agalega Islands','AG',1),(2135,136,'Cargados Carajos Shoals (Saint Brandon Islands)','CC',1),(2136,136,'Rodrigues','RO',1),(2137,136,'Black River','BL',1),(2138,136,'Flacq','FL',1),(2139,136,'Grand Port','GP',1),(2140,136,'Moka','MO',1),(2141,136,'Pamplemousses','PA',1),(2142,136,'Plaines Wilhems','PW',1),(2143,136,'Port Louis','PL',1),(2144,136,'Riviere du Rempart','RR',1),(2145,136,'Savanne','SA',1),(2146,138,'Baja California Norte','BN',1),(2147,138,'Baja California Sur','BS',1),(2148,138,'Campeche','CA',1),(2149,138,'Chiapas','CI',1),(2150,138,'Chihuahua','CH',1),(2151,138,'Coahuila de Zaragoza','CZ',1),(2152,138,'Colima','CL',1),(2153,138,'Distrito Federal','DF',1),(2154,138,'Durango','DU',1),(2155,138,'Guanajuato','GA',1),(2156,138,'Guerrero','GE',1),(2157,138,'Hidalgo','HI',1),(2158,138,'Jalisco','JA',1),(2159,138,'Mexico','ME',1),(2160,138,'Michoacan de Ocampo','MI',1),(2161,138,'Morelos','MO',1),(2162,138,'Nayarit','NA',1),(2163,138,'Nuevo Leon','NL',1),(2164,138,'Oaxaca','OA',1),(2165,138,'Puebla','PU',1),(2166,138,'Queretaro de Arteaga','QA',1),(2167,138,'Quintana Roo','QR',1),(2168,138,'San Luis Potosi','SA',1),(2169,138,'Sinaloa','SI',1),(2170,138,'Sonora','SO',1),(2171,138,'Tabasco','TB',1),(2172,138,'Tamaulipas','TM',1),(2173,138,'Tlaxcala','TL',1),(2174,138,'Veracruz-Llave','VE',1),(2175,138,'Yucatan','YU',1),(2176,138,'Zacatecas','ZA',1),(2177,139,'Chuuk','C',1),(2178,139,'Kosrae','K',1),(2179,139,'Pohnpei','P',1),(2180,139,'Yap','Y',1),(2181,140,'Gagauzia','GA',1),(2182,140,'Chisinau','CU',1),(2183,140,'Balti','BA',1),(2184,140,'Cahul','CA',1),(2185,140,'Edinet','ED',1),(2186,140,'Lapusna','LA',1),(2187,140,'Orhei','OR',1),(2188,140,'Soroca','SO',1),(2189,140,'Tighina','TI',1),(2190,140,'Ungheni','UN',1),(2191,140,'St‚nga Nistrului','SN',1),(2192,141,'Fontvieille','FV',1),(2193,141,'La Condamine','LC',1),(2194,141,'Monaco-Ville','MV',1),(2195,141,'Monte-Carlo','MC',1),(2196,142,'Ulanbaatar','1',1),(2197,142,'Orhon','035',1),(2198,142,'Darhan uul','037',1),(2199,142,'Hentiy','039',1),(2200,142,'Hovsgol','041',1),(2201,142,'Hovd','043',1),(2202,142,'Uvs','046',1),(2203,142,'Tov','047',1),(2204,142,'Selenge','049',1),(2205,142,'Suhbaatar','051',1),(2206,142,'Omnogovi','053',1),(2207,142,'Ovorhangay','055',1),(2208,142,'Dzavhan','057',1),(2209,142,'DundgovL','059',1),(2210,142,'Dornod','061',1),(2211,142,'Dornogov','063',1),(2212,142,'Govi-Sumber','064',1),(2213,142,'Govi-Altay','065',1),(2214,142,'Bulgan','067',1),(2215,142,'Bayanhongor','069',1),(2216,142,'Bayan-Olgiy','071',1),(2217,142,'Arhangay','073',1),(2218,143,'Saint Anthony','A',1),(2219,143,'Saint Georges','G',1),(2220,143,'Saint Peter','P',1),(2221,144,'Agadir','AGD',1),(2222,144,'Al Hoceima','HOC',1),(2223,144,'Azilal','AZI',1),(2224,144,'Beni Mellal','BME',1),(2225,144,'Ben Slimane','BSL',1),(2226,144,'Boulemane','BLM',1),(2227,144,'Casablanca','CBL',1),(2228,144,'Chaouen','CHA',1),(2229,144,'El Jadida','EJA',1),(2230,144,'El Kelaa des Sraghna','EKS',1),(2231,144,'Er Rachidia','ERA',1),(2232,144,'Essaouira','ESS',1),(2233,144,'Fes','FES',1),(2234,144,'Figuig','FIG',1),(2235,144,'Guelmim','GLM',1),(2236,144,'Ifrane','IFR',1),(2237,144,'Kenitra','KEN',1),(2238,144,'Khemisset','KHM',1),(2239,144,'Khenifra','KHN',1),(2240,144,'Khouribga','KHO',1),(2241,144,'Laayoune','LYN',1),(2242,144,'Larache','LAR',1),(2243,144,'Marrakech','MRK',1),(2244,144,'Meknes','MKN',1),(2245,144,'Nador','NAD',1),(2246,144,'Ouarzazate','ORZ',1),(2247,144,'Oujda','OUJ',1),(2248,144,'Rabat-Sale','RSA',1),(2249,144,'Safi','SAF',1),(2250,144,'Settat','SET',1),(2251,144,'Sidi Kacem','SKA',1),(2252,144,'Tangier','TGR',1),(2253,144,'Tan-Tan','TAN',1),(2254,144,'Taounate','TAO',1),(2255,144,'Taroudannt','TRD',1),(2256,144,'Tata','TAT',1),(2257,144,'Taza','TAZ',1),(2258,144,'Tetouan','TET',1),(2259,144,'Tiznit','TIZ',1),(2260,144,'Ad Dakhla','ADK',1),(2261,144,'Boujdour','BJD',1),(2262,144,'Es Smara','ESM',1),(2263,145,'Cabo Delgado','CD',1),(2264,145,'Gaza','GZ',1),(2265,145,'Inhambane','IN',1),(2266,145,'Manica','MN',1),(2267,145,'Maputo (city)','MC',1),(2268,145,'Maputo','MP',1),(2269,145,'Nampula','NA',1),(2270,145,'Niassa','NI',1),(2271,145,'Sofala','SO',1),(2272,145,'Tete','TE',1),(2273,145,'Zambezia','ZA',1),(2274,146,'Ayeyarwady','AY',1),(2275,146,'Bago','BG',1),(2276,146,'Magway','MG',1),(2277,146,'Mandalay','MD',1),(2278,146,'Sagaing','SG',1),(2279,146,'Tanintharyi','TN',1),(2280,146,'Yangon','YG',1),(2281,146,'Chin State','CH',1),(2282,146,'Kachin State','KC',1),(2283,146,'Kayah State','KH',1),(2284,146,'Kayin State','KN',1),(2285,146,'Mon State','MN',1),(2286,146,'Rakhine State','RK',1),(2287,146,'Shan State','SH',1),(2288,147,'Caprivi','CA',1),(2289,147,'Erongo','ER',1),(2290,147,'Hardap','HA',1),(2291,147,'Karas','KR',1),(2292,147,'Kavango','KV',1),(2293,147,'Khomas','KH',1),(2294,147,'Kunene','KU',1),(2295,147,'Ohangwena','OW',1),(2296,147,'Omaheke','OK',1),(2297,147,'Omusati','OT',1),(2298,147,'Oshana','ON',1),(2299,147,'Oshikoto','OO',1),(2300,147,'Otjozondjupa','OJ',1),(2301,148,'Aiwo','AO',1),(2302,148,'Anabar','AA',1),(2303,148,'Anetan','AT',1),(2304,148,'Anibare','AI',1),(2305,148,'Baiti','BA',1),(2306,148,'Boe','BO',1),(2307,148,'Buada','BU',1),(2308,148,'Denigomodu','DE',1),(2309,148,'Ewa','EW',1),(2310,148,'Ijuw','IJ',1),(2311,148,'Meneng','ME',1),(2312,148,'Nibok','NI',1),(2313,148,'Uaboe','UA',1),(2314,148,'Yaren','YA',1),(2315,149,'Bagmati','BA',1),(2316,149,'Bheri','BH',1),(2317,149,'Dhawalagiri','DH',1),(2318,149,'Gandaki','GA',1),(2319,149,'Janakpur','JA',1),(2320,149,'Karnali','KA',1),(2321,149,'Kosi','KO',1),(2322,149,'Lumbini','LU',1),(2323,149,'Mahakali','MA',1),(2324,149,'Mechi','ME',1),(2325,149,'Narayani','NA',1),(2326,149,'Rapti','RA',1),(2327,149,'Sagarmatha','SA',1),(2328,149,'Seti','SE',1),(2329,150,'Drenthe','DR',1),(2330,150,'Flevoland','FL',1),(2331,150,'Friesland','FR',1),(2332,150,'Gelderland','GE',1),(2333,150,'Groningen','GR',1),(2334,150,'Limburg','LI',1),(2335,150,'Noord Brabant','NB',1),(2336,150,'Noord Holland','NH',1),(2337,150,'Overijssel','OV',1),(2338,150,'Utrecht','UT',1),(2339,150,'Zeeland','ZE',1),(2340,150,'Zuid Holland','ZH',1),(2341,152,'Iles Loyaute','L',1),(2342,152,'Nord','N',1),(2343,152,'Sud','S',1),(2344,153,'Auckland','AUK',1),(2345,153,'Bay of Plenty','BOP',1),(2346,153,'Canterbury','CAN',1),(2347,153,'Coromandel','COR',1),(2348,153,'Gisborne','GIS',1),(2349,153,'Fiordland','FIO',1),(2350,153,'Hawke\'s Bay','HKB',1),(2351,153,'Marlborough','MBH',1),(2352,153,'Manawatu-Wanganui','MWT',1),(2353,153,'Mt Cook-Mackenzie','MCM',1),(2354,153,'Nelson','NSN',1),(2355,153,'Northland','NTL',1),(2356,153,'Otago','OTA',1),(2357,153,'Southland','STL',1),(2358,153,'Taranaki','TKI',1),(2359,153,'Wellington','WGN',1),(2360,153,'Waikato','WKO',1),(2361,153,'Wairprarapa','WAI',1),(2362,153,'West Coast','WTC',1),(2363,154,'Atlantico Norte','AN',1),(2364,154,'Atlantico Sur','AS',1),(2365,154,'Boaco','BO',1),(2366,154,'Carazo','CA',1),(2367,154,'Chinandega','CI',1),(2368,154,'Chontales','CO',1),(2369,154,'Esteli','ES',1),(2370,154,'Granada','GR',1),(2371,154,'Jinotega','JI',1),(2372,154,'Leon','LE',1),(2373,154,'Madriz','MD',1),(2374,154,'Managua','MN',1),(2375,154,'Masaya','MS',1),(2376,154,'Matagalpa','MT',1),(2377,154,'Nuevo Segovia','NS',1),(2378,154,'Rio San Juan','RS',1),(2379,154,'Rivas','RI',1),(2380,155,'Agadez','AG',1),(2381,155,'Diffa','DF',1),(2382,155,'Dosso','DS',1),(2383,155,'Maradi','MA',1),(2384,155,'Niamey','NM',1),(2385,155,'Tahoua','TH',1),(2386,155,'Tillaberi','TL',1),(2387,155,'Zinder','ZD',1),(2388,156,'Abia','AB',1),(2389,156,'Abuja Federal Capital Territory','CT',1),(2390,156,'Adamawa','AD',1),(2391,156,'Akwa Ibom','AK',1),(2392,156,'Anambra','AN',1),(2393,156,'Bauchi','BC',1),(2394,156,'Bayelsa','BY',1),(2395,156,'Benue','BN',1),(2396,156,'Borno','BO',1),(2397,156,'Cross River','CR',1),(2398,156,'Delta','DE',1),(2399,156,'Ebonyi','EB',1),(2400,156,'Edo','ED',1),(2401,156,'Ekiti','EK',1),(2402,156,'Enugu','EN',1),(2403,156,'Gombe','GO',1),(2404,156,'Imo','IM',1),(2405,156,'Jigawa','JI',1),(2406,156,'Kaduna','KD',1),(2407,156,'Kano','KN',1),(2408,156,'Katsina','KT',1),(2409,156,'Kebbi','KE',1),(2410,156,'Kogi','KO',1),(2411,156,'Kwara','KW',1),(2412,156,'Lagos','LA',1),(2413,156,'Nassarawa','NA',1),(2414,156,'Niger','NI',1),(2415,156,'Ogun','OG',1),(2416,156,'Ondo','ONG',1),(2417,156,'Osun','OS',1),(2418,156,'Oyo','OY',1),(2419,156,'Plateau','PL',1),(2420,156,'Rivers','RI',1),(2421,156,'Sokoto','SO',1),(2422,156,'Taraba','TA',1),(2423,156,'Yobe','YO',1),(2424,156,'Zamfara','ZA',1),(2425,159,'Northern Islands','N',1),(2426,159,'Rota','R',1),(2427,159,'Saipan','S',1),(2428,159,'Tinian','T',1),(2429,160,'Akershus','AK',1),(2430,160,'Aust-Agder','AA',1),(2431,160,'Buskerud','BU',1),(2432,160,'Finnmark','FM',1),(2433,160,'Hedmark','HM',1),(2434,160,'Hordaland','HL',1),(2435,160,'More og Romdal','MR',1),(2436,160,'Nord-Trondelag','NT',1),(2437,160,'Nordland','NL',1),(2438,160,'Ostfold','OF',1),(2439,160,'Oppland','OP',1),(2440,160,'Oslo','OL',1),(2441,160,'Rogaland','RL',1),(2442,160,'Sor-Trondelag','ST',1),(2443,160,'Sogn og Fjordane','SJ',1),(2444,160,'Svalbard','SV',1),(2445,160,'Telemark','TM',1),(2446,160,'Troms','TR',1),(2447,160,'Vest-Agder','VA',1),(2448,160,'Vestfold','VF',1),(2449,161,'Ad Dakhiliyah','DA',1),(2450,161,'Al Batinah','BA',1),(2451,161,'Al Wusta','WU',1),(2452,161,'Ash Sharqiyah','SH',1),(2453,161,'Az Zahirah','ZA',1),(2454,161,'Masqat','MA',1),(2455,161,'Musandam','MU',1),(2456,161,'Zufar','ZU',1),(2457,162,'Balochistan','B',1),(2458,162,'Federally Administered Tribal Areas','T',1),(2459,162,'Islamabad Capital Territory','I',1),(2460,162,'North-West Frontier','N',1),(2461,162,'Punjab','P',1),(2462,162,'Sindh','S',1),(2463,163,'Aimeliik','AM',1),(2464,163,'Airai','AR',1),(2465,163,'Angaur','AN',1),(2466,163,'Hatohobei','HA',1),(2467,163,'Kayangel','KA',1),(2468,163,'Koror','KO',1),(2469,163,'Melekeok','ME',1),(2470,163,'Ngaraard','NA',1),(2471,163,'Ngarchelong','NG',1),(2472,163,'Ngardmau','ND',1),(2473,163,'Ngatpang','NT',1),(2474,163,'Ngchesar','NC',1),(2475,163,'Ngeremlengui','NR',1),(2476,163,'Ngiwal','NW',1),(2477,163,'Peleliu','PE',1),(2478,163,'Sonsorol','SO',1),(2479,164,'Bocas del Toro','BT',1),(2480,164,'Chiriqui','CH',1),(2481,164,'Cocle','CC',1),(2482,164,'Colon','CL',1),(2483,164,'Darien','DA',1),(2484,164,'Herrera','HE',1),(2485,164,'Los Santos','LS',1),(2486,164,'Panama','PA',1),(2487,164,'San Blas','SB',1),(2488,164,'Veraguas','VG',1),(2489,165,'Bougainville','BV',1),(2490,165,'Central','CE',1),(2491,165,'Chimbu','CH',1),(2492,165,'Eastern Highlands','EH',1),(2493,165,'East New Britain','EB',1),(2494,165,'East Sepik','ES',1),(2495,165,'Enga','EN',1),(2496,165,'Gulf','GU',1),(2497,165,'Madang','MD',1),(2498,165,'Manus','MN',1),(2499,165,'Milne Bay','MB',1),(2500,165,'Morobe','MR',1),(2501,165,'National Capital','NC',1),(2502,165,'New Ireland','NI',1),(2503,165,'Northern','NO',1),(2504,165,'Sandaun','SA',1),(2505,165,'Southern Highlands','SH',1),(2506,165,'Western','WE',1),(2507,165,'Western Highlands','WH',1),(2508,165,'West New Britain','WB',1),(2509,166,'Alto Paraguay','AG',1),(2510,166,'Alto Parana','AN',1),(2511,166,'Amambay','AM',1),(2512,166,'Asuncion','AS',1),(2513,166,'Boqueron','BO',1),(2514,166,'Caaguazu','CG',1),(2515,166,'Caazapa','CZ',1),(2516,166,'Canindeyu','CN',1),(2517,166,'Central','CE',1),(2518,166,'Concepcion','CC',1),(2519,166,'Cordillera','CD',1),(2520,166,'Guaira','GU',1),(2521,166,'Itapua','IT',1),(2522,166,'Misiones','MI',1),(2523,166,'Neembucu','NE',1),(2524,166,'Paraguari','PA',1),(2525,166,'Presidente Hayes','PH',1),(2526,166,'San Pedro','SP',1),(2527,167,'Amazonas','AM',1),(2528,167,'Ancash','AN',1),(2529,167,'Apurimac','AP',1),(2530,167,'Arequipa','AR',1),(2531,167,'Ayacucho','AY',1),(2532,167,'Cajamarca','CJ',1),(2533,167,'Callao','CL',1),(2534,167,'Cusco','CU',1),(2535,167,'Huancavelica','HV',1),(2536,167,'Huanuco','HO',1),(2537,167,'Ica','IC',1),(2538,167,'Junin','JU',1),(2539,167,'La Libertad','LD',1),(2540,167,'Lambayeque','LY',1),(2541,167,'Lima','LI',1),(2542,167,'Loreto','LO',1),(2543,167,'Madre de Dios','MD',1),(2544,167,'Moquegua','MO',1),(2545,167,'Pasco','PA',1),(2546,167,'Piura','PI',1),(2547,167,'Puno','PU',1),(2548,167,'San Martin','SM',1),(2549,167,'Tacna','TA',1),(2550,167,'Tumbes','TU',1),(2551,167,'Ucayali','UC',1),(2552,168,'Abra','ABR',1),(2553,168,'Agusan del Norte','ANO',1),(2554,168,'Agusan del Sur','ASU',1),(2555,168,'Aklan','AKL',1),(2556,168,'Albay','ALB',1),(2557,168,'Antique','ANT',1),(2558,168,'Apayao','APY',1),(2559,168,'Aurora','AUR',1),(2560,168,'Basilan','BAS',1),(2561,168,'Bataan','BTA',1),(2562,168,'Batanes','BTE',1),(2563,168,'Batangas','BTG',1),(2564,168,'Biliran','BLR',1),(2565,168,'Benguet','BEN',1),(2566,168,'Bohol','BOL',1),(2567,168,'Bukidnon','BUK',1),(2568,168,'Bulacan','BUL',1),(2569,168,'Cagayan','CAG',1),(2570,168,'Camarines Norte','CNO',1),(2571,168,'Camarines Sur','CSU',1),(2572,168,'Camiguin','CAM',1),(2573,168,'Capiz','CAP',1),(2574,168,'Catanduanes','CAT',1),(2575,168,'Cavite','CAV',1),(2576,168,'Cebu','CEB',1),(2577,168,'Compostela','CMP',1),(2578,168,'Davao del Norte','DNO',1),(2579,168,'Davao del Sur','DSU',1),(2580,168,'Davao Oriental','DOR',1),(2581,168,'Eastern Samar','ESA',1),(2582,168,'Guimaras','GUI',1),(2583,168,'Ifugao','IFU',1),(2584,168,'Ilocos Norte','INO',1),(2585,168,'Ilocos Sur','ISU',1),(2586,168,'Iloilo','ILO',1),(2587,168,'Isabela','ISA',1),(2588,168,'Kalinga','KAL',1),(2589,168,'Laguna','LAG',1),(2590,168,'Lanao del Norte','LNO',1),(2591,168,'Lanao del Sur','LSU',1),(2592,168,'La Union','UNI',1),(2593,168,'Leyte','LEY',1),(2594,168,'Maguindanao','MAG',1),(2595,168,'Marinduque','MRN',1),(2596,168,'Masbate','MSB',1),(2597,168,'Mindoro Occidental','MIC',1),(2598,168,'Mindoro Oriental','MIR',1),(2599,168,'Misamis Occidental','MSC',1),(2600,168,'Misamis Oriental','MOR',1),(2601,168,'Mountain','MOP',1),(2602,168,'Negros Occidental','NOC',1),(2603,168,'Negros Oriental','NOR',1),(2604,168,'North Cotabato','NCT',1),(2605,168,'Northern Samar','NSM',1),(2606,168,'Nueva Ecija','NEC',1),(2607,168,'Nueva Vizcaya','NVZ',1),(2608,168,'Palawan','PLW',1),(2609,168,'Pampanga','PMP',1),(2610,168,'Pangasinan','PNG',1),(2611,168,'Quezon','QZN',1),(2612,168,'Quirino','QRN',1),(2613,168,'Rizal','RIZ',1),(2614,168,'Romblon','ROM',1),(2615,168,'Samar','SMR',1),(2616,168,'Sarangani','SRG',1),(2617,168,'Siquijor','SQJ',1),(2618,168,'Sorsogon','SRS',1),(2619,168,'South Cotabato','SCO',1),(2620,168,'Southern Leyte','SLE',1),(2621,168,'Sultan Kudarat','SKU',1),(2622,168,'Sulu','SLU',1),(2623,168,'Surigao del Norte','SNO',1),(2624,168,'Surigao del Sur','SSU',1),(2625,168,'Tarlac','TAR',1),(2626,168,'Tawi-Tawi','TAW',1),(2627,168,'Zambales','ZBL',1),(2628,168,'Zamboanga del Norte','ZNO',1),(2629,168,'Zamboanga del Sur','ZSU',1),(2630,168,'Zamboanga Sibugay','ZSI',1),(2631,170,'Dolnoslaskie','DO',1),(2632,170,'Kujawsko-Pomorskie','KP',1),(2633,170,'Lodzkie','LO',1),(2634,170,'Lubelskie','LL',1),(2635,170,'Lubuskie','LU',1),(2636,170,'Malopolskie','ML',1),(2637,170,'Mazowieckie','MZ',1),(2638,170,'Opolskie','OP',1),(2639,170,'Podkarpackie','PP',1),(2640,170,'Podlaskie','PL',1),(2641,170,'Pomorskie','PM',1),(2642,170,'Slaskie','SL',1),(2643,170,'Swietokrzyskie','SW',1),(2644,170,'Warminsko-Mazurskie','WM',1),(2645,170,'Wielkopolskie','WP',1),(2646,170,'Zachodniopomorskie','ZA',1),(2647,198,'Saint Pierre','P',1),(2648,198,'Miquelon','M',1),(2649,171,'A&ccedil;ores','AC',1),(2650,171,'Aveiro','AV',1),(2651,171,'Beja','BE',1),(2652,171,'Braga','BR',1),(2653,171,'Bragan&ccedil;a','BA',1),(2654,171,'Castelo Branco','CB',1),(2655,171,'Coimbra','CO',1),(2656,171,'&Eacute;vora','EV',1),(2657,171,'Faro','FA',1),(2658,171,'Guarda','GU',1),(2659,171,'Leiria','LE',1),(2660,171,'Lisboa','LI',1),(2661,171,'Madeira','ME',1),(2662,171,'Portalegre','PO',1),(2663,171,'Porto','PR',1),(2664,171,'Santar&eacute;m','SA',1),(2665,171,'Set&uacute;bal','SE',1),(2666,171,'Viana do Castelo','VC',1),(2667,171,'Vila Real','VR',1),(2668,171,'Viseu','VI',1),(2669,173,'Ad Dawhah','DW',1),(2670,173,'Al Ghuwayriyah','GW',1),(2671,173,'Al Jumayliyah','JM',1),(2672,173,'Al Khawr','KR',1),(2673,173,'Al Wakrah','WK',1),(2674,173,'Ar Rayyan','RN',1),(2675,173,'Jarayan al Batinah','JB',1),(2676,173,'Madinat ash Shamal','MS',1),(2677,173,'Umm Sa\'id','UD',1),(2678,173,'Umm Salal','UL',1),(2679,175,'Alba','AB',1),(2680,175,'Arad','AR',1),(2681,175,'Arges','AG',1),(2682,175,'Bacau','BC',1),(2683,175,'Bihor','BH',1),(2684,175,'Bistrita-Nasaud','BN',1),(2685,175,'Botosani','BT',1),(2686,175,'Brasov','BV',1),(2687,175,'Braila','BR',1),(2688,175,'Bucuresti','B',1),(2689,175,'Buzau','BZ',1),(2690,175,'Caras-Severin','CS',1),(2691,175,'Calarasi','CL',1),(2692,175,'Cluj','CJ',1),(2693,175,'Constanta','CT',1),(2694,175,'Covasna','CV',1),(2695,175,'Dimbovita','DB',1),(2696,175,'Dolj','DJ',1),(2697,175,'Galati','GL',1),(2698,175,'Giurgiu','GR',1),(2699,175,'Gorj','GJ',1),(2700,175,'Harghita','HR',1),(2701,175,'Hunedoara','HD',1),(2702,175,'Ialomita','IL',1),(2703,175,'Iasi','IS',1),(2704,175,'Ilfov','IF',1),(2705,175,'Maramures','MM',1),(2706,175,'Mehedinti','MH',1),(2707,175,'Mures','MS',1),(2708,175,'Neamt','NT',1),(2709,175,'Olt','OT',1),(2710,175,'Prahova','PH',1),(2711,175,'Satu-Mare','SM',1),(2712,175,'Salaj','SJ',1),(2713,175,'Sibiu','SB',1),(2714,175,'Suceava','SV',1),(2715,175,'Teleorman','TR',1),(2716,175,'Timis','TM',1),(2717,175,'Tulcea','TL',1),(2718,175,'Vaslui','VS',1),(2719,175,'Valcea','VL',1),(2720,175,'Vrancea','VN',1),(2721,176,'Республика Хакасия','KK',1),(2722,176,'Московская область','MOS',1),(2723,176,'Чукотский АО','CHU',1),(2724,176,'Архангельская область','ARK',1),(2725,176,'Астраханская область','AST',1),(2726,176,'Алтайский край','ALT',1),(2727,176,'Белгородская область','BEL',1),(2728,176,'Еврейская АО','YEV',1),(2729,176,'Амурская область','AMU',1),(2730,176,'Брянская область','BRY',1),(2731,176,'Чувашская Республика','CU',1),(2732,176,'Челябинская область','CHE',1),(2733,176,'Карачаево-Черкеcсия','KC',1),(2734,176,'Забайкальский край','ZAB',1),(2735,176,'Ленинградская область','LEN',1),(2736,176,'Республика Калмыкия','KL',1),(2737,176,'Сахалинская область','SAK',1),(2738,176,'Республика Алтай','AL',1),(2739,176,'Чеченская Республика','CE',1),(2740,176,'Иркутская область','IRK',1),(2741,176,'Ивановская область','IVA',1),(2742,176,'Удмуртская Республика','UD',1),(2743,176,'Калининградская область','KGD',1),(2744,176,'Калужская область','KLU',1),(2746,176,'Республика Татарстан','TA',1),(2747,176,'Кемеровская область','KEM',1),(2748,176,'Хабаровский край','KHA',1),(2749,176,'Ханты-Мансийский АО - Югра','KHM',1),(2750,176,'Костромская область','KOS',1),(2751,176,'Краснодарский край','KDA',1),(2752,176,'Красноярский край','KYA',1),(2754,176,'Курганская область','KGN',1),(2755,176,'Курская область','KRS',1),(2756,176,'Республика Тыва','TY',1),(2757,176,'Липецкая область','LIP',1),(2758,176,'Магаданская область','MAG',1),(2759,176,'Республика Дагестан','DA',1),(2760,176,'Республика Адыгея','AD',1),(2761,176,'Москва','MOW',1),(2762,176,'Мурманская область','MUR',1),(2763,176,'Республика Кабардино-Балкария','KB',1),(2764,176,'Ненецкий АО','NEN',1),(2765,176,'Республика Ингушетия','IN',1),(2766,176,'Нижегородская область','NIZ',1),(2767,176,'Новгородская область','NGR',1),(2768,176,'Новосибирская область','NVS',1),(2769,176,'Омская область','OMS',1),(2770,176,'Орловская область','ORL',1),(2771,176,'Оренбургская область','ORE',1),(2773,176,'Пензенская область','PNZ',1),(2774,176,'Пермский край','PER',1),(2775,176,'Камчатский край','KAM',1),(2776,176,'Республика Карелия','KR',1),(2777,176,'Псковская область','PSK',1),(2778,176,'Ростовская область','ROS',1),(2779,176,'Рязанская область','RYA',1),(2780,176,'Ямало-Ненецкий АО','YAN',1),(2781,176,'Самарская область','SAM',1),(2782,176,'Республика Мордовия','MO',1),(2783,176,'Саратовская область','SAR',1),(2784,176,'Смоленская область','SMO',1),(2785,176,'Санкт-Петербург','SPE',1),(2786,176,'Ставропольский край','STA',1),(2787,176,'Республика Коми','KO',1),(2788,176,'Тамбовская область','TAM',1),(2789,176,'Томская область','TOM',1),(2790,176,'Тульская область','TUL',1),(2792,176,'Тверская область','TVE',1),(2793,176,'Тюменская область','TYU',1),(2794,176,'Республика Башкортостан','BA',1),(2795,176,'Ульяновская область','ULY',1),(2796,176,'Республика Бурятия','BU',1),(2798,176,'Республика Северная Осетия','SE',1),(2799,176,'Владимирская область','VLA',1),(2800,176,'Приморский край','PRI',1),(2801,176,'Волгоградская область','VGG',1),(2802,176,'Вологодская область','VLG',1),(2803,176,'Воронежская область','VOR',1),(2804,176,'Кировская область','KIR',1),(2805,176,'Республика Саха','SA',1),(2806,176,'Ярославская область','YAR',1),(2807,176,'Свердловская область','SVE',1),(2808,176,'Республика Марий Эл','ME',1),(2809,177,'Butare','BU',1),(2810,177,'Byumba','BY',1),(2811,177,'Cyangugu','CY',1),(2812,177,'Gikongoro','GK',1),(2813,177,'Gisenyi','GS',1),(2814,177,'Gitarama','GT',1),(2815,177,'Kibungo','KG',1),(2816,177,'Kibuye','KY',1),(2817,177,'Kigali Rurale','KR',1),(2818,177,'Kigali-ville','KV',1),(2819,177,'Ruhengeri','RU',1),(2820,177,'Umutara','UM',1),(2821,178,'Christ Church Nichola Town','CCN',1),(2822,178,'Saint Anne Sandy Point','SAS',1),(2823,178,'Saint George Basseterre','SGB',1),(2824,178,'Saint George Gingerland','SGG',1),(2825,178,'Saint James Windward','SJW',1),(2826,178,'Saint John Capesterre','SJC',1),(2827,178,'Saint John Figtree','SJF',1),(2828,178,'Saint Mary Cayon','SMC',1),(2829,178,'Saint Paul Capesterre','CAP',1),(2830,178,'Saint Paul Charlestown','CHA',1),(2831,178,'Saint Peter Basseterre','SPB',1),(2832,178,'Saint Thomas Lowland','STL',1),(2833,178,'Saint Thomas Middle Island','STM',1),(2834,178,'Trinity Palmetto Point','TPP',1),(2835,179,'Anse-la-Raye','AR',1),(2836,179,'Castries','CA',1),(2837,179,'Choiseul','CH',1),(2838,179,'Dauphin','DA',1),(2839,179,'Dennery','DE',1),(2840,179,'Gros-Islet','GI',1),(2841,179,'Laborie','LA',1),(2842,179,'Micoud','MI',1),(2843,179,'Praslin','PR',1),(2844,179,'Soufriere','SO',1),(2845,179,'Vieux-Fort','VF',1),(2846,180,'Charlotte','C',1),(2847,180,'Grenadines','R',1),(2848,180,'Saint Andrew','A',1),(2849,180,'Saint David','D',1),(2850,180,'Saint George','G',1),(2851,180,'Saint Patrick','P',1),(2852,181,'A\'ana','AN',1),(2853,181,'Aiga-i-le-Tai','AI',1),(2854,181,'Atua','AT',1),(2855,181,'Fa\'asaleleaga','FA',1),(2856,181,'Gaga\'emauga','GE',1),(2857,181,'Gagaifomauga','GF',1),(2858,181,'Palauli','PA',1),(2859,181,'Satupa\'itea','SA',1),(2860,181,'Tuamasaga','TU',1),(2861,181,'Va\'a-o-Fonoti','VF',1),(2862,181,'Vaisigano','VS',1),(2863,182,'Acquaviva','AC',1),(2864,182,'Borgo Maggiore','BM',1),(2865,182,'Chiesanuova','CH',1),(2866,182,'Domagnano','DO',1),(2867,182,'Faetano','FA',1),(2868,182,'Fiorentino','FI',1),(2869,182,'Montegiardino','MO',1),(2870,182,'Citta di San Marino','SM',1),(2871,182,'Serravalle','SE',1),(2872,183,'Sao Tome','S',1),(2873,183,'Principe','P',1),(2874,184,'Al Bahah','BH',1),(2875,184,'Al Hudud ash Shamaliyah','HS',1),(2876,184,'Al Jawf','JF',1),(2877,184,'Al Madinah','MD',1),(2878,184,'Al Qasim','QS',1),(2879,184,'Ar Riyad','RD',1),(2880,184,'Ash Sharqiyah (Eastern)','AQ',1),(2881,184,'\'Asir','AS',1),(2882,184,'Ha\'il','HL',1),(2883,184,'Jizan','JZ',1),(2884,184,'Makkah','ML',1),(2885,184,'Najran','NR',1),(2886,184,'Tabuk','TB',1),(2887,185,'Dakar','DA',1),(2888,185,'Diourbel','DI',1),(2889,185,'Fatick','FA',1),(2890,185,'Kaolack','KA',1),(2891,185,'Kolda','KO',1),(2892,185,'Louga','LO',1),(2893,185,'Matam','MA',1),(2894,185,'Saint-Louis','SL',1),(2895,185,'Tambacounda','TA',1),(2896,185,'Thies','TH',1),(2897,185,'Ziguinchor','ZI',1),(2898,186,'Anse aux Pins','AP',1),(2899,186,'Anse Boileau','AB',1),(2900,186,'Anse Etoile','AE',1),(2901,186,'Anse Louis','AL',1),(2902,186,'Anse Royale','AR',1),(2903,186,'Baie Lazare','BL',1),(2904,186,'Baie Sainte Anne','BS',1),(2905,186,'Beau Vallon','BV',1),(2906,186,'Bel Air','BA',1),(2907,186,'Bel Ombre','BO',1),(2908,186,'Cascade','CA',1),(2909,186,'Glacis','GL',1),(2910,186,'Grand\' Anse (on Mahe)','GM',1),(2911,186,'Grand\' Anse (on Praslin)','GP',1),(2912,186,'La Digue','DG',1),(2913,186,'La Riviere Anglaise','RA',1),(2914,186,'Mont Buxton','MB',1),(2915,186,'Mont Fleuri','MF',1),(2916,186,'Plaisance','PL',1),(2917,186,'Pointe La Rue','PR',1),(2918,186,'Port Glaud','PG',1),(2919,186,'Saint Louis','SL',1),(2920,186,'Takamaka','TA',1),(2921,187,'Eastern','E',1),(2922,187,'Northern','N',1),(2923,187,'Southern','S',1),(2924,187,'Western','W',1),(2925,189,'Banskobystrický','BA',1),(2926,189,'Bratislavský','BR',1),(2927,189,'Košický','KO',1),(2928,189,'Nitriansky','NI',1),(2929,189,'Prešovský','PR',1),(2930,189,'Trenčiansky','TC',1),(2931,189,'Trnavský','TV',1),(2932,189,'Žilinský','ZI',1),(2933,191,'Central','CE',1),(2934,191,'Choiseul','CH',1),(2935,191,'Guadalcanal','GC',1),(2936,191,'Honiara','HO',1),(2937,191,'Isabel','IS',1),(2938,191,'Makira','MK',1),(2939,191,'Malaita','ML',1),(2940,191,'Rennell and Bellona','RB',1),(2941,191,'Temotu','TM',1),(2942,191,'Western','WE',1),(2943,192,'Awdal','AW',1),(2944,192,'Bakool','BK',1),(2945,192,'Banaadir','BN',1),(2946,192,'Bari','BR',1),(2947,192,'Bay','BY',1),(2948,192,'Galguduud','GA',1),(2949,192,'Gedo','GE',1),(2950,192,'Hiiraan','HI',1),(2951,192,'Jubbada Dhexe','JD',1),(2952,192,'Jubbada Hoose','JH',1),(2953,192,'Mudug','MU',1),(2954,192,'Nugaal','NU',1),(2955,192,'Sanaag','SA',1),(2956,192,'Shabeellaha Dhexe','SD',1),(2957,192,'Shabeellaha Hoose','SH',1),(2958,192,'Sool','SL',1),(2959,192,'Togdheer','TO',1),(2960,192,'Woqooyi Galbeed','WG',1),(2961,193,'Eastern Cape','EC',1),(2962,193,'Free State','FS',1),(2963,193,'Gauteng','GT',1),(2964,193,'KwaZulu-Natal','KN',1),(2965,193,'Limpopo','LP',1),(2966,193,'Mpumalanga','MP',1),(2967,193,'North West','NW',1),(2968,193,'Northern Cape','NC',1),(2969,193,'Western Cape','WC',1),(2970,195,'La Coru&ntilde;a','CA',1),(2971,195,'&Aacute;lava','AL',1),(2972,195,'Albacete','AB',1),(2973,195,'Alicante','AC',1),(2974,195,'Almeria','AM',1),(2975,195,'Asturias','AS',1),(2976,195,'&Aacute;vila','AV',1),(2977,195,'Badajoz','BJ',1),(2978,195,'Baleares','IB',1),(2979,195,'Barcelona','BA',1),(2980,195,'Burgos','BU',1),(2981,195,'C&aacute;ceres','CC',1),(2982,195,'C&aacute;diz','CZ',1),(2983,195,'Cantabria','CT',1),(2984,195,'Castell&oacute;n','CL',1),(2985,195,'Ceuta','CE',1),(2986,195,'Ciudad Real','CR',1),(2987,195,'C&oacute;rdoba','CD',1),(2988,195,'Cuenca','CU',1),(2989,195,'Girona','GI',1),(2990,195,'Granada','GD',1),(2991,195,'Guadalajara','GJ',1),(2992,195,'Guip&uacute;zcoa','GP',1),(2993,195,'Huelva','HL',1),(2994,195,'Huesca','HS',1),(2995,195,'Ja&eacute;n','JN',1),(2996,195,'La Rioja','RJ',1),(2997,195,'Las Palmas','PM',1),(2998,195,'Leon','LE',1),(2999,195,'Lleida','LL',1),(3000,195,'Lugo','LG',1),(3001,195,'Madrid','MD',1),(3002,195,'Malaga','MA',1),(3003,195,'Melilla','ML',1),(3004,195,'Murcia','MU',1),(3005,195,'Navarra','NV',1),(3006,195,'Ourense','OU',1),(3007,195,'Palencia','PL',1),(3008,195,'Pontevedra','PO',1),(3009,195,'Salamanca','SL',1),(3010,195,'Santa Cruz de Tenerife','SC',1),(3011,195,'Segovia','SG',1),(3012,195,'Sevilla','SV',1),(3013,195,'Soria','SO',1),(3014,195,'Tarragona','TA',1),(3015,195,'Teruel','TE',1),(3016,195,'Toledo','TO',1),(3017,195,'Valencia','VC',1),(3018,195,'Valladolid','VD',1),(3019,195,'Vizcaya','VZ',1),(3020,195,'Zamora','ZM',1),(3021,195,'Zaragoza','ZR',1),(3022,196,'Central','CE',1),(3023,196,'Eastern','EA',1),(3024,196,'North Central','NC',1),(3025,196,'Northern','NO',1),(3026,196,'North Western','NW',1),(3027,196,'Sabaragamuwa','SA',1),(3028,196,'Southern','SO',1),(3029,196,'Uva','UV',1),(3030,196,'Western','WE',1),(3031,197,'Ascension','A',1),(3032,197,'Saint Helena','S',1),(3033,197,'Tristan da Cunha','T',1),(3034,199,'A\'ali an Nil','ANL',1),(3035,199,'Al Bahr al Ahmar','BAM',1),(3036,199,'Al Buhayrat','BRT',1),(3037,199,'Al Jazirah','JZR',1),(3038,199,'Al Khartum','KRT',1),(3039,199,'Al Qadarif','QDR',1),(3040,199,'Al Wahdah','WDH',1),(3041,199,'An Nil al Abyad','ANB',1),(3042,199,'An Nil al Azraq','ANZ',1),(3043,199,'Ash Shamaliyah','ASH',1),(3044,199,'Bahr al Jabal','BJA',1),(3045,199,'Gharb al Istiwa\'iyah','GIS',1),(3046,199,'Gharb Bahr al Ghazal','GBG',1),(3047,199,'Gharb Darfur','GDA',1),(3048,199,'Gharb Kurdufan','GKU',1),(3049,199,'Janub Darfur','JDA',1),(3050,199,'Janub Kurdufan','JKU',1),(3051,199,'Junqali','JQL',1),(3052,199,'Kassala','KSL',1),(3053,199,'Nahr an Nil','NNL',1),(3054,199,'Shamal Bahr al Ghazal','SBG',1),(3055,199,'Shamal Darfur','SDA',1),(3056,199,'Shamal Kurdufan','SKU',1),(3057,199,'Sharq al Istiwa\'iyah','SIS',1),(3058,199,'Sinnar','SNR',1),(3059,199,'Warab','WRB',1),(3060,200,'Brokopondo','BR',1),(3061,200,'Commewijne','CM',1),(3062,200,'Coronie','CR',1),(3063,200,'Marowijne','MA',1),(3064,200,'Nickerie','NI',1),(3065,200,'Para','PA',1),(3066,200,'Paramaribo','PM',1),(3067,200,'Saramacca','SA',1),(3068,200,'Sipaliwini','SI',1),(3069,200,'Wanica','WA',1),(3070,202,'Hhohho','H',1),(3071,202,'Lubombo','L',1),(3072,202,'Manzini','M',1),(3073,202,'Shishelweni','S',1),(3074,203,'Blekinge','K',1),(3075,203,'Dalarna','W',1),(3076,203,'G&auml;vleborg','X',1),(3077,203,'Gotland','I',1),(3078,203,'Halland','N',1),(3079,203,'J&auml;mtland','Z',1),(3080,203,'J&ouml;nk&ouml;ping','F',1),(3081,203,'Kalmar','H',1),(3082,203,'Kronoberg','G',1),(3083,203,'Norrbotten','BD',1),(3084,203,'&Ouml;rebro','T',1),(3085,203,'&Ouml;sterg&ouml;tland','E',1),(3086,203,'Sk&aring;ne','M',1),(3087,203,'S&ouml;dermanland','D',1),(3088,203,'Stockholm','AB',1),(3089,203,'Uppsala','C',1),(3090,203,'V&auml;rmland','S',1),(3091,203,'V&auml;sterbotten','AC',1),(3092,203,'V&auml;sternorrland','Y',1),(3093,203,'V&auml;stmanland','U',1),(3094,203,'V&auml;stra G&ouml;taland','O',1),(3095,204,'Aargau','AG',1),(3096,204,'Appenzell Ausserrhoden','AR',1),(3097,204,'Appenzell Innerrhoden','AI',1),(3098,204,'Basel-Stadt','BS',1),(3099,204,'Basel-Landschaft','BL',1),(3100,204,'Bern','BE',1),(3101,204,'Fribourg','FR',1),(3102,204,'Gen&egrave;ve','GE',1),(3103,204,'Glarus','GL',1),(3104,204,'Graub&uuml;nden','GR',1),(3105,204,'Jura','JU',1),(3106,204,'Luzern','LU',1),(3107,204,'Neuch&acirc;tel','NE',1),(3108,204,'Nidwald','NW',1),(3109,204,'Obwald','OW',1),(3110,204,'St. Gallen','SG',1),(3111,204,'Schaffhausen','SH',1),(3112,204,'Schwyz','SZ',1),(3113,204,'Solothurn','SO',1),(3114,204,'Thurgau','TG',1),(3115,204,'Ticino','TI',1),(3116,204,'Uri','UR',1),(3117,204,'Valais','VS',1),(3118,204,'Vaud','VD',1),(3119,204,'Zug','ZG',1),(3120,204,'Z&uuml;rich','ZH',1),(3121,205,'Al Hasakah','HA',1),(3122,205,'Al Ladhiqiyah','LA',1),(3123,205,'Al Qunaytirah','QU',1),(3124,205,'Ar Raqqah','RQ',1),(3125,205,'As Suwayda','SU',1),(3126,205,'Dara','DA',1),(3127,205,'Dayr az Zawr','DZ',1),(3128,205,'Dimashq','DI',1),(3129,205,'Halab','HL',1),(3130,205,'Hamah','HM',1),(3131,205,'Hims','HI',1),(3132,205,'Idlib','ID',1),(3133,205,'Rif Dimashq','RD',1),(3134,205,'Tartus','TA',1),(3135,206,'Chang-hua','CH',1),(3136,206,'Chia-i','CI',1),(3137,206,'Hsin-chu','HS',1),(3138,206,'Hua-lien','HL',1),(3139,206,'I-lan','IL',1),(3140,206,'Kao-hsiung county','KH',1),(3141,206,'Kin-men','KM',1),(3142,206,'Lien-chiang','LC',1),(3143,206,'Miao-li','ML',1),(3144,206,'Nan-t\'ou','NT',1),(3145,206,'P\'eng-hu','PH',1),(3146,206,'P\'ing-tung','PT',1),(3147,206,'T\'ai-chung','TG',1),(3148,206,'T\'ai-nan','TA',1),(3149,206,'T\'ai-pei county','TP',1),(3150,206,'T\'ai-tung','TT',1),(3151,206,'T\'ao-yuan','TY',1),(3152,206,'Yun-lin','YL',1),(3153,206,'Chia-i city','CC',1),(3154,206,'Chi-lung','CL',1),(3155,206,'Hsin-chu','HC',1),(3156,206,'T\'ai-chung','TH',1),(3157,206,'T\'ai-nan','TN',1),(3158,206,'Kao-hsiung city','KC',1),(3159,206,'T\'ai-pei city','TC',1),(3160,207,'Gorno-Badakhstan','GB',1),(3161,207,'Khatlon','KT',1),(3162,207,'Sughd','SU',1),(3163,208,'Arusha','AR',1),(3164,208,'Dar es Salaam','DS',1),(3165,208,'Dodoma','DO',1),(3166,208,'Iringa','IR',1),(3167,208,'Kagera','KA',1),(3168,208,'Kigoma','KI',1),(3169,208,'Kilimanjaro','KJ',1),(3170,208,'Lindi','LN',1),(3171,208,'Manyara','MY',1),(3172,208,'Mara','MR',1),(3173,208,'Mbeya','MB',1),(3174,208,'Morogoro','MO',1),(3175,208,'Mtwara','MT',1),(3176,208,'Mwanza','MW',1),(3177,208,'Pemba North','PN',1),(3178,208,'Pemba South','PS',1),(3179,208,'Pwani','PW',1),(3180,208,'Rukwa','RK',1),(3181,208,'Ruvuma','RV',1),(3182,208,'Shinyanga','SH',1),(3183,208,'Singida','SI',1),(3184,208,'Tabora','TB',1),(3185,208,'Tanga','TN',1),(3186,208,'Zanzibar Central/South','ZC',1),(3187,208,'Zanzibar North','ZN',1),(3188,208,'Zanzibar Urban/West','ZU',1),(3189,209,'Amnat Charoen','Amnat Charoen',1),(3190,209,'Ang Thong','Ang Thong',1),(3191,209,'Ayutthaya','Ayutthaya',1),(3192,209,'Bangkok','Bangkok',1),(3193,209,'Buriram','Buriram',1),(3194,209,'Chachoengsao','Chachoengsao',1),(3195,209,'Chai Nat','Chai Nat',1),(3196,209,'Chaiyaphum','Chaiyaphum',1),(3197,209,'Chanthaburi','Chanthaburi',1),(3198,209,'Chiang Mai','Chiang Mai',1),(3199,209,'Chiang Rai','Chiang Rai',1),(3200,209,'Chon Buri','Chon Buri',1),(3201,209,'Chumphon','Chumphon',1),(3202,209,'Kalasin','Kalasin',1),(3203,209,'Kamphaeng Phet','Kamphaeng Phet',1),(3204,209,'Kanchanaburi','Kanchanaburi',1),(3205,209,'Khon Kaen','Khon Kaen',1),(3206,209,'Krabi','Krabi',1),(3207,209,'Lampang','Lampang',1),(3208,209,'Lamphun','Lamphun',1),(3209,209,'Loei','Loei',1),(3210,209,'Lop Buri','Lop Buri',1),(3211,209,'Mae Hong Son','Mae Hong Son',1),(3212,209,'Maha Sarakham','Maha Sarakham',1),(3213,209,'Mukdahan','Mukdahan',1),(3214,209,'Nakhon Nayok','Nakhon Nayok',1),(3215,209,'Nakhon Pathom','Nakhon Pathom',1),(3216,209,'Nakhon Phanom','Nakhon Phanom',1),(3217,209,'Nakhon Ratchasima','Nakhon Ratchasima',1),(3218,209,'Nakhon Sawan','Nakhon Sawan',1),(3219,209,'Nakhon Si Thammarat','Nakhon Si Thammarat',1),(3220,209,'Nan','Nan',1),(3221,209,'Narathiwat','Narathiwat',1),(3222,209,'Nong Bua Lamphu','Nong Bua Lamphu',1),(3223,209,'Nong Khai','Nong Khai',1),(3224,209,'Nonthaburi','Nonthaburi',1),(3225,209,'Pathum Thani','Pathum Thani',1),(3226,209,'Pattani','Pattani',1),(3227,209,'Phangnga','Phangnga',1),(3228,209,'Phatthalung','Phatthalung',1),(3229,209,'Phayao','Phayao',1),(3230,209,'Phetchabun','Phetchabun',1),(3231,209,'Phetchaburi','Phetchaburi',1),(3232,209,'Phichit','Phichit',1),(3233,209,'Phitsanulok','Phitsanulok',1),(3234,209,'Phrae','Phrae',1),(3235,209,'Phuket','Phuket',1),(3236,209,'Prachin Buri','Prachin Buri',1),(3237,209,'Prachuap Khiri Khan','Prachuap Khiri Khan',1),(3238,209,'Ranong','Ranong',1),(3239,209,'Ratchaburi','Ratchaburi',1),(3240,209,'Rayong','Rayong',1),(3241,209,'Roi Et','Roi Et',1),(3242,209,'Sa Kaeo','Sa Kaeo',1),(3243,209,'Sakon Nakhon','Sakon Nakhon',1),(3244,209,'Samut Prakan','Samut Prakan',1),(3245,209,'Samut Sakhon','Samut Sakhon',1),(3246,209,'Samut Songkhram','Samut Songkhram',1),(3247,209,'Sara Buri','Sara Buri',1),(3248,209,'Satun','Satun',1),(3249,209,'Sing Buri','Sing Buri',1),(3250,209,'Sisaket','Sisaket',1),(3251,209,'Songkhla','Songkhla',1),(3252,209,'Sukhothai','Sukhothai',1),(3253,209,'Suphan Buri','Suphan Buri',1),(3254,209,'Surat Thani','Surat Thani',1),(3255,209,'Surin','Surin',1),(3256,209,'Tak','Tak',1),(3257,209,'Trang','Trang',1),(3258,209,'Trat','Trat',1),(3259,209,'Ubon Ratchathani','Ubon Ratchathani',1),(3260,209,'Udon Thani','Udon Thani',1),(3261,209,'Uthai Thani','Uthai Thani',1),(3262,209,'Uttaradit','Uttaradit',1),(3263,209,'Yala','Yala',1),(3264,209,'Yasothon','Yasothon',1),(3265,210,'Kara','K',1),(3266,210,'Plateaux','P',1),(3267,210,'Savanes','S',1),(3268,210,'Centrale','C',1),(3269,210,'Maritime','M',1),(3270,211,'Atafu','A',1),(3271,211,'Fakaofo','F',1),(3272,211,'Nukunonu','N',1),(3273,212,'Ha\'apai','H',1),(3274,212,'Tongatapu','T',1),(3275,212,'Vava\'u','V',1),(3276,213,'Couva/Tabaquite/Talparo','CT',1),(3277,213,'Diego Martin','DM',1),(3278,213,'Mayaro/Rio Claro','MR',1),(3279,213,'Penal/Debe','PD',1),(3280,213,'Princes Town','PT',1),(3281,213,'Sangre Grande','SG',1),(3282,213,'San Juan/Laventille','SL',1),(3283,213,'Siparia','SI',1),(3284,213,'Tunapuna/Piarco','TP',1),(3285,213,'Port of Spain','PS',1),(3286,213,'San Fernando','SF',1),(3287,213,'Arima','AR',1),(3288,213,'Point Fortin','PF',1),(3289,213,'Chaguanas','CH',1),(3290,213,'Tobago','TO',1),(3291,214,'Ariana','AR',1),(3292,214,'Beja','BJ',1),(3293,214,'Ben Arous','BA',1),(3294,214,'Bizerte','BI',1),(3295,214,'Gabes','GB',1),(3296,214,'Gafsa','GF',1),(3297,214,'Jendouba','JE',1),(3298,214,'Kairouan','KR',1),(3299,214,'Kasserine','KS',1),(3300,214,'Kebili','KB',1),(3301,214,'Kef','KF',1),(3302,214,'Mahdia','MH',1),(3303,214,'Manouba','MN',1),(3304,214,'Medenine','ME',1),(3305,214,'Monastir','MO',1),(3306,214,'Nabeul','NA',1),(3307,214,'Sfax','SF',1),(3308,214,'Sidi','SD',1),(3309,214,'Siliana','SL',1),(3310,214,'Sousse','SO',1),(3311,214,'Tataouine','TA',1),(3312,214,'Tozeur','TO',1),(3313,214,'Tunis','TU',1),(3314,214,'Zaghouan','ZA',1),(3315,215,'Adana','ADA',1),(3316,215,'Adıyaman','ADI',1),(3317,215,'Afyonkarahisar','AFY',1),(3318,215,'Ağrı','AGR',1),(3319,215,'Aksaray','AKS',1),(3320,215,'Amasya','AMA',1),(3321,215,'Ankara','ANK',1),(3322,215,'Antalya','ANT',1),(3323,215,'Ardahan','ARD',1),(3324,215,'Artvin','ART',1),(3325,215,'Aydın','AYI',1),(3326,215,'Balıkesir','BAL',1),(3327,215,'Bartın','BAR',1),(3328,215,'Batman','BAT',1),(3329,215,'Bayburt','BAY',1),(3330,215,'Bilecik','BIL',1),(3331,215,'Bingöl','BIN',1),(3332,215,'Bitlis','BIT',1),(3333,215,'Bolu','BOL',1),(3334,215,'Burdur','BRD',1),(3335,215,'Bursa','BRS',1),(3336,215,'Çanakkale','CKL',1),(3337,215,'Çankırı','CKR',1),(3338,215,'Çorum','COR',1),(3339,215,'Denizli','DEN',1),(3340,215,'Diyarbakır','DIY',1),(3341,215,'Düzce','DUZ',1),(3342,215,'Edirne','EDI',1),(3343,215,'Elazığ','ELA',1),(3344,215,'Erzincan','EZC',1),(3345,215,'Erzurum','EZR',1),(3346,215,'Eskişehir','ESK',1),(3347,215,'Gaziantep','GAZ',1),(3348,215,'Giresun','GIR',1),(3349,215,'Gümüşhane','GMS',1),(3350,215,'Hakkari','HKR',1),(3351,215,'Hatay','HTY',1),(3352,215,'Iğdır','IGD',1),(3353,215,'Isparta','ISP',1),(3354,215,'İstanbul','IST',1),(3355,215,'İzmir','IZM',1),(3356,215,'Kahramanmaraş','KAH',1),(3357,215,'Karabük','KRB',1),(3358,215,'Karaman','KRM',1),(3359,215,'Kars','KRS',1),(3360,215,'Kastamonu','KAS',1),(3361,215,'Kayseri','KAY',1),(3362,215,'Kilis','KLS',1),(3363,215,'Kırıkkale','KRK',1),(3364,215,'Kırklareli','KLR',1),(3365,215,'Kırşehir','KRH',1),(3366,215,'Kocaeli','KOC',1),(3367,215,'Konya','KON',1),(3368,215,'Kütahya','KUT',1),(3369,215,'Malatya','MAL',1),(3370,215,'Manisa','MAN',1),(3371,215,'Mardin','MAR',1),(3372,215,'Mersin','MER',1),(3373,215,'Muğla','MUG',1),(3374,215,'Muş','MUS',1),(3375,215,'Nevşehir','NEV',1),(3376,215,'Niğde','NIG',1),(3377,215,'Ordu','ORD',1),(3378,215,'Osmaniye','OSM',1),(3379,215,'Rize','RIZ',1),(3380,215,'Sakarya','SAK',1),(3381,215,'Samsun','SAM',1),(3382,215,'Şanlıurfa','SAN',1),(3383,215,'Siirt','SII',1),(3384,215,'Sinop','SIN',1),(3385,215,'Şırnak','SIR',1),(3386,215,'Sivas','SIV',1),(3387,215,'Tekirdağ','TEL',1),(3388,215,'Tokat','TOK',1),(3389,215,'Trabzon','TRA',1),(3390,215,'Tunceli','TUN',1),(3391,215,'Uşak','USK',1),(3392,215,'Van','VAN',1),(3393,215,'Yalova','YAL',1),(3394,215,'Yozgat','YOZ',1),(3395,215,'Zonguldak','ZON',1),(3396,216,'Ahal Welayaty','A',1),(3397,216,'Balkan Welayaty','B',1),(3398,216,'Dashhowuz Welayaty','D',1),(3399,216,'Lebap Welayaty','L',1),(3400,216,'Mary Welayaty','M',1),(3401,217,'Ambergris Cays','AC',1),(3402,217,'Dellis Cay','DC',1),(3403,217,'French Cay','FC',1),(3404,217,'Little Water Cay','LW',1),(3405,217,'Parrot Cay','RC',1),(3406,217,'Pine Cay','PN',1),(3407,217,'Salt Cay','SL',1),(3408,217,'Grand Turk','GT',1),(3409,217,'South Caicos','SC',1),(3410,217,'East Caicos','EC',1),(3411,217,'Middle Caicos','MC',1),(3412,217,'North Caicos','NC',1),(3413,217,'Providenciales','PR',1),(3414,217,'West Caicos','WC',1),(3415,218,'Nanumanga','NMG',1),(3416,218,'Niulakita','NLK',1),(3417,218,'Niutao','NTO',1),(3418,218,'Funafuti','FUN',1),(3419,218,'Nanumea','NME',1),(3420,218,'Nui','NUI',1),(3421,218,'Nukufetau','NFT',1),(3422,218,'Nukulaelae','NLL',1),(3423,218,'Vaitupu','VAI',1),(3424,219,'Kalangala','KAL',1),(3425,219,'Kampala','KMP',1),(3426,219,'Kayunga','KAY',1),(3427,219,'Kiboga','KIB',1),(3428,219,'Luwero','LUW',1),(3429,219,'Masaka','MAS',1),(3430,219,'Mpigi','MPI',1),(3431,219,'Mubende','MUB',1),(3432,219,'Mukono','MUK',1),(3433,219,'Nakasongola','NKS',1),(3434,219,'Rakai','RAK',1),(3435,219,'Sembabule','SEM',1),(3436,219,'Wakiso','WAK',1),(3437,219,'Bugiri','BUG',1),(3438,219,'Busia','BUS',1),(3439,219,'Iganga','IGA',1),(3440,219,'Jinja','JIN',1),(3441,219,'Kaberamaido','KAB',1),(3442,219,'Kamuli','KML',1),(3443,219,'Kapchorwa','KPC',1),(3444,219,'Katakwi','KTK',1),(3445,219,'Kumi','KUM',1),(3446,219,'Mayuge','MAY',1),(3447,219,'Mbale','MBA',1),(3448,219,'Pallisa','PAL',1),(3449,219,'Sironko','SIR',1),(3450,219,'Soroti','SOR',1),(3451,219,'Tororo','TOR',1),(3452,219,'Adjumani','ADJ',1),(3453,219,'Apac','APC',1),(3454,219,'Arua','ARU',1),(3455,219,'Gulu','GUL',1),(3456,219,'Kitgum','KIT',1),(3457,219,'Kotido','KOT',1),(3458,219,'Lira','LIR',1),(3459,219,'Moroto','MRT',1),(3460,219,'Moyo','MOY',1),(3461,219,'Nakapiripirit','NAK',1),(3462,219,'Nebbi','NEB',1),(3463,219,'Pader','PAD',1),(3464,219,'Yumbe','YUM',1),(3465,219,'Bundibugyo','BUN',1),(3466,219,'Bushenyi','BSH',1),(3467,219,'Hoima','HOI',1),(3468,219,'Kabale','KBL',1),(3469,219,'Kabarole','KAR',1),(3470,219,'Kamwenge','KAM',1),(3471,219,'Kanungu','KAN',1),(3472,219,'Kasese','KAS',1),(3473,219,'Kibaale','KBA',1),(3474,219,'Kisoro','KIS',1),(3475,219,'Kyenjojo','KYE',1),(3476,219,'Masindi','MSN',1),(3477,219,'Mbarara','MBR',1),(3478,219,'Ntungamo','NTU',1),(3479,219,'Rukungiri','RUK',1),(3480,220,'Черкасская область','71',1),(3481,220,'Черниговская область','74',1),(3482,220,'Черновицкая область','77',1),(3483,220,'Автономная Республика Крым','43',1),(3484,220,'Днепропетровская область','12',1),(3485,220,'Донецкая область','14',1),(3486,220,'Ивано-Франковская область','26',1),(3487,220,'Херсонская область','65',1),(3488,220,'Хмельницкая область','68',1),(3489,220,'Кировоградская область','35',1),(3490,220,'Киев','30',1),(3491,220,'Киевская область','32',1),(3492,220,'Луганская область','09',1),(3493,220,'Львовская область','46',1),(3494,220,'Николаевская область','48',1),(3495,220,'Одесская область','51',1),(3496,220,'Полтавская область','53',1),(3497,220,'Ровненская область','56',1),(3498,220,'Севастополь','40',1),(3499,220,'Сумская область','59',1),(3500,220,'Тернопольская область','61',1),(3501,220,'Винницкая область','05',1),(3502,220,'Волынская область','07',1),(3503,220,'Закарпатская область','21',1),(3504,220,'Запорожская область','23',1),(3505,220,'Житомирская область','18',1),(3506,221,'Abu Dhabi','ADH',1),(3507,221,'\'Ajman','AJ',1),(3508,221,'Al Fujayrah','FU',1),(3509,221,'Ash Shariqah','SH',1),(3510,221,'Dubai','DU',1),(3511,221,'R\'as al Khaymah','RK',1),(3512,221,'Umm al Qaywayn','UQ',1),(3513,222,'Aberdeen','ABN',1),(3514,222,'Aberdeenshire','ABNS',1),(3515,222,'Anglesey','ANG',1),(3516,222,'Angus','AGS',1),(3517,222,'Argyll and Bute','ARY',1),(3518,222,'Bedfordshire','BEDS',1),(3519,222,'Berkshire','BERKS',1),(3520,222,'Blaenau Gwent','BLA',1),(3521,222,'Bridgend','BRI',1),(3522,222,'Bristol','BSTL',1),(3523,222,'Buckinghamshire','BUCKS',1),(3524,222,'Caerphilly','CAE',1),(3525,222,'Cambridgeshire','CAMBS',1),(3526,222,'Cardiff','CDF',1),(3527,222,'Carmarthenshire','CARM',1),(3528,222,'Ceredigion','CDGN',1),(3529,222,'Cheshire','CHES',1),(3530,222,'Clackmannanshire','CLACK',1),(3531,222,'Conwy','CON',1),(3532,222,'Cornwall','CORN',1),(3533,222,'Denbighshire','DNBG',1),(3534,222,'Derbyshire','DERBY',1),(3535,222,'Devon','DVN',1),(3536,222,'Dorset','DOR',1),(3537,222,'Dumfries and Galloway','DGL',1),(3538,222,'Dundee','DUND',1),(3539,222,'Durham','DHM',1),(3540,222,'East Ayrshire','ARYE',1),(3541,222,'East Dunbartonshire','DUNBE',1),(3542,222,'East Lothian','LOTE',1),(3543,222,'East Renfrewshire','RENE',1),(3544,222,'East Riding of Yorkshire','ERYS',1),(3545,222,'East Sussex','SXE',1),(3546,222,'Edinburgh','EDIN',1),(3547,222,'Essex','ESX',1),(3548,222,'Falkirk','FALK',1),(3549,222,'Fife','FFE',1),(3550,222,'Flintshire','FLINT',1),(3551,222,'Glasgow','GLAS',1),(3552,222,'Gloucestershire','GLOS',1),(3553,222,'Greater London','LDN',1),(3554,222,'Greater Manchester','MCH',1),(3555,222,'Gwynedd','GDD',1),(3556,222,'Hampshire','HANTS',1),(3557,222,'Herefordshire','HWR',1),(3558,222,'Hertfordshire','HERTS',1),(3559,222,'Highlands','HLD',1),(3560,222,'Inverclyde','IVER',1),(3561,222,'Isle of Wight','IOW',1),(3562,222,'Kent','KNT',1),(3563,222,'Lancashire','LANCS',1),(3564,222,'Leicestershire','LEICS',1),(3565,222,'Lincolnshire','LINCS',1),(3566,222,'Merseyside','MSY',1),(3567,222,'Merthyr Tydfil','MERT',1),(3568,222,'Midlothian','MLOT',1),(3569,222,'Monmouthshire','MMOUTH',1),(3570,222,'Moray','MORAY',1),(3571,222,'Neath Port Talbot','NPRTAL',1),(3572,222,'Newport','NEWPT',1),(3573,222,'Norfolk','NOR',1),(3574,222,'North Ayrshire','ARYN',1),(3575,222,'North Lanarkshire','LANN',1),(3576,222,'North Yorkshire','YSN',1),(3577,222,'Northamptonshire','NHM',1),(3578,222,'Northumberland','NLD',1),(3579,222,'Nottinghamshire','NOT',1),(3580,222,'Orkney Islands','ORK',1),(3581,222,'Oxfordshire','OFE',1),(3582,222,'Pembrokeshire','PEM',1),(3583,222,'Perth and Kinross','PERTH',1),(3584,222,'Powys','PWS',1),(3585,222,'Renfrewshire','REN',1),(3586,222,'Rhondda Cynon Taff','RHON',1),(3587,222,'Rutland','RUT',1),(3588,222,'Scottish Borders','BOR',1),(3589,222,'Shetland Islands','SHET',1),(3590,222,'Shropshire','SPE',1),(3591,222,'Somerset','SOM',1),(3592,222,'South Ayrshire','ARYS',1),(3593,222,'South Lanarkshire','LANS',1),(3594,222,'South Yorkshire','YSS',1),(3595,222,'Staffordshire','SFD',1),(3596,222,'Stirling','STIR',1),(3597,222,'Suffolk','SFK',1),(3598,222,'Surrey','SRY',1),(3599,222,'Swansea','SWAN',1),(3600,222,'Torfaen','TORF',1),(3601,222,'Tyne and Wear','TWR',1),(3602,222,'Vale of Glamorgan','VGLAM',1),(3603,222,'Warwickshire','WARKS',1),(3604,222,'West Dunbartonshire','WDUN',1),(3605,222,'West Lothian','WLOT',1),(3606,222,'West Midlands','WMD',1),(3607,222,'West Sussex','SXW',1),(3608,222,'West Yorkshire','YSW',1),(3609,222,'Western Isles','WIL',1),(3610,222,'Wiltshire','WLT',1),(3611,222,'Worcestershire','WORCS',1),(3612,222,'Wrexham','WRX',1),(3613,223,'Alabama','AL',1),(3614,223,'Alaska','AK',1),(3615,223,'American Samoa','AS',1),(3616,223,'Arizona','AZ',1),(3617,223,'Arkansas','AR',1),(3618,223,'Armed Forces Africa','AF',1),(3619,223,'Armed Forces Americas','AA',1),(3620,223,'Armed Forces Canada','AC',1),(3621,223,'Armed Forces Europe','AE',1),(3622,223,'Armed Forces Middle East','AM',1),(3623,223,'Armed Forces Pacific','AP',1),(3624,223,'California','CA',1),(3625,223,'Colorado','CO',1),(3626,223,'Connecticut','CT',1),(3627,223,'Delaware','DE',1),(3628,223,'District of Columbia','DC',1),(3629,223,'Federated States Of Micronesia','FM',1),(3630,223,'Florida','FL',1),(3631,223,'Georgia','GA',1),(3632,223,'Guam','GU',1),(3633,223,'Hawaii','HI',1),(3634,223,'Idaho','ID',1),(3635,223,'Illinois','IL',1),(3636,223,'Indiana','IN',1),(3637,223,'Iowa','IA',1),(3638,223,'Kansas','KS',1),(3639,223,'Kentucky','KY',1),(3640,223,'Louisiana','LA',1),(3641,223,'Maine','ME',1),(3642,223,'Marshall Islands','MH',1),(3643,223,'Maryland','MD',1),(3644,223,'Massachusetts','MA',1),(3645,223,'Michigan','MI',1),(3646,223,'Minnesota','MN',1),(3647,223,'Mississippi','MS',1),(3648,223,'Missouri','MO',1),(3649,223,'Montana','MT',1),(3650,223,'Nebraska','NE',1),(3651,223,'Nevada','NV',1),(3652,223,'New Hampshire','NH',1),(3653,223,'New Jersey','NJ',1),(3654,223,'New Mexico','NM',1),(3655,223,'New York','NY',1),(3656,223,'North Carolina','NC',1),(3657,223,'North Dakota','ND',1),(3658,223,'Northern Mariana Islands','MP',1),(3659,223,'Ohio','OH',1),(3660,223,'Oklahoma','OK',1),(3661,223,'Oregon','OR',1),(3662,223,'Palau','PW',1),(3663,223,'Pennsylvania','PA',1),(3664,223,'Puerto Rico','PR',1),(3665,223,'Rhode Island','RI',1),(3666,223,'South Carolina','SC',1),(3667,223,'South Dakota','SD',1),(3668,223,'Tennessee','TN',1),(3669,223,'Texas','TX',1),(3670,223,'Utah','UT',1),(3671,223,'Vermont','VT',1),(3672,223,'Virgin Islands','VI',1),(3673,223,'Virginia','VA',1),(3674,223,'Washington','WA',1),(3675,223,'West Virginia','WV',1),(3676,223,'Wisconsin','WI',1),(3677,223,'Wyoming','WY',1),(3678,224,'Baker Island','BI',1),(3679,224,'Howland Island','HI',1),(3680,224,'Jarvis Island','JI',1),(3681,224,'Johnston Atoll','JA',1),(3682,224,'Kingman Reef','KR',1),(3683,224,'Midway Atoll','MA',1),(3684,224,'Navassa Island','NI',1),(3685,224,'Palmyra Atoll','PA',1),(3686,224,'Wake Island','WI',1),(3687,225,'Artigas','AR',1),(3688,225,'Canelones','CA',1),(3689,225,'Cerro Largo','CL',1),(3690,225,'Colonia','CO',1),(3691,225,'Durazno','DU',1),(3692,225,'Flores','FS',1),(3693,225,'Florida','FA',1),(3694,225,'Lavalleja','LA',1),(3695,225,'Maldonado','MA',1),(3696,225,'Montevideo','MO',1),(3697,225,'Paysandu','PA',1),(3698,225,'Rio Negro','RN',1),(3699,225,'Rivera','RV',1),(3700,225,'Rocha','RO',1),(3701,225,'Salto','SL',1),(3702,225,'San Jose','SJ',1),(3703,225,'Soriano','SO',1),(3704,225,'Tacuarembo','TA',1),(3705,225,'Treinta y Tres','TT',1),(3706,226,'Andijon','AN',1),(3707,226,'Buxoro','BU',1),(3708,226,'Farg\'ona','FA',1),(3709,226,'Jizzax','JI',1),(3710,226,'Namangan','NG',1),(3711,226,'Navoiy','NW',1),(3712,226,'Qashqadaryo','QA',1),(3713,226,'Qoraqalpog\'iston Republikasi','QR',1),(3714,226,'Samarqand','SA',1),(3715,226,'Sirdaryo','SI',1),(3716,226,'Surxondaryo','SU',1),(3717,226,'Toshkent City','TK',1),(3718,226,'Toshkent Region','TO',1),(3719,226,'Xorazm','XO',1),(3720,227,'Malampa','MA',1),(3721,227,'Penama','PE',1),(3722,227,'Sanma','SA',1),(3723,227,'Shefa','SH',1),(3724,227,'Tafea','TA',1),(3725,227,'Torba','TO',1),(3726,229,'Amazonas','AM',1),(3727,229,'Anzoategui','AN',1),(3728,229,'Apure','AP',1),(3729,229,'Aragua','AR',1),(3730,229,'Barinas','BA',1),(3731,229,'Bolivar','BO',1),(3732,229,'Carabobo','CA',1),(3733,229,'Cojedes','CO',1),(3734,229,'Delta Amacuro','DA',1),(3735,229,'Dependencias Federales','DF',1),(3736,229,'Distrito Federal','DI',1),(3737,229,'Falcon','FA',1),(3738,229,'Guarico','GU',1),(3739,229,'Lara','LA',1),(3740,229,'Merida','ME',1),(3741,229,'Miranda','MI',1),(3742,229,'Monagas','MO',1),(3743,229,'Nueva Esparta','NE',1),(3744,229,'Portuguesa','PO',1),(3745,229,'Sucre','SU',1),(3746,229,'Tachira','TA',1),(3747,229,'Trujillo','TR',1),(3748,229,'Vargas','VA',1),(3749,229,'Yaracuy','YA',1),(3750,229,'Zulia','ZU',1),(3751,230,'An Giang','AG',1),(3752,230,'Bac Giang','BG',1),(3753,230,'Bac Kan','BK',1),(3754,230,'Bac Lieu','BL',1),(3755,230,'Bac Ninh','BC',1),(3756,230,'Ba Ria-Vung Tau','BR',1),(3757,230,'Ben Tre','BN',1),(3758,230,'Binh Dinh','BH',1),(3759,230,'Binh Duong','BU',1),(3760,230,'Binh Phuoc','BP',1),(3761,230,'Binh Thuan','BT',1),(3762,230,'Ca Mau','CM',1),(3763,230,'Can Tho','CT',1),(3764,230,'Cao Bang','CB',1),(3765,230,'Dak Lak','DL',1),(3766,230,'Dak Nong','DG',1),(3767,230,'Da Nang','DN',1),(3768,230,'Dien Bien','DB',1),(3769,230,'Dong Nai','DI',1),(3770,230,'Dong Thap','DT',1),(3771,230,'Gia Lai','GL',1),(3772,230,'Ha Giang','HG',1),(3773,230,'Hai Duong','HD',1),(3774,230,'Hai Phong','HP',1),(3775,230,'Ha Nam','HM',1),(3776,230,'Ha Noi','HI',1),(3777,230,'Ha Tay','HT',1),(3778,230,'Ha Tinh','HH',1),(3779,230,'Hoa Binh','HB',1),(3780,230,'Ho Chi Minh City','HC',1),(3781,230,'Hau Giang','HU',1),(3782,230,'Hung Yen','HY',1),(3783,232,'Saint Croix','C',1),(3784,232,'Saint John','J',1),(3785,232,'Saint Thomas','T',1),(3786,233,'Alo','A',1),(3787,233,'Sigave','S',1),(3788,233,'Wallis','W',1),(3789,235,'Abyan','AB',1),(3790,235,'Adan','AD',1),(3791,235,'Amran','AM',1),(3792,235,'Al Bayda','BA',1),(3793,235,'Ad Dali','DA',1),(3794,235,'Dhamar','DH',1),(3795,235,'Hadramawt','HD',1),(3796,235,'Hajjah','HJ',1),(3797,235,'Al Hudaydah','HU',1),(3798,235,'Ibb','IB',1),(3799,235,'Al Jawf','JA',1),(3800,235,'Lahij','LA',1),(3801,235,'Ma\'rib','MA',1),(3802,235,'Al Mahrah','MR',1),(3803,235,'Al Mahwit','MW',1),(3804,235,'Sa\'dah','SD',1),(3805,235,'San\'a','SN',1),(3806,235,'Shabwah','SH',1),(3807,235,'Ta\'izz','TA',1),(3812,237,'Bas-Congo','BC',1),(3813,237,'Bandundu','BN',1),(3814,237,'Equateur','EQ',1),(3815,237,'Katanga','KA',1),(3816,237,'Kasai-Oriental','KE',1),(3817,237,'Kinshasa','KN',1),(3818,237,'Kasai-Occidental','KW',1),(3819,237,'Maniema','MA',1),(3820,237,'Nord-Kivu','NK',1),(3821,237,'Orientale','OR',1),(3822,237,'Sud-Kivu','SK',1),(3823,238,'Central','CE',1),(3824,238,'Copperbelt','CB',1),(3825,238,'Eastern','EA',1),(3826,238,'Luapula','LP',1),(3827,238,'Lusaka','LK',1),(3828,238,'Northern','NO',1),(3829,238,'North-Western','NW',1),(3830,238,'Southern','SO',1),(3831,238,'Western','WE',1),(3832,239,'Bulawayo','BU',1),(3833,239,'Harare','HA',1),(3834,239,'Manicaland','ML',1),(3835,239,'Mashonaland Central','MC',1),(3836,239,'Mashonaland East','ME',1),(3837,239,'Mashonaland West','MW',1),(3838,239,'Masvingo','MV',1),(3839,239,'Matabeleland North','MN',1),(3840,239,'Matabeleland South','MS',1),(3841,239,'Midlands','MD',1),(3861,105,'Campobasso','CB',1),(3862,105,'Carbonia-Iglesias','CI',1),(3863,105,'Caserta','CE',1),(3864,105,'Catania','CT',1),(3865,105,'Catanzaro','CZ',1),(3866,105,'Chieti','CH',1),(3867,105,'Como','CO',1),(3868,105,'Cosenza','CS',1),(3869,105,'Cremona','CR',1),(3870,105,'Crotone','KR',1),(3871,105,'Cuneo','CN',1),(3872,105,'Enna','EN',1),(3873,105,'Ferrara','FE',1),(3874,105,'Firenze','FI',1),(3875,105,'Foggia','FG',1),(3876,105,'Forli-Cesena','FC',1),(3877,105,'Frosinone','FR',1),(3878,105,'Genova','GE',1),(3879,105,'Gorizia','GO',1),(3880,105,'Grosseto','GR',1),(3881,105,'Imperia','IM',1),(3882,105,'Isernia','IS',1),(3883,105,'L&#39;Aquila','AQ',1),(3884,105,'La Spezia','SP',1),(3885,105,'Latina','LT',1),(3886,105,'Lecce','LE',1),(3887,105,'Lecco','LC',1),(3888,105,'Livorno','LI',1),(3889,105,'Lodi','LO',1),(3890,105,'Lucca','LU',1),(3891,105,'Macerata','MC',1),(3892,105,'Mantova','MN',1),(3893,105,'Massa-Carrara','MS',1),(3894,105,'Matera','MT',1),(3895,105,'Medio Campidano','VS',1),(3896,105,'Messina','ME',1),(3897,105,'Milano','MI',1),(3898,105,'Modena','MO',1),(3899,105,'Napoli','NA',1),(3900,105,'Novara','NO',1),(3901,105,'Nuoro','NU',1),(3902,105,'Ogliastra','OG',1),(3903,105,'Olbia-Tempio','OT',1),(3904,105,'Oristano','OR',1),(3905,105,'Padova','PD',1),(3906,105,'Palermo','PA',1),(3907,105,'Parma','PR',1),(3908,105,'Pavia','PV',1),(3909,105,'Perugia','PG',1),(3910,105,'Pesaro e Urbino','PU',1),(3911,105,'Pescara','PE',1),(3912,105,'Piacenza','PC',1),(3913,105,'Pisa','PI',1),(3914,105,'Pistoia','PT',1),(3915,105,'Pordenone','PN',1),(3916,105,'Potenza','PZ',1),(3917,105,'Prato','PO',1),(3918,105,'Ragusa','RG',1),(3919,105,'Ravenna','RA',1),(3920,105,'Reggio Calabria','RC',1),(3921,105,'Reggio Emilia','RE',1),(3922,105,'Rieti','RI',1),(3923,105,'Rimini','RN',1),(3924,105,'Roma','RM',1),(3925,105,'Rovigo','RO',1),(3926,105,'Salerno','SA',1),(3927,105,'Sassari','SS',1),(3928,105,'Savona','SV',1),(3929,105,'Siena','SI',1),(3930,105,'Siracusa','SR',1),(3931,105,'Sondrio','SO',1),(3932,105,'Taranto','TA',1),(3933,105,'Teramo','TE',1),(3934,105,'Terni','TR',1),(3935,105,'Torino','TO',1),(3936,105,'Trapani','TP',1),(3937,105,'Trento','TN',1),(3938,105,'Treviso','TV',1),(3939,105,'Trieste','TS',1),(3940,105,'Udine','UD',1),(3941,105,'Varese','VA',1),(3942,105,'Venezia','VE',1),(3943,105,'Verbano-Cusio-Ossola','VB',1),(3944,105,'Vercelli','VC',1),(3945,105,'Verona','VR',1),(3946,105,'Vibo Valentia','VV',1),(3947,105,'Vicenza','VI',1),(3948,105,'Viterbo','VT',1),(3949,222,'County Antrim','ANT',1),(3950,222,'County Armagh','ARM',1),(3951,222,'County Down','DOW',1),(3952,222,'County Fermanagh','FER',1),(3953,222,'County Londonderry','LDY',1),(3954,222,'County Tyrone','TYR',1),(3955,222,'Cumbria','CMA',1),(3956,190,'Pomurska','1',1),(3957,190,'Podravska','2',1),(3958,190,'Koroška','3',1),(3959,190,'Savinjska','4',1),(3960,190,'Zasavska','5',1),(3961,190,'Spodnjeposavska','6',1),(3962,190,'Jugovzhodna Slovenija','7',1),(3963,190,'Osrednjeslovenska','8',1),(3964,190,'Gorenjska','9',1),(3965,190,'Notranjsko-kraška','10',1),(3966,190,'Goriška','11',1),(3967,190,'Obalno-kraška','12',1),(3968,33,'Ruse','',1),(3969,101,'Alborz','ALB',1),(3971,138,'Aguascalientes','AG',1),(3973,242,'Andrijevica','01',1),(3974,242,'Bar','02',1),(3975,242,'Berane','03',1),(3976,242,'Bijelo Polje','04',1),(3977,242,'Budva','05',1),(3978,242,'Cetinje','06',1),(3979,242,'Danilovgrad','07',1),(3980,242,'Herceg-Novi','08',1),(3981,242,'Kolašin','09',1),(3982,242,'Kotor','10',1),(3983,242,'Mojkovac','11',1),(3984,242,'Nikšić','12',1),(3985,242,'Plav','13',1),(3986,242,'Pljevlja','14',1),(3987,242,'Plužine','15',1),(3988,242,'Podgorica','16',1),(3989,242,'Rožaje','17',1),(3990,242,'Šavnik','18',1),(3991,242,'Tivat','19',1),(3992,242,'Ulcinj','20',1),(3993,242,'Žabljak','21',1),(3994,243,'Belgrade','00',1),(3995,243,'North Bačka','01',1),(3996,243,'Central Banat','02',1),(3997,243,'North Banat','03',1),(3998,243,'South Banat','04',1),(3999,243,'West Bačka','05',1),(4000,243,'South Bačka','06',1),(4001,243,'Srem','07',1),(4002,243,'Mačva','08',1),(4003,243,'Kolubara','09',1),(4004,243,'Podunavlje','10',1),(4005,243,'Braničevo','11',1),(4006,243,'Šumadija','12',1),(4007,243,'Pomoravlje','13',1),(4008,243,'Bor','14',1),(4009,243,'Zaječar','15',1),(4010,243,'Zlatibor','16',1),(4011,243,'Moravica','17',1),(4012,243,'Raška','18',1),(4013,243,'Rasina','19',1),(4014,243,'Nišava','20',1),(4015,243,'Toplica','21',1),(4016,243,'Pirot','22',1),(4017,243,'Jablanica','23',1),(4018,243,'Pčinja','24',1),(4020,245,'Bonaire','BO',1),(4021,245,'Saba','SA',1),(4022,245,'Sint Eustatius','SE',1),(4023,248,'Central Equatoria','EC',1),(4024,248,'Eastern Equatoria','EE',1),(4025,248,'Jonglei','JG',1),(4026,248,'Lakes','LK',1),(4027,248,'Northern Bahr el-Ghazal','BN',1),(4028,248,'Unity','UY',1),(4029,248,'Upper Nile','NU',1),(4030,248,'Warrap','WR',1),(4031,248,'Western Bahr el-Ghazal','BW',1),(4032,248,'Western Equatoria','EW',1),(4036,117,'Ainaži, Salacgrīvas novads','0661405',1),(4037,117,'Aizkraukle, Aizkraukles novads','0320201',1),(4038,117,'Aizkraukles novads','0320200',1),(4039,117,'Aizpute, Aizputes novads','0640605',1),(4040,117,'Aizputes novads','0640600',1),(4041,117,'Aknīste, Aknīstes novads','0560805',1),(4042,117,'Aknīstes novads','0560800',1),(4043,117,'Aloja, Alojas novads','0661007',1),(4044,117,'Alojas novads','0661000',1),(4045,117,'Alsungas novads','0624200',1),(4046,117,'Alūksne, Alūksnes novads','0360201',1),(4047,117,'Alūksnes novads','0360200',1),(4048,117,'Amatas novads','0424701',1),(4049,117,'Ape, Apes novads','0360805',1),(4050,117,'Apes novads','0360800',1),(4051,117,'Auce, Auces novads','0460805',1),(4052,117,'Auces novads','0460800',1),(4053,117,'Ādažu novads','0804400',1),(4054,117,'Babītes novads','0804900',1),(4055,117,'Baldone, Baldones novads','0800605',1),(4056,117,'Baldones novads','0800600',1),(4057,117,'Baloži, Ķekavas novads','0800807',1),(4058,117,'Baltinavas novads','0384400',1),(4059,117,'Balvi, Balvu novads','0380201',1),(4060,117,'Balvu novads','0380200',1),(4061,117,'Bauska, Bauskas novads','0400201',1),(4062,117,'Bauskas novads','0400200',1),(4063,117,'Beverīnas novads','0964700',1),(4064,117,'Brocēni, Brocēnu novads','0840605',1),(4065,117,'Brocēnu novads','0840601',1),(4066,117,'Burtnieku novads','0967101',1),(4067,117,'Carnikavas novads','0805200',1),(4068,117,'Cesvaine, Cesvaines novads','0700807',1),(4069,117,'Cesvaines novads','0700800',1),(4070,117,'Cēsis, Cēsu novads','0420201',1),(4071,117,'Cēsu novads','0420200',1),(4072,117,'Ciblas novads','0684901',1),(4073,117,'Dagda, Dagdas novads','0601009',1),(4074,117,'Dagdas novads','0601000',1),(4075,117,'Daugavpils','0050000',1),(4076,117,'Daugavpils novads','0440200',1),(4077,117,'Dobele, Dobeles novads','0460201',1),(4078,117,'Dobeles novads','0460200',1),(4079,117,'Dundagas novads','0885100',1),(4080,117,'Durbe, Durbes novads','0640807',1),(4081,117,'Durbes novads','0640801',1),(4082,117,'Engures novads','0905100',1),(4083,117,'Ērgļu novads','0705500',1),(4084,117,'Garkalnes novads','0806000',1),(4085,117,'Grobiņa, Grobiņas novads','0641009',1),(4086,117,'Grobiņas novads','0641000',1),(4087,117,'Gulbene, Gulbenes novads','0500201',1),(4088,117,'Gulbenes novads','0500200',1),(4089,117,'Iecavas novads','0406400',1),(4090,117,'Ikšķile, Ikšķiles novads','0740605',1),(4091,117,'Ikšķiles novads','0740600',1),(4092,117,'Ilūkste, Ilūkstes novads','0440807',1),(4093,117,'Ilūkstes novads','0440801',1),(4094,117,'Inčukalna novads','0801800',1),(4095,117,'Jaunjelgava, Jaunjelgavas novads','0321007',1),(4096,117,'Jaunjelgavas novads','0321000',1),(4097,117,'Jaunpiebalgas novads','0425700',1),(4098,117,'Jaunpils novads','0905700',1),(4099,117,'Jelgava','0090000',1),(4100,117,'Jelgavas novads','0540200',1),(4101,117,'Jēkabpils','0110000',1),(4102,117,'Jēkabpils novads','0560200',1),(4103,117,'Jūrmala','0130000',1),(4104,117,'Kalnciems, Jelgavas novads','0540211',1),(4105,117,'Kandava, Kandavas novads','0901211',1),(4106,117,'Kandavas novads','0901201',1),(4107,117,'Kārsava, Kārsavas novads','0681009',1),(4108,117,'Kārsavas novads','0681000',1),(4109,117,'Kocēnu novads ,bij. Valmieras)','0960200',1),(4110,117,'Kokneses novads','0326100',1),(4111,117,'Krāslava, Krāslavas novads','0600201',1),(4112,117,'Krāslavas novads','0600202',1),(4113,117,'Krimuldas novads','0806900',1),(4114,117,'Krustpils novads','0566900',1),(4115,117,'Kuldīga, Kuldīgas novads','0620201',1),(4116,117,'Kuldīgas novads','0620200',1),(4117,117,'Ķeguma novads','0741001',1),(4118,117,'Ķegums, Ķeguma novads','0741009',1),(4119,117,'Ķekavas novads','0800800',1),(4120,117,'Lielvārde, Lielvārdes novads','0741413',1),(4121,117,'Lielvārdes novads','0741401',1),(4122,117,'Liepāja','0170000',1),(4123,117,'Limbaži, Limbažu novads','0660201',1),(4124,117,'Limbažu novads','0660200',1),(4125,117,'Līgatne, Līgatnes novads','0421211',1),(4126,117,'Līgatnes novads','0421200',1),(4127,117,'Līvāni, Līvānu novads','0761211',1),(4128,117,'Līvānu novads','0761201',1),(4129,117,'Lubāna, Lubānas novads','0701413',1),(4130,117,'Lubānas novads','0701400',1),(4131,117,'Ludza, Ludzas novads','0680201',1),(4132,117,'Ludzas novads','0680200',1),(4133,117,'Madona, Madonas novads','0700201',1),(4134,117,'Madonas novads','0700200',1),(4135,117,'Mazsalaca, Mazsalacas novads','0961011',1),(4136,117,'Mazsalacas novads','0961000',1),(4137,117,'Mālpils novads','0807400',1),(4138,117,'Mārupes novads','0807600',1),(4139,117,'Mērsraga novads','0887600',1),(4140,117,'Naukšēnu novads','0967300',1),(4141,117,'Neretas novads','0327100',1),(4142,117,'Nīcas novads','0647900',1),(4143,117,'Ogre, Ogres novads','0740201',1),(4144,117,'Ogres novads','0740202',1),(4145,117,'Olaine, Olaines novads','0801009',1),(4146,117,'Olaines novads','0801000',1),(4147,117,'Ozolnieku novads','0546701',1),(4148,117,'Pārgaujas novads','0427500',1),(4149,117,'Pāvilosta, Pāvilostas novads','0641413',1),(4150,117,'Pāvilostas novads','0641401',1),(4151,117,'Piltene, Ventspils novads','0980213',1),(4152,117,'Pļaviņas, Pļaviņu novads','0321413',1),(4153,117,'Pļaviņu novads','0321400',1),(4154,117,'Preiļi, Preiļu novads','0760201',1),(4155,117,'Preiļu novads','0760202',1),(4156,117,'Priekule, Priekules novads','0641615',1),(4157,117,'Priekules novads','0641600',1),(4158,117,'Priekuļu novads','0427300',1),(4159,117,'Raunas novads','0427700',1),(4160,117,'Rēzekne','0210000',1),(4161,117,'Rēzeknes novads','0780200',1),(4162,117,'Riebiņu novads','0766300',1),(4163,117,'Rīga','0010000',1),(4164,117,'Rojas novads','0888300',1),(4165,117,'Ropažu novads','0808400',1),(4166,117,'Rucavas novads','0648500',1),(4167,117,'Rugāju novads','0387500',1),(4168,117,'Rundāles novads','0407700',1),(4169,117,'Rūjiena, Rūjienas novads','0961615',1),(4170,117,'Rūjienas novads','0961600',1),(4171,117,'Sabile, Talsu novads','0880213',1),(4172,117,'Salacgrīva, Salacgrīvas novads','0661415',1),(4173,117,'Salacgrīvas novads','0661400',1),(4174,117,'Salas novads','0568700',1),(4175,117,'Salaspils novads','0801200',1),(4176,117,'Salaspils, Salaspils novads','0801211',1),(4177,117,'Saldus novads','0840200',1),(4178,117,'Saldus, Saldus novads','0840201',1),(4179,117,'Saulkrasti, Saulkrastu novads','0801413',1),(4180,117,'Saulkrastu novads','0801400',1),(4181,117,'Seda, Strenču novads','0941813',1),(4182,117,'Sējas novads','0809200',1),(4183,117,'Sigulda, Siguldas novads','0801615',1),(4184,117,'Siguldas novads','0801601',1),(4185,117,'Skrīveru novads','0328200',1),(4186,117,'Skrunda, Skrundas novads','0621209',1),(4187,117,'Skrundas novads','0621200',1),(4188,117,'Smiltene, Smiltenes novads','0941615',1),(4189,117,'Smiltenes novads','0941600',1),(4190,117,'Staicele, Alojas novads','0661017',1),(4191,117,'Stende, Talsu novads','0880215',1),(4192,117,'Stopiņu novads','0809600',1),(4193,117,'Strenči, Strenču novads','0941817',1),(4194,117,'Strenču novads','0941800',1),(4195,117,'Subate, Ilūkstes novads','0440815',1),(4196,117,'Talsi, Talsu novads','0880201',1),(4197,117,'Talsu novads','0880200',1),(4198,117,'Tērvetes novads','0468900',1),(4199,117,'Tukuma novads','0900200',1),(4200,117,'Tukums, Tukuma novads','0900201',1),(4201,117,'Vaiņodes novads','0649300',1),(4202,117,'Valdemārpils, Talsu novads','0880217',1),(4203,117,'Valka, Valkas novads','0940201',1),(4204,117,'Valkas novads','0940200',1),(4205,117,'Valmiera','0250000',1),(4206,117,'Vangaži, Inčukalna novads','0801817',1),(4207,117,'Varakļāni, Varakļānu novads','0701817',1),(4208,117,'Varakļānu novads','0701800',1),(4209,117,'Vārkavas novads','0769101',1),(4210,117,'Vecpiebalgas novads','0429300',1),(4211,117,'Vecumnieku novads','0409500',1),(4212,117,'Ventspils','0270000',1),(4213,117,'Ventspils novads','0980200',1),(4214,117,'Viesīte, Viesītes novads','0561815',1),(4215,117,'Viesītes novads','0561800',1),(4216,117,'Viļaka, Viļakas novads','0381615',1),(4217,117,'Viļakas novads','0381600',1),(4218,117,'Viļāni, Viļānu novads','0781817',1),(4219,117,'Viļānu novads','0781800',1),(4220,117,'Zilupe, Zilupes novads','0681817',1),(4221,117,'Zilupes novads','0681801',1),(4222,43,'Arica y Parinacota','AP',1),(4223,43,'Los Rios','LR',1),(4224,220,'Харьковская область','63',1),(4225,118,'Beirut','LB-BR',1),(4226,118,'Bekaa','LB-BE',1),(4227,118,'Mount Lebanon','LB-ML',1),(4228,118,'Nabatieh','LB-NB',1),(4229,118,'North','LB-NR',1),(4230,118,'South','LB-ST',1),(4231,99,'Telangana','TS',1),(4232,44,'Qinghai','QH',1),(4233,100,'Papua Barat','PB',1),(4234,100,'Sulawesi Barat','SR',1),(4235,100,'Kepulauan Riau','KR',1);
/*!40000 ALTER TABLE `oc_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_zone_to_geo_zone`
--

DROP TABLE IF EXISTS `oc_zone_to_geo_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_zone_to_geo_zone` (
  `zone_to_geo_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL DEFAULT '0',
  `geo_zone_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`zone_to_geo_zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_zone_to_geo_zone`
--

LOCK TABLES `oc_zone_to_geo_zone` WRITE;
/*!40000 ALTER TABLE `oc_zone_to_geo_zone` DISABLE KEYS */;
INSERT INTO `oc_zone_to_geo_zone` VALUES (57,176,0,3,'2015-11-11 15:56:24','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `oc_zone_to_geo_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_prodproperty`
--

DROP TABLE IF EXISTS `product_prodproperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_prodproperty` (
  `product_prodproperty_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_prodproperty_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `val` varchar(1000) DEFAULT NULL,
  `sortOrder` tinyint(3) DEFAULT NULL,
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_prodproperty_id`),
  KEY `category_prodproperty_id` (`category_prodproperty_id`)
) ENGINE=MyISAM AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_prodproperty`
--

LOCK TABLES `product_prodproperty` WRITE;
/*!40000 ALTER TABLE `product_prodproperty` DISABLE KEYS */;
INSERT INTO `product_prodproperty` VALUES (77,17,53,'Пленка',NULL,0),(93,16,42,'Полиэстер',NULL,0),(76,16,53,'Стеклохолст',NULL,0),(71,26,50,NULL,NULL,1),(72,16,50,'Полиэстер',NULL,0),(70,20,50,'4,6',NULL,0),(129,17,51,NULL,NULL,1),(66,25,52,'900 (92) / 1000 (102)',NULL,0),(65,22,52,'-25',NULL,0),(64,21,52,'2',NULL,0),(63,20,52,'4,0',NULL,0),(67,26,52,NULL,NULL,1),(68,17,52,'Пленка',NULL,0),(73,17,50,'Пленка',NULL,0),(128,25,51,'900 (92) / 1000 (102)',NULL,0);
/*!40000 ALTER TABLE `product_prodproperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_prodtab`
--

DROP TABLE IF EXISTS `product_prodtab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_prodtab` (
  `product_prodtab_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_prodtab_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `val` varchar(1000) DEFAULT NULL,
  `sortOrder` tinyint(3) DEFAULT NULL,
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_prodtab_id`),
  KEY `category_prodtab_id` (`category_prodtab_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_prodtab`
--

LOCK TABLES `product_prodtab` WRITE;
/*!40000 ALTER TABLE `product_prodtab` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_prodtab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produnit_packagestr`
--

DROP TABLE IF EXISTS `produnit_packagestr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produnit_packagestr` (
  `packagestr_id` int(10) NOT NULL AUTO_INCREMENT,
  `produnit_template_id` int(10) NOT NULL,
  `description` varchar(250) NOT NULL,
  `value` varchar(250) NOT NULL,
  `sortOrder` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`packagestr_id`)
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produnit_packagestr`
--

LOCK TABLES `produnit_packagestr` WRITE;
/*!40000 ALTER TABLE `produnit_packagestr` DISABLE KEYS */;
INSERT INTO `produnit_packagestr` VALUES (1,1,'asdfsaf','asdfsadf',0),(70,3,'на паллете: ','30 рулонов',6),(58,2,'Толщина рулона: ','4.2 мм.',3),(59,2,'на паллете: ','20 рулонов',5),(60,2,'Вес м2: ','5кг',2),(57,2,'Размер рулона: ','10 м. x 1 м.',4),(56,2,'Упаковка','рулон, 10 м2',1),(69,3,'Размер рулона: ','1 м x 9 м',4),(68,3,'Вес м2: ','3.5кг',2),(67,3,'Упаковка','рулон, 9 м2',1),(71,3,'Вес рулона:','31,5 кг',5),(72,3,'Толщина','2,5 мм',3);
/*!40000 ALTER TABLE `produnit_packagestr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produnit_template`
--

DROP TABLE IF EXISTS `produnit_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produnit_template` (
  `produnit_template_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`produnit_template_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produnit_template`
--

LOCK TABLES `produnit_template` WRITE;
/*!40000 ALTER TABLE `produnit_template` DISABLE KEYS */;
INSERT INTO `produnit_template` VALUES (3,'РМ | 9м2 | 3,5кг | 30шт |','Для Гидроизол ТКП-3,5'),(2,'РМ | 10м2 | 5кг | 20шт |','Рулонные материалы | рулон, 10 м2 | 5 кг вес одного кв. м | 20 шт на паллете |');
/*!40000 ALTER TABLE `produnit_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produnit_unit`
--

DROP TABLE IF EXISTS `produnit_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produnit_unit` (
  `unit_id` int(10) NOT NULL AUTO_INCREMENT,
  `produnit_template_id` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_price` varchar(50) NOT NULL DEFAULT '',
  `name_plural` varchar(50) NOT NULL DEFAULT '',
  `name_package_dimension` varchar(50) NOT NULL DEFAULT '',
  `name_in_package` varchar(50) NOT NULL DEFAULT '',
  `calcKoef` double(16,9) unsigned DEFAULT NULL COMMENT 'coef for calculations with regard to base unit',
  `calcRel` int(10) DEFAULT NULL COMMENT 'calculate to this unit',
  `isPriceBase` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'unit for pricing, using products'' price',
  `isSaleBase` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'unit for selling, influences min sale quantity',
  `isPackageBase` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'unit for calculating loading, using weight',
  `switchSortOrder` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'is show in price switch. 0=not shown',
  `loadingSortOrder` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'is show in loading calculator. 0=not shown',
  `weight` float(10,3) DEFAULT NULL COMMENT 'kg',
  `package_width` varchar(50) NOT NULL DEFAULT '',
  `package_length` varchar(50) NOT NULL DEFAULT '',
  `package_height` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`unit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produnit_unit`
--

LOCK TABLES `produnit_unit` WRITE;
/*!40000 ALTER TABLE `produnit_unit` DISABLE KEYS */;
INSERT INTO `produnit_unit` VALUES (3,65,'листn','л.','','','',234.000000000,4,0,1,1,0,1,100.000,'','',''),(4,65,'м32','м3','','','',1.000000000,3,0,0,0,1,1,NULL,'','',''),(8,2,'рулон','рулон','рулонов','рулона','В рулоне',10.000000000,9,0,1,0,2,2,50.000,'10 м.','1 м.','4.2 мм.'),(11,2,'паллета','палетта','паллет','паллеты','на паллете',20.000000000,8,0,0,0,3,0,NULL,'','',''),(9,2,'м2','м2','м2','м2','м2',NULL,NULL,1,0,1,1,1,5.000,'','',''),(12,3,'м2','м2','м2','м2','м2',NULL,NULL,1,0,1,1,1,3.500,'','',''),(13,3,'рулон','рулон','рулонов','рулона','в рулоне',9.000000000,12,0,1,0,2,2,31.500,'1 м','9 м','2,7 мм'),(14,3,'паллета','паллета','паллет','паллеты','на паллете',30.000000000,13,0,0,0,0,0,NULL,'','','');
/*!40000 ALTER TABLE `produnit_unit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-11  8:52:22