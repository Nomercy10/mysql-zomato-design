-- "This JSON file contains all the features we will be covering in out DB design"

-- Below is the list of the tables we will create for the design
-- "zomatomaindb",
-- "customers",
-- "restuarants",
-- "zo_employee",
-- "foods",
-- "orders_details",
-- "payments",
-- "orders_food",
-- "wallet"

-- Let's define all the tables one by one with their required schemas, attributes

drop schema if exists zomatomaindb;

create schema zomatomaindb;

use schema zomatomaindb


-- Customers

drop table if exists customers;

-- Create customers table
create table customers(
	cust_id int(4) not null,
	cust_name varchar(20) not null,
	cust_phone varchar(11) not null,
	cust_add varchar(30) not null,
	constraint pk_customers primary key (cust_id)
);

-- Insert into customers table
insert into customers(cust_id, cust_name, cust_phone, cust_add) VALUES
(101, 'John Doe', '9980808080', '11 East street, London'),
(102, 'Alex D', '98989898989', '2nd Street, London'),
(103, 'Robin Mary', '8787767665', '1st Avenue, London'),
(104, 'Vin M', '7373737373', '20th Street A, London'),
(105, 'Paul Mackenzi', '9292929292', '2nd Avenue, London'),
(106, 'Smith Jones', '0101010101', '10 West Street, London'),
(107, 'Laurel G', '8383838383', '18th South Street, London');

-- To select all Customers
select * from customers;

-- Restuarants
drop table if exists restuarants

create table restuarants(
	rest_id int(3) not null,
	rest_name varchar(20) not null,
	rlocation varchar(20) not null,
	rrating decimal(2,1) not null,
	constraint pk_restuarants primary key (rest_id)
);

-- Insert into restuarants table
insert into restuarants(rest_id, rest_name, rlocation, rrating) VALUES
(1001, "JJs Bistro", '11 East street, London', '4.8'),
(1002, "Smith & Jones", '2nd Street, London', '3.4'),
(1003, "Pizzeria", '10 West Street, London', '1.4'),
(1004, "JJs Bistro", '20th Street A, London', '4.1'),
(1005, "JJs Bistro", '1st Avenue, London', '3.9');

select * from restuarants;

-- Zomato employees
drop table if exists zo_employee;

create table zo_employee(
	emp_id int(6) not null,
	emp_name varchar(20) not null,
	emp_phone varchar(11) not null,
	emp_rating decimal(2, 1) not null,
	constraint pk_zo_employee primary key (emp_id)
);

-- Insert into zomato employees table
insert into zo_employee(emp_id, emp_name, emp_phone, emp_rating) VALUES
(2001, 'Samuel S', '9980808080', '3.5'),
(2002, 'Noel Poyser', '898329321', '4.2'),
(2003, 'Doug Shelly', '8787878772', '3.9'),
(2004, 'Michael P', '82382382382', '3.8'),
(2005, 'Petr M', '82382391923', '4.1'),
(2006, 'Mike J', '87341092321', '4.5'),
(2007, 'Ronald', '87173981231', '3.1'),
(2008, 'Joey T', '91873818312', '4.3');

select * from zo_employee;

-- Foods table
drop table if exists foods;

create table foods(
	food_id int(7) not null,
	food_name varchar(20) not null,
	per_unit_price decimal(5,2) not null,
	constraint pk_foods primary key (food_id)
);

-- Insert food items in food table
insert into foods(food_id, food_name, per_unit_price) VALUES
(700, 'Chicken burger', '100.00'),
(701, 'Pepperoni pizza', '120.00'),
(702, 'Ham Sandwich', '300.00'),
(703, 'Cold drink', '20.00'),
(704, 'Fruite Juice', '50.00'),
(705, 'Chocolate Brownie', '89.00'),
(706, 'Morocco chicken', '180.00'),
(707, 'Penne pasta', '200.00'),
(708, 'American breakfast', '150.00'),
(709, 'Scrambled eggs', '90.00'),
(710, 'Kebab platter', '170.00'),
(711, 'Bacon', '110.00');

select * from foods;

-- Order details table
drop table if exists orders_details

-- Create order details table and keep, customer, rest and emp ids as foreign keys to fetch the required details
create table orders_details(
	order_id int(4) not null,
	cust_id int(4) not null,
	rest_id int(4) not null,
	emp_id int(6) not null,
	order_status varchar(10),
	order_time timestamp,
	delivered_time timestamp,
	constraint fk_customers FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
	constraint fk_restuarants FOREIGN KEY (rest_id) REFERENCES restuarants(res_id),
	constraint fk_zo_employee FOREIGN KEY (emp_id) REFERENCES zo_employee(emp_id)
);

-- Insert values into orders_details
insert into orders_details(order_id, cust_id, rest_id, emp_id, order_status, order_time, delivered_time) VALUES
( 6001, 101, 1001, 2001, 'confirmed', '2020-02-01 12:20:19', '2020-02-01 12:50:19'),
( 6002, 102, 1002, 2002, 'pending', '2020-03-22 21:20:19', '2020-03-22 21:50:19'),
( 6003, 103, 1003, 2003, 'pickedup', '2020-04-03 14:20:19', '2020-04-03 14:45:19'),
( 6004, 104, 1004, 2004, 'waiting', '2020-05-07 18:20:19', '2020-05-07 18:55:19'),
( 6005, 105, 1001, 2005, 'confirmed', '2020-01-17 23:20:19', '2020-01-17 23:48:19'),
( 6006, 106, 1002, 2006, 'confirmed', '2020-07-15 11:20:19', '2020-07-15 11:58:19'),
( 6007, 107, 1003, 2007, 'pending', '2020-04-06 03:20:19', '2020-04-06 03:30:19'),
( 6008, 101, 1004, 2008, 'pending', '2020-01-09 03:20:19', '2020-01-09 03:35:19'),
( 6009, 102, 1005, 2001, 'pending', '2020-06-18 18:20:19', '2020-06-18 18:50:19'),
( 6010, 103, 1001, 2002, 'pending', '2020-09-23 23:20:19', '2020-09-23 23:55:19'),
( 6011, 104, 1002, 2003, 'pickedup', '2020-01-26 13:20:19', '2020-01-26 13:39:19'),
( 6012, 105, 1003, 2004, 'pickedup', '2020-03-31 12:20:19', '2020-03-31 12:41:19'),
( 6013, 106, 1004, 2005, 'waiting', '2020-09-12 15:20:19', '2020-09-12 15:42:19'),
( 6014, 107, 1005, 2006, 'waiting', '2020-12-29 08:20:19', '2020-12-29 08:36:19'),
( 6015, 101, 1001, 2007, 'waiting', '2020-11-20 04:20:19', '2020-11-20 04:40:19');

select * from orders_details;

-- Payments table
drop table if exists payments;

create table payments(
	transaction_id int(8) not null,
	order_id int(4) not null,
	payment_type varchar(20) not null,
	payment_status varchar(10),
	amount decimal(5,2) not null,
	constraint pk_payments primary key (transaction_id),
	constraint fk_orders_details FOREIGN KEY (order_id) REFERENCES orders_details(order_id)
);

-- insert values in to payments table
insert into payments(transaction_id, order_id, payment_type, payment_status, amount) VALUES
(87878787, 6001, "Debit Card", 'paid', '200.00'),
(87873434, 6002, "COD", 'unpaid', '120.00'),
(87877676, 6003, "Credit Card", 'paid', '500.00'),
(87878090, 6004, "Credit Card", 'paid', '300.00'),
(87877373, 6005, "Credit Card", 'paid', '100.00'),
(87871212, 6006, "Credit Card", 'paid', '150.00'),
(87871010, 6007, "COD", 'unpaid', '23.00'),
(87879292, 6008, "COD", 'unpaid', '150.00'),
(87877744, 6009, "COD", 'unpaid', '123.00'),
(87879393, 6010, "Internet Banking", 'failed', '430.00'),
(87878712, 6011, "Internet Banking", 'failed', '232.00'),
(87879872, 6012, "Credit Card", 'pending', '42.00'),
(87877632, 6013, "COD", 'paid', '340.00');

select * from payments;

-- orders_food table

drop table if exists orders_food;

create table orders_food(
	order_food_id int not null auto_increment,
	order_id int(4) not null,
	cust_id int(4) not null,
	rest_id int(3) not null,
	food_id int(7) not null,
	qty int(2),
	emp_id int(6) not null,
	constraint pk_orders_food primary key (order_food_id),
	constraint fk_payments FOREIGN KEY (transaction_id) REFERENCES payments(transaction_id),
	constraint fk_orders_details FOREIGN KEY (order_id) REFERENCES orders(order_id),
	constraint fk_foods FOREIGN KEY (food_id) REFERENCES foods(food_id)
);

-- inser values into orders_food table
insert into orders_food(order_food_id, order_id, cust_id, rest_id, food_id, qty, emp_id) VALUES
(8810, 6001, 101, 1005,9999, 1, 2001),
(8811, 6002, 102, 1004,9991, 2, 2002),
(8812, 6003, 103, 1003,9992, 3, 2003),
(8813, 6004, 104, 1002,9993, 1, 2004),
(8814, 6005, 105, 1001,9994, 1, 2005),
(8815, 6006, 106, 1002,9995, 1, 2006),
(8816, 6007, 107, 1003,9996, 5, 2007),
(8817, 6008, 101, 1004,9997, 8, 2008),
(8818, 6009, 102, 1005,9998, 3, 2001),
(8819, 6001, 103, 1001,9910, 2, 2002),
(8820, 6002, 104, 1002,9911, 1, 2003);

select * from orders_food;

-- wallet table

drop table if exists wallet

create table wallet(
	wallet_id int(4) not null,
	wallet_balance decimal(2, 1) not null,
	cust_id int(4) not null,
	constraint pk_wallet primary key (wallet_id),
	constraint fk_cust_id FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

-- insert values into wallet table
insert into wallet(wallet_id, wallet_balance, cust_id) VALUES
(3001,"300.00", 101),
(3002,"400.00", 102),
(3003,"500.00", 103),
(3004,"600.00", 104),
(3005,"700.00", 105),
(3006,"100.00", 106);

select * from wallet;


-- Queries which can be used to fetch required info and power our features

-- 1. Count total number of users on Zomato
select count(*) as total_users from customers;

-- 2. Count total number of restuarants on Zomato
select count(*) as total_restaurants from restuarants;

-- 3. Count total number of employees of Zomato
select count(*) as total_employees from zo_employee;

-- 4 Find list of users who ordered food more than 2 times in a particular month
select cust_id, count(order_id) from orders_details
where cust_id in( select cust_id from orders_details where month(order_time) == 4)
group by cust_id
having count(order_id) > 2;
or
select c.cust_id, c.cust_name, count(o.order_id) as no_of_orders, month(o.order_time)
from customers c inner join orders_detail o on c.cust_id = o.cust_id
group by cust_id
having no_of_orders > 2
order by no_of_orders desc;

-- 5. Find top 3 delivery boy on the basis of customer rating and time to deliver the food item
-- for eg on customer rating
select o.emp_id, z.emp_name, z.emp_rating, timestampdiff(minute, o.order_time,o.delivered_time) as delivered_time_minute
from orders_details o inner join zo_employee on o.emp_id = z.emp_id
group by emp_id
order by z.emp_rating desc
limit 3;

-- for eg on delivery time
select o.emp_id, z.emp_name, z.emp_rating, timestampdiff(minute, o.order_time,o.delivered_time) as delivered_time_minute
from orders_details o inner join zo_employee on o.emp_id = z.emp_id
group by emp_id
order by delivered_time_minute asc
limit 3;

-- for both
select o.emp_id, z.emp_name, z.emp_rating, timestampdiff(minute, o.order_time,o.delivered_time) as delivered_time_minute
from orders_details o inner join zo_employee on o.emp_id = z.emp_id
group by emp_id
order by delivered_time_minute, z.emp_rating asc
limit 3;

-- 6. Find users who order food from same restuarants more than 2 times in a week

select o.cust_id, c.cust_name, rest_id, count(*) as orders, week(order_time)
from orders_details inner join customer c on o.cust_id == c.cust_id
group by rest_id
having orders > 2;