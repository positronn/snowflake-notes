
-- To query using the fully-qualified names of the view and table function,
-- in the form of database.information_schema.name:
select *
from table(information_schema.stage_storage_usage_history(dateadd('days',-10,current_date()),current_date()));

SELECT  *
FROM    citibike.INFORMATION_SCHEMA.TABLES
WHERE   TABLE_SCHEMA = 'PUBLIC';

select *
from table(citibike.INFORMATION_SCHEMA.login_history_by_user());


select *
from table(WEATHER.INFORMATION_SCHEMA.login_history(
    TIME_RANGE_START => dateadd('days', -6, current_timestamp()),
                                            current_timestamp())
);


