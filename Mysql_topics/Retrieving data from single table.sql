USE sql_store;
#SELECT first_name,last_name,(points+10)*100 as 'discount',points from customers;
#select DISTINCT state from customers;
#select name,unit_price,(unit_price*1.1) as new_price from products;
select * from customers;
select * from customers where birth_date<'1985-00-00';
select * from orders where (order_date>='2017-00-00') and not(order_date>='2018-00-00');

select * from order_items where order_id=6  and quantity*unit_price>29 ;

#in
select * from customers where state not in ('FL','GA','VA');
select * from products where quantity_in_stock in (49,38,72);

#between
select * from products where quantity_in_stock between 38 and 72;
select * from customers where birth_date between '1990-01-01' and '2000-01-01';

#like
select * from customers  where last_name like '%y';

select * from customers  where last_name like 'b____y';
# % any number of characters
#_ exact number of characters

#regexp
select * from customers;

select * from customers where (address like '%trail%' or address like '%avenue%') and phone like '__4%'; 

select * from customers where phone not like '%9'; -- 

#regexp
select * from customers;

select * from customers where last_name like '%field%';
select * from customers where last_name REGEXP 'field$';
select * from customers where last_name REGEXP '^field';

select * from customers where last_name REGEXP 'field$|^mac';
select * from customers where last_name REGEXP '^field|mac|rose';

select * from customers where last_name REGEXP '[a-h]e';
select * from customers where first_name REGEXP '^ELKA|^AMBUR';
select * from customers where last_name REGEXP 'EY$|ON$';
select * from customers where last_name REGEXP '^MY|SE';
select * from customers where last_name REGEXP 'burgh';


select * from customers where phone  is not null;
select * from orders where shipped_date is null;

select * from customers order by state,first_name desc;
select * from customers order by points desc,first_name;

select first_name,last_name,19 from customers order by points;


select *,quantity*unit_price as total_price from order_items where order_id=2 order by quantity*unit_price desc;
select * from customers order by points desc limit 3;

select * from customers order by points desc limit 3,3;
select * from customers order by points desc;
