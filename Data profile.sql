CREATE TABLE inventory_logs (
    log_id VARCHAR(20) PRIMARY KEY,
    product_id VARCHAR(20),
    timestamp VARCHAR(50),  -- will be cleaned later
    change_type VARCHAR(50),
    quantity_changed INT,
    stock_after_change FLOAT,
    log_notes TEXT
);

CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    is_popular_product BOOLEAN,
    brand_name VARCHAR(100),
    product_name VARCHAR(255),
    category VARCHAR(100),
    supplier_id VARCHAR(20),
    description TEXT,
    base_price VARCHAR(50),  -- inconsistent format, clean later
    currency VARCHAR(10),
    product_attributes TEXT,
    unit_of_measure VARCHAR(50),
    stock_quantity VARCHAR(50),  -- inconsistent format, clean later
    date_added VARCHAR(50),  -- will be cleaned
    last_updated_date VARCHAR(50),  -- will be cleaned
    is_active VARCHAR(10)  -- will be cleaned to boolean
);

CREATE TABLE suppliers (
    supplier_id VARCHAR(20) PRIMARY KEY,
    supplier_name VARCHAR(255),
    contact_person VARCHAR(100),
    supplier_email VARCHAR(255),
    supplier_phone VARCHAR(50),
    supplier_address TEXT,
    country VARCHAR(100),
    supplier_registration_date VARCHAR(50),  -- will be cleaned
    preferred_supplier BOOLEAN
);

CREATE TABLE product_reviews (
    review_id VARCHAR(20) PRIMARY KEY,
    product_id VARCHAR(20),
    customer_id VARCHAR(50),
    reviewer_name VARCHAR(100),
    rating FLOAT,
    review_title VARCHAR(255),
    review_text TEXT,
    review_date VARCHAR(50),  -- will be cleaned
    is_verified_purchase VARCHAR(10),  -- can convert to boolean
    helpfulness_votes FLOAT
);

SHOW VARIABLES LIKE "secure_file_priv";

ALTER TABLE products
MODIFY COLUMN is_popular_product VARCHAR(10);

ALTER TABLE products
MODIFY COLUMN is_active VARCHAR(10);

ALTER TABLE suppliers
MODIFY COLUMN preferred_supplier VARCHAR(10);

ALTER TABLE product_reviews
MODIFY COLUMN helpfulness_votes FLOAT NULL;





LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv"
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/suppliers.csv"
INTO TABLE suppliers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_reviews.csv'
INTO TABLE product_reviews
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    review_id,
    product_id,
    customer_id,
    reviewer_name,
    @rating,
    review_title,
    review_text,
    review_date,
    is_verified_purchase,
    @helpfulness_votes
)
SET 
rating = CASE
    WHEN NULLIF(TRIM(@rating), '') IS NULL THEN NULL
    WHEN TRIM(@rating) REGEXP '^[0-9]+(\\.[0-9]+)?$' THEN CAST(TRIM(@rating) AS DECIMAL(3,1))
    ELSE NULL
END,
helpfulness_votes = CASE
    WHEN NULLIF(TRIM(@helpfulness_votes), '') IS NULL THEN NULL
    WHEN TRIM(@helpfulness_votes) REGEXP '^[0-9]+(\\.[0-9]+)?$' THEN CAST(TRIM(@helpfulness_votes) AS DECIMAL(10,2))
    ELSE NULL
END;







select* from product_reviews