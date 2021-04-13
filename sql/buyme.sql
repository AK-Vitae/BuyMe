DROP DATABASE IF EXISTS `buyme`;
CREATE DATABASE IF NOT EXISTS `buyme`;

USE `buyme`;

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account`
(
    `account_number` INT NOT NULL auto_increment,
    `first_name`     VARCHAR(25) DEFAULT NULL,
    `last_name`      VARCHAR(25) DEFAULT NULL,
    `username`       VARCHAR(50) DEFAULT NULL,
    `password`       VARCHAR(50) DEFAULT NULL,
    `email`          VARCHAR(50) DEFAULT NULL,
    `access_level`   INT NOT NULL,
    `is_active`       BOOLEAN NOT NULL,
    PRIMARY KEY (`account_number`)
);

-- Adding data for admin and three customer representatives

LOCK TABLES account WRITE;
INSERT INTO account (first_name, last_name, username, password, email, access_level, is_active) VALUES
('admin','admin','admin','admin','admin@buyme.com',1, true),
('John','Smith','jsmith','1234','jsmith@buyme.com',2, true),
('Jane','Doe','jdoe','4321','jdoe@buyme.com',2, true),
('Joe','Shmoe','jshmoe','password','jshmoe@buyme.com',2, true),
('Zoe', 'Long', 'zlong', '1234', 'zlong@google.com', 3, true),
('Kevin', 'Motts', 'kmotts', '1234', 'kmotts@gmail.com', 3, true);
UNLOCK TABLES;

-- Display account table

SELECT * FROM `account`;

-- Create a question table for q&a 

DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`
(
    `question_id`     INT NOT NULL auto_increment,
    `topic`           VARCHAR(50) DEFAULT NULL,
    `question`        VARCHAR(200) DEFAULT NULL,
    `asked_by`        INT DEFAULT NULL,
    `ask_date`        DATETIME DEFAULT NULL,
    `answer`          VARCHAR(200) DEFAULT NULL,
    `answered_by`     INT DEFAULT NULL,
    `answer_date`     DATETIME DEFAULT NULL,
    PRIMARY KEY (`question_id`),
    FOREIGN KEY(`asked_by`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`answered_by`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM `question`;

-- Creates an the item for auction
DROP TABLE IF EXISTS `auctionItem`;
CREATE TABLE `auctionItem`
(
    `listingID` 		INT NOT NULL auto_increment,
    `productID`    		VARCHAR(50) DEFAULT NULL,
    `type`				VARCHAR(10) DEFAULT NULL,
    `listPrice`			DECIMAL(20,2) DEFAULT NULL,
    `minSellPrice`		DECIMAL(20,2) DEFAULT NULL,
    `soldPrice`			DECIMAL(20,2) DEFAULT NULL,
    `exteriorColor` 	VARCHAR(25) DEFAULT NULL,
    `interiorColor` 	VARCHAR(25) DEFAULT NULL,
    `model`		    	VARCHAR(50) DEFAULT NULL,
    `manufacturer`  	VARCHAR(50) DEFAULT NULL,
    `condition`  		VARCHAR(50) DEFAULT NULL,
    `capacity` 			INT DEFAULT NULL,
    `closingDate`      	DATETIME DEFAULT NULL,
    `year`				INT DEFAULT NULL,
    `listDate`			DATETIME DEFAULT NULL,
    `seller`			INT DEFAULT NULL,
    `purchaser`			INT DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY(`seller`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`purchaser`) REFERENCES account(`account_number`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`
(
    `listingID` 		INT NOT NULL,
    `fuelType`			VARCHAR(50) DEFAULT NULL,
    `mileage`			INT DEFAULT NULL,
    `driveType`			VARCHAR(50) DEFAULT NULL,
    `bodyType`			VARCHAR(50) DEFAULT NULL,
    `transmission`		VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY(`listingID`) REFERENCES auctionItem(`listingID`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- list car
LOCK TABLES auctionItem WRITE;
INSERT INTO auctionItem (productID, type, listPrice, minSellPrice, exteriorColor, interiorColor, model, manufacturer, `condition`, capacity, closingDate, `year`, listDate, seller) VALUES
('acd', 'car', 12000.00, 18000.00, 'white', 'black', 'Pasat', 'Volkswagon', 'used', 5, '2022-05-01 12:30:00', 2015, '2021-04-11 16:30:00', 6);
UNLOCK TABLES;
select * from `auctionItem`;

LOCK TABLES car WRITE;
INSERT INTO car (listingID, fuelType, mileage, driveType, bodyType, transmission) VALUES
(LAST_INSERT_ID(), 'super', 50000, 'FWD', 'Sedan', 'automatic');
UNLOCK TABLES;
select * from `car`;