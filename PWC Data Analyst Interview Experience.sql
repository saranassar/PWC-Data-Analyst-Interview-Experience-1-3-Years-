
--1. Write a query to calculate the total sales for each region over the past year.

SELECT region, SUM(sales) AS total_sales
FROM sales
WHERE year = 2024
GROUP BY region;


--2. How would you identify the top 3 customers with the highest revenue in a specific quarter?

--1st solution:

SELECT customer_id, quarter, SUM(revenue) AS total_revenue
FROM customers
WHERE quarter = 'Q1'
GROUP BY customer_id, quarter
ORDER BY total_revenue DESC
LIMIT 3;

--Or Using RANK function:

SELECT customer_id, quarter, revenue
FROM (
 SELECT customer_id, quarter, revenue,
 RANK() OVER (PARTITION BY quarter ORDER BY revenue DESC) AS rank
 FROM customers
) AS ranked_customers
WHERE quarter = 'Q1' AND rank <= 3;


--3. Given a transactions table, find all products that were sold but have not been restocked for 6 months.

SELECT product_id
FROM products
WHERE sales_date IS NOT NULL 
 AND restock_date <= DATEADD(MONTH, -6, GETDATE());


--4. Write a query to determine the monthly growth rate of active users.

SELECT month, SUM(growth_rate) AS total_growth
FROM users
WHERE user_state = 'active'
GROUP BY month;


--5. Find the 3rd lowest salary in an employee table using a dynamic parameter.

--1st solution:

SELECT employee_id, salary
FROM employee
ORDER BY salary ASC
LIMIT 1 OFFSET 2;

--Or Using RANK function:

SELECT employee_id, salary
FROM (
 SELECT employee_id, salary,
 RANK() OVER (ORDER BY salary ASC) AS rank
 FROM employee
) AS ranked_salaries
WHERE rank = 3;

--7. Compare CROSS JOIN and INNER JOIN in SQL, with examples.

- --Cross join: gives all combinations from two tables without condition.
- --Inner join: gives only matched rows based on a condition.

--8. When should you use the GROUP BY clause versus window functions in SQL?

--- Use GROUP BY to summarize data into fewer rows.
--- Use window functions when performing calculations across rows without losing individual row data.