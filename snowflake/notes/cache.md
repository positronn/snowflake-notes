## cache

Snowflake has a result cache that holds the results of every query executed in the past 24 hours.
These are available across warehouses, so query results returned to one user
are available to any other user on the system who executes the same query,
provided the underlying data has not changed. Not only do these repeated queries
return extremely fast, but they also use no compute credits.
