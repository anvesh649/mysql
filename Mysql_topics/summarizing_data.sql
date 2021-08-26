-- Aggregate functions

USE sql_invoicing;

SELECT MAX(invoice_total) AS highest,
       MIN(invoice_total) AS lowest,
       AVG(invoice_total) AS average,
       SUM(invoice_total*1.1) AS total,
       COUNT(DISTINCT client_id) AS unique_id,
       COUNT(*) AS total_number_records 
FROM invoices i;

select * FROM invoices;

-- Group by
SELECT client_id,SUM(invoice_total) AS total_sales 
  FROM invoices
GROUP BY client_id
ORDER BY total_sales DESC LIMIT 1;

SELECT p.date,pm.name AS payment_method,SUM(p.amount) AS total_payments FROM payments p JOIN payment_methods pm ON 
  p.payment_method = pm.payment_method_id 
  GROUP BY p.date,pm.name;


-- Having clause

-- where clause before the rows are grouped,having clause after the rows are grouped
SELECT client_id,SUM(invoice_total) AS total_sales,COUNT(client_id) AS number_of_invoices
  FROM invoices
  GROUP BY client_id
  HAVING total_sales>500 AND number_of_invoices>5;

USE SQL_STORE;

select * FROM order_items;

SELECT c.customer_id,c.first_name,c.last_name,SUM(oi.quantity*oi.unit_price) AS amount_spent
  from customers c
  JOIN orders o ON c.customer_id = o.customer_id 
  join order_items oi ON o.order_id = oi.order_id 
  WHERE state='va'
  GROUP BY c.customer_id
  HAVING amount_spent>100;

-- Rollup clause

USE sql_invoicing;
SELECT state,
       c.city,
       SUM(invoice_total) AS total_sales 
FROM invoices i
JOIN clients c USING(client_id)
GROUP BY state,c.city WITH ROLLUP;
-- https://www.sqltutorial.org/sql-rollup/ (sanfrisco iphones)


SELECT * FROM payments p;
SELECT * from payment_methods pm;

SELECT pm.name AS payment_method,SUM(p.amount) AS total_amount FROM payments p 
  JOIN payment_methods pm
  ON p.payment_method = pm.payment_method_id
  GROUP BY pm.name WITH ROLLUP;

