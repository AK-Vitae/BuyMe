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
('Joe','Shmoe','jshmoe','password','jshmoe@buyme.com',2, true);
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
    FOREIGN KEY(`asked_by`) REFERENCES account(`account_number`),
    FOREIGN KEY(`answered_by`) REFERENCES account(`account_number`)
);

SELECT * FROM `question`;

