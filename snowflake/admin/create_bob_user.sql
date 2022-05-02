USE ROLE SECURITYADMIN;
-- create role
CREATE ROLE READ_ALL_ONLY_ROLE;
GRANT ROLE READ_ALL_ONLY_ROLE TO ROLE SYSADMIN;


SHOW ROLES;
-- create a warehouse
CREATE WAREHOUSE IDENTIFIER('"READ_ALL_DB_ONLY_XS_WH"')
       WAREHOUSE_SIZE = 'XSMALL'
       AUTO_RESUME = true
       AUTO_SUSPEND = 180
       MIN_CLUSTER_COUNT = 1
       MAX_CLUSTER_COUNT = 4
       SCALING_POLICY = 'STANDARD';
       
-- create a warehouse
CREATE WAREHOUSE IDENTIFIER('"READ_ALL_DB_ONLY_M_WH"')
       WAREHOUSE_SIZE = 'MEDIUM'
       AUTO_RESUME = true
       AUTO_SUSPEND = 180
       MIN_CLUSTER_COUNT = 1
       MAX_CLUSTER_COUNT = 4
       SCALING_POLICY = 'STANDARD';
       
-- create a warehouse
CREATE WAREHOUSE IDENTIFIER('"READ_ALL_DB_ONLY_L_WH"')
       WAREHOUSE_SIZE = 'LARGE'
       AUTO_RESUME = true
       AUTO_SUSPEND = 180
       MIN_CLUSTER_COUNT = 1
       MAX_CLUSTER_COUNT = 4
       SCALING_POLICY = 'ECONOMY';
       
USE ROLE READ_ALL_ONLY_ROLE;
SHOW WAREHOUSES;
GRANT OPERATE,USAGE ON WAREHOUSE READ_ALL_DB_ONLY_XS_WH TO ROLE READ_ALL_ONLY_ROLE;
GRANT OPERATE,USAGE ON WAREHOUSE READ_ALL_DB_ONLY_M_WH TO ROLE READ_ALL_ONLY_ROLE;
GRANT OPERATE,USAGE ON WAREHOUSE READ_ALL_DB_ONLY_L_WH TO ROLE READ_ALL_ONLY_ROLE;


USE ROLE SYSADMIN;
ALTER WAREHOUSE READ_ALL_DB_ONLY_XS_WH SUSPEND;


USE ROLE SECURITYADMIN;
-- grant privileges to role READ_ALL_ONLY_ROLE
GRANT USAGE ON DATABASE CITIBIKE TO ROLE READ_ALL_ONLY_ROLE;
GRANT USAGE ON DATABASE WEATHER TO ROLE READ_ALL_ONLY_ROLE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE CITIBIKE TO ROLE READ_ALL_ONLY_ROLE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE WEATHER TO ROLE READ_ALL_ONLY_ROLE;

GRANT SELECT ON ALL TABLES IN SCHEMA CITIBIKE.PUBLIC TO ROLE READ_ALL_ONLY_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA WEATHER.PUBLIC TO ROLE READ_ALL_ONLY_ROLE;


-- create a user and prompt it to change its password
GRANT ROLE READ_ALL_ONLY_ROLE TO USER bobterreros;
CREATE USER bobterreros
    PASSWORD = 'thisisapassword'
    MUST_CHANGE_PASSWORD = true
    EMAIL = 'roberto.terreros@gmail.com'
    DAYS_TO_EXPIRY = 10
    DEFAULT_ROLE = 'READ_ALL_ONLY_ROLE'
    FIRST_NAME = 'Roberto'
    LAST_NAME = 'Terreros';


GRANT ROLE SYSADMIN TO USER bobterreros;
GRANT ROLE READ_ALL_ONLY_ROLE TO ROLE SYSADMIN;
