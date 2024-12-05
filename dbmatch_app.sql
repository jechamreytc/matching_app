-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2024 at 06:54 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbmatch_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `admin_id` int(11) NOT NULL,
  `admin_username` varchar(100) NOT NULL,
  `admin_password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`admin_id`, `admin_username`, `admin_password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `tblmatching`
--

CREATE TABLE `tblmatching` (
  `matching_id` int(11) NOT NULL,
  `matching_id_number` varchar(100) NOT NULL,
  `matching_temp_id` int(11) NOT NULL,
  `matching_room_number` varchar(150) NOT NULL,
  `matching_gender` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblmatching`
--

INSERT INTO `tblmatching` (`matching_id`, `matching_id_number`, `matching_temp_id`, `matching_room_number`, `matching_gender`) VALUES
(1, '456', 1, 'A6520', 'Female'),
(2, '123', 1, 'P3730', 'Male'),
(3, '7878', 1, 'P3730', 'Female'),
(4, 'heuawe', 2, 'P3730', 'Female'),
(7, '4561', 2, 'P3730', 'Male'),
(8, '456123', 3, 'P3730', 'Male'),
(10, '02-2223-02022', 1, 'E4663', 'Female'),
(12, '02-2223-09909', 1, 'E4663', 'Male'),
(14, '202020', 2, 'A6520', 'Female'),
(15, '2121', 2, 'E4663', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `tblrooms`
--

CREATE TABLE `tblrooms` (
  `rooms_id` int(11) NOT NULL,
  `rooms_number` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblrooms`
--

INSERT INTO `tblrooms` (`rooms_id`, `rooms_number`) VALUES
(1, 'P3730'),
(2, 'A6520'),
(3, 'F7810'),
(4, 'C5841'),
(5, 'J5910'),
(6, 'J4819'),
(7, 'F9675'),
(8, 'M0832'),
(9, 'Y9270'),
(10, 'Y9453'),
(11, 'H3550'),
(12, 'J6703'),
(13, 'N9973'),
(14, 'E4663');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `tblmatching`
--
ALTER TABLE `tblmatching`
  ADD PRIMARY KEY (`matching_id`),
  ADD UNIQUE KEY `matching_id_number` (`matching_id_number`);

--
-- Indexes for table `tblrooms`
--
ALTER TABLE `tblrooms`
  ADD PRIMARY KEY (`rooms_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblmatching`
--
ALTER TABLE `tblmatching`
  MODIFY `matching_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tblrooms`
--
ALTER TABLE `tblrooms`
  MODIFY `rooms_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
