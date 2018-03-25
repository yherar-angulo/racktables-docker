# racktables-docker


Racktables https://www.racktables.org/ installation with LDAP Authentication


# Run Example

You habe to adapt this for your environment

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
  - 8000:80
```