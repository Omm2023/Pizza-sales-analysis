-- Total count
use pizzahut;
select count(order_id) as "Total_count"from orders; 

-- Total count
use pizzahut;
select count(order_id) as "Total_count"from orders; 

-- Calculate the total revenue generated.
select
round(sum(order_details.quantity*pizzas.price),2) as total_revenue
from order_details
inner join pizzas
on order_details.pizza_id=pizzas.pizza_id

-- Highest priced pizza
select pizza_types.name,pizzas.price
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;

#Highest sold pizza
select quantity,count(order_details_id)
from order_details group by quantity
order by quantity limit 1

-- Size of pizza ordered in max number
select pizzas.size,count(order_details.order_details_id) as total_count
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size order by total_count;

-- List of top 5 ordered pizzas 
-- along their quantities 
use pizzahut;
select pizza_types.name,
sum(order_details.quantity)
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name;


-- Group the data by date and calculate the average
-- number of pizzas ordered per day
select round(avg(quantity),0) from 
(select orders.date,sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id=order_details.order_id
group by orders.date) as order_quantity;

-- Analyse the cumilative revenue generated over time
select date,
sum(revenue) over (order by date) as cumrevenue
from
(select orders.date ,
sum(order_details.quantity*pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id=pizzas.pizza_id
join orders
on orders.order_id=order_details.order_id
group by orders.date) as sales;



