
USE DataWarehouseAnalytics;


---------------- TASK ONE ------------------------


WITH product_segments AS (
select 
product_key,
product_name, 
cost,
CASE WHEN cost < 100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	 ELSE 'Above 1000'
END cost_range
from gold.dim_products
)

select 
cost_range,
COUNT(product_key) AS total_products
from product_segments
GROUP BY cost_range
ORDER BY total_products DESC


------------------------- TASK TWO --------------------------------

WITH customer_spending AS (
select 
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF (month, MIN(order_date), MAX(order_date)) AS lifespan
from gold.fact_sales f
LEFT JOIN gold.dim_customers c
on f.customer_key = c.customer_key
GROUP BY c.customer_key
)


select 
customer_segment,
count(customer_key) AS total_customers
from (
		select 
		customer_key, 
		CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
			 WHEN lifespan <=12 AND total_spending <= 5000 THEN 'Regular'
			 ELSE 'New'
		END  Customer_segment
		FROM customer_spending) t
GROUP BY customer_segment
order by total_customers DESC
