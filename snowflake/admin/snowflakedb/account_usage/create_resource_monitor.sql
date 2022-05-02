--
-- To create a monitor that starts monitoring immediately, resets at
-- the beginning of each month, and suspends the assigned warehouse when
-- the used credits reach 100% of the credit quota:
use role accountadmin;
create or replace resource monitor monitor_name
    with    credit_quota = 1000
            triggers on 100 percent do suspend;

alter warehouse wh1 set recource_monitor = monitor_name;


-- To create a monitor that is similar to the first example,
-- but suspends at 90% and suspends immediately at 100% to prevent
-- all warehouses in the account from consuming credits after the quota has been reached:
use role accountadmin;
create or replace resource monitor limit1
    with credit_quota = 1000
         triggers on 90 percent do suspend
                  on 100 prtcent do suspend_immediate;

alter warehouse wh1 set resource_monitor = limit1;

-- In this example, a notification is generated and the assigned warehouses
-- are suspended when 90% usage is reached, which prevents the warehouses
-- from executing any new queries, but allows currently-executing queries
-- to complete. If the assigned warehouses reach 100% usage, a notification is
-- generated and the warehouses are suspended immediately, canceling all currently-executing queries.


-- To create a monitor that is similar to the first example, but
-- lets the assigned warehouse exceed the quota by 10% and also includes
-- two notification actions to alert account administrators as the used credits
-- reach the halfway and three-quarters points for the quota:
use role accountadmin;

create or replace resource monitor limit1
    with credit_quota = 1000
         triggers on 50 percent do notify
                  on 75 percent do notify
                  on 100 percent do suspend
                  on 110 percent do suspend_immediate;

alter warehouse wh1 set resource_monitor = limit1;

--  When 50% and 75% usage is reached, an alert notification is sent to all account
--     administrators who have enabled notifications, but no other actions are performed.
-- When 100% usage is reached, the assigned warehouse is suspended.
-- If the warehouse is still running when 110% usage is reached, it is suspended immediately.



-- Creating a Resource Monitor with a Custom Schedule
use role accountadmin;
create or replace resource monitor limit1
    with credit_quota = 1000
         frequency = monthly
         start_timestamp = immediately
         triggers on 100 percent do suspend;

alter warehouse wh1 set resource_monitor = limit1;


-- To create a resource monitor that starts at a specific date and time in
-- the future, resets weekly on the same day, has no end date or time, and performs
-- two different suspend actions at different thresholds on two assigned warehouses:
use role accountadmin;
create or replace resource monitor limit1
    with credit_quota = 2000
         frequency = weekly
         start_timestmap = '2019-03-04 00:00 PST'
         triggers on 80 percent do suspend
                  on 100 percent do suspend_immediate

alter warehouse wh1
    set resource_monitor = limit1;
alter warehouse wh2
    set resource_monitor = limit1;


-- to increase the credit quota for limit1 to 3000:
alter resource monitor limit1
    set credit_qupta = 3000;

-- If a resource monitor has a customized schedule, you cannot change the schedule
-- back to the default. You must drop the monitor and create a new monitor.
