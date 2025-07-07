-- Inspect the Raw Table
Select *
From commerce_data
Limit 10;
-- Create Work Table 

Create table E_commerce  
Like commerce_data;
 
Select *
From e_commerce;

Insert e_commerce
Select *
From commerce_data;

-- Check For Nulls
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS null_invoice,
    SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS null_stockcode,
    SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS null_description,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS null_invoicedate,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS null_unitprice,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customerid,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS null_country
FROM e_commerce;

-- Remove Canceled Orders
CREATE TABLE clean_ecommerce_data AS
SELECT *
FROM e_commerce
WHERE InvoiceNo NOT LIKE 'C%';

Select *
From clean_ecommerce_data;

-- Remove Nulls and Invalids 
CREATE TABLE clean_ecommerce_data_final AS
SELECT *
FROM clean_ecommerce_data
WHERE 
    CustomerID IS NOT NULL 
    AND Quantity > 0
    AND UnitPrice > 0;
    
Select * 
From clean_ecommerce_data_final;



-- Add Total Price Column

ALTER TABLE clean_ecommerce_data_final
ADD COLUMN TotalPrice DECIMAL(10,2);

UPDATE clean_ecommerce_data_final
SET TotalPrice = Quantity * UnitPrice;

-- EXPLORATORY ANALYSIS 
-- * Total Sales by Country
SELECT Country, ROUND(SUM(TotalPrice), 2) AS TotalSales
FROM clean_ecommerce_data_final
GROUP BY Country
ORDER BY TotalSales DESC;

-- Top 10 Product by Revenue 
SELECT Description, ROUND(SUM(TotalPrice), 2) AS Revenue
FROM clean_ecommerce_data_final
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 10;

-- Purchase Trends by Hour
SELECT 
    EXTRACT(HOUR FROM InvoiceDate) AS HourOfDay,
    COUNT(*) AS TotalPurchases
FROM clean_ecommerce_data_final
GROUP BY HourOfDay
ORDER BY HourOfDay;

-- Return Rate by Country

SELECT Country,
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0 END) AS ReturnOrders,
    ROUND(100.0 * SUM(CASE WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ReturnRatePercent
FROM clean_ecommerce_data_final
GROUP BY Country
ORDER BY ReturnRatePercent DESC;

Select
    ROW_NUMBER() OVER (ORDER BY InvoiceDate) AS SerialNumber

FROM clean_ecommerce_data_final;

Select * 
From clean_ecommerce_data_final;