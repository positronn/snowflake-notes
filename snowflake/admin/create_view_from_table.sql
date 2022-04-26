-- Views & Materialized Views A view allows the result of a query to be accessed
-- as if it were a table. Views can help present data to end users in a cleaner
-- manner, limit what end users can view in a source table, and write more modular
-- SQL. Snowflake also supports materialized views in which the query results are
-- stored as though the results are a table. This allows faster access, but requires
-- storage space. Materialized views can be created and queried if you are using
-- Snowflake Enterprise Edition (or higher).

create view json_weather_data_view as
select
    v:time::timestamp as observation_time,
    v:city.id::int as city_id,
    v:city.name::string as city_name,
    v:city.country::string as country,
    v:city.coord.lat::float as city_lat,
    v:city.coord.lon::float as city_lon,
    v:clouds.all::int as clouds,
    (v:main.temp::float)-273.15 as temp_avg,
    (v:main.temp_min::float)-273.15 as temp_min,
    (v:main.temp_max::float)-273.15 as temp_max,
    v:weather[0].main::string as weather,
    v:weather[0].description::string as weather_desc,
    v:weather[0].icon::string as weather_icon,
    v:wind.deg::float as wind_dir,
    v:wind.speed::float as wind_speed
from json_weather_data
where
    city_id = 5128638;

-- SQL dot notation v:city.coord.lat is used in this command to
-- pull out values at lower levels within the JSON object hierarchy.
-- This allows us to treat each field as if it were a column in a relational table.

-- 
create view citibike.public.trips_by_conditions as
select
    weather as conditions,
    count(*) as num_trips
from CITIBIKE.PUBLIC.TRIPS
left outer join WEATHER.PUBLIC.JSON_WEATHER_DATA_VIEW
    on (date_trunc('hour', observation_time) = date_trunc('hour', starttime))
where
    conditions is not null
group by 1
order by 2
desc;