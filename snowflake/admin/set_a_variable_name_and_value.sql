-- this sets the result from the query to the variable query_id
set query_id = (
    select
        query_id
    from
        table(information_schema.query_history_by_session (result_limit=>5))
    where
        query_text like 'update%'
    order by start_time
    limit 1
);
