-- From the OrderDetails table, find all orders where the quantity is greater than 20.
/*select * 
from orderdetails
where quantity>20;*/

-- Using the OrderDetails table, write a query to find the total quantity ordered for each product.
/*select product_id, SUM(quantity) as total_quantity
from orderdetails
group by product_id
order by SUM(quantity) DESC;*/

-- Join the OrderDetails and Reviews tables.
/*select o.product_id,quantity,rating
from orderdetails o
join reviews r
on o.product_id=r.product_id;*/

--Find all product_ids from the Reviews table that have been reviewed more than once.
/*select product_id,count(product_id)
from reviews
group by product_id
having count(product_id)>1;*/

-- Find the product(s) from Reviews that have a higher average rating than the overall average rating across all reviews.
/*select product_id, AVG(rating) as average_rating 
from reviews
group by product_id
having avg(rating) > (
	select avg(rating) from reviews
);*/

-- write a query to find the total quantity shipped by each supplier in the year 2023
/*select supplier_id, SUM(quantity) as quantity_shipped
from shipments
where shipments.date between '2023-01-01' and '2023-12-31'
group by supplier_id;*/


--Find product(s) whose total quantity ordered is greater than the average quantity ordered across all products
/*select product_id, sum(quantity) as Total_Quantity
from orderdetails
group by product_id
having sum(quantity) > (
select avg(quantity) from orderdetails
)*/

-- Find products that were ordered more than 100 units in total but received an average rating less than 3.
/*select o.product_id
from orderdetails o
join reviews r
on o.product_id=r.product_id
group by o.product_id
having avg(rating)<3 and sum(quantity)>100;*/

--Find product(s) whose total quantity ordered is greater than the average total quantity per product.
/*select product_id,sum(quantity) as total_quantity
from orderdetails
group by product_id
having sum(quantity) > (
	select avg(sum_quantity)
	from (
		select sum(quantity) as sum_quantity
		from orderdetails
		group by product_id
	) AS sub
)*/





