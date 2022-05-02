-- Credits used by each warehouse in your account (month-to-date):
select  warehouse_name,
        sum(credits_used) as total_credits_used
from    warehouse_metering_history
where start_time >= date_trunc(month, current_date)
group by 1
order by 2 desc;


-- Credits used over time by each warehouse in your account (month-to-date):
select  start_time::date as usage_date,
        warehouse_name,
        sum(credits_used) as total_credits_used
from warehouse_metering_history
where start_time >= date_trunc(month, current_date)
group by 1, 2
order by 2, 1;