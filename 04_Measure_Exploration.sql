
USE DataWarehouseAnalytics;

select * from gold.dim_products

select * from gold.dim_customers;

select * from gold.fact_sales;

select 
SUM(sales_amount) AS Total_Sales
FROM gold.fact_sales;

SELECT 
SUM(quantity) as Total_quantity
FROM gold.fact_sales;

SELECT 
AVG(price) as avg_price
FROM gold.fact_sales;
 
select 
COUNT(order_number) as Total_Orders
FROM gold.fact_sales

select 
COUNT(DISTINCT order_number) as Dintinct_order_number
FROM gold.fact_sales

select 
COUNT(product_key) as Total_Products
FROM gold.dim_products

select 
COUNT(DISTINCT product_key) as Total_Products
FROM gold.dim_products


select 
COUNT(product_name) as Total_Products_Name
FROM gold.dim_products


select 
COUNT(DISTINCT product_name) as Total_Products_Name
FROM gold.dim_products


select 
COUNT(customer_key) as total_customers
FROM gold.dim_customers

select 
COUNT(DISTINCT customer_key) as total_customers
FROM gold.fact_sales

--- Generate a Report that show all the key metrics of the Business--

SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' as measure_name, SUM(quantity) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Avgerage Price' as measure_name, AVG(price) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders' as measure_name, COUNT(DISTINCT order_number) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products' as measure_name, COUNT(product_name) as measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers' as measure_name, COUNT(customer_key) as measure_value FROM gold.dim_customers