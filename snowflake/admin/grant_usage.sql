use role sysadmin;

grant usage on database citibike to role junior_dba;
grant usage on database weather to role junior_dba;


-- the USAGE privilege required to view and use a database
-- this will not give access or grant usage to a schema though