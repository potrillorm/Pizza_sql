CREATE DATABASE IF NOT EXISTS `Pizzas`;
USE `Pizzas`;

-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `Base_Pizzas`
--

DROP TABLE IF EXISTS `Base_Pizzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Base_Pizzas` (
  `Pizza_id` int NOT NULL AUTO_INCREMENT,
  `Pizza_name` varchar(45) NOT NULL,
  `Description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Pizza_id`),
  UNIQUE KEY `Pizza_name` (`Pizza_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Base_Pizzas`
--

LOCK TABLES `Base_Pizzas` WRITE;
/*!40000 ALTER TABLE `Base_Pizzas` DISABLE KEYS */;
INSERT INTO `Base_Pizzas` (`Pizza_id`, `Pizza_name`, `Description`) VALUES (1,'Margherita','Classic Italian'),(2,'Classic Pepperoni','The American favorite'),(3,'Hawaiian','Sweet and savory'),(4,'Supreme Veggie','Garden freshness');
/*!40000 ALTER TABLE `Base_Pizzas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customers` (
  `Customer_id` int NOT NULL AUTO_INCREMENT,
  `First_name` varchar(45) NOT NULL,
  `Last_name` varchar(45) NOT NULL,
  `Phone_number` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` (`Customer_id`, `First_name`, `Last_name`, `Phone_number`, `Email`, `Address`) VALUES (1,'John','Smith','5551234567','john.smith@mail.com','123 Oak St, New York, NY'),(2,'Emily','Jones','5559876543','emily.jones@mail.com','45 Maple Ave, Los Angeles, CA'),(3,'Michael','Brown','5551112222','michael.b@mail.com','789 Pine Ln, Chicago, IL'),(4,'Sarah','Miller','555-444-3333','sarah.miller@web.net','101 Bay View St, Miami, FL'),(5,'David','Wilson','555-777-8888','davidw@fastmail.com','20 Oakridge Dr, Dallas, TX');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingredients`
--

DROP TABLE IF EXISTS `Ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ingredients` (
  `Ingredient_id` int NOT NULL AUTO_INCREMENT,
  `Ingredient_name` varchar(75) NOT NULL,
  `Ingredient_type` varchar(45) DEFAULT NULL,
  `Ingredient_cost` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`Ingredient_id`),
  UNIQUE KEY `Ingredient_name` (`Ingredient_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredients`
--

LOCK TABLES `Ingredients` WRITE;
/*!40000 ALTER TABLE `Ingredients` DISABLE KEYS */;
INSERT INTO `Ingredients` (`Ingredient_id`, `Ingredient_name`, `Ingredient_type`, `Ingredient_cost`) VALUES (1,'Tomato Sauce','Base',1.50),(2,'Mozzarella Cheese','Dairy',4.80),(3,'Pepperoni','Meat',6.20),(4,'Mushrooms','Vegetable',3.10),(5,'Fresh Basil','Herb',1.00),(6,'Ham','Meat',5.50),(7,'Pineapple','Fruit',2.50),(8,'Onion','Vegetable',0.90),(9,'Green Bell Pepper','Vegetable',1.20),(10,'Garlic','Condiment',0.50);
/*!40000 ALTER TABLE `Ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_Details`
--

DROP TABLE IF EXISTS `Order_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_Details` (
  `Order_detail_id` int NOT NULL AUTO_INCREMENT,
  `Orders_Order_id` int NOT NULL,
  `Base_Pizzas_Pizza_id` int NOT NULL,
  `Sizes_Size_id` int NOT NULL,
  `Quantity` int NOT NULL,
  `Price_at_sale` decimal(5,2) NOT NULL,
  PRIMARY KEY (`Order_detail_id`),
  KEY `Orders_Order_id` (`Orders_Order_id`),
  KEY `Base_Pizzas_Pizza_id` (`Base_Pizzas_Pizza_id`),
  KEY `Sizes_Size_id` (`Sizes_Size_id`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`Orders_Order_id`) REFERENCES `Orders` (`Order_id`),
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`Base_Pizzas_Pizza_id`) REFERENCES `Base_Pizzas` (`Pizza_id`),
  CONSTRAINT `order_details_ibfk_3` FOREIGN KEY (`Sizes_Size_id`) REFERENCES `Sizes` (`Size_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Details`
--

LOCK TABLES `Order_Details` WRITE;
/*!40000 ALTER TABLE `Order_Details` DISABLE KEYS */;
INSERT INTO `Order_Details` (`Order_detail_id`, `Orders_Order_id`, `Base_Pizzas_Pizza_id`, `Sizes_Size_id`, `Quantity`, `Price_at_sale`) VALUES (1,1,2,3,1,18.99),(2,1,1,1,1,12.00),(3,2,3,3,1,17.99),(4,3,4,2,1,14.50),(5,3,1,4,1,19.50),(6,4,2,2,2,15.99),(7,5,3,1,1,11.50),(8,3,4,2,1,14.50),(9,3,1,4,1,19.50),(10,4,2,2,2,15.99),(11,5,3,1,1,11.50);
/*!40000 ALTER TABLE `Order_Details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `Order_id` int NOT NULL AUTO_INCREMENT,
  `Customers_Customer_id` int NOT NULL,
  `Order_date_time` datetime NOT NULL,
  `Total_amount` decimal(5,2) NOT NULL,
  `Payment_method` varchar(45) DEFAULT NULL,
  `Delivery_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Order_id`),
  KEY `Customers_Customer_id` (`Customers_Customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Customers_Customer_id`) REFERENCES `Customers` (`Customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` (`Order_id`, `Customers_Customer_id`, `Order_date_time`, `Total_amount`, `Payment_method`, `Delivery_type`) VALUES (1,1,'2025-10-18 18:00:00',30.99,'Credit Card','Delivery'),(2,2,'2025-10-17 19:30:00',17.99,'Cash','Pick Up'),(3,3,'2025-10-18 20:15:00',34.00,'Cash','Pick Up'),(4,1,'2025-10-18 20:45:00',31.98,'Credit Card','Delivery'),(5,2,'2025-10-19 12:30:00',11.50,'Credit Card','Delivery'),(6,3,'2025-10-18 20:15:00',34.00,'Cash','Pick Up'),(7,1,'2025-10-18 20:45:00',31.98,'Credit Card','Delivery'),(8,2,'2025-10-19 12:30:00',11.50,'Credit Card','Delivery');
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prices`
--

DROP TABLE IF EXISTS `Prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prices` (
  `Base_Pizzas_Pizza_id` int NOT NULL,
  `Sizes_Size_id` int NOT NULL,
  `Sale_price` decimal(5,2) NOT NULL,
  PRIMARY KEY (`Base_Pizzas_Pizza_id`,`Sizes_Size_id`),
  KEY `Sizes_Size_id` (`Sizes_Size_id`),
  CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`Base_Pizzas_Pizza_id`) REFERENCES `Base_Pizzas` (`Pizza_id`),
  CONSTRAINT `prices_ibfk_2` FOREIGN KEY (`Sizes_Size_id`) REFERENCES `Sizes` (`Size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prices`
--

LOCK TABLES `Prices` WRITE;
/*!40000 ALTER TABLE `Prices` DISABLE KEYS */;
INSERT INTO `Prices` (`Base_Pizzas_Pizza_id`, `Sizes_Size_id`, `Sale_price`) VALUES (1,1,10.50),(1,2,13.99),(1,3,16.99),(1,4,19.50),(2,1,12.00),(2,2,15.99),(2,3,18.99),(2,4,22.00),(3,1,11.50),(3,2,14.99),(3,3,17.99),(3,4,20.50),(4,1,11.00),(4,2,14.50),(4,3,17.50),(4,4,20.00);
/*!40000 ALTER TABLE `Prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipes`
--

DROP TABLE IF EXISTS `Recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipes` (
  `Base_Pizzas_Pizza_id` int NOT NULL,
  `Ingredients_Ingredient_id` int NOT NULL,
  `Ingredient_quantity` decimal(5,2) DEFAULT NULL,
  `Unit_of_measure` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Base_Pizzas_Pizza_id`,`Ingredients_Ingredient_id`),
  KEY `Ingredients_Ingredient_id` (`Ingredients_Ingredient_id`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`Base_Pizzas_Pizza_id`) REFERENCES `Base_Pizzas` (`Pizza_id`),
  CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`Ingredients_Ingredient_id`) REFERENCES `Ingredients` (`Ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipes`
--

LOCK TABLES `Recipes` WRITE;
/*!40000 ALTER TABLE `Recipes` DISABLE KEYS */;
INSERT INTO `Recipes` (`Base_Pizzas_Pizza_id`, `Ingredients_Ingredient_id`, `Ingredient_quantity`, `Unit_of_measure`) VALUES (1,1,150.00,'grams'),(1,2,200.00,'grams'),(1,5,5.00,'grams'),(2,1,150.00,'grams'),(2,2,200.00,'grams'),(2,3,100.00,'grams'),(3,1,150.00,'grams'),(3,2,200.00,'grams'),(3,6,80.00,'grams'),(3,7,75.00,'grams');
/*!40000 ALTER TABLE `Recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sizes`
--

DROP TABLE IF EXISTS `Sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sizes` (
  `Size_id` int NOT NULL AUTO_INCREMENT,
  `Size_name` varchar(45) NOT NULL,
  `Diameter_cm` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Size_id`),
  UNIQUE KEY `Size_name` (`Size_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sizes`
--

LOCK TABLES `Sizes` WRITE;
/*!40000 ALTER TABLE `Sizes` DISABLE KEYS */;
INSERT INTO `Sizes` (`Size_id`, `Size_name`, `Diameter_cm`) VALUES (1,'Small','8 in'),(2,'Medium','12 in'),(3,'Large','14 in'),(4,'Extra Large','16 in');
/*!40000 ALTER TABLE `Sizes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-18 19:16:07