
USE DataWarehouseAnalytics;

select * from gold.dim_products

select * from gold.dim_customers;

select * from gold.fact_sales;


-- Find the total Customers by Countries

Select 
country,
COUNT(customer_key) as total_customers
from gold.dim_customers
group by country
order by total_customers DESC


select 
gender, 
COUNT(customer_key) as total_customers
from gold.dim_customers
group by gender
order by total_customers DESC


SELECT 
category,
COUNT(product_key) as total_products
FROM gold.dim_products
group by category
order by total_products DESC


select 
category,
AVG(cost) as avg_cost
from gold.dim_products
group by category
order by avg_cost DESC


select 
p.category,
SUM(f.sales_amount) AS total_revenue
from gold.fact_sales f
LEFT JOIN gold.dim_products p  
ON p.product_key = f.product_key 
group by p.category
order by total_revenue DESC

SELECT 
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
group by c.customer_key, c.first_name, c.last_name
order by total_revenue DESC


select 
c.country,
SUM(f.quantity) as total_sold_item
from gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
group by c.country
order by total_sold_item DESC