-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.33-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- airline 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `airline`;
CREATE DATABASE IF NOT EXISTS `airline` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `airline`;

-- 테이블 airline.admin 구조 내보내기
DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hire_date` date NOT NULL,
  `post` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.admin:~0 rows (대략적) 내보내기
DELETE FROM `admin`;

-- 테이블 airline.booking 구조 내보내기
DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `member_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seat_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `refund_period` date NOT NULL,
  `booking_date` datetime NOT NULL,
  `booking_state` enum('활성','취소') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `refund_date` datetime DEFAULT NULL,
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_amount` int(11) NOT NULL,
  `luggage` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ticket_type` enum('이륙전','운항중','도착완료') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`booking_id`) USING BTREE,
  KEY `FK_예매_회원` (`member_id`) USING BTREE,
  KEY `FK_booking_seat` (`seat_id`),
  CONSTRAINT `FK_booking_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_booking_seat` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.booking:~0 rows (대략적) 내보내기
DELETE FROM `booking`;

-- 테이블 airline.city 구조 내보내기
DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `city_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `city_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `airport` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`city_id`) USING BTREE,
  KEY `FK_city_country` (`country_id`),
  CONSTRAINT `FK_city_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.city:~0 rows (대략적) 내보내기
DELETE FROM `city`;

-- 테이블 airline.country 구조 내보내기
DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` varchar(50) NOT NULL,
  `country_name` varchar(50) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 airline.country:~0 rows (대략적) 내보내기
DELETE FROM `country`;

-- 테이블 airline.flight 구조 내보내기
DROP TABLE IF EXISTS `flight`;
CREATE TABLE IF NOT EXISTS `flight` (
  `flight_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `route_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  `plane_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flight_price` int(11) NOT NULL,
  `status` enum('이륙전','비행중','도착완료') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`flight_id`) USING BTREE,
  KEY `FK_항공편_노선` (`route_id`) USING BTREE,
  KEY `FK_항공편_항공기` (`plane_id`) USING BTREE,
  CONSTRAINT `FK_flight_plane` FOREIGN KEY (`plane_id`) REFERENCES `plane` (`plane_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_flight_route` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.flight:~0 rows (대략적) 내보내기
DELETE FROM `flight`;

-- 테이블 airline.member 구조 내보내기
DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `member_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nation` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `birth_date` date NOT NULL,
  `mileage` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`member_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.member:~0 rows (대략적) 내보내기
DELETE FROM `member`;

-- 테이블 airline.plane 구조 내보내기
DROP TABLE IF EXISTS `plane`;
CREATE TABLE IF NOT EXISTS `plane` (
  `plane_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plane_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `airline` enum('코리아나') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '코리아나',
  `status` enum('운영가능','수리중','중단') NOT NULL,
  PRIMARY KEY (`plane_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.plane:~0 rows (대략적) 내보내기
DELETE FROM `plane`;

-- 테이블 airline.q&a 구조 내보내기
DROP TABLE IF EXISTS `q&a`;
CREATE TABLE IF NOT EXISTS `q&a` (
  `qna_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `update date` datetime NOT NULL,
  PRIMARY KEY (`qna_id`) USING BTREE,
  KEY `FK_자주묻는질문_관리자` (`admin_id`) USING BTREE,
  CONSTRAINT `FK_qna` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.q&a:~0 rows (대략적) 내보내기
DELETE FROM `q&a`;

-- 테이블 airline.review 구조 내보내기
DROP TABLE IF EXISTS `review`;
CREATE TABLE IF NOT EXISTS `review` (
  `review_id` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `FK_review_member` (`member_id`),
  CONSTRAINT `FK_review_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 airline.review:~0 rows (대략적) 내보내기
DELETE FROM `review`;

-- 테이블 airline.route 구조 내보내기
DROP TABLE IF EXISTS `route`;
CREATE TABLE IF NOT EXISTS `route` (
  `route_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `departure_city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `arrival_city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`route_id`) USING BTREE,
  KEY `FK_노선_도시` (`departure_city`) USING BTREE,
  KEY `FK_노선_도시_2` (`arrival_city`) USING BTREE,
  CONSTRAINT `FK_route_arrivalcity` FOREIGN KEY (`arrival_city`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_route_departurecity` FOREIGN KEY (`departure_city`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.route:~0 rows (대략적) 내보내기
DELETE FROM `route`;

-- 테이블 airline.seat 구조 내보내기
DROP TABLE IF EXISTS `seat`;
CREATE TABLE IF NOT EXISTS `seat` (
  `seat_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flight_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seat_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seat_grade` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seat_state` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`seat_id`),
  KEY `FK_좌석_항공편` (`flight_id`) USING BTREE,
  CONSTRAINT `FK_seat_flight` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.seat:~0 rows (대략적) 내보내기
DELETE FROM `seat`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
