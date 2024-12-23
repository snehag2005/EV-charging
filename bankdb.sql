-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 12, 2024 at 03:48 PM
-- Server version: 8.0.35
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bankdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `img_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`id`, `name`, `img_url`) VALUES
(1, 'Thane', 'area1'),
(2, 'wadala', 'area2');

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
CREATE TABLE IF NOT EXISTS `bank` (
  `BK_NAME` text,
  `BK_ID` int NOT NULL,
  `BK_BALANCE` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`BK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`BK_NAME`, `BK_ID`, `BK_BALANCE`) VALUES
('Ayush', 121212, 10000.00),
('Ansh', 121244, 10000.00);

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `useremail` varchar(255) DEFAULT NULL,
  `userphone` varchar(255) DEFAULT NULL,
  `useraddress` varchar(255) DEFAULT NULL,
  `userarea` varchar(255) DEFAULT NULL,
  `stationname` varchar(255) DEFAULT NULL,
  `stationemail` varchar(255) DEFAULT NULL,
  `stationphone` varchar(255) DEFAULT NULL,
  `stationaddress` varchar(255) DEFAULT NULL,
  `stationarea` varchar(255) DEFAULT NULL,
  `selectedport` varchar(255) DEFAULT NULL,
  `selectedtype` varchar(255) DEFAULT NULL,
  `selectedlevel` varchar(255) DEFAULT NULL,
  `starttime` varchar(255) DEFAULT NULL,
  `endtime` varchar(255) DEFAULT NULL,
  `totaltime` varchar(255) DEFAULT NULL,
  `totalcost` varchar(255) DEFAULT NULL,
  `bookingtime` varchar(255) DEFAULT NULL,
  `bookingdate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `username`, `useremail`, `userphone`, `useraddress`, `userarea`, `stationname`, `stationemail`, `stationphone`, `stationaddress`, `stationarea`, `selectedport`, `selectedtype`, `selectedlevel`, `starttime`, `endtime`, `totaltime`, `totalcost`, `bookingtime`, `bookingdate`) VALUES
(11, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:00 - 00:15', '03:00 - 03:15', '3 hours 15 minutes', '390', '2024-02-08', '17:47'),
(12, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '03:30 - 03:45', '06:15 - 06:30', '3 hours 0 minutes', '360', '2024-02-08', '17:47'),
(13, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '3', 'Type 1', 'Level 2', '12:30 - 12:45', '15:15 - 15:30', '3 hours 0 minutes', '360', '2024-02-08', '17:47'),
(14, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '10:15 - 10:30', '13:00 - 13:15', '3 hours 0 minutes', '360', '2024-02-08', '17:47'),
(15, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '03:00 - 03:15', '3 hours 15 minutes', '390', '2024-02-09', '10:32'),
(16, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '03:00 - 03:15', '3 hours 15 minutes', '390', '2024-02-09', '10:33'),
(17, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '03:00 - 03:15', '3 hours 15 minutes', '390', '2024-02-09', '10:34'),
(18, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '03:00 - 03:15', '3 hours 15 minutes', '390', '2024-02-09', '10:34'),
(19, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '03:00 - 03:15', '3 hours 15 minutes', '390', '2024-02-09', '10:35'),
(20, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:35'),
(21, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:36'),
(22, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:36'),
(23, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:37'),
(24, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:39'),
(25, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:39'),
(26, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:41'),
(27, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:42'),
(28, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:42'),
(29, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:53'),
(30, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:53'),
(31, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '10:55'),
(32, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '11:05'),
(33, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:45 - 01:00', '03:30 - 03:45', '3 hours 0 minutes', '360', '2024-02-09', '11:06'),
(34, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:08'),
(35, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:08'),
(36, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:16'),
(37, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:16'),
(38, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:17'),
(39, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:17'),
(40, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:17'),
(41, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '4', 'Type 1', 'Level 2', '06:15 - 06:30', '09:00 - 09:15', '3 hours 0 minutes', '360', '2024-02-09', '11:18'),
(42, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:00 - 00:15', '00:45 - 01:00', '1 hours 0 minutes', '120', '2024-02-09', '11:44'),
(43, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', NULL, NULL, NULL, NULL, '14:38', '2024-02-10'),
(44, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', NULL, NULL, NULL, NULL, '14:39', '2024-02-10'),
(45, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', NULL, NULL, NULL, NULL, '14:39', '2024-02-10'),
(46, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:00 - 00:15', '05:45 - 06:00', '6 hours 0 minutes', '720', '2024-02-10', '14:41'),
(47, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:00 - 00:15', '03:00 - 03:15', '3 hours 15 minutes', '390', '2024-02-10', '14:42'),
(48, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00:38', '2024-02-11'),
(49, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', NULL, 'Level 2', '03:45 - 04:00', '06:15 - 06:30', '2 hours 30 minutes', '150  INR', '00:39', '2024-02-11'),
(50, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', NULL, 'Level 2', '03:45 - 04:00', '06:15 - 06:30', '2 hours 30 minutes', '150  INR', '00:39', '2024-02-11'),
(51, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', NULL, 'Level 2', '01:00 - 01:15', '03:30 - 03:45', '2 hours 30 minutes', '150  INR', '00:43', '2024-02-11'),
(52, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', NULL, 'Level 2', '', '', '', '', '00:47', '2024-02-11'),
(53, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '08:30 - 08:45', '11:00 - 11:15', '2 hours 30 minutes', '150  INR', '00:52', '2024-02-11'),
(54, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '5', 'Type 1', 'Level 2', '00:00 - 00:15', '05:30 - 05:45', '5 hours 30 minutes', '330  INR', '00:54', '2024-02-11'),
(55, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '00:59', '2024-02-11'),
(56, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:01', '2024-02-11'),
(57, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:04', '2024-02-11'),
(58, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:06', '2024-02-11'),
(59, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:06', '2024-02-11'),
(60, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:06', '2024-02-11'),
(61, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:11', '2024-02-11'),
(62, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:11', '2024-02-11'),
(63, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:13', '2024-02-11'),
(64, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:14', '2024-02-11'),
(65, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:14', '2024-02-11'),
(66, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:15', '2024-02-11'),
(67, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:15', '2024-02-11'),
(68, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:16', '2024-02-11'),
(69, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:16', '2024-02-11'),
(70, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:20', '2024-02-11'),
(71, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:23', '2024-02-11'),
(72, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:24', '2024-02-11'),
(73, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:25', '2024-02-11'),
(74, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:26', '2024-02-11'),
(75, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:26', '2024-02-11'),
(76, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '2', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '01:30', '2024-02-11'),
(77, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '5', 'Type 1', 'Level 2', '11:00 - 11:15', '13:30 - 13:45', '2 hours 30 minutes', '150  INR', '01:31', '2024-02-11'),
(78, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '5', 'Type 1', 'Level 2', '11:00 - 11:15', '13:30 - 13:45', '2 hours 30 minutes', '150  INR', '01:33', '2024-02-11'),
(79, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '16:00 - 16:15', '20:30 - 20:45', '4 hours 30 minutes', '270  INR', '20:10', '2024-02-11'),
(80, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '16:00 - 16:15', '20:30 - 20:45', '4 hours 30 minutes', '270  INR', '20:12', '2024-02-11'),
(81, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '16:00 - 16:15', '20:30 - 20:45', '4 hours 30 minutes', '270  INR', '20:13', '2024-02-11'),
(82, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '20:30 - 20:45', '21:15 - 21:30', '0 hours 45 minutes', '45  INR', '20:13', '2024-02-11'),
(83, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '20:30 - 20:45', '21:15 - 21:30', '0 hours 45 minutes', '45  INR', '20:14', '2024-02-11'),
(84, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '11:15 - 11:30', '13:45 - 14:00', '2 hours 30 minutes', '150  INR', '20:33', '2024-02-11'),
(85, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '00:00 - 00:15', '02:45 - 03:00', '2 hours 45 minutes', '165  INR', '11:02', '2024-02-12'),
(86, 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', 'Motorcycle', 'Worli area', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', 'Nehru Nagar', 'thane', '1', 'Type 1', 'Level 2', '05:45 - 06:00', '11:00 - 11:15', '5 hours 15 minutes', '315  INR', '17:04', '2024-02-12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usertype` varchar(255) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `confirmpassword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `vehicle` varchar(255) DEFAULT NULL,
  `gst` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tspace` bigint DEFAULT NULL,
  `aspace` bigint DEFAULT NULL,
  `ospace` bigint DEFAULT NULL,
  `connector_types` text,
  `charge_levels` text,
  `dc_support` text,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `taluka` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `usertype`, `name`, `email`, `phone`, `password`, `confirmpassword`, `vehicle`, `gst`, `tspace`, `aspace`, `ospace`, `connector_types`, `charge_levels`, `dc_support`, `address`, `area`, `taluka`, `state`) VALUES
(2, '', 'Ayush Gupta', 'gayush2041@gmail.com', '+919324575394', '1234', '1234', NULL, '12345678', 50, NULL, NULL, 'Type 1, Type 2, Type 3', 'Level 1, Level 2, Level 3', '1', 'Nehru Nagar', 'Thane', 'mumbai', 'Maharashtra'),
(3, '', 'Ayush Gupta', 'gayush2@gmail.com', '+919324575394', '1212', '1212', NULL, '12345678', 50, NULL, NULL, 'Type 1, Type 2', 'Level 1, Level 2', '1', 'Nehru Nagar', 'worli', 'mumbai', 'Maharashtra'),
(4, 'station_owner', 'Ayush Gupta', 'gayush201@gmail.com', '+919324575394', '1212', '1212', NULL, '12345678', 5, NULL, NULL, 'Type 1, Type 2', 'Level 1, Level 3', '1', 'Nehru Nagar', 'Worli', 'mumbai', 'Maharashtra'),
(5, 'station_owner', 'Rushikesh', 'rushikesh@gmail.com', '+919324575394', '1234', '1234', NULL, '12345678', 5, NULL, NULL, 'Type 1, Type 2, Type 3', 'Level 2, Level 3', '1', 'Nehru Nagar', 'thane', 'thane', 'Maharashtra'),
(6, 'user', 'Ishika Gupta', 'ishika@gmail.com', '+919324575394', '1234', '1234', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Nehru Nagar', 'Worli area', 'mumbai', 'Maharashtra'),
(7, 'user', 'priyal', 'priyal@gmail.com', '+919324575394', '1234', '1234', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Nehru Nagar', 'Thane', 'mumbai', 'Maharashtra');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
