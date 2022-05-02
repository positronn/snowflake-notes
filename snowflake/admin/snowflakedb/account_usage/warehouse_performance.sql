--
-- This query calculates virtual warehouse performance metrics such as
-- throughput and latency for 15-minute time intervals over the course of one day.

-- In the code sample below, replace CURRENT_WAREHOUSE() with 'MY_WH'
-- to calculate metrics for a specific warehouse. In addition,
-- change the time_from and time_to dates in the WITH clause.

with params as (
    select  current_warehouse() as warehouse_name,
            '2021-11-01' as time_from,
            '2021-11-02' as time_to
),

jobs as (
    select  query_id,
            time_slice(start_time::timestamp_ntz, 15, 'minute', 'start') as interval_start,
            qh.warehouse_name,
            database_name,
            query_type,
            total_elapsed_time,
            compilation_time as compilation_and_scheduling_time,
            (queued_provisioning_time + queued_repair_time + queued_overload_time) as queued_time,
            transaction_blocked_time,
            execution_time
    from    snowflake.account_usage.query_history as qh, params
    where   qh.warehouse_name = params.warehouse_name
        and start_time >= params.time_from
        and start_time <= params.time_to
        and execution_status = 'SUCCESS'
        and query_type in ('SELECT', 'UDPATE', 'INSERT', 'MERGE', 'DELETE')
),

interval_stats as (
    select  query_type,
            interval_start,
            count(distinct query_id) as numjobs,
            median(total_elapsed_time)/1000 as p50_total_duration,
            (percentile_cont(0.95) within group (order by total_elapsed_time))/1000 as p95_total_duration,
            sum(total_elapsed_time)/1000 as sum_total_duration,
            sum(compilation_and_scheduling_time)/1000 as sum_compilation_and_scheduling_time,
            sum(queued_time)/1000 as sum_queued_time,
            sum(transaction_blocked_time)/1000 as sum_transaction_blocked_time,
            sum(execution_time)/1000 as sum_execution_time,
            round(sum_compilation_and_scheduling_time/sum_total_duration,2) as compilation_and_scheduling_ratio,
            round(sum_queued_time/sum_total_duration,2) as queued_ratio,
            round(sum_transaction_blocked_time/sum_total_duration,2) as blocked_ratio,
            round(sum_execution_time/sum_total_duration,2) as execution_ratio,
            round(sum_total_duration/numjobs,2) as total_duration_perjob,
            round(sum_compilation_and_scheduling_time/numjobs,2) as compilation_and_scheduling_perjob,
            round(sum_queued_time/numjobs,2) as queued_perjob,
            round(sum_transaction_blocked_time/numjobs,2) as blocked_perjob,
            round(sum_execution_time/numjobs,2) as execution_perjob
    from    jobs
    group by 1,2
    order by 1,2
)

select *
from interval_stats;


-- the `num_jobs` value represents the throughput for that time interval
-- the `P50_TOTA_DURATION` (median) and `P95_TOTAL_DURATION` (peak) values represent latency
-- The SUM_TOTAL_DURATION is the sum of the SUM_<job_stage>_TIME values for the
--    different job stages (COMPILATION_AND_SCHEDULING, QUEUED, BLOCKED, EXECUTION).
--
