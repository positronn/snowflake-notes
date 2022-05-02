-- Find queries by type that consume the most cloud services credits
-- the current role must have access ot the account usage share
use schema snowflake.account_usage;

select  query_type,
        sum(credits_used_cloud_services) as cs_credits,
        count(1) as num_queries
from query_history
where 1 = 1
    and start_time >= timestampadd(day, -1, current_timestamp)
group by 1
order by 2 desc
limit 10;


-- Find queries of a given type that consume the most cloud services credits
-- the current role must have access to the account usage share
use schema snowflake.account_usage;

select  *
from    query_history
where true
    and start_time >= timestmapdd(day, -1, current_timestamp)
    and query_type = 'COPY'
order by credits_used_cloud_services desc
limit 10;

-- Sort by different components of cloud services usage
-- TThe current role must have access to the account usage share
use schema snowflake.account_usage;

select *
from query_history
where true
    and start_time >= timestampadd(day, -60, current_timestamp)
    -- and query_type = 'COPY' -- optnional
order by    compilation_time desc,
            execution_time desc,
            list_external_files_time desc,
            queued_overload_time desc,
            credits_used_cloud_services desc
limit 20;

ami
-- Find warehouses that consume the most cloud services credits
-- the current role must have access to the account usage share
use schema snowflake.account_usage;

select  warehouse_name,
        sum(credits_used_cloud_services) as credits_used_cloud_services,
        sum(credits_used_compute) as credits_used_compute,
        sum(credits_used) as credits_used
from    warehouse_metering_history
where true
    and start_time >= timestampadd(day, -1, current_timestamp)
group by 1
order by 2 desc
limit 10;