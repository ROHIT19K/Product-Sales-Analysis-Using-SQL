

USE DataWarehouseAnalytics;

select * from gold.dim_products

select * from gold.dim_customers;

select * from gold.fact_sales;


select TOP 5
p.product_name,
SUM(f.sales_amount) as total_revenue
from gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
order by total_revenue DESC


select TOP 5
p.product_name,
SUM(f.sales_amount) as total_revenue
from gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
order by total_revenue ASC


select TOP 5
p.subcategory,
SUM(f.sales_amount) as total_revenue
from gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.subcategory
order by total_revenue DESC


select TOP 5
p.subcategory,
SUM(f.sales_amount) as total_revenue
from gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.subcategory
order by total_revenue ASC


SELECT * 
FROM (
	select 
	p.product_name,
	SUM(f.sales_amount) as total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_product
	from gold.fact_sales f
	LEFT JOIN gold.dim_products p 
	ON p.product_key = f.product_key
	GROUP BY p.product_name) t
WHERE rank_product <= 5




SELECT TOP 10 
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
group by c.customer_key, c.first_name, c.last_name
order by total_revenue DESC



SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) as total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
group by c.customer_key, c.first_name, c.last_name
order by total_orders 
