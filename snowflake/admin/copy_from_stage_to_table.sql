copy into trips
from @citibike_trips
    file_format = csv
    PATTERN = '.*csv.*' ;

copy into json_weather_data 
from @nyc_weather 
    file_format = (type=json);