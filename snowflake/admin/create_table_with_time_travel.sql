-- Use Time Travel to recreate the table with the correct station names:
create or replace table trips as (
    select * from trips before (statement => $query_id)
);
