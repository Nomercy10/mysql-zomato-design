# Relational database design for applications like Zomato/Swiggy

> This is my try to design a relational database design for Zomato. I have used MySql for this as I am more comfortable with it

**Context**

- **FeaturesList.sql** : A sql file which will provide all the table schemas required for the applications like
    - zomatomaindb
    - customers
    - restuarants
    - zo_employee
    - foods
    - orders_details
    - payments
    - orders_food
    - wallet
- **SQL queries**


### Data analysis using sql queries

`Count total number of users on Zomato:` 
```sql
select count(*) as total_users from customers;
```
`Count total number of restuarants on Zomato:`
```sql
select count(*) as total_restaurants from restuarants;
```
`Count total number of employees of Zomato:`
```sql
select count(*) as total_employees from zo_employee;
```
`Find list of users who ordered food more than 2 times in a particular month:`
```sql
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
```

`Find top 3 delivery boy on the basis of customer rating and time to deliver the food item:`
*for eg on customer rating*
```sql
select o.emp_id, z.emp_name, z.emp_rating, timestampdiff(minute, o.order_time,o.delivered_time) as delivered_time_minute
from orders_details o inner join zo_employee on o.emp_id = z.emp_id
group by emp_id
order by z.emp_rating desc
limit 3;
```
*for eg on delivery time*
```sql
select o.emp_id, z.emp_name, z.emp_rating, timestampdiff(minute, o.order_time,o.delivered_time) as delivered_time_minute
from orders_details o inner join zo_employee on o.emp_id = z.emp_id
group by emp_id
order by delivered_time_minute asc
limit 3;
```
*for both the cases*
```sql
select o.emp_id, z.emp_name, z.emp_rating, timestampdiff(minute, o.order_time,o.delivered_time) as delivered_time_minute
from orders_details o inner join zo_employee on o.emp_id = z.emp_id
group by emp_id
order by delivered_time_minute, z.emp_rating asc
limit 3;
```
`Find users who order food from same restuarants more than 2 times in a week:`
```sql
select o.cust_id, c.cust_name, rest_id, count(*) as orders, week(order_time)
from orders_details inner join customer c on o.cust_id == c.cust_id
group by rest_id
having orders > 2;
```

