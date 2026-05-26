
USE DataWarehouseAnalytics;

select * from gold.dim_products

select * from gold.dim_customers;

select * from gold.fact_sales;

SELECT 
DISTINCT country
FROM gold.dim_customers;

SELECT 
DISTINCT category
FROM gold.dim_products;

SELECT 
DISTINCT category, subcategory, product_name
FROM gold.dim_products
ORDER BY 1,2,3 