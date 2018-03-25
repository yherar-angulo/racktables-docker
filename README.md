# racktables-docker


Racktables https://www.racktables.org/ installation with LDAP Authentication. This works with OpenShift.

* Runs PHP-FPM and NGINX with supervisord as non root
* Expose Port 8080 from nginx


# Run Example

You habe to adapt this for your environment

Sample docker-compose.yml:

```
racktables:
  build: .
  environment:
  - DBHOST=
  - DBNAME=
  - DBUSER=
  - DBPASS=
  - LDAPHOST=
  - LDAP_SEARCH_DN=
  - LDAP_GROUP_SEARCH_DN=
nginx:
  image: nginx:stable-alpine
  links:
  - racktables
  volumes_from:
  - racktables
  volumes:
  - ./nginx.conf:/etc/nginx/nginx.conf
  ports:
  - 8080:8080
```