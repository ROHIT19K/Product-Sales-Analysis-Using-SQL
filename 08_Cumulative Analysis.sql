
USE DataWarehouseAnalytics;

select 
DATETRUNC(MONTH, order_date) AS order_date, SUM(sales_amount) as total_sales
from gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date)




Select order_date, total_sales,
SUM(total_sales) over (ORDER BY order_date) AS running_total_sales
FROM 
(
select 
DATETRUNC(MONTH, order_date) AS order_date, SUM(sales_amount) as total_sales
from gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
) t



Select order_date, total_sales,
SUM(total_sales) over (partition by order_date ORDER BY order_date) AS running_total_sales
FROM 
(
select 
DATETRUNC(MONTH, order_date) AS order_date, SUM(sales_amount) as total_sales
from gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
) t


Select order_date, total_sales,
SUM(total_sales) over (ORDER BY order_date) AS running_total_sales
FROM 
(
select 
DATETRUNC(YEAR, order_date) AS order_date, SUM(sales_amount) as total_sales
from gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
) t





Select order_date, total_sales,
SUM(total_sales) over (partition by order_date ORDER BY order_date) AS running_total_sales
FROM 
(
select 
DATETRUNC(YEAR, order_date) AS order_date, SUM(sales_amount) as total_sales
from gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
) t




Select order_date, total_sales, 
SUM(total_sales) over (ORDER BY order_date) AS running_total_sales,
AVG(avg_price) over (ORDER BY order_date) AS moving_averag_price
FROM 
(
select 
DATETRUNC(YEAR, order_date) AS order_date, SUM(sales_amount) as total_sales,
AVG(price) as avg_price
from gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
) t



Select order_date, total_sales, avg_price,
SUM(total_sales) over (ORDER BY order_date) AS running_total_sales,
AVG(avg_price) over (ORDER BY order_date) AS moving_averag_price
FROM 
(
select 
DATETRUNC(YEAR, order_date) AS order_date, SUM(sales_amount) as total_sales,
AVG(price) as avg_price
from gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
) t
