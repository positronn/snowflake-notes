--
-- Total jobs executed in your account (month-to-date):
select  count(*) as number_of_jobs
from    query_history
where   start_time >= date_trunc(month, current_date)


-- Total jobs executed by each warehouse in your account (month-to-date):
select  warehouse_name,
        count(*) as number_of_jobs
from query_history
where start_time >= date_trunc(month, current_date)
group by 1
order by 2 desc;


-- Average query execution time by query type and warehouse size (month-to-date):
select  query_type,
        warehouse_size,
        avg(execution_time) as average_execution_time
from query_history
where start_time >= date_trunc(month, current_date)
group by 1, 2
order by 3 desc;