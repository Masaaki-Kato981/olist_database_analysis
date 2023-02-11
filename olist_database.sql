 CREATE DATABASE olist;

\c olist;

CREATE TABLE IF NOT EXISTS customers (
  customer_id VARCHAR PRIMARY KEY,
  customer_unique_id VARCHAR,
  customer_zip_code_prefix INT,
  customer_city VARCHAR,
  customer_state VARCHAR
);

CREATE TABLE IF NOT EXISTS sellers (
    seller_id VARCHAR PRIMARY KEY,
    seller_zip_code_prefix VARCHAR,
    seller_city VARCHAR,
    seller_state VARCHAR
);

CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    CONSTRAINT fk_customer FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS order_reviews (
    review_id VARCHAR,
    order_id VARCHAR,
    review_score INT,
    review_comment_title VARCHAR,
    review_comment_message VARCHAR,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    PRIMARY KEY (review_id, order_id),
    CONSTRAINT fk_order FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

CREATE TABLE IF NOT EXISTS product_categories (
    product_category_name VARCHAR PRIMARY KEY,
    product_category_name_english VARCHAR
);

CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

CREATE TABLE IF NOT EXISTS order_items (
    order_id VARCHAR,
    order_item_id INT,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT,
    PRIMARY KEY (order_id, order_item_id),
    CONSTRAINT fk_order FOREIGN KEY(order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_product FOREIGN KEY(product_id) REFERENCES products(product_id),
    CONSTRAINT fk_seller FOREIGN KEY(seller_id) REFERENCES sellers(seller_id)
);

CREATE TABLE IF NOT EXISTS order_payments (
    order_id VARCHAR,
    payment_sequential INT,
    payment_type VARCHAR,
    payment_installations INT,
    payment_value FLOAT,
    PRIMARY KEY (order_id, payment_sequential),
    CONSTRAINT fk_order FOREIGN KEY(order_id) REFERENCES orders(order_id)
);



CREATE TABLE IF NOT EXISTS mqls (
    mql_id VARCHAR PRIMARY KEY,
    first_contact_date TIMESTAMP,
    landing_page_id VARCHAR,
    origin VARCHAR
);

CREATE TABLE IF NOT EXISTS closed_deals (
    mql_id VARCHAR PRIMARY KEY,
    seller_id VARCHAR,
    sdr_id VARCHAR,
    sr_id VARCHAR,
    won_date TIMESTAMP,
    business_segment VARCHAR,
    lead_type VARCHAR,
    lead_behaviour_profile VARCHAR,
    has_company VARCHAR,
    has_gtin VARCHAR,
    average_stock VARCHAR,
    business_type VARCHAR,
    declared_product_catalog_size NUMERIC,
    declared_monthly_revenue NUMERIC,
    CONSTRAINT fk_mql FOREIGN KEY (mql_id) REFERENCES mqls(mql_id)
);


COPY customers(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
FROM '/Users/Shared/olist_data/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY sellers(seller_id, seller_zip_code_prefix, seller_city, seller_state)
FROM '/Users/Shared/olist_data/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY product_categories(product_category_name, product_category_name_english)
FROM '/Users/Shared/olist_data/product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;

COPY orders(order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date)
FROM '/Users/Shared/olist_data/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY order_reviews(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp)
FROM '/Users/Shared/olist_data/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY products(product_id, product_category_name, product_name_length, product_description_length, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
FROM '/Users/Shared/olist_data/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY order_items(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
FROM '/Users/Shared/olist_data/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY order_payments(order_id, payment_sequential, payment_type, payment_installations, payment_value)
FROM '/Users/Shared/olist_data/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY mqls(mql_id, first_contact_date, landing_page_id, origin)
FROM '/Users/Shared/olist_data/olist_marketing_qualified_leads_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY closed_deals(mql_id, seller_id, sdr_id, sr_id, won_date, business_segment, lead_type, lead_behaviour_profile, has_company, has_gtin, average_stock, business_type, declared_product_catalog_size, declared_monthly_revenue)
FROM '/Users/Shared/olist_data/olist_closed_deals_dataset.csv'
DELIMITER ','
CSV HEADER;



