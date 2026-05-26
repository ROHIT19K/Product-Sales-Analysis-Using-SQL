
USE DataWarehouseAnalytics;

select 
category,
sales_amount
from gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key



WITH category_sales AS (
select 
category,
sum(sales_amount) as total_sales
from gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY category
)

select 
category, 
total_sales,
SUM(total_sales) OVER () overall_total_sales,
CONCAT(ROUND((CAST (total_sales as float)  /  SUM(total_sales)  over () ) * 100, 2), '%') AS  percentage_of_total
from category_sales 
ORDER BY total_sales DESC