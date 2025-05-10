-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 10, 2025 at 12:25 PM
-- Server version: 8.0.42
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chillspace`
--

-- --------------------------------------------------------

--
-- Table structure for table `cartitem`
--

CREATE TABLE `cartitem` (
  `cart_item_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price_at_addition` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cartitem`
--

INSERT INTO `cartitem` (`cart_item_id`, `product_id`, `quantity`, `price_at_addition`) VALUES
(1, 1, 1, '1499850.00'),
(2, 2, 1, '299850.00');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Dorm Essentials'),
(2, 'Study Supplies'),
(3, 'Furniture'),
(4, 'Electronics'),
(5, 'Dorm Essentials'),
(6, 'Study Supplies'),
(7, 'Furniture'),
(8, 'Electronics');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  `transaction_type` enum('incoming','outgoing','return') NOT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `location_id`, `stock_quantity`, `transaction_type`, `transaction_date`, `remarks`) VALUES
(1, 1, 1, 50, 'incoming', '2025-05-10 19:11:35', 'Initial stock at Education Park'),
(2, 2, 2, 100, 'incoming', '2025-05-10 19:11:35', 'Initial stock at Beverly Hills');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int NOT NULL,
  `location_name` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `location_name`, `latitude`, `longitude`, `address`) VALUES
(1, 'Education Park, President University Student Housing', NULL, NULL, 'Jl. Ki Hajar Dewantara, Simpangan, Kec. Cikarang Utara, Kabupaten Bekasi, Jawa Barat 17530'),
(2, 'Beverly Hills', NULL, NULL, 'P528+RHG, Jl. Movie Land, Mekarmukti, Kec. Cikarang Utara, Kabupaten Bekasi, Jawa Barat 17530'),
(3, 'Others', NULL, NULL, 'Other locations across various cities');

-- --------------------------------------------------------

--
-- Table structure for table `orderitem`
--

CREATE TABLE `orderitem` (
  `order_item_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price_at_purchase` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orderitem`
--

INSERT INTO `orderitem` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price_at_purchase`) VALUES
(1, 1, 1, 1, '1499850.00'),
(2, 1, 2, 1, '299850.00'),
(3, 1, 3, 1, '179850.00'),
(4, 1, 4, 1, '89950.00'),
(5, 1, 6, 1, '194850.00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('Pending','Paid','Shipped') NOT NULL,
  `payment_status` enum('Pending','Completed','Failed') NOT NULL,
  `receipt_number` varchar(255) DEFAULT NULL,
  `receipt_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_amount`, `status`, `payment_status`, `receipt_number`, `receipt_date`) VALUES
(1, 1, '2025-05-10 19:10:50', '3899350.00', 'Paid', 'Completed', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `payment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `payment_status` enum('Pending','Completed','Failed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `order_id`, `payment_method`, `payment_date`, `amount_paid`, `payment_status`) VALUES
(1, 1, 'Credit Card', '2025-05-10 19:11:46', '3899350.00', 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `product_details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `name`, `description`, `price`, `stock_quantity`, `category_id`, `image_url`, `product_details`) VALUES
(1, 'Bedding Set', 'Comfortable bedding set for dorm room, includes pillow, blanket, and sheets', '1499850.00', 50, 1, 'image_url_1', 'Details about Bedding Set'),
(2, 'Study Desk Lamp', 'Adjustable LED desk lamp with touch control, perfect for late-night studying', '299850.00', 100, 2, 'image_url_2', 'Details about Desk Lamp'),
(3, 'Desk Organizer', 'Compact and functional desk organizer for keeping your study space tidy', '179850.00', 150, 2, 'image_url_3', 'Details about Desk Organizer'),
(4, 'Notebooks (Pack of 5)', 'Set of 5 notebooks for taking lecture notes, college-ruled paper', '89950.00', 300, 2, 'image_url_4', 'Details about Notebook Pack'),
(5, 'Storage Box', 'Multi-purpose storage box for organizing dorm room essentials', '359850.00', 120, 1, 'image_url_5', 'Details about Storage Box'),
(6, 'USB Flash Drive', '16GB USB flash drive for storing documents, projects, and study materials', '194850.00', 120, 4, 'image_url_6', 'Details about USB Flash Drive'),
(7, 'Mini Refrigerator', 'Compact refrigerator for dorm rooms, ideal for storing snacks and drinks', '2499850.00', 30, 3, 'image_url_7', 'Details about Mini Refrigerator'),
(8, 'Bedding Set', 'Comfortable bedding set for dorm room, includes pillow, blanket, and sheets', '1499850.00', 50, 1, 'image_url_1', 'Details about Bedding Set'),
(9, 'Study Desk Lamp', 'Adjustable LED desk lamp with touch control, perfect for late-night studying', '299850.00', 100, 2, 'image_url_2', 'Details about Desk Lamp'),
(10, 'Desk Organizer', 'Compact and functional desk organizer for keeping your study space tidy', '179850.00', 150, 2, 'image_url_3', 'Details about Desk Organizer'),
(11, 'Notebooks (Pack of 5)', 'Set of 5 notebooks for taking lecture notes, college-ruled paper', '89950.00', 300, 2, 'image_url_4', 'Details about Notebook Pack'),
(12, 'Storage Box', 'Multi-purpose storage box for organizing dorm room essentials', '359850.00', 120, 1, 'image_url_5', 'Details about Storage Box'),
(13, 'USB Flash Drive', '16GB USB flash drive for storing documents, projects, and study materials', '194850.00', 120, 4, 'image_url_6', 'Details about USB Flash Drive'),
(14, 'Mini Refrigerator', 'Compact refrigerator for dorm rooms, ideal for storing snacks and drinks', '2499850.00', 30, 3, 'image_url_7', 'Details about Mini Refrigerator');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` text,
  `review_date` datetime DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `product_id`, `user_id`, `rating`, `comment`, `review_date`) VALUES
(1, 1, 1, 5, 'The bedding set is super comfortable and perfect for my dorm room!', '2025-05-10 19:11:13'),
(2, 2, 1, 4, 'Great desk lamp, but I wish it had more brightness settings.', '2025-05-10 19:11:13'),
(3, 3, 1, 5, 'The desk organizer helps keep my study space neat and tidy.', '2025-05-10 19:11:13'),
(4, 4, 1, 5, 'Notebooks are perfect for lecture notes, good quality paper.', '2025-05-10 19:11:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','buyer','seller','support') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role`) VALUES
(1, 'alice_smith', 'alice.smith@example.com', 'hashed_password', 'seller'),
(2, 'bob_jones', 'bob.jones@example.com', 'hashed_password', 'buyer'),
(3, 'jennie_kim', 'jennie.kim@example.com', 'hashed_password', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cartitem`
--
ALTER TABLE `cartitem`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cartitem`
--
ALTER TABLE `cartitem`
  MODIFY `cart_item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orderitem`
--
ALTER TABLE `orderitem`
  MODIFY `order_item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cartitem`
--
ALTER TABLE `cartitem`
  ADD CONSTRAINT `cartitem_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE CASCADE;

--
-- Constraints for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
