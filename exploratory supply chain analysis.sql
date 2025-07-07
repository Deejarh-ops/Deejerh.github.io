-- Exploratory Analysis
 
-- Overall shipment performance
SELECT 
    COUNT(*) AS Total_Shipments,
    SUM(CASE WHEN Arrival_on_Time = 1 THEN 1 ELSE 0 END) AS On_Time_Deliveries,
    SUM(CASE WHEN Arrival_on_Time = 0 THEN 1 ELSE 0 END) AS Late_Deliveries,
    ROUND(SUM(CASE WHEN Arrival_on_Time = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS On_Time_Percentage,
    ROUND(SUM(CASE WHEN Arrival_on_Time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply;

-- Mode of Shipment VS Delivery Timeliness
SELECT 
    mode_of_shipment,
    COUNT(*) AS Total_Shipments,
    SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) AS Late_Shipments,
    ROUND(SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply
GROUP BY mode_of_shipment
ORDER BY Late_Percentage DESC;

-- Warehouse Block Performance
SELECT 
    warehouse_block,
    COUNT(*) AS Total_Shipments,
    ROUND(AVG(customer_rating), 2) AS Avg_Rating,
    ROUND(AVG(discount_offered), 2) AS Avg_Discount,
    ROUND(SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply
GROUP BY warehouse_block
ORDER BY Late_Percentage DESC;

-- Customer Rating VS On Time Delivery
SELECT 
    customer_rating,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) AS Late_Shipments,
    ROUND(SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply
GROUP BY customer_rating
ORDER BY customer_rating;

-- Product Importance VS Late Deliveries
SELECT 
    product_importance,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(cost_of_the_product), 2) AS Avg_Cost,
    ROUND(AVG(discount_offered), 2) AS Avg_Discount,
    ROUND(SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply
GROUP BY product_importance
ORDER BY Late_Percentage DESC;


-- Discount Offered VS On-Time Delivery
-- Grouping discount into buckets for easier analysis
SELECT 
    CASE 
        WHEN discount_offered < 5 THEN 'Low (0-4%)'
        WHEN discount_offered BETWEEN 5 AND 10 THEN 'Moderate (5-10%)'
        WHEN discount_offered BETWEEN 11 AND 20 THEN 'High (11-20%)'
        ELSE 'Very High (>20%)'
    END AS Discount_Band,
    COUNT(*) AS Shipments,
    ROUND(AVG(weight_in_gms), 0) AS Avg_Weight,
    ROUND(SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply
GROUP BY Discount_Band
ORDER BY Late_Percentage DESC;

-- Gender Based Shippinh Behaviour
SELECT 
    gender,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(prior_purchases), 2) AS Avg_Prior_Purchases,
    ROUND(AVG(cost_of_the_product), 2) AS Avg_Product_Cost,
    ROUND(SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply
GROUP BY gender;

-- Weight VS Late Deliveries
-- Check if heavier products are delayed more

SELECT
    CASE 
        WHEN weight_in_gms < 1000 THEN 'Light (<1kg)'
        WHEN weight_in_gms BETWEEN 1000 AND 3000 THEN 'Medium (1–3kg)'
        ELSE 'Heavy (>3kg)'
    END AS Weight_Category,
    COUNT(*) AS Orders,
    ROUND(SUM(CASE WHEN arrival_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM work_supply
GROUP BY Weight_Category
ORDER BY Late_Percentage DESC;

Select * From work_supply;