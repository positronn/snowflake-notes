CREATE WAREHOUSE IDENTIFIER('"ACCNT_ADMIN_XS_WH"')
       COMMENT = 'Compute instance for accountadmin role-user. Auto-scale mode, min-clusters=1, max-clusters=4, scaling-policy=standard. Suspend after 2 mins.'
       WAREHOUSE_SIZE = 'X-Small'
       AUTO_RESUME = true
       AUTO_SUSPEND = 120
       MIN_CLUSTER_COUNT = 1
       MAX_CLUSTER_COUNT = 4
       SCALING_POLICY = 'STANDARD';