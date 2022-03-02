# Workers With The Highest Salaries

Find the titles of workers that earn the highest salary. Output the highest-paid title or multiple titles that share the highest salary.

```
Tables: worker, title
```

```sql
-- title of worker with highest salary
-- output - highest-paid title

-- 1. get col of interest
-- 2. get highest from worker
-- 3. join worker with title

select salary, t.worker_title from worker
join title t
on worker_id = t.worker_ref_id
where salary = (select max(worker.salary) from worker)
```