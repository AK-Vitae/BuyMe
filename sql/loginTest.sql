CREATE DATABASE IF NOT EXISTS `buyme`;

USE `buyme`;

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account`
  (
     `account_number` INT NOT NULL AUTO_INCREMENT,
     `first_name`    VARCHAR(25) DEFAULT NULL,
     `last_name`     VARCHAR(25) DEFAULT NULL,
     `username`      VARCHAR(50) DEFAULT NULL,
     `password`      VARCHAR(50) DEFAULT NULL,
     `email`         VARCHAR(50) DEFAULT NULL,
     `access_level`  INT NOT NULL,
     PRIMARY KEY (`account_number`)
  );

-- Adding data for admin and three customer representatives

LOCK TABLES account WRITE;
INSERT INTO account (first_name, last_name, username, password, email, access_level) VALUES 
	('Ad','Min','admin','admin','admin@buyme.com',1),
	('John','Smith','jsmith','1234','jsmith@buyme.com',2),
	('Jane','Doe','jdoe','4321','jdoe@buyme.com',2),
	('Joe','Shmoe','jshmoe','password','jshmoe@buyme.com',2);
UNLOCK TABLES;

-- Display account table

SELECT * FROM `account`;