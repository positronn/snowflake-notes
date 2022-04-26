## clone table

Snowflake allows you to create clones, also known as "zero-copy clones" of tables,
schemas, and databases in seconds. When a clone is created, Snowflake takes a snapshot
of data present in the source object and makes it available to the cloned object.
The cloned object is writable and independent of the clone source. Therefore, changes
made to either the source object or the clone object are not included in the other.

A popular use case for zero-copy cloning is to clone a production environment
for use by Development & Testing teams to test and experiment without adversely
impacting the production environment and eliminating the need to set up and manage
two separate environments.

Zero-Copy Cloning A massive benefit of zero-copy cloning is that the underlying
data is not copied. Only the metadata and pointers to the underlying data change.
Hence, clones are "zero-copy" and storage requirements are not doubled when the
data is cloned. Most data warehouses cannot do this, but for Snowflake it is 
