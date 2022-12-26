
CREATE TABLE `event` (
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(100) NOT NULL,
	`occurredAt` date NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `tip` (
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`tippeeID` int unsigned NOT NULL,
	`eventID` int unsigned NOT NULL,
	`amountInCents` int unsigned NOT NULL,
	`notes` varchar(300) NOT NULL,
	`createdAt` datetime NOT NULL,
	`isCompleted` tinyint unsigned NOT NULL,
	`completedAt` datetime DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `byTippee` (`tippeeID`),
	KEY `byEvent` (`eventID`),
	KEY `byDate` (`createdAt`)
) ENGINE=InnoDB;

CREATE TABLE `tippee` (
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`occupation` varchar(50) NOT NULL,
	`notes` varchar(300) NOT NULL,
	`createdAt` datetime NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;
