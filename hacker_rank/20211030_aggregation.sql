-- We define an employee's total earnings to be their monthly salary x months worked, and the maximum total earnings to be 
-- the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for 
-- all employees as well as the total number of employees who have maximum total earnings. 
-- Then print these values as 2 space-separated integers.

-- calculate the earnings
-- rank and get the max list
-- select earnings and its total count
with tmp as (
    select * from (
        select earnings, rank() over (order by earnings desc) rnk 
        from (select *, (salary * months) as earnings from employee) tmp1
    ) tmp2
    where rnk = 1)

select earnings, count(rnk) from tmp
group by earnings