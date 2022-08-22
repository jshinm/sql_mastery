# Total Cost of Orders

Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.

```
Tables: customers, orders
```

```sql
-- total cost of each customer's order
-- output: first_name, total_order_cost
-- order by first_name

-- 1. select column of interest
-- 2. join `customers` and `ordres` tables
-- 3. group by `first_name` and aggregate by sum of `total_order_cost`
```
