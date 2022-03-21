/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.20-MariaDB : Database - blogdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`blogdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `blogdb`;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `category` */

insert  into `category`(`id`,`category_name`) values 
(1,'Shooter'),
(2,'Survival'),
(3,'MMO');

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `comment` */

insert  into `comment`(`id`,`post_id`,`body`,`user_id`) values 
(1,1,'NAMALSK BEST MAP XD',2),
(2,2,'Very hard game not balanced',3),
(3,2,'I hate this game!!!!!!',4);

/*Table structure for table `game` */

DROP TABLE IF EXISTS `game`;

CREATE TABLE `game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` int(10) DEFAULT NULL,
  `image` blob DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `game` */

insert  into `game`(`id`,`game_name`,`description`,`rating`,`image`) values 
(1,'DAYZ','DayZ is a hardcore open-world survival game with only one rule: stay alive, no matter what. But with a myriad of threats lurking around every corner, that might be easier said than done...\r\nKey Features:\r\nWith no checkpoints or saves, when you die, you lose everything and have to start over.\r\nComplex and authentic survival mechanics, including hunting, crafting, building, health preservation, and resource management.\r\nUnpredictable and often emotional interactions with other players leading to a limitless spectrum of emergent gameplay.\r\nA huge 230 km2 map with a variety of beautiful landscapes and landmarks based on real-life locations.\r\nUp to 60 players striving to survive by any means necessary. Make friends, kill on sight, kidnap strangers and bend them to your will, or be betrayed for a can of beans. Anything and everything is possible.\r\nAn array of environmental threats that will test your capabilities. From erratic weather and dangerous wildlife to pitch-black nights and rage-induced infected.',4,NULL),
(2,'Escape from tarkov','Realistic mmo shooter',5,NULL);

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `icon` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `post` */

insert  into `post`(`id`,`icon`,`title`,`content`) values 
(1,'https://www.goclecd.fr/wp-content/uploads/dayz-banner2.jpg','DAYZ','BEST GAME EVER'),
(2,'https://gamepreorders.com/wp-content/uploads/2017/10/box-art.jpg','TARKOV','Prepare to die'),
(3,'https://thegamerhq.com/wp-content/uploads/2020/10/arma-2-download-pc.png','ARMA II','Dayz but not as good xd'),
(4,NULL,'DDLC','DOKI DOKI LITERATURE CLUB\r\n\r\n');

/*Table structure for table `rating` */

DROP TABLE IF EXISTS `rating`;

CREATE TABLE `rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rating_value` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_fk` (`post_id`),
  KEY `user_fk` (`user_id`),
  CONSTRAINT `post_fk` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `rating` */

insert  into `rating`(`id`,`rating_value`,`post_id`,`user_id`) values 
(1,4,1,2),
(2,3,1,2),
(6,1,2,2),
(8,2,1,2),
(12,3,2,2);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_mail` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_password` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_role` int(11) NOT NULL DEFAULT 0,
  `ban_status` tinyint(1) DEFAULT 0,
  `token` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`user_name`,`user_mail`,`user_password`,`user_role`,`ban_status`,`token`) values 
(2,'mirza ','mirza@gmail.com','1234',1,0,NULL),
(4,'miki','milane@gmail.com','827ccb0eea8a706c4c34a16891f84e7b',1,0,'7ea3338a0b63270e753777c2d0ab0ae7'),
(5,'mirza2','mirza@gmail.com','827ccb0eea8a706c4c34a16891f84e7b',1,0,'c1714ea375478cc65b43929e69a6b8e8'),
(6,'mirzone','mirzone@gmail.com','81dc9bdb52d04dc20036dbd8313ed055',2,0,'996c1712664938cd61a432c637b89c2a');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
