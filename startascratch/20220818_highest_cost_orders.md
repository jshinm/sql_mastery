# Highest Cost Orders

Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output customer's first name, total cost of their items, and the date.

```
Table: customers, orders
```

```sql
-- customer with highest daily total order between 2019/02/01 - 2019/05/01. 
-- If more than one order per day, get total order
-- output: first_name, total_cost, date
-- assume every first_name is unique

-- 1. filter `orders` for specified date range
-- 2. filter columns of interest from both table
-- 3. join two tables
-- 4. group by date and sum the aggregate
-- 5. order by `total_order_cost`
-- 6. get the first record

with t1 as 
(select cust_id, order_date, total_order_cost from orders
where
order_date < "2019-05-01" and
order_date > "2019-02-01"),

t2 as
(select id, first_name from customers)

select id, order_date, first_name, sum(total_order_cost) tot from t1
left join t2
on cust_id = id
group by order_date, first_name
order by tot desc
limit 1
```