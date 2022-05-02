-- Examples: Obtain a Query Count for Every Login Event
-- Join columns from LOGIN_HISTORY, QUERY_HISTORY, and SESSIONS to obtain a
-- query count for each user login event.

select  l.user_name,
        l.event_timestamp as login_time,
        l.client_ip,
        l.reported_client_type,
        l.first_authentication_factor,
        l.second_authentication_factor,
        count(q.query_id)
from    snowflake.account_usage.login_history as l
join    snowflake.account_usage.sessions as s
    on  (l.event_id = s.login_event_id)
join    snowflake.account_usage.query_history as q
    on  (q.session_id = s.session_id)
group by 1, 2, 3, 4, 5, 6
order by l.user_name;