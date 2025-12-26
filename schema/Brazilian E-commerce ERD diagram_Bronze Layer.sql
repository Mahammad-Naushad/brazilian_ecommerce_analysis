CREATE TABLE `customers` (
  `customer_id` varchar(255) PRIMARY KEY,
  `customer_unique_id` varchar(255),
  `customer_zip_code_prefix` int,
  `customer_city` varchar(255),
  `customer_state` varchar(255)
);

CREATE TABLE `orders` (
  `order_id` varchar(255) PRIMARY KEY,
  `customer_id` varchar(255),
  `order_status` varchar(255),
  `order_purchase_timestamp` timestamp,
  `order_approved_at` timestamp,
  `order_delivered_carrier_date` timestamp,
  `order_delivered_customer_date` timestamp,
  `order_estimated_delivery_date` timestamp
);

CREATE TABLE `order_items` (
  `order_id` varchar(255),
  `order_item_id` int,
  `product_id` varchar(255),
  `seller_id` varchar(255),
  `shipping_limit_date` timestamp,
  `price` decimal,
  `freight_value` decimal
);

CREATE TABLE `order_payments` (
  `order_id` varchar(255),
  `payment_sequential` int,
  `payment_type` varchar(255),
  `payment_installments` int,
  `payment_value` decimal
);

CREATE TABLE `order_reviews` (
  `review_id` varchar(255) PRIMARY KEY,
  `order_id` varchar(255),
  `review_score` int,
  `review_comment_title` varchar(255),
  `review_comment_message` varchar(255),
  `review_creation_date` timestamp,
  `review_answer_timestamp` timestamp
);

CREATE TABLE `products` (
  `product_id` varchar(255) PRIMARY KEY,
  `product_category_name` varchar(255),
  `product_name_lenght` int,
  `product_description_lenght` int,
  `product_photos_qty` int,
  `product_weight_g` int,
  `product_length_cm` int,
  `product_height_cm` int,
  `product_width_cm` int
);

CREATE TABLE `product_category_name_translation` (
  `product_category_name` varchar(255) PRIMARY KEY,
  `product_category_name_english` varchar(255)
);

CREATE TABLE `sellers` (
  `seller_id` varchar(255) PRIMARY KEY,
  `seller_zip_code_prefix` int,
  `seller_city` varchar(255),
  `seller_state` varchar(255)
);

CREATE TABLE `geolocation_details` (
  `geolocation_zip_code_prefix` int,
  `geolocation_lat` decimal,
  `geolocation_lng` decimal,
  `geolocation_city` varchar(255),
  `geolocation_state` varchar(255)
);

CREATE UNIQUE INDEX `order_items_index_0` ON `order_items` (`order_id`, `order_item_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`seller_id`);

ALTER TABLE `order_payments` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `order_reviews` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`product_category_name`) REFERENCES `product_category_name_translation` (`product_category_name`);

ALTER TABLE `customers` ADD FOREIGN KEY (`customer_zip_code_prefix`) REFERENCES `geolocation_details` (`geolocation_zip_code_prefix`);

ALTER TABLE `sellers` ADD FOREIGN KEY (`seller_zip_code_prefix`) REFERENCES `geolocation_details` (`geolocation_zip_code_prefix`);
