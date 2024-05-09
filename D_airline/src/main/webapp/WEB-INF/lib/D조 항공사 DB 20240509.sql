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

-- 테이블 데이터 airline.admin:~2 rows (대략적) 내보내기
DELETE FROM `admin`;
INSERT INTO `admin` (`admin_id`, `password`, `hire_date`, `post`) VALUES
	('admin1', '1234', '2014-05-09', 'admin'),
	('admin2', '1234', '2015-05-09', 'admin');

-- 테이블 airline.booking 구조 내보내기
DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `member_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seat_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `refund_period` date NOT NULL,
  `booking_date` datetime NOT NULL,
  `booking_state` enum('활성','취소') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '활성',
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
  `city_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `airport` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`city_name`),
  KEY `FK_city_country` (`country_id`),
  CONSTRAINT `FK_city_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.city:~20 rows (대략적) 내보내기
DELETE FROM `city`;
INSERT INTO `city` (`city_name`, `country_id`, `airport`) VALUES
	('광주', 'NA1', '군산 공항'),
	('뉴델리', 'NA8', '뉴델리 국제공항'),
	('뉴욕', 'NA4', 'JFK 국제공항'),
	('도쿄', 'NA2', '하네다 국제공항'),
	('디트로이트', 'NA4', '메트로 국제공항'),
	('런던', 'NA6', '히드로 국제공항'),
	('리우데자네이루', 'NA7', '갈레앙 국제공항'),
	('마카오', 'NA3', '마카오 국제공항'),
	('모스크바', 'NA5', '모스크바 국제공항'),
	('부산', 'NA1', '가덕도 공항'),
	('상하이', 'NA3', '푸둥 국제공항'),
	('서울', 'NA1', '인천 국제공항'),
	('시드니', 'NA10', '시드니 국제공항'),
	('오사카', 'NA2', '간사이 국제공항'),
	('워싱턴DC', 'NA4', '덜레스 국제공항'),
	('자카르타', 'NA11', '자카르타 국제공항'),
	('제주도', 'NA1', '제주 공항'),
	('케이프타운', 'NA9', '케이프타운 국제공항'),
	('홍콩', 'NA3', '홍콩 국제공항'),
	('히로시마', 'NA2', '히로시마 국제공항');

-- 테이블 airline.country 구조 내보내기
DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` varchar(50) NOT NULL,
  `country_name` varchar(50) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 airline.country:~11 rows (대략적) 내보내기
DELETE FROM `country`;
INSERT INTO `country` (`country_id`, `country_name`) VALUES
	('NA1', '대한민국'),
	('NA10', '호주'),
	('NA11', '인도네시아'),
	('NA2', '일본'),
	('NA3', '중국'),
	('NA4', '미국'),
	('NA5', '러시아'),
	('NA6', '영국'),
	('NA7', '브라질'),
	('NA8', '인도'),
	('NA9', '남아공');

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
  `flight_time` time NOT NULL,
  PRIMARY KEY (`flight_id`) USING BTREE,
  KEY `FK_항공편_노선` (`route_id`) USING BTREE,
  KEY `FK_항공편_항공기` (`plane_id`) USING BTREE,
  CONSTRAINT `FK_flight_plane` FOREIGN KEY (`plane_id`) REFERENCES `plane` (`plane_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_flight_route` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.flight:~1 rows (대략적) 내보내기
DELETE FROM `flight`;
INSERT INTO `flight` (`flight_id`, `route_id`, `departure_time`, `arrival_time`, `plane_id`, `flight_price`, `status`, `flight_time`) VALUES
	('FL1', 'RT1', '2024-08-09 14:30:00', '2024-08-09 15:30:00', 'PL1', 52100, '이륙전', '01:00:00');

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

-- 테이블 데이터 airline.plane:~40 rows (대략적) 내보내기
DELETE FROM `plane`;
INSERT INTO `plane` (`plane_id`, `plane_name`, `airline`, `status`) VALUES
	('PL1', 'KE011', '코리아나', '운영가능'),
	('PL10', 'KE020', '코리아나', '운영가능'),
	('PL11', 'KE021', '코리아나', '운영가능'),
	('PL12', 'KE022', '코리아나', '운영가능'),
	('PL13', 'KE023', '코리아나', '운영가능'),
	('PL14', 'KE024', '코리아나', '운영가능'),
	('PL15', 'KE025', '코리아나', '운영가능'),
	('PL16', 'KE026', '코리아나', '운영가능'),
	('PL17', 'KE026', '코리아나', '운영가능'),
	('PL18', 'KE027', '코리아나', '운영가능'),
	('PL19', 'KE028', '코리아나', '운영가능'),
	('PL2', 'KE012', '코리아나', '운영가능'),
	('PL20', 'KE029', '코리아나', '운영가능'),
	('PL21', 'KE030', '코리아나', '운영가능'),
	('PL22', 'KE031', '코리아나', '운영가능'),
	('PL23', 'KE032', '코리아나', '운영가능'),
	('PL24', 'KE033', '코리아나', '운영가능'),
	('PL25', 'KE034', '코리아나', '운영가능'),
	('PL26', 'KE035', '코리아나', '운영가능'),
	('PL27', 'KE036', '코리아나', '운영가능'),
	('PL28', 'KE037', '코리아나', '운영가능'),
	('PL29', 'KE038', '코리아나', '운영가능'),
	('PL3', 'KE013', '코리아나', '운영가능'),
	('PL30', 'KE039', '코리아나', '운영가능'),
	('PL31', 'KE040', '코리아나', '운영가능'),
	('PL32', 'KE041', '코리아나', '운영가능'),
	('PL33', 'KE042', '코리아나', '운영가능'),
	('PL34', 'KE043', '코리아나', '운영가능'),
	('PL35', 'KE044', '코리아나', '운영가능'),
	('PL36', 'KEO45', '코리아나', '운영가능'),
	('PL37', 'KE046', '코리아나', '운영가능'),
	('PL38', 'KE047', '코리아나', '운영가능'),
	('PL39', 'KE048', '코리아나', '운영가능'),
	('PL4', 'KE014', '코리아나', '운영가능'),
	('PL40', 'KE049', '코리아나', '운영가능'),
	('PL5', 'KE015', '코리아나', '운영가능'),
	('PL6', 'KE016', '코리아나', '운영가능'),
	('PL7', 'KE017', '코리아나', '운영가능'),
	('PL8', 'KE018', '코리아나', '운영가능'),
	('PL9', 'KE019', '코리아나', '운영가능');

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
  KEY `FK_route_city` (`departure_city`),
  KEY `FK_route_city_2` (`arrival_city`),
  CONSTRAINT `FK_route_city` FOREIGN KEY (`departure_city`) REFERENCES `city` (`city_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_route_city_2` FOREIGN KEY (`arrival_city`) REFERENCES `city` (`city_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 airline.route:~39 rows (대략적) 내보내기
DELETE FROM `route`;
INSERT INTO `route` (`route_id`, `departure_city`, `arrival_city`) VALUES
	('RT1', '서울', '광주'),
	('RT10', '서울', '시드니'),
	('RT11', '시드니', '서울'),
	('RT12', '서울', '자카르타'),
	('RT13', '자카르타', '서울'),
	('RT14', '서울', '오사카'),
	('RT15', '오사카', '서울'),
	('RT16', '서울', '히로시마'),
	('RT17', '히로시마', '서울'),
	('RT18', '서울', '마카오'),
	('RT19', '마카오', '서울'),
	('RT2', '광주', '제주도'),
	('RT20', '서울', '상하이'),
	('RT21', '상하이', '서울'),
	('RT22', '서울', '홍콩'),
	('RT23', '홍콩', '서울'),
	('RT24', '서울', '뉴욕'),
	('RT25', '뉴욕', '서울'),
	('RT26', '서울', '디트로이트'),
	('RT27', '디트로이트', '서울'),
	('RT28', '서울', '워싱턴DC'),
	('RT29', '워싱턴DC', '서울'),
	('RT3', '제주도', '부산'),
	('RT30', '서울', '모스크바'),
	('RT31', '모스크바', '서울'),
	('RT32', '서울', '런던'),
	('RT33', '런던', '서울'),
	('RT34', '서울', '리우데자네이루'),
	('RT35', '리우데자네이루', '서울'),
	('RT36', '서울', '뉴델리'),
	('RT37', '뉴델리', '서울'),
	('RT38', '서울', '케이프타운'),
	('RT39', '케이프타운', '서울'),
	('RT4', '부산', '서울'),
	('RT5', '서울', '도쿄'),
	('RT6', '도쿄', '서울'),
	('RT7', '광주', '서울'),
	('RT8', '광주', '제주도'),
	('RT9', '서울', '부산');

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

-- 테이블 airline.seatprice 구조 내보내기
DROP TABLE IF EXISTS `seatprice`;
CREATE TABLE IF NOT EXISTS `seatprice` (
  `seat_grade` varchar(50) NOT NULL,
  `seat_price` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`seat_grade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 airline.seatprice:~3 rows (대략적) 내보내기
DELETE FROM `seatprice`;
INSERT INTO `seatprice` (`seat_grade`, `seat_price`) VALUES
	('비지니스', 1.5),
	('일반석', 1),
	('퍼스트클래스', 2);


-- shop 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `shop`;
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `shop`;

-- 테이블 shop.category 구조 내보내기
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 shop.category:~8 rows (대략적) 내보내기
DELETE FROM `category`;
INSERT INTO `category` (`category`, `create_date`) VALUES
	('김치냉장고', '2024-04-05 12:45:10'),
	('냉장고', '2024-04-05 12:45:10'),
	('노트북', '2024-04-05 12:44:29'),
	('세탁기', '2024-04-05 12:45:10'),
	('악세서리', '2024-04-05 12:45:20'),
	('전자레인지', '2024-04-05 12:45:35'),
	('컴퓨터', '2024-04-05 12:44:29'),
	('텔레비전', '2024-04-05 12:24:55');

-- 테이블 shop.comment 구조 내보내기
DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `orders_no` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `content` text NOT NULL,
  `update_date` date NOT NULL,
  `create_date` date NOT NULL,
  PRIMARY KEY (`orders_no`),
  CONSTRAINT `FK__orders` FOREIGN KEY (`orders_no`) REFERENCES `orders` (`orders_no`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 shop.comment:~0 rows (대략적) 내보내기
DELETE FROM `comment`;

-- 테이블 shop.customer 구조 내보내기
DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `mail` varchar(50) NOT NULL,
  `pw` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `birth` date NOT NULL,
  `gender` enum('남','여') NOT NULL,
  `phone` varchar(50) NOT NULL,
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 shop.customer:~31 rows (대략적) 내보내기
DELETE FROM `customer`;
INSERT INTO `customer` (`mail`, `pw`, `name`, `birth`, `gender`, `phone`, `update_date`, `create_date`) VALUES
	('1@1.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '1', '2024-04-01', '남', '1', '2024-04-29 13:28:44', '2024-04-29 13:28:44'),
	('customer10@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '힘동석', '1907-10-31', '여', '01790900909', '2024-04-27 15:02:30', '2024-04-27 15:02:30'),
	('customer11@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '금동석', '2024-03-26', '여', '01944556677', '2024-04-27 22:25:27', '2024-04-27 22:25:27'),
	('customer12@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '박동석', '2020-01-03', '여', '01055669999', '2024-04-27 22:27:27', '2024-04-27 22:27:27'),
	('customer13@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '장첸', '2012-02-02', '여', '01066774433', '2024-04-27 22:28:28', '2024-04-27 22:28:28'),
	('customer14@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '마재윤', '2002-01-31', '여', '01156781234', '2024-04-27 22:29:44', '2024-04-27 22:29:44'),
	('customer15@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '임요환', '2019-05-02', '여', '01178832323', '2024-04-27 22:31:13', '2024-04-27 22:31:13'),
	('customer16@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '홍진호', '1992-03-13', '여', '01909090909', '2024-04-27 22:32:13', '2024-04-27 22:32:13'),
	('customer17@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '김캐리', '1998-02-04', '남', '01155338723', '2024-04-27 22:34:17', '2024-04-27 22:34:17'),
	('customer18@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '엄재경', '2001-11-30', '여', '01759492013', '2024-04-27 22:35:13', '2024-04-27 22:35:13'),
	('customer19@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '정소림', '2014-02-05', '여', '01023445939', '2024-04-27 22:39:28', '2024-04-27 22:39:28'),
	('customer19@navarc.om', '*A4B6157319038724E3560894F7F932C8886EBFCF', '정소림', '1982-02-03', '여', '01079593919', '2024-04-27 22:38:33', '2024-04-27 22:38:33'),
	('customer1@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '마동석', '2011-03-02', '여', '01099997777', '2024-04-27 14:57:15', '2024-04-27 14:57:15'),
	('customer20@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '김택용', '2021-06-10', '남', '01970503010', '2024-04-27 22:41:14', '2024-04-27 22:41:14'),
	('customer21@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '이제동', '2000-02-02', '남', '01933446677', '2024-04-27 22:42:56', '2024-04-27 22:42:56'),
	('customer22@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '송뱅구', '1975-02-12', '여', '01922220000', '2024-04-27 22:43:50', '2024-04-27 22:43:50'),
	('customer23@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '이영호', '1995-03-09', '여', '01079695949', '2024-04-27 22:48:28', '2024-04-27 22:48:28'),
	('customer24@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '류현진', '2007-01-31', '남', '01144920123', '2024-04-27 22:57:27', '2024-04-27 22:57:27'),
	('customer26@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '장동민', '1979-02-01', '여', '01739182354', '2024-04-27 22:59:21', '2024-04-27 22:59:21'),
	('customer27@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '최홍만', '1995-02-22', '여', '01132439534', '2024-04-27 23:02:49', '2024-04-27 23:02:49'),
	('customer28@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '홍둘리', '1994-06-30', '남', '01934493954', '2024-04-27 23:05:18', '2024-04-27 23:05:18'),
	('customer29@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '심봉사', '1962-11-07', '여', '01030405060', '2024-04-28 01:14:38', '2024-04-28 01:14:38'),
	('customer2@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '남동석', '2004-01-07', '남', '01944445555', '2024-04-27 14:57:56', '2024-04-27 14:57:56'),
	('customer30@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '홍두깨', '1959-07-23', '남', '01923443233', '2024-04-28 01:17:01', '2024-04-28 01:17:01'),
	('customer31@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '유재석', '1989-06-06', '남', '01022667744', '2024-04-28 22:13:15', '2024-04-28 22:13:15'),
	('customer3@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '걸동석', '1981-06-15', '여', '01156782345', '2024-04-27 14:58:38', '2024-04-27 14:58:38'),
	('customer4@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '맞동석', '2012-11-22', '남', '01711115555', '2024-04-26 14:11:44', '2024-04-26 14:11:44'),
	('customer5@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '구동석', '2024-03-07', '남', '01011112222', '2024-04-26 21:22:21', '2024-04-26 21:22:21'),
	('customer6@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '을동석', '2023-11-01', '여', '01022224444', '2024-04-26 21:29:03', '2024-04-26 21:29:03'),
	('customer7@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '장이수', '1994-05-17', '여', '01744444444', '2024-04-27 14:59:45', '2024-04-27 14:59:45'),
	('customer8@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '여동석', '1956-12-04', '여', '01177771234', '2024-04-27 15:00:39', '2024-04-27 15:00:39'),
	('customer9@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '남이수', '1947-11-12', '여', '01767675454', '2024-04-27 15:01:31', '2024-04-27 15:01:31');

-- 테이블 shop.customerpw 구조 내보내기
DROP TABLE IF EXISTS `customerpw`;
CREATE TABLE IF NOT EXISTS `customerpw` (
  `mail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pw` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `history` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`pw`,`mail`) USING BTREE,
  KEY `FK_customerpw_customer` (`mail`),
  CONSTRAINT `FK_customerpw_customer` FOREIGN KEY (`mail`) REFERENCES `customer` (`mail`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.customerpw:~31 rows (대략적) 내보내기
DELETE FROM `customerpw`;
INSERT INTO `customerpw` (`mail`, `pw`, `history`) VALUES
	('1@1.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-29 13:28:44'),
	('customer10@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 15:02:30'),
	('customer11@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:25:27'),
	('customer12@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:27:27'),
	('customer13@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:28:28'),
	('customer14@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:29:44'),
	('customer15@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:31:13'),
	('customer16@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:32:13'),
	('customer17@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:34:17'),
	('customer18@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:35:13'),
	('customer19@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:39:28'),
	('customer19@navarc.om', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:38:33'),
	('customer1@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 14:57:15'),
	('customer20@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:41:14'),
	('customer21@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:42:56'),
	('customer22@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:43:50'),
	('customer23@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:48:28'),
	('customer24@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:57:27'),
	('customer26@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 22:59:21'),
	('customer27@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 23:02:49'),
	('customer28@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 23:05:18'),
	('customer29@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-28 01:14:38'),
	('customer2@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 14:57:56'),
	('customer30@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-28 01:17:01'),
	('customer31@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-28 22:13:15'),
	('customer3@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 14:58:38'),
	('customer4@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-26 14:11:44'),
	('customer5@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-26 21:22:21'),
	('customer6@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-26 21:29:03'),
	('customer7@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 14:59:45'),
	('customer8@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 15:00:39'),
	('customer9@navar.com', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-27 15:01:31');

-- 테이블 shop.emp 구조 내보내기
DROP TABLE IF EXISTS `emp`;
CREATE TABLE IF NOT EXISTS `emp` (
  `emp_id` varchar(50) NOT NULL,
  `emp_pw` varchar(50) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_job` varchar(50) NOT NULL,
  `hire_date` date NOT NULL,
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `active` enum('ON','OFF') NOT NULL DEFAULT 'OFF',
  `grade` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 shop.emp:~19 rows (대략적) 내보내기
DELETE FROM `emp`;
INSERT INTO `emp` (`emp_id`, `emp_pw`, `emp_name`, `emp_job`, `hire_date`, `update_date`, `create_date`, `active`, `grade`) VALUES
	('admin1', '*A4B6157319038724E3560894F7F932C8886EBFCF', '고길동', '상무', '2016-02-10', '2024-04-27 14:05:38', '2024-04-05 12:36:54', 'ON', 1),
	('admin2', '*A4B6157319038724E3560894F7F932C8886EBFCF', '김길동', '부장', '2018-11-30', '2024-04-05 12:36:54', '2024-04-05 12:36:54', 'ON', 1),
	('admin3', '*A4B6157319038724E3560894F7F932C8886EBFCF', '최길동', '팀장', '2020-03-02', '2024-04-05 12:36:54', '2024-04-05 12:36:54', 'ON', 1),
	('employee1', '*A4B6157319038724E3560894F7F932C8886EBFCF', '홍사원', '사원', '2021-10-25', '2024-04-21 12:19:55', '2024-04-05 12:41:54', 'ON', 0),
	('employee2', '*A4B6157319038724E3560894F7F932C8886EBFCF', '김사원', '사원', '2022-05-05', '2024-04-21 12:22:47', '2024-04-05 12:37:36', 'ON', 0),
	('employee3', '*A4B6157319038724E3560894F7F932C8886EBFCF', '최사원', '사원', '2022-05-05', '2024-04-05 12:37:36', '2024-04-05 12:37:36', 'ON', 0),
	('employee4', '*A4B6157319038724E3560894F7F932C8886EBFCF', '박사원', '사원', '2022-05-05', '2024-04-27 14:07:01', '2024-04-05 12:37:36', 'ON', 0),
	('employee5', '*A4B6157319038724E3560894F7F932C8886EBFCF', '이사원', '사원', '2023-07-18', '2024-04-05 12:37:36', '2024-04-05 12:37:36', 'ON', 0),
	('employee6', '*A4B6157319038724E3560894F7F932C8886EBFCF', '한사원', '사원', '2023-08-01', '2024-04-21 12:22:10', '2024-04-05 12:37:36', 'ON', 0),
	('employee7', '*A4B6157319038724E3560894F7F932C8886EBFCF', '양사원', '사원', '2024-01-19', '2024-04-05 12:37:36', '2024-04-05 12:37:36', 'ON', 0),
	('employee8', '*A4B6157319038724E3560894F7F932C8886EBFCF', '우사원', '사원', '2024-02-02', '2024-04-21 12:15:45', '2024-04-05 12:37:36', 'ON', 0),
	('intern1', '*A4B6157319038724E3560894F7F932C8886EBFCF', '박견습', '견습', '2024-04-05', '2024-04-05 12:37:36', '2024-04-05 12:37:36', 'ON', 0),
	('intern2', '*A4B6157319038724E3560894F7F932C8886EBFCF', '이견습', '견습', '2024-04-06', '2024-04-21 12:20:24', '2024-04-05 12:37:36', 'OFF', 0),
	('intern3', '*A4B6157319038724E3560894F7F932C8886EBFCF', '고영업', '영업', '2024-04-15', '2024-04-21 12:19:52', '2024-04-17 20:35:56', 'OFF', 0),
	('intern4', '*A4B6157319038724E3560894F7F932C8886EBFCF', '박인턴', '수습', '2024-03-23', '2024-04-26 14:40:21', '2024-04-26 14:40:21', 'OFF', 0),
	('intern5', '*A4B6157319038724E3560894F7F932C8886EBFCF', '임인턴', '수습', '2024-03-23', '2024-04-26 14:49:19', '2024-04-26 14:49:19', 'OFF', 0),
	('intern6', '*A4B6157319038724E3560894F7F932C8886EBFCF', '을인턴', '수습', '2024-04-22', '2024-04-26 14:54:19', '2024-04-26 14:54:19', 'OFF', 0),
	('intern7', '*A4B6157319038724E3560894F7F932C8886EBFCF', '함인턴', '수습', '2024-04-25', '2024-04-26 14:57:27', '2024-04-26 14:57:27', 'OFF', 0),
	('intern8', '*A4B6157319038724E3560894F7F932C8886EBFCF', '탁인턴', '판촉', '2024-04-28', '2024-04-28 22:21:35', '2024-04-28 22:20:47', 'OFF', 0);

-- 테이블 shop.emppw 구조 내보내기
DROP TABLE IF EXISTS `emppw`;
CREATE TABLE IF NOT EXISTS `emppw` (
  `emp_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `emp_pw` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pw_history` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`emp_id`,`emp_pw`),
  CONSTRAINT `FK_emppw_emp` FOREIGN KEY (`emp_id`) REFERENCES `emp` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.emppw:~2 rows (대략적) 내보내기
DELETE FROM `emppw`;
INSERT INTO `emppw` (`emp_id`, `emp_pw`, `pw_history`) VALUES
	('intern7', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-26 14:57:27'),
	('intern8', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-04-28 22:20:47');

-- 테이블 shop.goods 구조 내보내기
DROP TABLE IF EXISTS `goods`;
CREATE TABLE IF NOT EXISTS `goods` (
  `goods_no` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `emp_id` varchar(50) NOT NULL,
  `goods_title` text NOT NULL,
  `filename` text DEFAULT 'default.jpg',
  `goods_content` text NOT NULL,
  `goods_price` int(11) NOT NULL,
  `goods_amount` int(11) NOT NULL,
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`goods_no`),
  KEY `FK_goods_category` (`category`),
  KEY `FK_goods_emp` (`emp_id`),
  CONSTRAINT `FK_goods_category` FOREIGN KEY (`category`) REFERENCES `category` (`category`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_goods_emp` FOREIGN KEY (`emp_id`) REFERENCES `emp` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=570 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 shop.goods:~48 rows (대략적) 내보내기
DELETE FROM `goods`;
INSERT INTO `goods` (`goods_no`, `category`, `emp_id`, `goods_title`, `filename`, `goods_content`, `goods_price`, `goods_amount`, `update_date`, `create_date`) VALUES
	(503, '냉장고', 'employee1', 'TCL 일반형 냉장고', 'f1192c4c7d7d43b08a50da475c75ea23.png', '저소음 냉장고, 원하는 기능을 한번의 터치로! 더 큰 공간에 더 많은 음식을 저장해보세요.', 584000, 30, '2024-04-05 15:55:11', '2024-04-05 15:55:11'),
	(505, '냉장고', 'employee2', '삼성전자 양문형 냉장고', '9e14b65c7f2c46f5a15a6d3d89d3a9e6.png', '공간에 스며드는 자연스러운 디자인. 7단계 변온으로 김치부터 살얼음까지 원하는대로 맞춤보관실', 1483210, 25, '2024-04-05 16:04:35', '2024-04-05 16:04:35'),
	(506, '냉장고', 'employee3', '삼성전자 비스포크 4도어 냉장고', '30329868ec474b8581e141a6258bb4b3.png', '저소음 냉장고, 원하는 기능을 한번의 터치로! 더 큰 공간에 더 많은 음식을 저장해보세요.', 584000, 30, '2024-04-05 16:04:35', '2024-04-05 16:04:35'),
	(507, '냉장고', 'employee4', 'LG전자 얼음정수기 냉장고', 'f31d516979fc4e13b90a6c468f9af3ac.png', 'LG 얼음정수기 냉장고 구매하고 케어서비스 6개월 지원 받으세요! 프리미엄 소재부터 컬러까지 어디에나 자연스럽게 아름답게. 오브제컬렉션 냉장고에 얼음정수기를 담다. 고급스럽고 아름다운 크래프트 아이스', 4749850, 49, '2024-04-05 16:04:35', '2024-04-05 16:04:35'),
	(508, '냉장고', 'employee5', '캐리어 클라윈드 냉장고', '768c22f85fb9410a86a67586927158fa.png', ' Smart한 냉장고로Fresh하게. 스마트 온도 감지 기술로 24시간 자동 정온', 645900, 70, '2024-04-05 16:04:35', '2024-04-05 16:04:35'),
	(509, '노트북', 'employee6', '에이수스 비보북15', '0cf7de030c9c435a9c82846145f29ed1.png', 'VIVOBOOK15 나노 엣지 디스플레이', 449000, 37, '2024-04-05 16:16:41', '2024-04-05 16:16:41'),
	(510, '노트북', 'employee7', '삼성노트북 NT550', '041731a8ecf8473aac765081452a1bb4.png', '능력을 향상시키는 강력한 퍼포먼스. 시선을 사로 잡는 프리미엄 디자인', 579000, 67, '2024-04-05 16:16:41', '2024-04-05 16:16:41'),
	(511, '노트북', 'employee1', 'LG전자 울트라코어PC', '23804f5e770748868d9de58ac1181107.png', '날렵함이 돋보이는 직선의 아름다움. 대화면에 온전히 집중할수 있도록 얇은 베젤로 바디는 콤팩트하게!', 805500, 65, '2024-04-05 16:16:41', '2024-04-05 16:16:41'),
	(512, '컴퓨터', 'employee1', '피씨스토어 화이트 감성 수냉쿨러', '7960d89a0f6741babd6e735dddcde529.png', '달컴 인텔 121세대 라이젠 5600의 강력한 성능!', 1069000, 24, '2024-04-05 16:17:12', '2024-04-05 16:17:12'),
	(514, '김치냉장고', 'employee2', '오리지널 딤채', 'b9bdd3be0673478eb1d7b001fb3e156e.png', '전국 서비스 센터 A/S 보증.사다리차 무상지원 서비스', 439000, 37, '2024-04-05 16:26:27', '2024-04-05 16:26:27'),
	(515, '김치냉장고', 'employee3', '굿트렌드 미니 김치냉장고', '2a99a683cb68444b8d5d60a93b61bc37.png', '50% 가격할인!. 100% 환불보장!', 299900, 58, '2024-04-05 16:26:27', '2024-04-05 16:26:27'),
	(516, '김치냉장고', 'employee4', '삼성전자 뚜껑형 김치플러스 냉장고', '07db6cb261f1418f958dd5f74cc7617c.png', '한겨울 땅속 같은 아삭한 김치맛 메탈쿨링', 658320, 8, '2024-04-05 16:26:27', '2024-04-05 16:26:27'),
	(517, '세탁기', 'employee2', '삼성전자 그랑데 통버블 세탁기', 'b52a80c12c97437381a5b0d240f780c9.png', '풍부한 버블과 입체날개 회전판으로 깨끗한 세탁과 에너지 절약. 버블폭포!', 448210, 36, '2024-04-05 16:26:27', '2024-04-05 16:26:27'),
	(518, '컴퓨터', 'employee3', '포유컴퓨터 최고사양 조립식컴퓨터', '7f16949a03b345f89454ec73693a205a.png', '정품 윈도우 탑재. 배그 풀옵션 쾌적가동!', 1874000, 59, '2024-04-05 16:35:21', '2024-04-05 16:35:21'),
	(519, '텔레비전', 'employee4', 'TCL 안드로이드11 4K UHD TV', 'fa92972915434ccdb83b623a57b57a99.png', '패널 3년 무상보증. 세계 1위 스마트TV', 399000, 78, '2024-04-05 16:35:21', '2024-04-05 16:35:21'),
	(520, '텔레비전', 'employee1', '샤오미 안드로이드 11 4k UHD led tv', '44328fa8211a4596a3a55495ce631816.png', '꽉찬 풀스크린 디자인. 몰입감 넘치는 영상', 499000, 18, '2024-04-05 16:36:20', '2024-04-05 16:36:20'),
	(521, '전자레인지', 'employee1', '쿠쿠 전자레인지 다이얼식 20L', '2ff277866d0148a1be21917912a4af08.png', '갖춰야 할 모든 것과 디자인이 만나 주방이 아름다워지다', 59800, 135, '2024-04-05 16:36:20', '2024-04-05 16:36:20'),
	(522, '악세서리', 'employee5', '빅쏘 충격보호 케이충전기 파우치', '311b46dc78e54523a9696176b9e94f00.png', '충격 보호 방수 케이블 충전기 수납 디지털 여행용 다용도 멀티 파우치 가방 DP1', 9400, 164, '2024-04-05 16:39:53', '2024-04-05 16:39:53'),
	(523, '악세서리', 'employee7', 'WEGO 테크 파우치', '7420112c2d1042bbb5785864ea7ef3fb.png', 'PU소재로 제작하여 내구성(생활방수, 스크래치)이 우수합니다', 26800, 67, '2024-04-05 16:39:53', '2024-04-05 16:39:53'),
	(524, '컴퓨터', 'admin1', '굿프렌드 PC 인텔97 하이엔드 게이밍 컴퓨터', '2418b3d7ebd44cfbb3ca7f41b85fe2eb.png', '최고와 최고가 만나다. 9090리퀴드. 검증된 부품들로 이루어진 본체 구성. 정품 윈도우 설치', 3067100, 10, '2024-04-07 15:29:33', '2024-04-07 15:29:33'),
	(525, '컴퓨터', 'admin1', '델 게이밍 데스크탑 PC 다크사이드 에일리언웨어', 'd32b4b0e32aa405e97037af4b9705e6d.png', '향상된 새로운 아키텍처, 차원이 다른 강력한 게이밍. 더 강력한 게이밍 성능을 위한 새로운 시스템 설계. 240mm로 더 커진 라디에이터 탑재, Alienware Cryp-tech 수냉식 쿨러', 3073620, 7, '2024-04-07 19:16:17', '2024-04-07 19:16:17'),
	(526, '컴퓨터', 'admin1', '델 에일리언웨어 게이밍 데스크탑', 'c497cde14f57482284f7ed4b19e40e6c.png', '기존의 퍼포먼스를 능가하는 더 강력해진 성능. 차원이 다른 게이밍 프로세서의 퍼포먼스. 게이머를 위한 속도, 그 이상 NVIDIA GeForce RTX 4090', 3299000, 22, '2024-04-07 21:16:20', '2024-04-07 21:16:20'),
	(527, '컴퓨터', 'admin1', 'HP OMEN core i9 RTX4090', '59e5950cc46340408468fb40d70add53.png', 'HP 프리미엄 게이밍 라인업. 더 강력해진 최신 14세대 인텔 코어 i9-14900K. 엔비디아 지포스 RTX4090 24GB. CoolerMaster의 강력한 360mm 수랭쿨러. 혁신적인 프로세서 아키텍처', 2698000, 12, '2024-04-07 23:43:39', '2024-04-07 23:43:39'),
	(528, '김치냉장고', 'admin1', 'LG전자 오브제 김치톡톡', 'acff964b6788438885dda12730b59591.png', '공간에 감각을 더하는 디자인. 원하는 대로 맞춰 쓰는 다용도 냉장고. 가뿐하게 꺼내고 보관은 편리하게. 입맛에 맞게 즐기는 맛있는 김치', 667720, 34, '2024-04-18 21:04:14', '2024-04-18 21:04:14'),
	(529, '김치냉장고', 'admin1', '리빙소다 미니 김치냉장고', 'da09d70ec59b4913b0832825a8c1a6a7.png', '미니멀 라이프 스타일의 시작. 맞춤형 수납공간 도어포켓. 저소음으로 편안하게. 이동이 용이한 휠 장착. 리빙소다 미니 김치냉장고 리얼리뷰로 말합니다.', 259000, 135, '2024-04-18 21:07:32', '2024-04-18 21:07:32'),
	(530, '냉장고', 'admin1', 'LG전자 오브제컬렉션 빌트인 냉장고', '316314c9755441ebae01f8f8802367e8.png', '분위기 좀 만들 줄 아는 모든 멋진 이들을 위한 무드업 냉장고. 원할 때마다 바꾸는 LED컬러 도어로 매일 새로워지는 분위기. 나만의 감성을 담아낸 나만의 오브제컬렉션', 5700000, 12, '2024-04-18 21:08:03', '2024-04-18 21:08:03'),
	(531, '김치냉장고', 'admin1', 'LG전자 오브제 디오스 김치냉장고', '0add7c132a934fc9abd56c56eb3dde4b.png', '미식(美食) 생활을 위한 전문 보관의 차이. 고급스러운 소재와 엄선한 컬러로 공간에 조화롭게. 류코노스톡 유산균을 최대 57배 더 많이. 필요에 따라 원하는 용도로 다양하게.', 1318900, 4, '2024-04-20 21:44:10', '2024-04-20 21:44:10'),
	(549, '노트북', 'admin1', 'LG전자 그램 폴드+', '57082c16665a4555afa0d4a9d756ba29.png', '한계를 접어, 상상을 펼치다. 하나같이 혁신적 그램 Fold의 5가지 모드. 탁월한 화면 분할 멀티태스킹 구현. 좁은 공간에서도 딱 맞춰 작업. 큰 화면으로 즐기는 드로잉. 나만의 대화면 워크스테이션', 3327830, 88, '2024-04-27 11:07:32', '2024-04-27 11:07:32'),
	(550, '노트북', 'admin1', '기가바이트 어로스', '3e3eb005c0d847b3b9015171f08d6f40.png', '완전히 새로워진 디자인과 성능. 최강의 퍼포먼스 인텔 13세대 코어 i9프로세서. 강력한 퍼포먼스 GeForce RTX 4090. Winforce Infinity Cooling. 더욱 넓어진 시야. 더 슬림해진 두께. 더 정교해진 궁극의 하이엔드 게이밍 노트북.', 6633650, 8, '2024-04-27 11:13:03', '2024-04-27 11:13:03'),
	(551, '노트북', 'admin1', '델 에일리언웨어 X16', '0e115ce868a24550ae507bae51434066.png', 'Legend의 완성. 마지막 디테일까지 섬세한 Legend3은 그 어느 때보다 더 고급스럽고 촉감이 뛰어나며 미래 지향적인 디자인을 자랑합니다. 새로운 Lunar Silver 컬러 메탈 본체. 향상된 AlienFX조명. 마이크로 LED 스타디움 조명', 5989000, 43, '2024-04-27 11:18:47', '2024-04-27 11:18:47'),
	(552, '세탁기', 'admin1', '삼성전자 비스포크 콤보 세탁기', '06979b255c054a13873b9a189cebf6ca.png', '세탁물 이동 없이 편리하게 하나로 세탁,건조하는 ONE 솔루션. 손끝으로 쉽게, 음성인식으로 간편하게! 세탁물에 맞게 적정 세제를 알아서. 알아서 문을 열어 내부 습도를 쾌적하게 오토 오픈 도어', 3859000, 67, '2024-04-27 11:23:10', '2024-04-27 11:23:10'),
	(553, '세탁기', 'admin1', '삼성전자 그랑데 드럼 세탁기', 'fb98ffc7d693491f9c8547bf9b67a1bb.png', '더 빠르고 강력해진 버블워시. 더 편리하고 위생적인 관리 무세제통세척+. 초강력 세탁으로 더 깨끗하게, 초절약 세탁으로 더 알뜰하게. 시간과 에너지를 줄여주는 건조용 강력 탈수. 에너지 1등급을 기본, 10년 무상보증까지', 667880, 132, '2024-04-27 11:25:50', '2024-04-27 11:25:50'),
	(554, '세탁기', 'admin1', '위닉스 건조 세탁기 메탈릭그레이', 'd6fec009026f487f8392748837e27463.png', '새로운 선택의 시작, 위닉스 초대형 텀블세탁기 25kg 런칭. 바른 세탁과 바른 건조의 시작. 초대형 위닉스 텀블세탁기로 경험하는 오직 당신만을 위한 새로운 텀블 라이프. 대한민국 1등 제습기술로 완성한 바른 건조 기술력', 1750000, 189, '2024-04-27 11:28:46', '2024-04-27 11:28:46'),
	(555, '세탁기', 'admin1', 'LG전자 트롬 오브제 컬렉션 건조 세탁기', 'a531e9ebea054abcb454a87e7e4febf9.png', '세상에 없던 6모션 건조의 시작. 건조 행동과 자연의 건조바람을 닮은 섬세한 건조. 본질에 집중한 정제된 디자인. 많은 빨래도 걱정없이 편리한 20kg 대용량. 공간을 빛내는 스타일리시 디자인', 1243280, 265, '2024-04-27 11:39:52', '2024-04-27 11:39:52'),
	(556, '세탁기', 'admin1', 'LG전자 통돌이 세탁기', '91ec6064d4654377b92365e4adfbd010.png', '통이 돌아서 빨래가 잘 되는 진짜 통돌이. 많은 양의 빨래도 여유롭게. 세탁은 강력하게! 시간은 더 빠르게! 강력한 통회전으로 위에서 두드려주는 세탁. 좌우 물살로 빨래를 비벼서 세탁. 강력한 터보샷으로 깨끗하고 빠른 세탁', 1028000, 267, '2024-04-27 11:42:33', '2024-04-27 11:42:33'),
	(557, '악세서리', 'admin1', '바이탭 원터치 UV 휴대폰 살균기', 'ddbb29dd4c8c4de0971a8084f9176243.png', '외출시, 오염에 노출되기 쉬운 마스크, 스마트폰, 돈, 신용카드, 이어폰 등 각종 물건들을 바로바로 안전하게 살균하세요! 아로마테라피 기능으로, 휴대용품들에 향기를 입히세요. 내부의 구멍에 아로마 오일을 3~4방울 떨어뜨리고 사용해 보세요', 19210, 92, '2024-04-27 11:45:50', '2024-04-27 11:45:50'),
	(558, '악세서리', 'admin1', '유이스토어 디지털 멀티 수납 파우치', '66c9b5b9461c4745b5d9077e9b23a698.png', '유이 스토어 당일배송. USB메모리 4개, USB케이블 3개, 외장하드 1개', 14900, 93, '2024-04-27 11:48:06', '2024-04-27 11:48:06'),
	(559, '악세서리', 'admin1', '요이치 USB 3.0 변환젠더', '254700c88fce4af7960b5286f86c8125.png', 'USB 3.0 FLOW c2 - USB A to C type OTG 젠더 1개. 기기 자체의 용량 한계를 개선하고 데이터의 보관 및 전송이 용이한 제품. USB 2.0보다 10배 빠른 속도로 1GB데이터를 단 3초 만에 전송합니다.', 3750, 289, '2024-04-27 11:52:00', '2024-04-27 11:52:00'),
	(560, '악세서리', 'admin1', '홈플래닛 와이드형 메탈 노트북 거치대', '5ad085886a1a404caadeda7375f2acae.png', '홈플래닛 와이드형 메탈 쿨링홀 노트북 거치대. 견고한 메탈 소재. 자연 냉각 디자인. 안정적인 와이드형. 최대 17인치 거치 가능. 자유로운 높이/각도 조절 기능', 22290, 87, '2024-04-27 11:53:37', '2024-04-27 11:53:37'),
	(561, '전자레인지', 'admin1', '삼성전자 비스포크 전자레인지', 'a7485ef233c34d5dbe122f1546e098e5.png', '나에게 맞춘 키친테리어 BESPOKE 디자인. 그릴로 바삭하게 전자레인지로 빠르게 복합조리. 모바일 음성 제어로 간편해진 스마트쿠킹. 바코드 조리로 편리해진 간편식 스캔. 빵 해동과 홈디저트도 간편하게 노오븐 베이킹', 154800, 295, '2024-04-27 11:56:20', '2024-04-27 11:56:20'),
	(562, '전자레인지', 'admin1', '엠엔 고출력 다이얼 전자레인지 23L', '01d6f40a299d4d6d8b767d80dae7aca3.png', '매일 사용하는 안전한 전자레인지. 대기 모드 소비전력 0.8W로 콘센트를 꽂아놓아도 안심. 이중 온도과승방지 장치로 과열시 전원 차단. 과전류, 과전압 방지! 낭비하는 전기 NO!', 83360, 176, '2024-04-27 12:00:33', '2024-04-27 12:00:33'),
	(563, '전자레인지', 'admin1', '미디어 광파오븐 에어프라이어 23L', 'a9536af8b2f544589968aa3acab4c861.png', '전자레인지와 에어프라이어가 만나다. 미디어 광파오븐 하나로 다양한 파티 음식을 즐겨보세요! 단계별로 다양하게 요리할 수 있는 강력한 800W출력. 조절 가능한 800W의 고출력으로 수분 손실 없이 맛있게 음식을 조리할 수 있습니다.', 129000, 110, '2024-04-27 12:05:05', '2024-04-27 12:05:05'),
	(564, '전자레인지', 'admin1', '한경희생활과학 안심쿡 올스텐 에어프라이어 15L', '2effa2fd58764b21a757ac2331a771aa.png', '대세는 올 스테인리스! 15리터 대용량 패밀리 사이즈. 올 스테인리스 제품으로 위생적. 조용한 저소음 에어프라이어. 강력한 팬 장착으로 고른 열 전달. 강화유리와 조명으로 조리 과정을 쉽게 확인. 한경희 에어프라이어가 해결해드립니다.', 159000, 10, '2024-04-27 12:07:39', '2024-04-27 12:07:39'),
	(565, '전자레인지', 'admin1', '쿠첸 클래식 레트로 전자레인지 다이얼식 20L', '1282a885cbc54ead82bcb3150f35c80f.png', '요리의 맛을 제대로 살리는 클래식 레트로 전자레인지. 간결한 디자인에 감성적인 우드 손잡이 포인트가 더 해져 평범한 주방에 엣지를 더해줍니다. 혼자사는 싱글 라이프에 꼭 필요한 필수 아이템. 쿠첸 레트로 체인지!', 105000, 72, '2024-04-27 12:09:40', '2024-04-27 12:09:40'),
	(566, '텔레비전', 'admin1', '삼성전자 8k Neo QLed TV', '7b948691ba464d08a5c9408738e092d9.png', '퀀텀 mini LED로 완성되는 새로운 차원의 화질, Neo 퀀텀 디스플레이 8k. 빛을 제어하는 초미세 기술의 진화 Neo 퀀텀 매트릭스 pro. 눈 앞에 펼쳐지는 놀라운 생동감 명암비 강화 Pro. 눈 앞에서 보는 듯한 압도적 디테일!', 9459000, 11, '2024-04-27 12:30:49', '2024-04-27 12:30:49'),
	(567, '텔레비전', 'admin1', '삼성전자 UHD Neo TV', '46a1d884d44c4266a204aeb7bf2c1a9a.png', '압도적 디테일을 표현하는 Neo 퀀텀 매트릭스 기술. 디테일이 살아나는 최첨단 퀀텀 HDR 1500. 10억개의 컬러로 구현하는 독보적 화질', 3977600, 9, '2024-04-27 12:35:20', '2024-04-27 12:35:20'),
	(568, '텔레비전', 'admin1', 'TCL 4k QLED 안드로이드 TV', '3535bc64f7fe4adebbecf9a0d9a0f285.png', '글로벌 구글 OS TV 1위. TV생산 점유율 2위. 가성비와 기능을 겸비한 종합 가전 브랜드. 선명한 색상, 활기찬 생동감. 궁극의 세밀함', 1889000, 51, '2024-04-27 12:43:17', '2024-04-27 12:43:17'),
	(569, '텔레비전', 'admin1', 'LG전자 울트라HD TV', 'dc478d17231e4262848578d79985e562.png', '리얼 4k 화질이 보여주는 선명함의 차이. 마치 눈앞에서 보는 듯한 선명한 화질. 알아서 최적의 영상과 사운드를 표현. 나의 일상을 더 스마트하게. 간결한 디자인이 완성하는 대화면의 몰입감!', 1890500, 35, '2024-04-27 12:46:41', '2024-04-27 12:46:41');

-- 테이블 shop.orders 구조 내보내기
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `orders_no` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(50) NOT NULL,
  `goods_no` int(11) NOT NULL,
  `total_price` int(11) NOT NULL,
  `state` enum('결제완료','출하지시','배송시작','배송완료','구매승인') NOT NULL DEFAULT '결제완료',
  `filename` varchar(50) NOT NULL DEFAULT 'default.png',
  `order_quantity` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `dispatch_date` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `arrived_date` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  PRIMARY KEY (`orders_no`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 shop.orders:~93 rows (대략적) 내보내기
DELETE FROM `orders`;
INSERT INTO `orders` (`orders_no`, `mail`, `goods_no`, `total_price`, `state`, `filename`, `order_quantity`, `name`, `order_date`, `dispatch_date`, `delivery_date`, `arrived_date`, `completed_date`) VALUES
	(48, 'customer4@navar.com', 566, 18918000, '구매승인', '9dac4970daf8454091df27285bc8059e.png', 2, '맞동석', '2024-04-27 13:02:32', NULL, NULL, NULL, '2024-04-28 16:16:43'),
	(49, 'customer1@navar.com', 563, 258000, '배송완료', 'a9536af8b2f544589968aa3acab4c861.png', 2, '마동석', '2024-04-27 15:04:57', NULL, NULL, '2024-04-28 16:16:44', NULL),
	(50, 'customer1@navar.com', 525, 3073620, '출하지시', 'd32b4b0e32aa405e97037af4b9705e6d.png', 1, '마동석', '2024-04-27 15:09:20', '2024-04-28 16:16:46', NULL, NULL, NULL),
	(51, 'customer2@navar.com', 528, 1335440, '배송완료', 'acff964b6788438885dda12730b59591.png', 2, '남동석', '2024-04-27 15:10:32', NULL, NULL, '2024-04-28 16:16:47', NULL),
	(52, 'customer3@navar.com', 507, 4749850, '구매승인', 'f31d516979fc4e13b90a6c468f9af3ac.png', 1, '걸동석', '2024-04-27 15:10:53', NULL, NULL, NULL, '2024-04-28 16:16:41'),
	(53, 'customer3@navar.com', 559, 37500, '배송시작', '2a0efec0543f49758a99bfca92f6de8a.png', 10, '걸동석', '2024-04-27 15:11:10', NULL, '2024-04-28 16:16:51', NULL, NULL),
	(54, 'customer5@navar.com', 554, 1750000, '배송완료', 'd6fec009026f487f8392748837e27463.png', 1, '구동석', '2024-04-27 15:12:30', NULL, NULL, '2024-04-28 16:20:14', NULL),
	(55, 'customer6@navar.com', 565, 315000, '구매승인', '1282a885cbc54ead82bcb3150f35c80f.png', 3, '을동석', '2024-04-27 15:12:52', NULL, NULL, '2024-04-28 16:16:35', '2024-04-28 16:16:55'),
	(56, 'customer7@navar.com', 524, 3067100, '배송완료', '2418b3d7ebd44cfbb3ca7f41b85fe2eb.png', 1, '장이수', '2024-04-27 15:13:16', NULL, NULL, '2024-04-28 16:17:19', NULL),
	(57, 'customer10@navar.com', 566, 9459000, '출하지시', '9dac4970daf8454091df27285bc8059e.png', 1, '힘동석', '2024-04-27 15:13:35', '2024-04-28 16:17:16', NULL, NULL, NULL),
	(58, 'customer10@navar.com', 558, 14900, '배송시작', 'b6124ab7e59c4024a0f49aa04be343a2.png', 1, '힘동석', '2024-04-27 15:13:54', NULL, '2024-04-28 16:17:13', NULL, NULL),
	(59, 'customer10@navar.com', 557, 38420, '배송완료', 'ddbb29dd4c8c4de0971a8084f9176243.png', 2, '힘동석', '2024-04-27 15:14:03', NULL, NULL, '2024-04-28 16:17:12', NULL),
	(60, 'customer10@navar.com', 560, 22290, '결제완료', 'ff431f0da8284c24a1069b88b9ab97d0.png', 1, '힘동석', '2024-04-27 15:14:14', NULL, NULL, NULL, NULL),
	(61, 'customer10@navar.com', 551, 5989000, '구매승인', 'd58b4d9e8c974c12b9df5c1178d7b5e8.png', 1, '힘동석', '2024-04-27 15:14:31', NULL, NULL, NULL, '2024-04-28 16:17:09'),
	(62, 'customer11@navar.com', 508, 1291800, '배송완료', '768c22f85fb9410a86a67586927158fa.png', 2, '금동석', '2024-04-27 22:25:55', NULL, NULL, '2024-04-28 16:17:08', NULL),
	(63, 'customer11@navar.com', 552, 11577000, '구매승인', '06979b255c054a13873b9a189cebf6ca.png', 3, '금동석', '2024-04-27 22:26:15', NULL, NULL, NULL, '2024-04-28 16:17:07'),
	(64, 'customer11@navar.com', 509, 449000, '출하지시', '0cf7de030c9c435a9c82846145f29ed1.png', 1, '금동석', '2024-04-27 22:26:25', '2024-04-28 16:17:54', NULL, NULL, NULL),
	(65, 'customer12@navar.com', 514, 2195000, '구매승인', 'b9bdd3be0673478eb1d7b001fb3e156e.png', 5, '박동석', '2024-04-27 22:27:48', NULL, NULL, NULL, '2024-04-28 16:17:48'),
	(66, 'customer13@navar.com', 530, 5700000, '결제완료', '316314c9755441ebae01f8f8802367e8.png', 1, '장첸', '2024-04-27 22:28:53', NULL, NULL, NULL, NULL),
	(67, 'customer14@navar.com', 550, 19900950, '배송시작', '97b36d72c92c48c5aeb9287fe8b7e9e0.png', 3, '마재윤', '2024-04-27 22:30:13', NULL, '2024-04-28 16:17:47', NULL, NULL),
	(68, 'customer14@navar.com', 512, 2138000, '배송완료', '7960d89a0f6741babd6e735dddcde529.png', 2, '마재윤', '2024-04-27 22:30:27', NULL, NULL, '2024-04-28 16:17:45', NULL),
	(69, 'customer15@navar.com', 505, 1483210, '배송완료', '9e14b65c7f2c46f5a15a6d3d89d3a9e6.png', 1, '임요환', '2024-04-27 22:31:42', NULL, NULL, '2024-04-28 16:17:44', NULL),
	(70, 'customer16@navar.com', 511, 2416500, '배송완료', '23804f5e770748868d9de58ac1181107.png', 3, '홍진호', '2024-04-27 22:32:31', NULL, NULL, '2024-04-28 16:17:43', NULL),
	(71, 'customer17@navar.com', 569, 3781000, '구매승인', 'dc478d17231e4262848578d79985e562.png', 2, '김캐리', '2024-04-27 22:34:38', NULL, NULL, NULL, '2024-04-28 16:17:41'),
	(72, 'customer18@navar.com', 566, 9459000, '배송완료', '9dac4970daf8454091df27285bc8059e.png', 1, '엄재경', '2024-04-27 22:35:33', NULL, NULL, '2024-04-28 16:18:08', NULL),
	(73, 'customer19@navar.com', 506, 584000, '구매승인', '30329868ec474b8581e141a6258bb4b3.png', 1, '정소림', '2024-04-27 22:40:02', NULL, NULL, NULL, '2024-04-28 16:18:10'),
	(74, 'customer20@navar.com', 505, 1483210, '배송완료', '9e14b65c7f2c46f5a15a6d3d89d3a9e6.png', 1, '김택용', '2024-04-27 22:41:29', NULL, NULL, '2024-04-28 16:18:06', NULL),
	(75, 'customer20@navar.com', 508, 645900, '배송시작', '768c22f85fb9410a86a67586927158fa.png', 1, '김택용', '2024-04-27 22:41:39', NULL, '2024-04-28 16:18:11', NULL, NULL),
	(76, 'customer20@navar.com', 506, 1168000, '배송시작', '30329868ec474b8581e141a6258bb4b3.png', 2, '김택용', '2024-04-27 22:41:44', NULL, '2024-04-28 16:20:24', NULL, NULL),
	(77, 'customer21@navar.com', 515, 899700, '출하지시', '2a99a683cb68444b8d5d60a93b61bc37.png', 3, '이제동', '2024-04-27 22:43:14', '2024-04-28 16:18:15', NULL, NULL, NULL),
	(78, 'customer22@navar.com', 531, 2637800, '구매승인', 'da58e6c876654a92bdcd6b8b613c4b7a.png', 2, '송뱅구', '2024-04-27 22:44:17', NULL, NULL, NULL, '2024-04-28 16:17:58'),
	(79, 'customer22@navar.com', 516, 658320, '배송완료', '07db6cb261f1418f958dd5f74cc7617c.png', 1, '송뱅구', '2024-04-27 22:44:21', NULL, NULL, '2024-04-28 16:18:03', NULL),
	(80, 'customer22@navar.com', 529, 777000, '배송시작', 'da09d70ec59b4913b0832825a8c1a6a7.png', 3, '송뱅구', '2024-04-27 22:44:27', NULL, '2024-04-28 16:19:02', NULL, NULL),
	(81, 'customer23@navar.com', 553, 2003640, '출하지시', 'fb98ffc7d693491f9c8547bf9b67a1bb.png', 3, '이영호', '2024-04-27 22:49:04', '2024-04-28 16:19:04', NULL, NULL, NULL),
	(82, 'customer1@navar.com', 503, 584000, '배송시작', 'f1192c4c7d7d43b08a50da475c75ea23.png', 1, '마동석', '2024-04-27 22:55:51', NULL, '2024-04-28 16:19:00', NULL, NULL),
	(83, 'customer1@navar.com', 507, 4749850, '결제완료', 'f31d516979fc4e13b90a6c468f9af3ac.png', 1, '마동석', '2024-04-27 22:55:55', NULL, NULL, NULL, NULL),
	(84, 'customer1@navar.com', 505, 1483210, '배송시작', '9e14b65c7f2c46f5a15a6d3d89d3a9e6.png', 1, '마동석', '2024-04-27 22:56:00', NULL, '2024-04-28 16:18:59', NULL, NULL),
	(85, 'customer1@navar.com', 508, 645900, '배송완료', '768c22f85fb9410a86a67586927158fa.png', 1, '마동석', '2024-04-27 22:56:04', NULL, NULL, '2024-04-28 16:18:57', NULL),
	(86, 'customer1@navar.com', 506, 584000, '출하지시', '30329868ec474b8581e141a6258bb4b3.png', 1, '마동석', '2024-04-27 22:56:08', '2024-04-28 16:19:06', NULL, NULL, NULL),
	(87, 'customer1@navar.com', 530, 5700000, '배송완료', '316314c9755441ebae01f8f8802367e8.png', 1, '마동석', '2024-04-27 22:56:11', NULL, NULL, '2024-04-28 16:18:55', NULL),
	(88, 'customer24@navar.com', 518, 1874000, '배송시작', '7f16949a03b345f89454ec73693a205a.png', 1, '류현진', '2024-04-27 22:57:53', NULL, '2024-04-28 16:19:19', NULL, NULL),
	(89, 'customer24@navar.com', 524, 3067100, '출하지시', '2418b3d7ebd44cfbb3ca7f41b85fe2eb.png', 1, '류현진', '2024-04-27 22:57:58', '2024-04-28 16:19:21', NULL, NULL, NULL),
	(90, 'customer24@navar.com', 526, 3299000, '배송시작', 'c497cde14f57482284f7ed4b19e40e6c.png', 1, '류현진', '2024-04-27 22:58:03', NULL, '2024-04-28 16:19:17', NULL, NULL),
	(91, 'customer24@navar.com', 527, 2698000, '결제완료', '59e5950cc46340408468fb40d70add53.png', 1, '류현진', '2024-04-27 22:58:08', NULL, NULL, NULL, NULL),
	(92, 'customer26@navar.com', 550, 6633650, '배송완료', '97b36d72c92c48c5aeb9287fe8b7e9e0.png', 1, '장동민', '2024-04-27 22:59:38', NULL, NULL, '2024-04-28 16:08:04', NULL),
	(93, 'customer26@navar.com', 510, 1737000, '출하지시', '041731a8ecf8473aac765081452a1bb4.png', 3, '장동민', '2024-04-27 22:59:43', '2024-04-28 16:19:15', NULL, NULL, NULL),
	(94, 'customer26@navar.com', 549, 16639150, '배송시작', '57082c16665a4555afa0d4a9d756ba29.png', 5, '장동민', '2024-04-27 22:59:49', NULL, '2024-04-28 16:19:13', NULL, NULL),
	(95, 'customer27@navar.com', 552, 7718000, '배송시작', '06979b255c054a13873b9a189cebf6ca.png', 2, '최홍만', '2024-04-27 23:03:10', NULL, '2024-04-28 16:19:11', NULL, NULL),
	(96, 'customer27@navar.com', 517, 448210, '결제완료', 'b52a80c12c97437381a5b0d240f780c9.png', 1, '최홍만', '2024-04-27 23:03:15', NULL, NULL, NULL, NULL),
	(97, 'customer27@navar.com', 556, 1028000, '출하지시', '91ec6064d4654377b92365e4adfbd010.png', 1, '최홍만', '2024-04-27 23:03:21', '2024-04-28 16:19:33', NULL, NULL, NULL),
	(98, 'customer27@navar.com', 553, 667880, '배송시작', 'fb98ffc7d693491f9c8547bf9b67a1bb.png', 1, '최홍만', '2024-04-27 23:03:26', NULL, '2024-04-28 16:19:31', NULL, NULL),
	(99, 'customer27@navar.com', 554, 1750000, '출하지시', 'd6fec009026f487f8392748837e27463.png', 1, '최홍만', '2024-04-27 23:03:33', '2024-04-28 15:40:14', NULL, NULL, NULL),
	(100, 'customer27@navar.com', 555, 2486560, '구매승인', 'a531e9ebea054abcb454a87e7e4febf9.png', 2, '최홍만', '2024-04-27 23:03:40', NULL, NULL, NULL, '2024-04-28 16:08:01'),
	(101, 'customer28@navar.com', 560, 289770, '출하지시', '5ad085886a1a404caadeda7375f2acae.png', 13, '홍둘리', '2024-04-27 23:05:49', '2024-04-28 15:36:17', NULL, NULL, NULL),
	(102, 'customer28@navar.com', 557, 19210, '출하지시', 'ddbb29dd4c8c4de0971a8084f9176243.png', 1, '홍둘리', '2024-04-27 23:05:54', '2024-04-28 15:40:56', NULL, NULL, NULL),
	(103, 'customer28@navar.com', 558, 59600, '배송완료', '66c9b5b9461c4745b5d9077e9b23a698.png', 4, '홍둘리', '2024-04-27 23:05:59', NULL, NULL, '2024-04-28 16:19:27', NULL),
	(104, 'customer28@navar.com', 523, 187600, '출하지시', '7420112c2d1042bbb5785864ea7ef3fb.png', 7, '홍둘리', '2024-04-27 23:06:04', '2024-04-28 16:19:56', NULL, NULL, NULL),
	(105, 'customer28@navar.com', 522, 150400, '출하지시', '311b46dc78e54523a9696176b9e94f00.png', 16, '홍둘리', '2024-04-27 23:06:10', '2024-04-28 16:19:55', NULL, NULL, NULL),
	(106, 'customer28@navar.com', 523, 455600, '출하지시', '7420112c2d1042bbb5785864ea7ef3fb.png', 17, '홍둘리', '2024-04-27 23:06:18', '2024-04-28 16:19:53', NULL, NULL, NULL),
	(107, 'customer2@navar.com', 519, 798000, '결제완료', 'fa92972915434ccdb83b623a57b57a99.png', 2, '남동석', '2024-04-27 23:12:55', NULL, NULL, NULL, NULL),
	(108, 'customer2@navar.com', 520, 499000, '배송시작', '44328fa8211a4596a3a55495ce631816.png', 1, '남동석', '2024-04-27 23:13:00', NULL, '2024-04-28 16:19:51', NULL, NULL),
	(109, 'customer2@navar.com', 568, 1889000, '출하지시', '3535bc64f7fe4adebbecf9a0d9a0f285.png', 1, '남동석', '2024-04-27 23:13:06', '2024-04-28 16:19:49', NULL, NULL, NULL),
	(110, 'customer2@navar.com', 569, 1890500, '배송완료', 'dc478d17231e4262848578d79985e562.png', 1, '남동석', '2024-04-27 23:13:10', NULL, NULL, '2024-04-28 16:19:48', NULL),
	(111, 'customer3@navar.com', 567, 3977600, '배송시작', '46a1d884d44c4266a204aeb7bf2c1a9a.png', 1, '걸동석', '2024-04-27 23:14:02', NULL, '2024-04-28 16:19:46', NULL, NULL),
	(112, 'customer3@navar.com', 566, 9459000, '구매승인', '9dac4970daf8454091df27285bc8059e.png', 1, '걸동석', '2024-04-27 23:14:11', NULL, NULL, NULL, '2024-04-28 16:07:59'),
	(113, 'customer4@navar.com', 562, 250080, '결제완료', '01d6f40a299d4d6d8b767d80dae7aca3.png', 3, '맞동석', '2024-04-27 23:15:07', NULL, NULL, NULL, NULL),
	(114, 'customer4@navar.com', 564, 636000, '출하지시', '33bad08653024d1cb5fcdac3f8be8dd8.png', 4, '맞동석', '2024-04-27 23:15:13', '2024-04-28 15:45:53', NULL, NULL, NULL),
	(115, 'customer4@navar.com', 561, 154800, '결제완료', 'a7485ef233c34d5dbe122f1546e098e5.png', 1, '맞동석', '2024-04-27 23:15:18', NULL, NULL, NULL, NULL),
	(116, 'customer4@navar.com', 521, 59800, '배송시작', '2ff277866d0148a1be21917912a4af08.png', 1, '맞동석', '2024-04-27 23:15:22', '2024-04-28 15:59:22', '2024-04-28 16:01:02', NULL, NULL),
	(117, 'customer4@navar.com', 563, 129000, '출하지시', 'a9536af8b2f544589968aa3acab4c861.png', 1, '맞동석', '2024-04-27 23:15:27', '2024-04-29 13:55:52', NULL, NULL, NULL),
	(118, 'customer29@navar.com', 564, 159000, '배송완료', '33bad08653024d1cb5fcdac3f8be8dd8.png', 1, '심봉사', '2024-04-28 01:15:13', NULL, NULL, '2024-04-28 16:16:27', NULL),
	(119, 'customer29@navar.com', 516, 658320, '출하지시', '07db6cb261f1418f958dd5f74cc7617c.png', 1, '심봉사', '2024-04-28 01:15:26', '2024-04-28 16:20:56', NULL, NULL, NULL),
	(120, 'customer30@navar.com', 517, 896420, '구매승인', 'b52a80c12c97437381a5b0d240f780c9.png', 2, '홍두깨', '2024-04-28 01:17:27', NULL, NULL, NULL, '2024-04-28 16:16:18'),
	(121, 'customer5@navar.com', 522, 28200, '출하지시', '311b46dc78e54523a9696176b9e94f00.png', 3, '구동석', '2024-04-28 01:18:38', '2024-04-28 16:16:16', NULL, NULL, NULL),
	(122, 'customer24@navar.com', 525, 3073620, '결제완료', 'd32b4b0e32aa405e97037af4b9705e6d.png', 1, '류현진', '2024-04-28 01:19:00', NULL, NULL, NULL, NULL),
	(123, 'customer9@navar.com', 530, 5700000, '배송시작', '316314c9755441ebae01f8f8802367e8.png', 1, '남이수', '2024-04-28 01:19:29', NULL, '2024-04-28 16:16:13', NULL, NULL),
	(124, 'customer1@navar.com', 551, 5989000, '출하지시', '0e115ce868a24550ae507bae51434066.png', 1, '마동석', '2024-04-28 01:19:57', '2024-04-28 16:21:23', NULL, NULL, NULL),
	(125, 'customer2@navar.com', 566, 9459000, '배송완료', '9dac4970daf8454091df27285bc8059e.png', 1, '남동석', '2024-04-28 01:20:27', NULL, NULL, '2024-04-28 16:16:10', NULL),
	(126, 'customer6@navar.com', 552, 3859000, '배송시작', '06979b255c054a13873b9a189cebf6ca.png', 1, '을동석', '2024-04-28 01:20:51', '2024-04-28 16:20:50', '2024-04-28 16:21:17', NULL, NULL),
	(127, 'customer6@navar.com', 528, 1335440, '출하지시', 'acff964b6788438885dda12730b59591.png', 2, '을동석', '2024-04-28 01:20:58', '2024-04-28 16:21:21', NULL, NULL, NULL),
	(128, 'customer6@navar.com', 519, 399000, '결제완료', 'fa92972915434ccdb83b623a57b57a99.png', 1, '을동석', '2024-04-28 01:21:10', NULL, NULL, NULL, NULL),
	(129, 'customer11@navar.com', 560, 66870, '출하지시', '5ad085886a1a404caadeda7375f2acae.png', 3, '금동석', '2024-04-28 01:21:26', '2024-04-28 15:45:50', NULL, NULL, NULL),
	(131, 'customer20@navar.com', 569, 3781000, '배송시작', 'dc478d17231e4262848578d79985e562.png', 2, '김택용', '2024-04-28 02:22:50', NULL, '2024-04-28 16:15:05', NULL, NULL),
	(132, 'customer18@navar.com', 520, 998000, '배송시작', '44328fa8211a4596a3a55495ce631816.png', 2, '엄재경', '2024-04-28 02:24:47', '2024-04-28 15:44:17', '2024-04-28 16:20:43', NULL, NULL),
	(133, 'customer22@navar.com', 503, 1752000, '출하지시', 'f1192c4c7d7d43b08a50da475c75ea23.png', 3, '송뱅구', '2024-04-28 02:26:12', '2024-04-28 15:43:03', NULL, NULL, NULL),
	(134, 'customer24@navar.com', 557, 57630, '배송시작', 'ddbb29dd4c8c4de0971a8084f9176243.png', 3, '류현진', '2024-04-28 09:22:08', '2024-04-28 15:26:44', '2024-04-28 16:21:13', NULL, NULL),
	(135, 'customer19@navar.com', 562, 83360, '배송완료', '01d6f40a299d4d6d8b767d80dae7aca3.png', 1, '정소림', '2024-04-28 09:23:26', NULL, NULL, '2024-04-28 16:07:48', NULL),
	(136, 'customer8@navar.com', 527, 2698000, '배송시작', '59e5950cc46340408468fb40d70add53.png', 1, '여동석', '2024-04-28 09:25:15', NULL, '2024-04-28 21:53:39', NULL, NULL),
	(137, 'customer16@navar.com', 559, 15000, '배송시작', '254700c88fce4af7960b5286f86c8125.png', 4, '홍진호', '2024-04-28 21:48:44', '2024-04-28 21:53:42', '2024-04-28 21:53:47', NULL, NULL),
	(138, 'customer5@navar.com', 555, 1243280, '출하지시', 'a531e9ebea054abcb454a87e7e4febf9.png', 1, '구동석', '2024-04-28 21:52:23', '2024-04-28 21:53:44', NULL, NULL, NULL),
	(139, 'customer7@navar.com', 557, 19210, '출하지시', 'ddbb29dd4c8c4de0971a8084f9176243.png', 1, '장이수', '2024-04-28 21:53:09', '2024-04-28 21:53:49', NULL, NULL, NULL),
	(140, 'customer7@navar.com', 510, 579000, '결제완료', '041731a8ecf8473aac765081452a1bb4.png', 1, '장이수', '2024-04-28 21:53:20', NULL, NULL, NULL, NULL),
	(141, 'customer31@navar.com', 519, 399000, '출하지시', 'fa92972915434ccdb83b623a57b57a99.png', 1, '유재석', '2024-04-28 22:14:03', '2024-04-29 13:32:39', NULL, NULL, NULL),
	(142, '1@1.com', 566, 9459000, '출하지시', '7b948691ba464d08a5c9408738e092d9.png', 1, '1', '2024-04-29 13:44:02', '2024-04-29 13:44:33', NULL, NULL, NULL);

-- 테이블 shop.orderstate 구조 내보내기
DROP TABLE IF EXISTS `orderstate`;
CREATE TABLE IF NOT EXISTS `orderstate` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(50) NOT NULL DEFAULT '결제완료',
  PRIMARY KEY (`index`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 shop.orderstate:~5 rows (대략적) 내보내기
DELETE FROM `orderstate`;
INSERT INTO `orderstate` (`index`, `state`) VALUES
	(1, '결제완료'),
	(2, '출하지시'),
	(3, '배송시작'),
	(4, '배송완료'),
	(5, '구매승인');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
