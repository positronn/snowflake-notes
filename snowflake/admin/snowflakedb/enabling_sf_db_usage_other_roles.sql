-- By default, the SNOWFLAKE database is available only to the ACCOUNTADMIN role.
-- To enable other roles to access the database and schemas, and query the views, a user with the ACCOUNTADMIN role must grant the following data sharing privilege to the desired roles:
-- IMPORTED PRIVILEGES

-- example
use role accountadmin;

grant imported privileges on database snowflake to role sysadmin;
grant imported privileges on database snowflake to role customrole1;

use role cusotmrole1;

select * from snowflake.account_usage.databases;