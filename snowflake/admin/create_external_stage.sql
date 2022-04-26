-- create an external stage
create stage nyc_weather
    url = 's3://snowflake-workshop-lab/weather-nyc';
