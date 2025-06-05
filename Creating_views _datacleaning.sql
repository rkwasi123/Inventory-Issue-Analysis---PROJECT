-- RUN PROJECT: 
-- ====================================

-- STEP 1: CREATE CLEANING VIEWS
-- ====================================

-- CLEAN INVENTORY LOGS and standardizing timestamp
CREATE OR REPLACE VIEW clean_inventory_logs AS
SELECT 
    log_id,
    product_id,
    CASE
        WHEN timestamp LIKE '__/__/____%' THEN
            STR_TO_DATE(timestamp, '%m/%d/%Y %H:%i:%s')
        WHEN timestamp LIKE '____-__-__%' THEN
            STR_TO_DATE(timestamp, '%Y-%m-%d %H:%i:%s')
        ELSE NULL
    END AS clean_timestamp,
    change_type,
    quantity_changed,
    stock_after_change,
    NULLIF(log_notes, '') AS clean_log_notes
FROM inventory_logs;

-- CLEAN PRODUCTS
CREATE OR REPLACE VIEW clean_products AS
SELECT 
    product_id,
    product_name,
    brand_name,
    category,
    supplier_id,
    CASE
        WHEN date_added LIKE '__/__/____' THEN
            STR_TO_DATE(date_added, '%m/%d/%Y')
        WHEN date_added LIKE '____-__-__' THEN
            STR_TO_DATE(date_added, '%Y-%m-%d')
        ELSE NULL
    END AS clean_date_added,
    CASE
        WHEN last_updated_date LIKE '__/__/____%' THEN
            STR_TO_DATE(last_updated_date, '%m/%d/%Y %H:%i:%s')
        WHEN last_updated_date LIKE '____-__-__%' THEN
            STR_TO_DATE(last_updated_date, '%Y-%m-%d %H:%i:%s')
        ELSE NULL
    END AS clean_last_updated_date,
    NULLIF(currency, '') AS clean_currency,
    NULLIF(is_active, '') AS clean_is_active,
    is_popular_product,
    description,
    product_attributes,
    unit_of_measure,
    stock_quantity
FROM products;

-- ====================================
-- STEP 2: FINAL INVENTORY ANALYSIS QUERY
-- ====================================

CREATE OR REPLACE VIEW final_inventory_analysis AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COUNT(CASE WHEN i.change_type = 'inventory_adjustment_manual' THEN 1 END) AS manual_adjustments,
    COUNT(CASE WHEN i.stock_after_change = 0 THEN 1 END) AS stockouts,
    COUNT(i.log_id) AS total_inventory_changes
FROM clean_inventory_logs i
JOIN clean_products p ON i.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_inventory_changes DESC;

select* from final_inventory_analysis

