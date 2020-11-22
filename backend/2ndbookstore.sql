-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2020 at 07:32 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `2ndbookstore`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_uploadBookAndItsImages` (IN `bookJSON` JSON)  NO SQL
BEGIN	
    DECLARE title VARCHAR(200);
    DECLARE book_condition VARCHAR(1000);
    DECLARE price DOUBLE;
    DECLARE negotiable tinyint(1);
    DECLARE owner_id VARCHAR(50);
    
    DECLARE book_id INT;
    DECLARE images_urls JSON;
    DECLARE counter INT;
    DECLARE arr_index VARCHAR(5);
    DECLARE tmp INT;
    
    SET title = JSON_UNQUOTE(JSON_EXTRACT(bookJSON,'$.title'));
    SET book_condition = JSON_UNQUOTE(JSON_EXTRACT(bookJSON,'$.book_condition'));
    SET price = JSON_UNQUOTE(JSON_EXTRACT(bookJSON,'$.price'));
    SET negotiable = JSON_UNQUOTE(JSON_EXTRACT(bookJSON,'$.negotiable'));
    SET owner_id = JSON_UNQUOTE(JSON_EXTRACT(bookJSON,'$.owner_id'));
   
    INSERT INTO `books`(`title`, `book_condition`, `price`, `negotiable`, `owner_id`) 
    VALUES (title, book_condition, price, negotiable, owner_id);
    
    SET images_urls = JSON_EXTRACT(bookJSON,'$.images_urls');
    SET book_id = (SELECT MAX(id) FROM books);
    SET tmp = 1;
    SET counter = 0;
    WHILE counter < JSON_LENGTH(images_urls) DO
        SET arr_index := CONCAT('$[', counter, ']');
        SET counter = counter + 1;
        INSERT INTO `book_images_urls`(`image_url`, `book_id`, `isThumbnail`) VALUES (JSON_UNQUOTE(JSON_EXTRACT(images_urls, arr_index)), book_id, tmp);
        SET tmp = 0;
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `book_condition` varchar(1000) NOT NULL,
  `price` double NOT NULL,
  `negotiable` tinyint(1) NOT NULL DEFAULT 0,
  `owner_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `book_condition`, `price`, `negotiable`, `owner_id`) VALUES
(13, 'Couch', 'Stupid Couch!', 54, 1, 'VOsuayoJ9IVFQL79oB6B8aGdVlr2'),
(14, 'Up', 'uupupupupupupupupup', 33, 0, 'VOsuayoJ9IVFQL79oB6B8aGdVlr2'),
(17, 'Ground', 'What Amazing!!', 88, 0, 'QM4wnDOyO7PSHE5ua1HlfPK66EK2');

-- --------------------------------------------------------

--
-- Table structure for table `book_images_urls`
--

CREATE TABLE `book_images_urls` (
  `id` int(11) NOT NULL,
  `image_url` varchar(150) NOT NULL,
  `book_id` int(11) NOT NULL,
  `isThumbnail` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book_images_urls`
--

INSERT INTO `book_images_urls` (`id`, `image_url`, `book_id`, `isThumbnail`) VALUES
(16, 'https://firebasestorage.googleapis.com/v0/b/bookstoretrial1.appspot.com/o/1605857655046?alt=media&token=eac558e4-d592-4164-a41c-153801972b0a', 13, 1),
(17, 'https://firebasestorage.googleapis.com/v0/b/bookstoretrial1.appspot.com/o/1605859065936?alt=media&token=2e9815b9-e6d6-4837-a6fc-f62da2bc33f6', 14, 1),
(18, 'https://firebasestorage.googleapis.com/v0/b/bookstoretrial1.appspot.com/o/1605932708383?alt=media&token=b2ca8e2d-e6d9-4284-bdce-65676f51f32c', 17, 1);

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `searches`
--

CREATE TABLE `searches` (
  `id` int(11) NOT NULL,
  `search_text` varchar(200) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `profile_image_url` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `firstname`, `lastname`, `profile_image_url`) VALUES
('QM4wnDOyO7PSHE5ua1HlfPK66EK2', ' ashrafmohamed.h1998@graduate.utm.my', '02468', 'Ashraf', 'Abdellatif', 'https://firebasestorage.googleapis.com/v0/b/bookstoretrial1.appspot.com/o/1603871097323?alt=media&token=0e53a3c2-73db-4969-9ed9-3c8ee3aeebdc'),
('VOsuayoJ9IVFQL79oB6B8aGdVlr2', 'hany212mohamed@gmail.com', '13579', 'Hany', 'Mohamed', 'https://firebasestorage.googleapis.com/v0/b/bookstoretrial1.appspot.com/o/1603871093151?alt=media&token=01ff9e72-a43a-414f-a559-94d1e53a746d');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_storepagebooks`
-- (See below for the actual view)
--
CREATE TABLE `vw_storepagebooks` (
`thumbnail_image` varchar(150)
,`title` varchar(200)
,`price` double
,`negotiable` tinyint(1)
,`num_of_likes` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_storepagebooks`
--
DROP TABLE IF EXISTS `vw_storepagebooks`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_storepagebooks`  AS  select `i`.`image_url` AS `thumbnail_image`,`b`.`title` AS `title`,`b`.`price` AS `price`,`b`.`negotiable` AS `negotiable`,count(`l`.`id`) AS `num_of_likes` from ((`books` `b` left join `book_images_urls` `i` on(`b`.`id` = `i`.`book_id` and `i`.`isThumbnail` = 1)) left join `likes` `l` on(`b`.`id` = `l`.`book_id`)) group by `b`.`id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_BookOwner` (`owner_id`);

--
-- Indexes for table `book_images_urls`
--
ALTER TABLE `book_images_urls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_BookImages` (`book_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_BookLike` (`book_id`),
  ADD KEY `FK_UserLike` (`user_id`);

--
-- Indexes for table `searches`
--
ALTER TABLE `searches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_UserSearch` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `book_images_urls`
--
ALTER TABLE `book_images_urls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `searches`
--
ALTER TABLE `searches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `FK_BookOwner` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `book_images_urls`
--
ALTER TABLE `book_images_urls`
  ADD CONSTRAINT `FK_BookImages` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `FK_BookLike` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `FK_BookLikes` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `FK_UserLike` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `searches`
--
ALTER TABLE `searches`
  ADD CONSTRAINT `FK_UserSearch` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
