
USE DataWarehouseAnalytics;


/* CHANGES OVER TIME  */

Select order_date, sum(sales_amount) as total_sales 
from gold.fact_sales
where order_date is not null
group by order_date
order by order_date  


Select YEAR(order_date) as order_year, SUM(sales_amount) as total_sales 
from gold.fact_sales
where order_date is not null
group by YEAR(order_date)
order by YEAR(order_date) 


Select YEAR(order_date) as order_year, SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers
from gold.fact_sales
where order_date is not null
group by YEAR(order_date)
order by YEAR(order_date) 


Select YEAR(order_date) as order_year, SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers, SUM(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by YEAR(order_date)
order by YEAR(order_date) 


Select MONTH(order_date) as order_year, SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers, SUM(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by MONTH(order_date)
order by MONTH(order_date) 


Select
YEAR(order_date) as order_year,
MONTH(order_date) as order_month, 
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers, 
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by YEAR(order_date), MONTH(order_date)
order by YEAR(order_date), MONTH(order_date) 


Select
DATETRUNC(MONTH, order_date) as order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers, 
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by DATETRUNC(MONTH, order_date)
order by DATETRUNC(MONTH, order_date)


Select
DATETRUNC(YEAR, order_date) as order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers, 
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by DATETRUNC(YEAR, order_date)
order by DATETRUNC(YEAR, order_date)


Select
FORMAT(order_date, 'yyyy-MMM') as order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers, 
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by FORMAT(order_date, 'yyyy-MMM')
order by FORMAT(order_date, 'yyyy-MMM')


