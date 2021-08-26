USE sql_store;


SELECT * FROM products p
  WHERE unit_price>
 (SELECT unit_price 
  FROM products p 
  WHERE p.product_id=1);
USE sql_hr;


SELECT * FROM employees e 
where e.salary>
  (SELECT AVG(salary) 
   FROM employees e);


USE sql_store;

SELECT * FROM order_items oi;
SELECT * FROM products p 
  WHERE p.product_id NOT IN (
    SELECT DISTINCT oi.product_id 
    FROM order_items oi
  );

SELECT * FROM customers c;

SELECT * FROM order_items oi;

SELECT * FROM orders o;


SELECT * FROM products p;


SELECT first_name,c.last_name,p.name,o.customer_id,p.product_id from orders o 
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN customers c ON o.customer_id = c.customer_id
  JOIN products p ON oi.product_id = p.product_id
  WHERE p.product_id =(SELECT p.product_id WHERE p.name REGEXP '^Lettuce');

USE sql_invoicing;

-- ALL keyword
SELECT * FROM invoices i 
  WHERE i.invoice_total> ALL (SELECT 
      i.invoice_total FROM invoices i 
      where i.client_id=3);

-- Any keyword
SELECT * FROM clients 
WHERE client_id = ANY(
    SELECT client_id
    FROM invoices i
    GROUP BY i.client_id
    HAVING COUNT(*)>=5
);

SELECT * FROM clients 
WHERE client_id in(
    SELECT client_id
    FROM invoices i
    GROUP BY i.client_id
    HAVING COUNT(*)>=5
);
   
-- correlated subqueries
USE sql_hr;
-- for each employee
-- calculate the average salary of the employee.office
-- return the employee if salary>avg
SELECT * FROM employees e
WHERE salary>(
  SELECT AVG(salary) FROM employees
    WHERE e.office_id=office_id 
);

USE sql_invoicing;

-- get the invoices that are larger than the 
-- clients average invoice amount

SELECT * FROM invoices i
  WHERE invoice_total>(
    SELECT AVG(invoice_total) FROM invoices
      WHERE i.client_id=client_id
  );


-- exists operator

-- if we use an in operator for below one it returns a result set
-- (if the set is too large it may cause problems)
SELECT * FROM clients c
WHERE EXISTS (
  SELECT client_id 
  FROM invoices 
  WHERE c.client_id=client_id);


USE sql_store;

-- find the products that are not ordered
SELECT * FROM products p
  WHERE product_id 
  NOT IN (
  SELECT DISTINCT 
   product_id FROM ORDER_items);


SELECT * FROM products p
WHERE NOT EXISTS (
    SELECT DISTINCT product_id FROM order_items oi
    WHERE oi.product_id=p.product_id 
  );

USE sql_invoicing;

-- subqueries from the select clause
SELECT 
    invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total) 
      FROM invoices) AS invoice_avg,
    invoice_total-(SELECT invoice_avg) AS difference  
FROM invoices i;


-- inorder to select already created queries by as use select
SELECT invoice_total AS it,(SELECT it) AS ig FROM invoices i;


SELECT c.client_id,c.name,SUM(i.invoice_total) AS total_sum,
  (SELECT AVG(i1.invoice_total) FROM invoices i1) AS average ,
  (SELECT average) as difference
  FROM clients c 
  LEFT join invoices i ON c.client_id = i.client_id 
  GROUP BY c.client_id;

SELECT client_id,SUM(i.invoice_total) FROM invoices i GROUP by i.client_id;




-- subqueries from the from clause


SELECT  * FROM(
SELECT c.client_id,c.name,SUM(i.invoice_total) AS total_sum,
  (SELECT AVG(i1.invoice_total) FROM invoices i1) AS average ,
  (SELECT average) as difference
  FROM clients c 
  LEFT join invoices i ON c.client_id = i.client_id 
  GROUP BY c.client_id) AS some1 WHERE some1.total_sum IS NOT NULL;
