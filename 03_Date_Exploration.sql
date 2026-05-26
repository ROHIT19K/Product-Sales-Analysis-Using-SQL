
USE DataWarehouseAnalytics;

select * from gold.dim_products

select * from gold.dim_customers;

select * from gold.fact_sales;


select order_date from gold.fact_sales;

select 
MIN(order_date) AS first_order_date
from gold.fact_sales

select 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date
from gold.fact_sales

select 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years
from gold.fact_sales

select 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
from gold.fact_sales

select 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(DAY, MIN(order_date), MAX(order_date)) AS order_range_days
from gold.fact_sales


--------------------------------------------------------------------------

select * from gold.dim_customers;

SELECT 
MIN(birthdate) AS oldest_birthdate,
MAX(birthdate) AS youngest_birthdate
FROM gold.dim_customers;

SELECT 
MIN(birthdate) AS oldest_birthdate,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age_of_customers,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age_of_customers
FROM gold.dim_customers;