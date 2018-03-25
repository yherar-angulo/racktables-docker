# racktables-docker


Racktables https://www.racktables.org/ installation with LDAP Authentication. This works with OpenShift.

* Runs PHP-FPM and NGINX with supervisord as non root
* Expose Port 8080 from nginx

# Environment Variables

* DBHOST= Database Host (Default: mariadb)
* DBNAME= Database Name (Default: racktables)
* DBUSER= Database User (Default: racktables)
* DBPASS= Database Password
* LDAPHOST= LDAP Server Host
* LDAP_SEARCH_DN= DN with your LDAP Users
* LDAP_GROUP_SEARCH_DN= DN with your LDAP Groups
* LDAP_SEARCH_ATTR= Attribute with should match the Username (Default: uid)
* LDAP_GROUP_SEARCH_ATTR = Attribute with the Group Name (Default: cn)
* LDAP_GROUP_SEARCH_MEMBER_ATTR= Attribute where the memberuid is search for in the Group LDAP Object (Default: memberuid)
* LDAP_DISPLAYNAME_ATTR= Displayname Attribute for User (Default: cn)

# Patch for Racktables

I added some modifications to auth.php in order to use LDAP Groups and not only memberof within the LDAP User Object. This modification is currently in my Racktables Fork (https://github.com/splattner/racktables/tree/ldapGroupMembership) and not merged with the official Racktables Repository.


# Remark

* Currently this Dockerized Version is adapted to the needs of my Company, there might be better ways to make things more general.
* Racktables supports more Config Variables for LDAP, not all are implemented in this Dockerized Version
* Altought the Connection to the LDAP Server tries to start TLS, the certificate is not validated "TLS_REQCERT allow" in /etc/openldap/ldap.conf

# Run Example

You habe to adapt this for your environment

Sample docker-compose.yml:

```
racktables:
  build: .
  environment:
  - DBHOST=
  - DBNAME=
  - DBUSER=d
  - DBPASS=
  - LDAPHOST=
  - LDAP_SEARCH_DN=
  - LDAP_GROUP_SEARCH_DN=
  ports:
  - 8000:8080
```