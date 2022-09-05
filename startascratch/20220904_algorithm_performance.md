# Algorithm Performance

Meta/Facebook is developing a search algorithm that will allow users to search through their post history. You are assigned to evaluate the performance of this algorithm.


We have a table with the user's search term, search result positions, and whether or not the user clicked on the search result.


Write a query that assigns ratings to the searches in the following way:
- If the search was not clicked for any term, assign the search with rating=1
- If the search was clicked but the top position of clicked terms was outside the top 3 positions, give it a rating=2
- If the search was clicked and the top position of a clicked term was in the top 3 positions, give it a rating=3


Output the search ID and it's rating.

```
Tables: fb_search_events
```

```sql

```
