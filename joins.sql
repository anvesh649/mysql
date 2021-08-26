select order_id,o.customer_id from orders o join customers c on o.customer_id=c.customer_id;

select * from order_items;

select * from products;

select order_id,o.product_id,p.name,quantity,o.unit_price from order_items o join products p on o.product_id=p.product_id;


select * from order_items oi join sql_inventory.products p on oi.product_id=p.product_id;

use sql_hr;
select e.employee_id,e.first_name,m.first_name as manager from employees e join employees m on e.reports_to =m.employee_id;

select * from employees e join employees m on e.reports_to =m.employee_id;

use sql_store;
select * from customers;
select * from order_statuses;

select o.order_id,o.order_date,c.first_name,c.last_name,os.name as status
from orders o 
join order_statuses os 
	on o.status=os.order_status_id 
join customers c 
	on c.customer_id=o.order_id order by o.order_id;

use sql_invoicing;

select c.client_id,c.name,c.address,invoice_id,date,amount,pm.name as payment_mode from payments p
join payment_methods pm
	on p.payment_method=pm.payment_method_id
join clients c
	on p.client_id=c.client_id order by c.client_id;

use sql_store;

select * from order_items oi join order_item_notes oin on oi.order_id=oin.order_id and oi.product_id=oin.product_id;
 
 
 select c.customer_id,c.first_name,o.order_id
 from customers c left join orders o on c.customer_id=o.customer_id
 order by c.customer_id;
 
 select * from order_items;
 
 select * from products;
 
 select p.product_id,oi.quantity,name from order_items oi right join products p on oi.product_id=p.product_id 
 order by p.product_id;
 
 
 select * from orders;
 
 select * from order_statuses;
 
 use sql_invoicing;
 select * from clients;
 select * from payments;
 select date,cl.name as client,p.amount,pm.name from payments p 
 join payment_methods pm 
 on p.payment_method=pm.payment_method_id
 join clients cl
 using(client_id)
 ;
use sql_store;

 select * from payment_methods;
 select * from customers;
 
 Insert into customers(first_name,
 last_name,
 birth_date,
 address,
 city,
 state) 
values('Bohn',
    'Smith',
    '1992-01-01',
    'dede',
	 'city',
	  'CA');
 select * from customers;

use sql_invoicing;

select count(*) from invoices;

select sum(invoice_total) as total_sales from invoices; 
select sum(invoice_total)  from invoices group by client_id;


use sql_hr;
select salary from employees order by salary desc limit 1;
 
select * from employees limit 1; 


use sql_invoicing;
select * from payments limit 1,1;
select date,pm.name,sum(amount)
from payments p 
join payment_methods pm 
 on p.payment_method=pm.payment_method_id
group by date,pm.name
order by date;

use sql_invoicing;

select * from invoices;
select 
		client_id,
        invoice_id,
	   sum(invoice_total) as total_sales
from invoices
group by client_id,invoice_id with rollup;


use sql_store;

select * from products;

select * from products 
where unit_price>(
	select unit_price
    from products
    where product_id=3
);

use sql_hr;

select * from employees;

select first_name,salary 
from employees
where salary>(
select avg(salary)
from employees);

select avg(salary) from employees;

use sql_store;	

select name,product_id from products
where product_id not in (
select distinct product_id 
from order_items
);
use sql_invoicing;

select client_id,name 
from clients
where client_id not in
(select distinct client_id 
from invoices);
select * FROM invoices;


use sql_store;

SELECT * FROM orders;

insert into customers values(
			null,'ewe','ewew','1990-01-23',789388383,'ss','beijing','ss',283628) ;

insert into customers (first_name,last_name,address,city,state,points)values(
		'Random','Woddty','ss','beijing','df',283628) ;
insert into shippers(name) values ('Shipper1'),('Shipper2'),('Shipper3');

select * from product;

insert into products (name,quantity_in_stock,unit_price) values 
    ('Rtx 30900',2,2.3),
    ('lg g305',44,25.3),
    ('Corsair rx500',35,2.3);


insert into orders (customer_id,order_date,status) values
	(1,'2019-01-02',1);

insert into order_items VALUES 
	 (last_insert_id(),1,1,2.95),
   (last_insert_id(),2,1,2.97);

   
select * FROM order_archives;


create table order_archives as select * FROM orders;

select * FROM order_archives;


INSERT INTO order_archives 
SELECT * FROM orders WHERE order_date<'2019-01-01';


USE sql_invoicing;

SELECT * FROM  clients;

CREATE TABLE payments_don as
SELECT i.invoice_id,number,i.payment_date,name AS client_name FROM invoices i JOIN clients c 
ON i.client_id = c.client_id WHERE i.payment_date IS NOT NULL;

SELECT * FROM payments_done pd;

SELECT * FROM invoices i;

UPDATE invoices i 
   set i.payment_total=i.invoice_total*0.5,i.payment_date=i.due_date where i.invoice_id IN(17,18);

USE sql_store;
SELECT * FROM customers c;

UPDATE customers  
  set points=points+500 WHERE birth_date<'1993-07-17';
USE sql_invoicing;

UPDATE invoices set 
  payment_total=invoice_total*0.5,
  payment_date=due_date
WHERE client_id in
    (select client_id FROM clients WHERE name='Myworks' OR name='vinte');

USE sql_store;
select * FROM customers;

-- UPDATE customers set
SELECT * FROM orders;
SELECT * from customers c;

UPDATE orders set comments='Gold Customer' WHERE customer_id IN 
    (SELECT customer_id FROM customers WHERE points>3000); 
(SELECT customer_id FROM customers WHERE points>3000); 

DELETE FROM orders WHERE order_id=2;

SELECT * FROM orders WHERE order_id=2;

USE sql_invoicing;

DELETE FROM invoices WHERE client_id=2;

SELECT * FROM invoices;
