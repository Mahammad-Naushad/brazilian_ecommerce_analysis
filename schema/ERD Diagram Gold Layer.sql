CREATE TABLE `dim_customer` (
  `customer_id` string PRIMARY KEY,
  `customer_unique_id` string,
  `customer_state` string,
  `customer_city` string,
  `customer_zip_code_prefix` bigint,
  `customer_lat` double,
  `customer_long` double,
  `_ingested_at` timestamp,
  `_source_file` string
);

CREATE TABLE `dim_product` (
  `product_id` string PRIMARY KEY,
  `product_photos_qty` bigint,
  `product_weight_g` bigint,
  `product_length_cm` bigint,
  `product_height_cm` bigint,
  `product_width_cm` bigint,
  `product_category` string,
  `_ingested_at` timestamp,
  `_source_file` string
);

CREATE TABLE `dim_seller` (
  `seller_id` string PRIMARY KEY,
  `seller_zip_code_prefix` bigint,
  `seller_state` string,
  `seller_city` string,
  `seller_lat` double,
  `seller_long` double,
  `_ingested_at` timestamp,
  `_source_file` string
);

CREATE TABLE `fact_sales` (
  `order_id` string,
  `customer_id` string,
  `product_id` string,
  `seller_id` string,
  `order_status` string,
  `item_revenue` double,
  `item_freight` double,
  `item_total_value` double,
  `item_quantity` bigint,
  `total_order_payment_value` double,
  `total_unique_payment_types` bigint,
  `payment_types_list` string,
  `max_payment_installments` bigint,
  `_ingested_at` timestamp,
  `_source_file` string
);

CREATE TABLE `fact_reviews` (
  `review_id` string PRIMARY KEY,
  `order_id` string,
  `customer_id` string,
  `order_status` string,
  `review_score` bigint,
  `review_comment_title` string,
  `review_comment_message` string,
  `review_creation_date` timestamp,
  `review_answer_timestamp` timestamp,
  `has_review_commnents` boolean,
  `_ingested_at` timestamp,
  `_source_file` string
);

CREATE UNIQUE INDEX `fact_sales_index_0` ON `fact_sales` (`order_id`, `product_id`, `seller_id`);

ALTER TABLE `fact_sales` ADD FOREIGN KEY (`customer_id`) REFERENCES `dim_customer` (`customer_id`);

ALTER TABLE `fact_sales` ADD FOREIGN KEY (`product_id`) REFERENCES `dim_product` (`product_id`);

ALTER TABLE `fact_sales` ADD FOREIGN KEY (`seller_id`) REFERENCES `dim_seller` (`seller_id`);

ALTER TABLE `fact_reviews` ADD FOREIGN KEY (`customer_id`) REFERENCES `dim_customer` (`customer_id`);
