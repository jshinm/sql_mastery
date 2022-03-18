# Highest Salary In Department

Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.

```
Table: employee
```

```sql
-- employee with the highest salary per dept

-- 1. filter columns
-- 2. groupby dept and find the max
-- 3. search two tables where sal and dept matches

select first_name, m.department, sal from
    (select department, max(salary) as sal from employee group by department) m,
    (select department, first_name, salary from employee) n
where m.department = n.department and
m.sal = n.salary
```