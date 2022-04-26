-- To query an object (e.g. a table or view), a role must have the USAGE
-- privilege on a warehouse. The warehouse provides the compute resources to execute the query.
-- To operate on any object in a schema, a role must have the USAGE privilege
-- on the container database and schema.
GRANT USAGE
  ON DATABASE <database_name>
  TO ROLE read_only;

GRANT USAGE
  ON SCHEMA <database_name>.<schema_name>
  TO ROLE read_only;

GRANT SELECT
  ON ALL TABLES IN SCHEMA <database_name>.<schema_name>
  TO ROLE read_only;

-- grant select to future tables
GRANT SELECT
  ON FUTURE TABLES IN SCHEMA <database_name>.<schema_name>
  TO ROLE read_only;

GRANT USAGE
  ON WAREHOUSE <warehouse_name>
  TO ROLE read_only;


-- to view the current permissions on a schema, execute the following command:
SHOW GRANTS ON SCHEMA <database_name>.<schema_name>;

-- You can also run the SHOW GRANTS command to view the current
-- set of privileges granted to a role, or the current set of roles granted to a user:
SHOW GRANTS TO ROLE <role_name>;
SHOW GRANTS TO USER <user_name>;


-- Grant the USAGE privilege on all future schemas in a database to role r1
grant usage on future schemas in database d1 to role r1;
-- Grant the SELECT privilege on all future tables in a schema to role r1
GRANT SELECT ON FUTURE TABLES IN SCHEMA d1.s1 TO ROLE r1;
-- Grants the SELECT and INSERT privileges on all future tables in a schema to r1
grant select,insert on future tables in schema d1.s1 to role r1;


-- Future grants only pertain to new objects. You must explicitly grant
-- the desired privileges to a role on existing objects using the GRANT <privileges> … TO ROLE command.

-- Grant the USAGE privilege on all existing schemas in a database to role r1
grant usage on all schemas in database d1 to role r1;
-- Grant the SELECT privilege on all existing tables in a schema to role r1
grant select on all tables in schema d1.s1 to role r1


-- You can revoking future grants on database objects using the
-- REVOKE <privileges> … FROM ROLE command with the ON FUTURE keywords.
-- Revoking future grants on database objects, only removes privileges granted
-- on future objects of a specified type rather than existing objects.
-- Any privileges granted on existing objects are retained.

-- Revoke the USAGE privilege on all existing schemas in a database from role r1
revoke usage on all schemas in database d1 from role r1;
-- Revoke the SELECT and INSERT privileges on tables in a schema from the role r1
revoke select,insert on future tables in schema d1.s1 from role r1;

-- Future grants are not applied when renaming or swapping a table.
-- When a database is cloned, the schemas in the cloned database copy the
-- future privileges from the source schemas. This maintains consistency with
-- the regular object grants, in which the grants of the
-- source object (i.e. database) are not copied to the clone, but the
-- grants on all the children objects (i.e. schemas in the database) are copied to the clones.


--
-- Creating Managed Access Schemas
--
-- Managed access schemas improve security by locking down privilege management on objects.
-- In regular (i.e. non-managed) schemas, object owners
-- (i.e. a role with the OWNERSHIP privilege on an object) can grant access on
-- their objects to other roles, with the option to further grant those roles
-- the ability to manage object grants.
-- With managed access schemas, object owners lose the ability to
-- make grant decisions. Only the schema owner (i.e. the role with the
-- OWNERSHIP privilege on the schema) or a role with the MANAGE GRANTS privilege
-- can grant privileges on objects in the schema, including future grants, centralizing privilege management.
create schema <database_name>.<schema_name> WITH MANAGED ACCESS
-- or alter the schema
alter schema  <database_name>.<schema_name> ENABLE | DISABLE MANAGED ACCESS


-- To enable users who are not account administrators to access/view this information,
-- grant the following privileges to a system-defined or custom role.
-- Granting the privileges to a role allows all users who are granted the role to
-- access this historical/usage information:
-- For example, to grant these permissions to the custom role:
GRANT MONITOR USAGE ON ACCOUNT TO ROLE custom;
GRANT IMPORTED PRIVILEGES ON DATABASE snowflake TO ROLE custom;
