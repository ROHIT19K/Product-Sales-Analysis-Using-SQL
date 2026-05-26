# 📊 Product Sales & Customer Analytics Using SQL

End-to-End SQL Data Analysis Project for analyzing Sales Performance, Customer Behavior, Product Insights, and Business KPIs using relational datasets.

## 📌 Project Overview

The Product Sales & Customer Analytics project focuses on analyzing retail business data using SQL to generate meaningful insights related to sales performance, customer behavior, product trends, and revenue analysis.

The project uses a relational data model consisting of:

* Customer Dimension Table
* Product Dimension Table
* Sales Fact Table

to perform advanced SQL analysis and business reporting.

The analysis demonstrates practical SQL skills used in real-world Data Analyst roles including:

Joins
CTEs
Window Functions
Aggregate Functions
Subqueries
CASE Statements
KPI Reporting

## 📌 Project Objective

The main objective of this project is to:

Analyze sales and revenue trends

Evaluate customer purchasing behavior

Identify high-performing products

Generate business KPIs

Perform relational database analysis

Build SQL-based business reports

## 🛠 Tools & Technologies

* SQL Server Management Studio (SSMS)

## Beginner Concepts :-

Database creation & table design

Data retrieval & filtering (SELECT, WHERE)

Aggregations (GROUP BY, HAVING, SUM, COUNT)

Multi-table JOINs

## Intermediate Concepts :-

Conditional logic (CASE WHEN, IF ELSE)

Date functions (YEAR, MONTH, QUARTER, DATEDIFF, DAYNAME, YEARWEEK)


## Advanced Concepts :-

Window functions (RANK, DENSE_RANK, ROW_NUMBER / LEAD, LAG for growth trends)

Common Table Expressions (CTEs, Recursive CTEs)

VIEW For Report Generating


## Business Insights KPIS 

1. Retrieve a list of unique countries from which customers originate

        SELECT DISTINCT 
            country 
        FROM gold.dim_customers
        ORDER BY country;

2. Retrieve a list of unique categories, subcategories, and products

        SELECT DISTINCT 
            category, 
            subcategory, 
            product_name 
        FROM gold.dim_products
        ORDER BY category, subcategory, product_name;

3. Determine the first and last order date and the total duration in months

        SELECT 
            MIN(order_date) AS first_order_date,
            MAX(order_date) AS last_order_date,
            DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
        FROM gold.fact_sales;


4. Find the youngest and oldest customer based on birthdate

        SELECT
            MIN(birthdate) AS oldest_birthdate,
            DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
            MAX(birthdate) AS youngest_birthdate,
            DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
        FROM gold.dim_customers;

5. Find the Total Sales

        SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

6. Find how many items are sold
    
        SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales

7. Find the average selling price
        
        SELECT AVG(price) AS avg_price FROM gold.fact_sales

8. Find the Total number of Orders

        SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales

9. Find the total number of products

        SELECT COUNT(product_name) AS total_products FROM gold.dim_products

10. Find the total number of customers
    
        SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers;

11. Find the total number of customers that has placed an order
    
        SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;

10.  Generate a Report that shows all key metrics of the business

    
    SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
    UNION ALL
    SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
    UNION ALL
    SELECT 'Average Price', AVG(price) FROM gold.fact_sales
    UNION ALL
    SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
    UNION ALL
    SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
    UNION ALL
    SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;

11.  Find total customers by countries

        SELECT
            country,
            COUNT(customer_key) AS total_customers
        FROM gold.dim_customers
        GROUP BY country
        ORDER BY total_customers DESC;

12. Find total customers by gender

        SELECT
            gender,
            COUNT(customer_key) AS total_customers
        FROM gold.dim_customers
        GROUP BY gender
        ORDER BY total_customers DESC;

13.  Find total products by category

        SELECT
            category,
            COUNT(product_key) AS total_products
        FROM gold.dim_products
        GROUP BY category
        ORDER BY total_products DESC;

14.  What is the average costs in each category

        SELECT
            category,
            AVG(cost) AS avg_cost
        FROM gold.dim_products
        GROUP BY category
        ORDER BY avg_cost DESC;

15.  What is the total revenue generated for each category

            SELECT
                p.category,
                SUM(f.sales_amount) AS total_revenue
            FROM gold.fact_sales f
            LEFT JOIN gold.dim_products p
                ON p.product_key = f.product_key
            GROUP BY p.category
            ORDER BY total_revenue DESC;


16.  What is the total revenue generated by each customer

        SELECT
            c.customer_key,
            c.first_name,
            c.last_name,
            SUM(f.sales_amount) AS total_revenue
        FROM gold.fact_sales f
        LEFT JOIN gold.dim_customers c
            ON c.customer_key = f.customer_key
        GROUP BY 
            c.customer_key,
            c.first_name,
            c.last_name
        ORDER BY total_revenue DESC;

17.  What is the distribution of sold items across countries?

        SELECT
            c.country,
            SUM(f.quantity) AS total_sold_items
        FROM gold.fact_sales f
        LEFT JOIN gold.dim_customers c
            ON c.customer_key = f.customer_key
        GROUP BY c.country
        ORDER BY total_sold_items DESC;

18. Which 5 products Generating the Highest Revenue?

                SELECT *
                FROM (
                    SELECT
                        p.product_name,
                        SUM(f.sales_amount) AS total_revenue,
                        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
                    FROM gold.fact_sales f
                    LEFT JOIN gold.dim_products p
                        ON p.product_key = f.product_key
                    GROUP BY p.product_name
                ) AS ranked_products
                WHERE rank_products <= 5;

19.  What are the 5 worst-performing products in terms of sales?
        
        SELECT TOP 5
            p.product_name,
            SUM(f.sales_amount) AS total_revenue
        FROM gold.fact_sales f
        LEFT JOIN gold.dim_products p
            ON p.product_key = f.product_key
        GROUP BY p.product_name
        ORDER BY total_revenue;

20.  Find the top 10 customers who have generated the highest revenue

        SELECT TOP 10
            c.customer_key,
            c.first_name,
            c.last_name,
            SUM(f.sales_amount) AS total_revenue
        FROM gold.fact_sales f
        LEFT JOIN gold.dim_customers c
            ON c.customer_key = f.customer_key
        GROUP BY 
            c.customer_key,
            c.first_name,
            c.last_name
        ORDER BY total_revenue DESC;

21. The 3 customers with the fewest orders placed

        SELECT TOP 3
            c.customer_key,
            c.first_name,
            c.last_name,
            COUNT(DISTINCT order_number) AS total_orders
        FROM gold.fact_sales f
        LEFT JOIN gold.dim_customers c
            ON c.customer_key = f.customer_key
        GROUP BY 
            c.customer_key,
            c.first_name,
            c.last_name
        ORDER BY total_orders ;

22.  Analyse sales performance over time Using Different Functions

        -- Quick Date Functions
        SELECT
            YEAR(order_date) AS order_year,
            MONTH(order_date) AS order_month,
            SUM(sales_amount) AS total_sales,
            COUNT(DISTINCT customer_key) AS total_customers,
            SUM(quantity) AS total_quantity
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY YEAR(order_date), MONTH(order_date)
        ORDER BY YEAR(order_date), MONTH(order_date);

        -- DATETRUNC()
        SELECT
            DATETRUNC(month, order_date) AS order_date,
            SUM(sales_amount) AS total_sales,
            COUNT(DISTINCT customer_key) AS total_customers,
            SUM(quantity) AS total_quantity
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY DATETRUNC(month, order_date)
        ORDER BY DATETRUNC(month, order_date);

        -- FORMAT()
        SELECT
            FORMAT(order_date, 'yyyy-MMM') AS order_date,
            SUM(sales_amount) AS total_sales,
            COUNT(DISTINCT customer_key) AS total_customers,
            SUM(quantity) AS total_quantity
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY FORMAT(order_date, 'yyyy-MMM')
        ORDER BY FORMAT(order_date, 'yyyy-MMM');

23.  Calculate the total sales per month and the running total of sales over time 

        SELECT
            order_date,
            total_sales,
            SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
            AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
        FROM
        (
            SELECT 
                DATETRUNC(year, order_date) AS order_date,
                SUM(sales_amount) AS total_sales,
                AVG(price) AS avg_price
            FROM gold.fact_sales
            WHERE order_date IS NOT NULL
            GROUP BY DATETRUNC(year, order_date)
        ) t

24. Analyze the yearly performance of products by comparing their sales to both the    average   sales performance of the product and the previous year's sales .

        WITH yearly_product_sales AS (
            SELECT
                YEAR(f.order_date) AS order_year,
                p.product_name,
                SUM(f.sales_amount) AS current_sales
            FROM gold.fact_sales f
            LEFT JOIN gold.dim_products p
                ON f.product_key = p.product_key
            WHERE f.order_date IS NOT NULL
            GROUP BY 
                YEAR(f.order_date),
                p.product_name
        )
        SELECT
            order_year,
            product_name,
            current_sales,
            AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
            current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
            CASE 
                WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
                WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
                ELSE 'Avg'
            END AS avg_change,
            -- Year-over-Year Analysis
            LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
            current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
            CASE 
                WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
                WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
                ELSE 'No Change'
            END AS py_change
        FROM yearly_product_sales
        ORDER BY product_name, order_year;


25. Segment products into cost ranges and count how many products fall into each segment.

        WITH product_segments AS (
            SELECT
                product_key,
                product_name,
                cost,
                CASE 
                    WHEN cost < 100 THEN 'Below 100'
                    WHEN cost BETWEEN 100 AND 500 THEN '100-500'
                    WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
                    ELSE 'Above 1000'
                END AS cost_range
            FROM gold.dim_products
        )
        SELECT 
            cost_range,
            COUNT(product_key) AS total_products
        FROM product_segments
        GROUP BY cost_range
        ORDER BY total_products DESC;

26. Group customers into three segments based on their spending behavior:

	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
      And find the total number of customers by each group

        WITH customer_spending AS (
            SELECT
                c.customer_key,
                SUM(f.sales_amount) AS total_spending,
                MIN(order_date) AS first_order,
                MAX(order_date) AS last_order,
                DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
            FROM gold.fact_sales f
            LEFT JOIN gold.dim_customers c
                ON f.customer_key = c.customer_key
            GROUP BY c.customer_key
        )
        
        SELECT 
            customer_segment,
            COUNT(customer_key) AS total_customers
        FROM (
            SELECT 
                customer_key,
                CASE 
                    WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
                    WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
                    ELSE 'New'
                END AS customer_segment
            FROM customer_spending
        ) AS segmented_customers
        GROUP BY customer_segment
        ORDER BY total_customers DESC;

27. Which categories contribute the most to overall sales?

        WITH category_sales AS (
            SELECT
                p.category,
                SUM(f.sales_amount) AS total_sales
            FROM gold.fact_sales f
            LEFT JOIN gold.dim_products p
                ON p.product_key = f.product_key
            GROUP BY p.category
        )
        SELECT
            category,
            total_sales,
            SUM(total_sales) OVER () AS overall_sales,
            ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
        FROM category_sales
        ORDER BY total_sales DESC;

28. Customer Report 

            Purpose:
                This report consolidates key customer metrics and behaviors

                Highlights:
                    1. Gathers essential fields such as names, ages, and transaction details.
                    2. Segments customers into categories (VIP, Regular, New) and age groups.
                    3. Aggregates customer-level metrics:
                    - total orders
                    - total sales
                    - total quantity purchased
                    - total products
                    - lifespan (in months)
                    4. Calculates valuable KPIs:
                        - recency (months since last order)
                        - average order value
                        - average monthly spend





            Create Report: gold.report_customers

            IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
                DROP VIEW gold.report_customers;
            GO

            CREATE VIEW gold.report_customers AS

            WITH base_query AS(
            1) Base Query: Retrieves core columns from tables
            SELECT
            f.order_number,
            f.product_key,
            f.order_date,
            f.sales_amount,
            f.quantity,
            c.customer_key,
            c.customer_number,
            CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
            DATEDIFF(year, c.birthdate, GETDATE()) age
            FROM gold.fact_sales f
            LEFT JOIN gold.dim_customers c
            ON c.customer_key = f.customer_key
            WHERE order_date IS NOT NULL)

            , customer_aggregation AS (
            2) Customer Aggregations: Summarizes key metrics at the customer level
           
            SELECT 
                customer_key,
                customer_number,
                customer_name,
                age,
                COUNT(DISTINCT order_number) AS total_orders,
                SUM(sales_amount) AS total_sales,
                SUM(quantity) AS total_quantity,
                COUNT(DISTINCT product_key) AS total_products,
                MAX(order_date) AS last_order_date,
                DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
            FROM base_query
            GROUP BY 
                customer_key,
                customer_number,
                customer_name,
                age
            )
            SELECT
            customer_key,
            customer_number,
            customer_name,
            age,
            CASE 
                WHEN age < 20 THEN 'Under 20'
                WHEN age between 20 and 29 THEN '20-29'
                WHEN age between 30 and 39 THEN '30-39'
                WHEN age between 40 and 49 THEN '40-49'
                ELSE '50 and above'
            END AS age_group,
            CASE 
                WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
                WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
                ELSE 'New'
            END AS customer_segment,
            last_order_date,
            DATEDIFF(month, last_order_date, GETDATE()) AS recency,
            total_orders,
            total_sales,
            total_quantity,
            total_products
            lifespan,
            -- Compuate average order value (AVO)
            CASE WHEN total_sales = 0 THEN 0
                ELSE total_sales / total_orders
            END AS avg_order_value,
            -- Compuate average monthly spend
            CASE WHEN lifespan = 0 THEN total_sales
                ELSE total_sales / lifespan
            END AS avg_monthly_spend
            FROM customer_aggregation

29. Product Report

        Purpose:
            - This report consolidates key product metrics and behaviors.

        Highlights:
            1. Gathers essential fields such as product name, category, subcategory, and cost.
            2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
            3. Aggregates product-level metrics:
            - total orders
            - total sales
            - total quantity sold
            - total customers (unique)
            - lifespan (in months)
            4. Calculates valuable KPIs:
            - recency (months since last sale)
            - average order revenue (AOR)
            - average monthly revenue

        Create Report: gold.report_products

        IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
            DROP VIEW gold.report_products;
        GO

        CREATE VIEW gold.report_products AS

        WITH base_query AS (
        /*---------------------------------------------------------------------------
        1) Base Query: Retrieves core columns from fact_sales and dim_products
        ---------------------------------------------------------------------------*/
            SELECT
                f.order_number,
                f.order_date,
                f.customer_key,
                f.sales_amount,
                f.quantity,
                p.product_key,
                p.product_name,
                p.category,
                p.subcategory,
                p.cost
            FROM gold.fact_sales f
            LEFT JOIN gold.dim_products p
                ON f.product_key = p.product_key
            WHERE order_date IS NOT NULL  -- only consider valid sales dates
        ),

        product_aggregations AS (
        /*---------------------------------------------------------------------------
        2) Product Aggregations: Summarizes key metrics at the product level
        ---------------------------------------------------------------------------*/
        SELECT
            product_key,
            product_name,
            category,
            subcategory,
            cost,
            DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
            MAX(order_date) AS last_sale_date,
            COUNT(DISTINCT order_number) AS total_orders,
            COUNT(DISTINCT customer_key) AS total_customers,
            SUM(sales_amount) AS total_sales,
            SUM(quantity) AS total_quantity,
            ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price
        FROM base_query

        GROUP BY
            product_key,
            product_name,
            category,
            subcategory,
            cost
        )

        /*---------------------------------------------------------------------------
        3) Final Query: Combines all product results into one output
        ---------------------------------------------------------------------------*/
        SELECT 
            product_key,
            product_name,
            category,
            subcategory,
            cost,
            last_sale_date,
            DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
            CASE
                WHEN total_sales > 50000 THEN 'High-Performer'
                WHEN total_sales >= 10000 THEN 'Mid-Range'
                ELSE 'Low-Performer'
            END AS product_segment,
            lifespan,
            total_orders,
            total_sales,
            total_quantity,
            total_customers,
            avg_selling_price,
            -- Average Order Revenue (AOR)
            CASE 
                WHEN total_orders = 0 THEN 0
                ELSE total_sales / total_orders
            END AS avg_order_revenue,

            -- Average Monthly Revenue
            CASE
                WHEN lifespan = 0 THEN total_sales
                ELSE total_sales / lifespan
            END AS avg_monthly_revenue

        FROM product_aggregations 
