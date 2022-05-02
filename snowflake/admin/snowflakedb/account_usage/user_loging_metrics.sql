use role accountadmin;
use schema snowflake.account_usage;

--
-- Average number of seconds between failed login attempts by user (month-to-date):
select  user_name,
        count(*) as failed_logins,
        avg(seconds_between_loginattempts) as average_seconds_between_login_attempts
from (
        select  user_name,
                timediff(seconds, event_timestamp, lead(event_timestamp)
                    over(partition by user_name order by event_timestamp)) as seconds_between_login_attempts
        from    login_history
        where   event_timestamp > date_trunc(month, current_date)
        and is_success = 'NO'
    )
group by    1
order by    3



-- failed logins by user (month-to-date)
select  user_name,
        sum(iff(is_success = 'NO', 1, 0)) as failed_logins
        count(*) as logins,
        sum(iff(is_success = 'NO', 1, 0)) / nullif(count(*), 0) as login_failure_rate
from    login_history
where   event_timestamp > date_trunc(month, current_date)
group by user_name
order by login_failure_rate desc;


-- Failed logins by user and connecting client (month-to-date):
select  reported_client_type,
        user_name,
        sum(iff(is_success = 'NO', 1, 0)) as failed_logins
        count(*) as logins
        sum(iff(is_success = 'NO', 1, 0)) / nullif(count(*), 0) as login_failure_rate
from    login_history
where event_timestamp > date_trunc(month, current_date)
group by reported_client_type, user_name
order by login_failure_rate desc;