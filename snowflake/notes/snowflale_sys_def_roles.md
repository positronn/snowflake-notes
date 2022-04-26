# Roles

There are a small number of system-defined roles in a Snowflake account.
System-defined roles cannot be dropped. In addition, the privileges granted
to these roles by Snowflake cannot be revoked.

Users who have been granted a role with the necessary privileges can
create custom roles to meet specific business and security needs.

## System-Defined Roles

- ORGADMIN:
    
    Role that manages operations at the organization level. More specifically, this role:
    * Can create accounts in the organization.
    * Can view all accounts in the organization (using SHOW ORGANIZATION ACCOUNTS) as well as all regions enabled for the organization (using SHOW REGIONS).
    * Can view usage information across the organization.

- ACCOUNTADMIN:
    
    Role that encapsulates the SYSADMIN and SECURITYADMIN system-defined roles. It is the top-level role in the system and should be granted only to a limited/controlled number of users in your account.

- SECURITYADMIN

    Role that can manage any object grant globally, as well as create, monitor, and manage users and roles. More specifically, this role:
    * Is granted the MANAGE GRANTS security privilege to be able to modify any grant, including revoking it.
    * Inherits the privileges of the USERADMIN role via the system role hierarchy (e.g. USERADMIN role is granted to SECURITYADMIN).

- USERADMIN

    Role that is dedicated to user and role management only. More specifically, this role:
    * Is granted the CREATE USER and CREATE ROLE security privileges.
    * Can create users and roles in the account.
    
    This role can also manage users and roles that it owns. Only the role with the OWNERSHIP privilege on an object (i.e. user or role), or a higher role, can modify the object properties.

- SYSADMIN
    Role that has privileges to create warehouses and databases (and other objects) in an account.
    * If, as recommended, you create a role hierarchy that ultimately assigns all custom roles to the SYSADMIN role, this role also has the ability to grant privileges on warehouses, databases, and other objects to other roles.

- PUBLIC
    Pseudo-role that is automatically granted to every user and every role in your account. The PUBLIC role can own securable objects, just like any other role; however, the objects owned by the role are, by definition, available to every other user and role in your account.

    This role is typically used in cases where explicit access control is not needed and all users are viewed as equal with regard to their access rights.}


When creating roles that will serve as the owners of securable objects in the system, Snowflake recommends creating a hierarchy of custom roles, with the top-most custom role assigned to the system role SYSADMIN. This role structure allows system administrators to manage all objects in the account, such as warehouses and database objects, while restricting management of users and roles to the USERADMIN role.

Conversely, if a custom role is not assigned to SYSADMIN through a role hierarchy, the system administrators will not be able to manage the objects owned by the role. Only those roles granted the MANAGE GRANTS privilege (only the SECURITYADMIN role by default) can view the objects and modify their access grants.

