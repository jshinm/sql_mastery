# Ranking Most Active Guests

Rank guests based on the number of messages they've exchanged with the hosts. Guests with the same number of messages as other guests should have the same rank. Do not skip rankings if the preceding rankings are identical. Output the rank, guest id, and number of total messages they've sent. Order by the highest number of total messages first.

```
Tables: customers, orders
```

```sql
-- rank guest based on the number of messages exchanged with the hosts.
-- same rank should exist (i.e., don't skip ranks)
-- order by the highest number of total messages first
-- output: rank, guest_id, total number of messages sent

-- 1. group by `id_guest` and agg over `n_messages`
-- 2. dense_rank partition by `id_guest` order by total messages in descending order


```
