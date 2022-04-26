--create file format
create or replace file format csv
    type = 'csv'
    compression = 'auto'
    field_delimiter = ','
    record_delimiter = '\n'
    skip_header = 0
    field_optionally_enclosed_by = '\042'
    trim_space = false
    error_on_column_count_mismatch = false
    escape = 'none'
    escape_unenclosed_field = '\134'
    date_format = 'auto'
    timestamp_format = 'auto'
    null_if = ('')
    comment = 'file format for ingesting data for zero to snowflake';

-- show the file formats available in the database
show file formats in database citibike;
