-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Gostitelj: localhost
-- Čas nastanka: 10. jan 2019 ob 20.30
-- Različica strežnika: 5.7.24-0ubuntu0.16.04.1
-- Različica PHP: 7.0.32-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Zbirka podatkov: `olive`
--
CREATE DATABASE IF NOT EXISTS `olive` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `olive`;

-- --------------------------------------------------------

--
-- Struktura tabele `organisations`
--

DROP TABLE IF EXISTS `organisations`;
CREATE TABLE `organisations` (
  `id` int(10) UNSIGNED NOT NULL,
  `idLeader` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- --------------------------------------------------------

--
-- Struktura tabele `organisationsusers`
--

DROP TABLE IF EXISTS `organisationsusers`;
CREATE TABLE `organisationsusers` (
  `idOrganisation` int(10) UNSIGNED NOT NULL,
  `idUser` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Odloži podatke za tabelo `organisationsusers`
--

-- --------------------------------------------------------

--
-- Struktura tabele `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `idOrganisation` int(10) UNSIGNED NOT NULL,
  `idLeader` int(10) UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Sprožilci `projects`
--
DROP TRIGGER IF EXISTS `deleteUsersFromProject`;
DELIMITER $$
CREATE TRIGGER `deleteUsersFromProject` BEFORE DELETE ON `projects` FOR EACH ROW BEGIN
DELETE FROM userprojects WHERE idProject = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabele `psps`
--

DROP TABLE IF EXISTS `psps`;
CREATE TABLE `psps` (
  `id` int(10) UNSIGNED NOT NULL,
  `programing_language` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `psp_errors`
--

DROP TABLE IF EXISTS `psp_errors`;
CREATE TABLE `psp_errors` (
  `id` int(10) UNSIGNED NOT NULL,
  `idCategory` int(10) UNSIGNED NOT NULL,
  `phaseEntry` int(10) UNSIGNED NOT NULL,
  `phaseFinish` int(10) UNSIGNED NOT NULL,
  `idPSP` int(10) UNSIGNED NOT NULL,
  `resolve_time` int(11) NOT NULL,
  `num_fixed_errors` int(11) NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `psp_errors_categories`
--

DROP TABLE IF EXISTS `psp_errors_categories`;
CREATE TABLE `psp_errors_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Odloži podatke za tabelo `psp_errors_categories`
--

INSERT INTO `psp_errors_categories` (`id`, `name`) VALUES
(2, 'Documentation'),
(3, 'Syntax'),
(4, 'Construction'),
(5, 'Arranging'),
(6, 'Interface'),
(7, 'Checking'),
(8, 'Data'),
(9, 'Functions'),
(10, 'System'),
(11, 'Environment');

-- --------------------------------------------------------

--
-- Struktura tabele `psp_phases`
--

DROP TABLE IF EXISTS `psp_phases`;
CREATE TABLE `psp_phases` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Odloži podatke za tabelo `psp_phases`
--

INSERT INTO `psp_phases` (`id`, `name`) VALUES
(1, 'Planning'),
(2, 'Infrastructuring'),
(3, 'Coding'),
(4, 'Code review'),
(5, 'Compiling'),
(6, 'Testing'),
(7, 'Analysis');

-- --------------------------------------------------------

--
-- Struktura tabele `psp_tasks`
--

DROP TABLE IF EXISTS `psp_tasks`;
CREATE TABLE `psp_tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `idPhase` int(10) UNSIGNED NOT NULL,
  `idPSP` int(10) UNSIGNED NOT NULL,
  `start` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `pause` int(10) UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `units` int(10) UNSIGNED NOT NULL,
  `estimatedtime` int(10) UNSIGNED NOT NULL,
  `estimatedunits` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idProject` int(10) UNSIGNED NOT NULL,
  `idTask_status` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `tasksusersprojects`
--

DROP TABLE IF EXISTS `tasksusersprojects`;
CREATE TABLE `tasksusersprojects` (
  `idUser` int(10) UNSIGNED NOT NULL,
  `idTask` int(10) UNSIGNED NOT NULL,
  `idPSP` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `task_status`
--

DROP TABLE IF EXISTS `task_status`;
CREATE TABLE `task_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Odloži podatke za tabelo `task_status`
--

INSERT INTO `task_status` (`id`, `name`) VALUES
(1, 'OPEN'),
(2, 'CLOSED'),
(3, 'IN PROGRESS'),
(4, 'REVIEW'),
(5, 'REJECTED');

-- --------------------------------------------------------

--
-- Struktura tabele `userprojects`
--

DROP TABLE IF EXISTS `userprojects`;
CREATE TABLE `userprojects` (
  `idProject` int(10) UNSIGNED NOT NULL,
  `idUser` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- --------------------------------------------------------

--
-- Struktura tabele `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `verified` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `resettable` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `roles_mask` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `registered` int(10) UNSIGNED NOT NULL,
  `last_login` int(10) UNSIGNED DEFAULT NULL,
  `force_logout` mediumint(7) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `users_confirmations`
--

DROP TABLE IF EXISTS `users_confirmations`;
CREATE TABLE `users_confirmations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `email` varchar(249) COLLATE utf8mb4_unicode_ci NOT NULL,
  `selector` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `expires` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `users_remembered`
--

DROP TABLE IF EXISTS `users_remembered`;
CREATE TABLE `users_remembered` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `selector` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `expires` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `users_resets`
--

DROP TABLE IF EXISTS `users_resets`;
CREATE TABLE `users_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `selector` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `expires` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `users_throttling`
--

DROP TABLE IF EXISTS `users_throttling`;
CREATE TABLE `users_throttling` (
  `bucket` varchar(44) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `tokens` float UNSIGNED NOT NULL,
  `replenished_at` int(10) UNSIGNED NOT NULL,
  `expires_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- --------------------------------------------------------

--
-- Struktura tabele `user_psp_data`
--

DROP TABLE IF EXISTS `user_psp_data`;
CREATE TABLE `user_psp_data` (
  `idUser` int(11) UNSIGNED NOT NULL,
  `size` int(11) NULL DEFAULT '0',
  `planning_time` int(11) NULL DEFAULT '0',
  `infrastructuring_time` int(11) NULL DEFAULT '0',
  `coding_time` int(11) NULL DEFAULT '0',
  `code_review_time` int(11) NULL DEFAULT '0',
  `compiling_time` int(11) NULL DEFAULT '0',
  `testing_time` int(11) NULL DEFAULT '0',
  `analysis_time` int(11) NULL DEFAULT '0',
  `planning_in_err` int(11) NULL DEFAULT '0',
  `infrastructuring_in_err` int(11) NULL DEFAULT '0',
  `coding_in_err` int(11) NULL DEFAULT '0',
  `code_review_in_err` int(11) NULL DEFAULT '0',
  `compiling_in_err` int(11) NULL DEFAULT '0',
  `testing_in_err` int(11) NULL DEFAULT '0',
  `analysis_in_err` int(11) NULL DEFAULT '0',
  `planning_res_err` int(11) NULL DEFAULT '0',
  `infrastructuring_res_err` int(11) NULL DEFAULT '0',
  `coding_res_err` int(11) NULL DEFAULT '0',
  `code_review_res_err` int(11) NULL DEFAULT '0',
  `compiling_res_err` int(11) NULL DEFAULT '0',
  `testing_res_err` int(11) NULL DEFAULT '0',
  `analysis_res_err` int(11) NULL DEFAULT '0',
  `psp_number` int(11) NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indeksi zavrženih tabel
--

--
-- Indeksi tabele `organisations`
--
ALTER TABLE `organisations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idLeader` (`idLeader`);

--
-- Indeksi tabele `organisationsusers`
--
ALTER TABLE `organisationsusers`
  ADD PRIMARY KEY (`idOrganisation`,`idUser`),
  ADD KEY `idOrganisation` (`idOrganisation`),
  ADD KEY `idUser` (`idUser`);

--
-- Indeksi tabele `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idOrganisation` (`idOrganisation`),
  ADD KEY `idLeader` (`idLeader`);

--
-- Indeksi tabele `psps`
--
ALTER TABLE `psps`
  ADD PRIMARY KEY (`id`);

--
-- Indeksi tabele `psp_errors`
--
ALTER TABLE `psp_errors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCategory` (`idCategory`),
  ADD KEY `phaseEntry` (`phaseEntry`),
  ADD KEY `phaseFinish` (`phaseFinish`),
  ADD KEY `idPSP` (`idPSP`);

--
-- Indeksi tabele `psp_errors_categories`
--
ALTER TABLE `psp_errors_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeksi tabele `psp_phases`
--
ALTER TABLE `psp_phases`
  ADD PRIMARY KEY (`id`);

--
-- Indeksi tabele `psp_tasks`
--
ALTER TABLE `psp_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idPhase` (`idPhase`),
  ADD KEY `idPSP` (`idPSP`);

--
-- Indeksi tabele `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idProject` (`idProject`),
  ADD KEY `idTask_status` (`idTask_status`);

--
-- Indeksi tabele `tasksusersprojects`
--
ALTER TABLE `tasksusersprojects`
  ADD PRIMARY KEY (`idUser`,`idTask`),
  ADD KEY `idUser` (`idUser`),
  ADD KEY `idTask` (`idTask`),
  ADD KEY `idPSP` (`idPSP`);

--
-- Indeksi tabele `task_status`
--
ALTER TABLE `task_status`
  ADD PRIMARY KEY (`id`);

--
-- Indeksi tabele `userprojects`
--
ALTER TABLE `userprojects`
  ADD PRIMARY KEY (`idProject`,`idUser`),
  ADD KEY `idProject` (`idProject`),
  ADD KEY `idUser` (`idUser`);

--
-- Indeksi tabele `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indeksi tabele `users_confirmations`
--
ALTER TABLE `users_confirmations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `selector` (`selector`),
  ADD KEY `email_expires` (`email`(191),`expires`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeksi tabele `users_remembered`
--
ALTER TABLE `users_remembered`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `selector` (`selector`),
  ADD KEY `user` (`user`);

--
-- Indeksi tabele `users_resets`
--
ALTER TABLE `users_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `selector` (`selector`),
  ADD KEY `user_expires` (`user`,`expires`);

--
-- Indeksi tabele `users_throttling`
--
ALTER TABLE `users_throttling`
  ADD PRIMARY KEY (`bucket`),
  ADD KEY `expires_at` (`expires_at`);

--
-- Indeksi tabele `user_psp_data`
--
ALTER TABLE `user_psp_data`
  ADD KEY `idUser` (`idUser`);

--
-- AUTO_INCREMENT zavrženih tabel
--

--
-- AUTO_INCREMENT tabele `organisations`
--
ALTER TABLE `organisations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT tabele `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT tabele `psps`
--
ALTER TABLE `psps`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `psp_errors`
--
ALTER TABLE `psp_errors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `psp_errors_categories`
--
ALTER TABLE `psp_errors_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT tabele `psp_phases`
--
ALTER TABLE `psp_phases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT tabele `psp_tasks`
--
ALTER TABLE `psp_tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `task_status`
--
ALTER TABLE `task_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT tabele `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT tabele `users_confirmations`
--
ALTER TABLE `users_confirmations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `users_remembered`
--
ALTER TABLE `users_remembered`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT tabele `users_resets`
--
ALTER TABLE `users_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Omejitve tabel za povzetek stanja
--

--
-- Omejitve za tabelo `organisations`
--
ALTER TABLE `organisations`
  ADD CONSTRAINT `fk_organisations_fk1` FOREIGN KEY (`idLeader`) REFERENCES `users` (`id`);

--
-- Omejitve za tabelo `organisationsusers`
--
ALTER TABLE `organisationsusers`
  ADD CONSTRAINT `organisationsusers_ibfk_1` FOREIGN KEY (`idOrganisation`) REFERENCES `organisations` (`id`),
  ADD CONSTRAINT `organisationsusers_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

--
-- Omejitve za tabelo `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`idOrganisation`) REFERENCES `organisations` (`id`);

--
-- Omejitve za tabelo `psp_errors`
--
ALTER TABLE `psp_errors`
  ADD CONSTRAINT `psp_errors_ibfk_1` FOREIGN KEY (`idCategory`) REFERENCES `psp_errors_categories` (`id`),
  ADD CONSTRAINT `psp_errors_ibfk_2` FOREIGN KEY (`phaseEntry`) REFERENCES `psp_phases` (`id`),
  ADD CONSTRAINT `psp_errors_ibfk_3` FOREIGN KEY (`phaseFinish`) REFERENCES `psp_phases` (`id`),
  ADD CONSTRAINT `psp_errors_ibfk_4` FOREIGN KEY (`idPSP`) REFERENCES `psps` (`id`);

--
-- Omejitve za tabelo `psp_tasks`
--
ALTER TABLE `psp_tasks`
  ADD CONSTRAINT `psp_tasks_ibfk_1` FOREIGN KEY (`idPhase`) REFERENCES `psp_phases` (`id`),
  ADD CONSTRAINT `psp_tasks_ibfk_2` FOREIGN KEY (`idPSP`) REFERENCES `psps` (`id`);

--
-- Omejitve za tabelo `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`idProject`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`idTask_status`) REFERENCES `task_status` (`id`);

--
-- Omejitve za tabelo `tasksusersprojects`
--
ALTER TABLE `tasksusersprojects`
  ADD CONSTRAINT `tasksusersprojects_ibfk_1` FOREIGN KEY (`idTask`) REFERENCES `tasks` (`id`),
  ADD CONSTRAINT `tasksusersprojects_ibfk_2` FOREIGN KEY (`idPSP`) REFERENCES `psps` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tasksusersprojects_ibfk_3` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

--
-- Omejitve za tabelo `userprojects`
--
ALTER TABLE `userprojects`
  ADD CONSTRAINT `userprojects_ibfk_1` FOREIGN KEY (`idProject`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `userprojects_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

--
-- Omejitve za tabelo `user_psp_data`
--
ALTER TABLE `user_psp_data`
  ADD CONSTRAINT `user_psp_data_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
