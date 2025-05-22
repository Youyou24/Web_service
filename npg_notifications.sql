/*
 Navicat Premium Data Transfer

 Source Server         : 10.10.2.17
 Source Server Type    : MySQL
 Source Server Version : 100422 (10.4.22-MariaDB)
 Source Host           : 10.10.2.17:3306
 Source Schema         : npg_notifications

 Target Server Type    : MySQL
 Target Server Version : 100422 (10.4.22-MariaDB)
 File Encoding         : 65001

 Date: 23/04/2025 10:17:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for _prisma_migrations
-- ----------------------------
DROP TABLE IF EXISTS `_prisma_migrations`;
CREATE TABLE `_prisma_migrations`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) NULL DEFAULT NULL,
  `migration_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `rolled_back_at` datetime(3) NULL DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of _prisma_migrations
-- ----------------------------
INSERT INTO `_prisma_migrations` VALUES ('2298cf30-4ea9-4840-9488-5aed8fc64f41', '5fd7e2b6f5baba4006bccc329aa01091f713a5b4d534b748a41fa35c2943dfa6', '2025-01-29 08:59:14.411', '20250114095445_init', NULL, NULL, '2025-01-29 08:59:12.464', 1);
INSERT INTO `_prisma_migrations` VALUES ('bd97a878-9683-41dc-88dc-41ed0990691b', '378854418f5a6b2ddd2f39320bafe679417df2167af8525db2d19a2dbe875f67', '2025-01-29 09:29:31.024', '20250129092930_init', NULL, NULL, '2025-01-29 09:29:30.741', 1);

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application`  (
  `applicationId` int NOT NULL AUTO_INCREMENT,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`applicationId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of application
-- ----------------------------
INSERT INTO `application` VALUES (1, 'WMS');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `authId` int NOT NULL AUTO_INCREMENT,
  `userIdFk` int NOT NULL,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`authId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (1, 258, 'jonathan.ezoa');

-- ----------------------------
-- Table structure for channel
-- ----------------------------
DROP TABLE IF EXISTS `channel`;
CREATE TABLE `channel`  (
  `channelId` int NOT NULL AUTO_INCREMENT,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applicationIdFK` int NOT NULL,
  `platformIdFK` int NOT NULL,
  `contactIdFK` int NOT NULL,
  PRIMARY KEY (`channelId`) USING BTREE,
  INDEX `Channel_applicationIdFK_fkey`(`applicationIdFK` ASC) USING BTREE,
  INDEX `Channel_platformIdFK_fkey`(`platformIdFK` ASC) USING BTREE,
  INDEX `Channel_contactIdFK_fkey`(`contactIdFK` ASC) USING BTREE,
  CONSTRAINT `Channel_applicationIdFK_fkey` FOREIGN KEY (`applicationIdFK`) REFERENCES `application` (`applicationId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Channel_contactIdFK_fkey` FOREIGN KEY (`contactIdFK`) REFERENCES `contact` (`contactId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Channel_platformIdFK_fkey` FOREIGN KEY (`platformIdFK`) REFERENCES `platform` (`platformId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of channel
-- ----------------------------
INSERT INTO `channel` VALUES (1, '327fc337d6904410bb56', 'WMS QUALITE', 1, 1, 3);

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`  (
  `contactId` int NOT NULL AUTO_INCREMENT,
  `contact` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `platformIdFK` int NOT NULL,
  PRIMARY KEY (`contactId`) USING BTREE,
  INDEX `Contact_platformIdFK_fkey`(`platformIdFK` ASC) USING BTREE,
  CONSTRAINT `Contact_platformIdFK_fkey` FOREIGN KEY (`platformIdFK`) REFERENCES `platform` (`platformId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contact
-- ----------------------------
INSERT INTO `contact` VALUES (1, 'notification@npgandour.com', 'Nprs@#2030!ion', 'notification', 3);
INSERT INTO `contact` VALUES (2, 'notification@npgandour.com', 'Nprs@#2030!ion', 'notification sms', 2);
INSERT INTO `contact` VALUES (3, 'mobwo0x2qo6c3dxy', '', 'whatsapp1', 1);

-- ----------------------------
-- Table structure for email
-- ----------------------------
DROP TABLE IF EXISTS `email`;
CREATE TABLE `email`  (
  `emailId` int NOT NULL AUTO_INCREMENT,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `platformIdFK` int NOT NULL,
  PRIMARY KEY (`emailId`) USING BTREE,
  INDEX `Email_platformIdFK_fkey`(`platformIdFK` ASC) USING BTREE,
  CONSTRAINT `Email_platformIdFK_fkey` FOREIGN KEY (`platformIdFK`) REFERENCES `platform` (`platformId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of email
-- ----------------------------

-- ----------------------------
-- Table structure for entetenotification
-- ----------------------------
DROP TABLE IF EXISTS `entetenotification`;
CREATE TABLE `entetenotification`  (
  `enteteNotificationId` int NOT NULL AUTO_INCREMENT,
  `channelIdFK` int NULL DEFAULT NULL,
  `platformIdFK` int NOT NULL,
  `applicationIdFK` int NULL DEFAULT NULL,
  `discution` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `createdBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `object` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `contactIdFK` int NULL DEFAULT NULL,
  PRIMARY KEY (`enteteNotificationId`) USING BTREE,
  INDEX `EnteteNotification_channelIdFK_fkey`(`channelIdFK` ASC) USING BTREE,
  INDEX `EnteteNotification_platformIdFK_fkey`(`platformIdFK` ASC) USING BTREE,
  INDEX `EnteteNotification_applicationIdFK_fkey`(`applicationIdFK` ASC) USING BTREE,
  INDEX `EnteteNotification_contactIdFK_fkey`(`contactIdFK` ASC) USING BTREE,
  CONSTRAINT `EnteteNotification_applicationIdFK_fkey` FOREIGN KEY (`applicationIdFK`) REFERENCES `application` (`applicationId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `EnteteNotification_channelIdFK_fkey` FOREIGN KEY (`channelIdFK`) REFERENCES `channel` (`channelId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `EnteteNotification_contactIdFK_fkey` FOREIGN KEY (`contactIdFK`) REFERENCES `contact` (`contactId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `EnteteNotification_platformIdFK_fkey` FOREIGN KEY (`platformIdFK`) REFERENCES `platform` (`platformId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of entetenotification
-- ----------------------------
INSERT INTO `entetenotification` VALUES (1, NULL, 3, NULL, '1', '2025-01-29 10:15:24.607', '2025-01-29 10:15:24.607', 'jonathan.ezoa', 'test objet', 'jonathan test', NULL);
INSERT INTO `entetenotification` VALUES (2, NULL, 2, NULL, '1', '2025-01-29 10:37:32.865', '2025-01-29 10:37:32.865', 'jonathan.ezoa', 'test sms', 'sms test', NULL);
INSERT INTO `entetenotification` VALUES (3, 1, 1, 1, '1', '2025-03-17 09:38:37.857', '2025-03-17 09:38:37.857', 'jonathan.ezoa', 'object test', 'test message 444444', 3);
INSERT INTO `entetenotification` VALUES (4, 1, 1, 1, '1', '2025-03-17 10:00:17.610', '2025-03-17 10:00:17.610', 'jonathan.ezoa', 'test encore', 'je test encore', NULL);
INSERT INTO `entetenotification` VALUES (5, 1, 1, 1, '1', '2025-03-17 14:58:15.858', '2025-03-17 14:58:15.858', 'jonathan.ezoa', 'Test', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test mzssage\n            ', 3);
INSERT INTO `entetenotification` VALUES (6, 1, 1, 1, '1', '2025-03-17 15:00:39.035', '2025-03-17 15:00:39.035', 'jonathan.ezoa', 'object test', 'test message 444444', 3);
INSERT INTO `entetenotification` VALUES (7, 1, 1, 1, '1', '2025-03-17 15:01:53.512', '2025-03-17 15:01:53.512', 'jonathan.ezoa', 'test', 'test messagee', 3);
INSERT INTO `entetenotification` VALUES (8, 1, 1, 1, '1', '2025-03-17 15:02:34.981', '2025-03-17 15:02:34.981', 'jonathan.ezoa', 'test', '\n            test message\n            ', 3);
INSERT INTO `entetenotification` VALUES (9, 1, 1, 1, '1', '2025-03-17 15:02:56.686', '2025-03-17 15:02:56.686', 'jonathan.ezoa', 'test', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', 3);
INSERT INTO `entetenotification` VALUES (10, 1, 1, 1, '1', '2025-03-17 15:03:53.273', '2025-03-17 15:03:53.273', 'jonathan.ezoa', 'test', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test mon message\n            ', 3);
INSERT INTO `entetenotification` VALUES (11, 1, 1, 1, '1', '2025-03-17 15:04:47.939', '2025-03-17 15:04:47.939', 'jonathan.ezoa', 'Objet', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test mon message\n            ', 3);
INSERT INTO `entetenotification` VALUES (12, 1, 1, 1, '1', '2025-03-17 15:18:37.594', '2025-03-17 15:18:37.594', 'jonathan.ezoa', 'Test object', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test objetb226 \n            ', 3);
INSERT INTO `entetenotification` VALUES (13, 1, 1, 1, '1', '2025-03-17 15:19:26.351', '2025-03-17 15:19:26.351', 'jonathan.ezoa', 'Test', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test 1234\n            ', 3);
INSERT INTO `entetenotification` VALUES (14, 1, 1, 1, '1', '2025-03-17 15:20:06.729', '2025-03-17 15:20:06.729', 'jonathan.ezoa', 'Test object', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Objet message\n            ', 3);
INSERT INTO `entetenotification` VALUES (15, 1, 1, 1, '1', '2025-03-18 11:28:37.787', '2025-03-18 11:28:37.787', 'jonathan.ezoa', 'Test jonathan', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message body\n            ', 3);
INSERT INTO `entetenotification` VALUES (16, 1, 1, 1, '1', '2025-03-18 11:30:34.362', '2025-03-18 11:30:34.362', 'jonathan.ezoa', 'Objet', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test notification\n            ', 3);
INSERT INTO `entetenotification` VALUES (17, 1, 1, 1, '1', '2025-03-18 11:33:19.122', '2025-03-18 11:33:19.122', 'jonathan.ezoa', 'Probleme', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Un probleme a ete detecter \n            ', 3);
INSERT INTO `entetenotification` VALUES (18, 1, 1, 1, '1', '2025-03-18 11:46:59.954', '2025-03-18 11:46:59.954', 'jonathan.ezoa', 'Test oblet', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Hdhdh djdjjdd fjdjdjd djdjdjd fjfjfjf fkfkfkf fjfkfjf fkfkfkf fkfkfkf fjfjjjdjdjd djdjdjdjd djdjdjdjdjdjdudidid dkdididid dkdidididd djdididid djdkdid\n            ', 3);
INSERT INTO `entetenotification` VALUES (19, 1, 1, 1, '1', '2025-03-18 11:51:07.946', '2025-03-18 11:51:07.946', 'jonathan.ezoa', 'Objet 2', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test lzq message avec la plus grand plage de mots disponible dans le susteme avec tout le reste des sujet disponible encore zt encore et encore etc\n            ', 3);
INSERT INTO `entetenotification` VALUES (20, 1, 1, 1, '1', '2025-03-18 11:52:56.893', '2025-03-18 11:52:56.893', 'jonathan.ezoa', 'Objet', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test encore pojr fois si ce n’est pas le nombre de reload qui fait que cela charge a l’infini. J’espere que ce n’est pas ca sinon ca sera bizarre e\n            ', 3);
INSERT INTO `entetenotification` VALUES (21, 1, 1, 1, '1', '2025-03-18 11:54:30.514', '2025-03-18 11:54:30.514', 'jonathan.ezoa', 'Test objet', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Cela c’est reproduit encore. Je ne sais pas ce qui fait ça mais c’est tres bizare que ća fasse ća. Jespere jusye que je vais trouver le probleme et le\n            ', 3);
INSERT INTO `entetenotification` VALUES (22, 1, 1, 1, '1', '2025-03-18 11:55:14.827', '2025-03-18 11:55:14.827', 'jonathan.ezoa', 'Bizare', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Cela c’est reproduit encore. Je ne sais pas ce qui fait ça mais c’est tres bizare que ća fasse ća. Jespere jusye que je vais trouver le probleme et le\n            ', 3);
INSERT INTO `entetenotification` VALUES (23, 1, 1, 1, '1', '2025-03-18 11:57:41.898', '2025-03-18 11:57:41.898', 'jonathan.ezoa', 'Ffff', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Cela c’est reproduit encore. Je ne sais pas ce qui fait ça mais c’est tres bizare que ća fasse ća. Jespere jusye que je vais trouver le probleme et le\n            ', 3);
INSERT INTO `entetenotification` VALUES (24, 1, 1, 1, '1', '2025-03-18 15:26:33.109', '2025-03-18 15:26:33.109', 'jonathan.ezoa', 'Test', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', 3);
INSERT INTO `entetenotification` VALUES (25, 1, 2, 1, '1', '2025-03-18 15:27:36.143', '2025-03-18 15:27:36.143', 'jonathan.ezoa', 'Objet', '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', 2);
INSERT INTO `entetenotification` VALUES (26, 1, 2, 1, '1', '2025-03-19 12:14:12.927', '2025-03-19 12:14:12.927', 'jonathan.ezoa', 'Test notification', '\n            OF:1103669\r\nArticle: CRE. CAROTONE { MIX } 135 ML 96P\r\nLot de contrôle: 030000053164\r\nControlleur: lorda.jarmouche\r\n \r\nMessage:\r\n Je test les message \n            ', 2);
INSERT INTO `entetenotification` VALUES (27, 1, 1, 1, '1', '2025-03-19 12:19:02.516', '2025-03-19 12:19:02.516', 'jonathan.ezoa', 'Test notification', '\n            OF:1103669\r\nArticle: CRE. CAROTONE { MIX } 135 ML 96P\r\nLot de contrôle: 030000053164\r\nControlleur: lorda.jarmouche\r\n \r\nMessage:\r\n Test \n            ', 3);
INSERT INTO `entetenotification` VALUES (28, 1, 1, 1, '1', '2025-03-19 12:23:18.623', '2025-03-19 12:23:18.623', 'jonathan.ezoa', 'Notification', '\n            OF:1103669\r\nArticle: CRE. CAROTONE { MIX } 135 ML 96P\r\nLot de contrôle: 030000053164\r\nControlleur: lorda.jarmouche\r\n \r\nMessage:\r\n Test notification\n            ', 3);

-- ----------------------------
-- Table structure for filehasentetenotification
-- ----------------------------
DROP TABLE IF EXISTS `filehasentetenotification`;
CREATE TABLE `filehasentetenotification`  (
  `notificationId` int NOT NULL AUTO_INCREMENT,
  `enteteNotificationIdFK` int NOT NULL,
  `originalname` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `filename` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `size` int NULL DEFAULT NULL,
  `mimetype` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`notificationId`) USING BTREE,
  INDEX `FileHasEnteteNotification_enteteNotificationIdFK_fkey`(`enteteNotificationIdFK` ASC) USING BTREE,
  CONSTRAINT `FileHasEnteteNotification_enteteNotificationIdFK_fkey` FOREIGN KEY (`enteteNotificationIdFK`) REFERENCES `entetenotification` (`enteteNotificationId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of filehasentetenotification
-- ----------------------------
INSERT INTO `filehasentetenotification` VALUES (1, 4, 'Capture1.PNG', '1742205618387-Capture1.PNG', 51066, 'image/png');
INSERT INTO `filehasentetenotification` VALUES (2, 12, 'photo-1742224684957.jpg', '1742224717838-photo-1742224684957.jpg', 470796, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (3, 14, 'photo-1742224791062.jpg', '1742224806824-photo-1742224791062.jpg', 702604, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (4, 14, 'photo-1742224799110.jpg', '1742224807058-photo-1742224799110.jpg', 701482, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (5, 15, 'photo-1742297308400.jpg', '1742297318254-photo-1742297308400.jpg', 515290, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (6, 17, 'photo-1742297592273.jpg', '1742297599158-photo-1742297592273.jpg', 519457, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (7, 18, 'photo-1742298411801.jpg', '1742298420027-photo-1742298411801.jpg', 429710, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (8, 21, 'photo-1742298863869.jpg', '1742298870710-photo-1742298863869.jpg', 469062, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (9, 22, 'photo-1742298894447.jpg', '1742298914868-photo-1742298894447.jpg', 501957, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (10, 22, 'photo-1742298901837.jpg', '1742298915037-photo-1742298901837.jpg', 455123, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (11, 22, 'photo-1742298908173.jpg', '1742298915180-photo-1742298908173.jpg', 458250, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (12, 23, 'photo-1742299055059.jpg', '1742299061948-photo-1742299055059.jpg', 414052, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (13, 24, 'photo-1742311576400.jpg', '1742311593167-photo-1742311576400.jpg', 596323, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (14, 24, 'photo-1742311584499.jpg', '1742311593317-photo-1742311584499.jpg', 541906, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (15, 27, 'photo-1742386733226.jpg', '1742386742602-photo-1742386733226.jpg', 482963, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (16, 28, 'photo-1742386988863.jpg', '1742386998669-photo-1742386988863.jpg', 421452, 'image/jpeg');
INSERT INTO `filehasentetenotification` VALUES (17, 28, 'photo-1742386995251.jpg', '1742386998762-photo-1742386995251.jpg', 410904, 'image/jpeg');

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`  (
  `notificationId` int NOT NULL AUTO_INCREMENT,
  `enteteNotificationIdFK` int NOT NULL,
  `platformIdFK` int NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachmentUrl` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `attachmentName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `whatsapp` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `userIdFK` int NOT NULL,
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`notificationId`) USING BTREE,
  INDEX `Notification_enteteNotificationIdFK_fkey`(`enteteNotificationIdFK` ASC) USING BTREE,
  INDEX `Notification_platformIdFK_fkey`(`platformIdFK` ASC) USING BTREE,
  CONSTRAINT `Notification_enteteNotificationIdFK_fkey` FOREIGN KEY (`enteteNotificationIdFK`) REFERENCES `entetenotification` (`enteteNotificationId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Notification_platformIdFK_fkey` FOREIGN KEY (`platformIdFK`) REFERENCES `platform` (`platformId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notification
-- ----------------------------
INSERT INTO `notification` VALUES (1, 1, 3, 'jonathan test', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (2, 2, 2, 'sms test', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (3, 3, 1, 'test message 444444', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (4, 4, 1, 'je test encore', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (5, 5, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test mzssage\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (6, 6, 1, 'test message 444444', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (7, 7, 1, 'test messagee', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (8, 8, 1, '\n            test message\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (9, 9, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (10, 10, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test mon message\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (11, 11, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test mon message\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (12, 12, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test objetb226 \n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (13, 13, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test 1234\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (14, 14, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Objet message\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (15, 15, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message body\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (16, 16, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Test notification\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (17, 17, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Un probleme a ete detecter \n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (18, 18, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Hdhdh djdjjdd fjdjdjd djdjdjd fjfjfjf fkfkfkf fjfkfjf fkfkfkf fkfkfkf fjfjjjdjdjd djdjdjdjd djdjdjdjdjdjdudidid dkdididid dkdidididd djdididid djdkdid\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (19, 19, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test lzq message avec la plus grand plage de mots disponible dans le susteme avec tout le reste des sujet disponible encore zt encore et encore etc\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (20, 20, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Je test encore pojr fois si ce n’est pas le nombre de reload qui fait que cela charge a l’infini. J’espere que ce n’est pas ca sinon ca sera bizarre e\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (21, 21, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Cela c’est reproduit encore. Je ne sais pas ce qui fait ça mais c’est tres bizare que ća fasse ća. Jespere jusye que je vais trouver le probleme et le\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (22, 22, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Cela c’est reproduit encore. Je ne sais pas ce qui fait ça mais c’est tres bizare que ća fasse ća. Jespere jusye que je vais trouver le probleme et le\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (23, 23, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Cela c’est reproduit encore. Je ne sais pas ce qui fait ça mais c’est tres bizare que ća fasse ća. Jespere jusye que je vais trouver le probleme et le\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (24, 24, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', NULL, NULL, 'imad.ghamloush@npgandour.com', '+2250576600019', '2250576600019', 229, 'imad.ghamloush');
INSERT INTO `notification` VALUES (25, 24, 1, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (26, 25, 2, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', NULL, NULL, 'imad.ghamloush@npgandour.com', '+2250576600019', '2250576600019', 229, 'imad.ghamloush');
INSERT INTO `notification` VALUES (27, 25, 2, '\n            OF:1101418\r\nArticle: CRE. ABANA VISAGE 35 ML\r\nLot de contrôle: 030000051374\r\nControlleur: jonathan.ezoa\r\n \r\nMessage:\r\n Message\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (28, 26, 2, '\n            OF:1103669\r\nArticle: CRE. CAROTONE { MIX } 135 ML 96P\r\nLot de contrôle: 030000053164\r\nControlleur: lorda.jarmouche\r\n \r\nMessage:\r\n Je test les message \n            ', NULL, NULL, 'imad.ghamloush@npgandour.com', '+2250576600019', '2250576600019', 229, 'imad.ghamloush');
INSERT INTO `notification` VALUES (29, 26, 2, '\n            OF:1103669\r\nArticle: CRE. CAROTONE { MIX } 135 ML 96P\r\nLot de contrôle: 030000053164\r\nControlleur: lorda.jarmouche\r\n \r\nMessage:\r\n Je test les message \n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (30, 27, 1, '\n            OF:1103669\r\nArticle: CRE. CAROTONE { MIX } 135 ML 96P\r\nLot de contrôle: 030000053164\r\nControlleur: lorda.jarmouche\r\n \r\nMessage:\r\n Test \n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');
INSERT INTO `notification` VALUES (31, 28, 1, '\n            OF:1103669\r\nArticle: CRE. CAROTONE { MIX } 135 ML 96P\r\nLot de contrôle: 030000053164\r\nControlleur: lorda.jarmouche\r\n \r\nMessage:\r\n Test notification\n            ', NULL, NULL, 'jonathan.ezoa@npgandour.com', '+2250788218525', '+2250788218525', 258, 'jonathan.ezoa');

-- ----------------------------
-- Table structure for platform
-- ----------------------------
DROP TABLE IF EXISTS `platform`;
CREATE TABLE `platform`  (
  `platformId` int NOT NULL AUTO_INCREMENT,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `api` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `isPassword` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`platformId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform
-- ----------------------------
INSERT INTO `platform` VALUES (1, 'WHATSAPP', NULL, 0);
INSERT INTO `platform` VALUES (2, 'SMS', NULL, 1);
INSERT INTO `platform` VALUES (3, 'EMAIL', NULL, 1);

-- ----------------------------
-- Table structure for userhaschannel
-- ----------------------------
DROP TABLE IF EXISTS `userhaschannel`;
CREATE TABLE `userhaschannel`  (
  `userHasChannelId` int NOT NULL AUTO_INCREMENT,
  `userIdFK` int NOT NULL,
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `channelIdFK` int NOT NULL,
  PRIMARY KEY (`userHasChannelId`) USING BTREE,
  INDEX `UserHasChannel_channelIdFK_fkey`(`channelIdFK` ASC) USING BTREE,
  CONSTRAINT `UserHasChannel_channelIdFK_fkey` FOREIGN KEY (`channelIdFK`) REFERENCES `channel` (`channelId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userhaschannel
-- ----------------------------
INSERT INTO `userhaschannel` VALUES (8, 229, 'imad.ghamloush', 1);
INSERT INTO `userhaschannel` VALUES (9, 258, 'jonathan.ezoa', 1);
INSERT INTO `userhaschannel` VALUES (10, 577, 'lorda.jarmouche', 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `matricule` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name_user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_direction_u` int NULL DEFAULT NULL,
  `id_departement` int NULL DEFAULT NULL,
  `id_service` int NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp,
  `actif` int NOT NULL DEFAULT 1,
  `whatsapp` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
