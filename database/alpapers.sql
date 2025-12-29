-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2025 at 06:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `alpapers`
--

-- --------------------------------------------------------

--
-- Table structure for table `exam_sessions`
--

CREATE TABLE `exam_sessions` (
  `id` bigint(20) NOT NULL,
  `active` bit(1) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  `start_time` time(6) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `subject_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `message` varchar(500) NOT NULL,
  `read_flag` bit(1) NOT NULL,
  `title` varchar(150) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `papers`
--

CREATE TABLE `papers` (
  `id` bigint(20) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `title` varchar(180) NOT NULL,
  `year` int(11) NOT NULL,
  `type` enum('MODEL','PAST') NOT NULL,
  `subject_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `papers`
--

INSERT INTO `papers` (`id`, `file_path`, `title`, `year`, `type`, `subject_id`) VALUES
(22, 'uploads/papers/1762776283331_sft2015.pdf', 'Science for Technology Past Paper', 2015, 'PAST', 17),
(23, 'uploads/papers/1762776311950_sft2016.pdf', 'Science for Technology Past Paper', 2016, 'PAST', 17),
(24, 'uploads/papers/1762776342035_sft2017.pdf', 'Science for Technology Past Paper', 2017, 'PAST', 17),
(25, 'uploads/papers/1762776362562_sft2018.pdf', 'Science for Technology Past Paper', 2018, 'PAST', 17),
(26, 'uploads/papers/1762776388740_sft2019.pdf', 'Science for Technology Past Paper', 2019, 'PAST', 17),
(27, 'uploads/papers/1762776413921_sft2020.pdf', 'Science for Technology Past Paper', 2020, 'PAST', 17),
(28, 'uploads/papers/1762776554833_2015-AL-ET-Past-Paper-Sinhala-Medium.pdf', 'Engineering Technology Past Papers', 2015, 'PAST', 15),
(29, 'uploads/papers/1762776722839_2016-AL-ET-Past-Paper-Sinhala-Medium.pdf', 'Engineering Technology Past Papers', 2016, 'PAST', 15),
(30, 'uploads/papers/1762829188054_2021-AL-SFT-Past-Paper-Sinhala-Medium.pdf', 'Science for Technology Past Paper', 2021, 'PAST', 17),
(31, 'uploads/papers/1762829395626_GCE-Advanced-Level-2022-SFT-Sinhala-Medium-Paper.pdf', 'Science for Technology Past Paper', 2022, 'PAST', 17),
(32, 'uploads/papers/1762829488795_2017-AL-ET-Past-Paper-Sinhala-Medium.pdf', 'Engineering Technology Past Paper', 2017, 'PAST', 15);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `stream` enum('ARTS','COMMERCE','MATHEMATICS','SCIENCE','TECHNOLOGY') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `stream`) VALUES
(15, 'Engineering Technology (ET)', 'TECHNOLOGY'),
(16, 'Bio-System Technology (BST)', 'TECHNOLOGY'),
(17, 'Science for Technology (SFT)', 'TECHNOLOGY'),
(18, 'Information and Communication Technology (ICT)', 'TECHNOLOGY');

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `id` bigint(20) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `score` double DEFAULT NULL,
  `student_email` varchar(255) DEFAULT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `submitted_at` datetime(6) DEFAULT NULL,
  `exam_session_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_requests`
--

CREATE TABLE `support_requests` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `message` varchar(2000) DEFAULT NULL,
  `status` enum('IN_PROGRESS','OPEN','RESOLVED') DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_requests`
--

INSERT INTO `support_requests` (`id`, `created_at`, `email`, `full_name`, `message`, `status`, `subject`) VALUES
(1, '2025-11-10 23:48:11.000000', 'tharushadilhara1124@gmail.com', 'Tharusha Dilhara Egodage', 'I cannot access ET model papers section.', 'IN_PROGRESS', 'I can\'t access '),
(2, '2025-11-11 00:15:54.000000', 'mavindi@gmail.com', 'Mavindi Tharu', 'I need 2024 sft past papers', 'OPEN', 'SFT');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `email` varchar(120) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','STUDENT','TEACHER') NOT NULL,
  `avatar_path` varchar(255) DEFAULT NULL,
  `grade` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `stream` varchar(255) DEFAULT NULL,
  `profile_image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `enabled`, `full_name`, `password`, `role`, `avatar_path`, `grade`, `phone`, `stream`, `profile_image_path`) VALUES
(1, 'admin@alpms.local', b'1', 'Admin', '$2a$10$/j2sHfVvXVTo6yaIMqoiBeA..CjQeYZG0kq3MeGZxgDaDAfshZivy', 'ADMIN', NULL, NULL, NULL, NULL, NULL),
(2, 'tharusha123@gmail.com', b'1', 'Tharusha Dilhara Egodage', '$2a$10$ZnCwMY0JRoxRP5in6fn.MO62323.rlG8h28OQ6d8KDvz2j8ZpMxn2', 'ADMIN', '/uploads/avatars/user-2-1762342911324.jpg', NULL, '0703582765', 'Technology', NULL),
(3, 'lahiru@gmail.com', b'1', 'Lahiru kalpa', '$2a$10$NVL13XSlQjqCcfVBuPweLuT9g1e4o4htk6U/12rrYHLhqO2XEyH8S', 'ADMIN', NULL, NULL, '+94769582765', NULL, NULL),
(4, 'admin@gmail.com', b'1', 'admin', '$2a$10$T.rlbkgTraJSSsq6BbnTtu7yVOK87IBHAOLjrifymvq73.1TGmzlq', 'ADMIN', '/uploads/avatars/user-4-1762824272900.jpg', NULL, '+94703582765', 'admin', NULL),
(5, 'sasundi@gmail.com', b'1', 'Sasundi Binara', '$2a$10$djyo.iYfrkykjrV5c/layuFvCrbuLL7OhQIwHMS5NPh30HYFyMK2S', 'STUDENT', NULL, NULL, '0712598632', '', NULL),
(6, 'mavindi@gmail.com', b'1', 'Mavindi Tharu', '$2a$10$sDFUWXVTU0HXx65L9sNzougH.Kf1m8u1wuWd3oWoyPqoH7w1ex33i', 'TEACHER', NULL, NULL, '0758965423', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKcs2lmh95gc1jxa5eh6uy5an9q` (`subject_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`);

--
-- Indexes for table `papers`
--
ALTER TABLE `papers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKbtuuf4fd66r3a9v445r3oet9e` (`subject_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKaodt3utnw0lsov4k9ta88dbpr` (`name`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKiitntnsqc0rnwvu2lq995u79o` (`exam_session_id`);

--
-- Indexes for table `support_requests`
--
ALTER TABLE `support_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `papers`
--
ALTER TABLE `papers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_requests`
--
ALTER TABLE `support_requests`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  ADD CONSTRAINT `FKcs2lmh95gc1jxa5eh6uy5an9q` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `papers`
--
ALTER TABLE `papers`
  ADD CONSTRAINT `FKbtuuf4fd66r3a9v445r3oet9e` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`);

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `FKiitntnsqc0rnwvu2lq995u79o` FOREIGN KEY (`exam_session_id`) REFERENCES `exam_sessions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
