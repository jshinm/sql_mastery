-- You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
-- It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
-- If the End_Date of the tasks are consecutive, then they are part of the same project. 
-- Samantha is interested in finding the total number of different projects completed.

-- Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
-- If there is more than one project that have the same number of completion days, then order by the start date of the project.

-- 1. output start and end date
-- 2. get # of days took the complete each project
-- 3. order by date took, then order by the start date

-- start_date would not show up on the list of end_date, and vice versa
-- order by datediff()

set sql_mode = ''; -- for changing sql_mode, there are multiple start_date (from a) that has multiple end_date(from b)
select start_date, end_date from
(select start_date from projects where start_date not in (select end_date from projects)) a,
(select end_date from projects where end_date not in (select start_date from projects)) b
where start_date < end_date
group by start_date
order by datediff(end_date, start_date), start_date

-- Write a query to output the names of those students whose best friends got offered a higher salary than them. 
-- Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

-- 1. join students and packages, join friends and packages
-- 2. select those students whose best friends got offered a higher salary

select t1.name from

(select s.id, name, salary from students s
join packages p
on s.id = p.id) t1,

(select f.id, f.friend_id, salary from friends f
join packages p
on f.friend_id = p.id) t2

where t1.salary < t2.salary and
t1.id = t2.id

order by t2.salary

-- make index to prevent counting itself
-- run two tables where x1 = y2 and x2 = y1
-- List the rows such that X1 <= Y1
-- symmetric pairs in ascending order by the value of X
set @t:= 0;
with tmp as (
select *, @t:=@t+1 as id from functions
order by x, y)

select distinct t1.x, t1.y from tmp t1, tmp t2
where 
t1.x = t2.y and t1.y = t2.x and
t1.id <> t2.id and
t1.x <= t1.y;