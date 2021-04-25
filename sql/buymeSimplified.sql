DROP DATABASE IF EXISTS `buyme`;
CREATE DATABASE IF NOT EXISTS `buyme`;

USE `buyme`;

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`
(
    `account_number` INT     NOT NULL auto_increment,
    `first_name`     VARCHAR(25) DEFAULT NULL,
    `last_name`      VARCHAR(25) DEFAULT NULL,
    `username`       VARCHAR(50) DEFAULT NULL,
    `password`       VARCHAR(50) DEFAULT NULL,
    `email`          VARCHAR(50) DEFAULT NULL,
    `access_level`   INT     NOT NULL,
    `is_active`      BOOLEAN NOT NULL,
    PRIMARY KEY (`account_number`)
);

-- Adding data for admin and two customer representatives

INSERT INTO account (first_name, last_name, username, password, email, access_level, is_active)
VALUES ('admin', 'admin', 'admin', 'admin', 'admin@buyme.com', 1, true),
       ('John', 'Smith', 'jsmith', '1234', 'jsmith@buyme.com', 2, true),
       ('Jane', 'Doe', 'jdoe', '4321', 'jdoe@buyme.com', 2, true);

-- Q&A
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`
(
    `question_id` INT NOT NULL auto_increment,
    `topic`       VARCHAR(50)  DEFAULT NULL,
    `question`    VARCHAR(200) DEFAULT NULL,
    `asked_by`    INT          DEFAULT NULL,
    `ask_date`    DATETIME     DEFAULT NULL,
    `answer`      VARCHAR(200) DEFAULT NULL,
    `answered_by` INT          DEFAULT NULL,
    `answer_date` DATETIME     DEFAULT NULL,
    PRIMARY KEY (`question_id`),
    FOREIGN KEY (`asked_by`) REFERENCES account (`account_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`answered_by`) REFERENCES account (`account_number`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Auctiom Item
DROP TABLE IF EXISTS `auctionItem`;
CREATE TABLE `auctionItem`
(
    `listingID`     INT NOT NULL auto_increment,
    `productID`     VARCHAR(50)    DEFAULT NULL,
    `type`          VARCHAR(10)    DEFAULT NULL,
    `listPrice`     DECIMAL(20, 2) DEFAULT NULL,
    `minSellPrice`  DECIMAL(20, 2) DEFAULT NULL,
    `soldPrice`     DECIMAL(20, 2) DEFAULT NULL,
    `exteriorColor` VARCHAR(25)    DEFAULT NULL,
    `interiorColor` VARCHAR(25)    DEFAULT NULL,
    `model`         VARCHAR(50)    DEFAULT NULL,
    `manufacturer`  VARCHAR(50)    DEFAULT NULL,
    `condition`     VARCHAR(5)     DEFAULT NULL,
    `capacity`      INT            DEFAULT NULL,
    `closingDate`   DATETIME       DEFAULT NULL,
    `year`          INT            DEFAULT NULL,
    `listDate`      DATETIME       DEFAULT NULL,
    `seller`        INT            DEFAULT NULL,
    `purchaser`     INT            DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY (`seller`) REFERENCES account (`account_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`purchaser`) REFERENCES account (`account_number`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Car
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`
(
    `listingID`    INT NOT NULL,
    `fuelType`     VARCHAR(50) DEFAULT NULL,
    `mileage`      INT         DEFAULT NULL,
    `driveType`    VARCHAR(50) DEFAULT NULL,
    `bodyType`     VARCHAR(50) DEFAULT NULL,
    `transmission` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY (`listingID`) REFERENCES auctionItem (`listingID`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Boat
DROP TABLE IF EXISTS `boat`;
CREATE TABLE `boat`
(
    `listingID`       INT NOT NULL,
    `engineType`      VARCHAR(50) DEFAULT NULL,
    `boatType`        VARCHAR(50) DEFAULT NULL,
    `hullMaterial`    VARCHAR(50) DEFAULT NULL,
    `primaryFuelType` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY (`listingID`) REFERENCES auctionItem (`listingID`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Aircraft
DROP TABLE IF EXISTS `aircraft`;
CREATE TABLE `aircraft`
(
    `listingID`   INT NOT NULL,
    `airCategory` VARCHAR(50)  DEFAULT NULL,
    `engineHours` INT          DEFAULT NULL,
    `avionics`    VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (`listingID`),
    FOREIGN KEY (`listingID`) REFERENCES auctionItem (`listingID`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bid
DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid`
(
    `listingID` INT,
    `bidder`    INT,
    `bidValue`  DECIMAL(20, 2),
    `bidDate`   DATETIME DEFAULT NULL,
    PRIMARY KEY (listingID, bidValue),
    FOREIGN KEY (listingID) REFERENCES auctionitem (listingID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (bidder) REFERENCES account (account_number) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Autobid
DROP TABLE IF EXISTS `autobid`;
CREATE TABLE `autobid`
(
    `listingID` int    NOT NULL,
    `userID`    int    NOT NULL,
    `ceiling`   double NOT NULL,
    `increment` double NOT NULL,
    PRIMARY KEY (`listingID`, `userID`)
);

-- Alerts
DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert`
(
    `alertID`      INT NOT NULL auto_increment,
    `user`         INT,
    `alertTopic`   VARCHAR(50),
    `alertMessage` VARCHAR(300),
    `isRead`       BOOLEAN DEFAULT false,
    PRIMARY KEY (alertID),
    FOREIGN KEY (`user`) REFERENCES account (`account_number`) ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Wishlist
DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist`
(
    `user`         INT,
    `model`        VARCHAR(50),
    `manufacturer` VARCHAR(50),
    `condition`    VARCHAR(5),
    `maxPrice`     DECIMAL(20, 2),
    `isAvailable`  BOOLEAN,
    PRIMARY KEY (`user`, `model`, `manufacturer`, `condition`, `maxPrice`),
    FOREIGN KEY (`user`) REFERENCES account (`account_number`) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT *
FROM `account`;
SELECT *
FROM `question`;
SELECT *
FROM `auctionItem`;
SELECT *
FROM `car`;
SELECT *
FROM `boat`;
SELECT *
FROM `aircraft`;
SELECT *
FROM `bid`;
SELECT *
FROM `autobid`;
SELECT *
FROM `wishlist`;