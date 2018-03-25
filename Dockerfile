
FROM alpine:3.7


ENV DBHOST="mariadb" \
    DBNAME="racktables" \
    DBUSER="racktables" \
    DBPASS="" \
    LDAPHOST="" \
    LDAP_SEARCH_ATTR="uid" \
    LDAP_SEARCH_DN="" \
    LDAP_GROUP_SEARCH_DN="" \
    LDAP_GROUP_SEARCH_ATTR="cn" \
    LDAP_GROUP_SEARCH_MEMBER_ATTR="memberuid" \
    LDAP_DISPLAYNAME_ATTR="cn"


COPY entrypoint.sh /entrypoint.sh
RUN apk --no-cache add \
    ca-certificates \
    curl \
    php5-bcmath \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-json \
    php5-ldap \
    php5-pcntl \
    php5-pdo_mysql \
    php5-snmp \
    php5-ldap \
    && chmod +x /entrypoint.sh \
    && curl -sSLo /racktables.tar.gz 'https://github.com/RackTables/racktables/archive/RackTables-0.21.1.tar.gz' \
    && mkdir /opt \
    && tar -xz -C /opt -f /racktables.tar.gz \
    && mv /opt/racktables-RackTables-0.21.1 /opt/racktables \
    && rm -f /racktables.tar.gz \
    && sed -i \
    -e 's|^listen =.*$|listen = 9000|' \
    -e 's|^;daemonize =.*$|daemonize = no|' \
    /etc/php5/php-fpm.conf 

# Patch Auth File for Group Authentication
COPY patch/auth.php /opt/racktables/wwwroot/inc/auth.php

RUN chmod -R g+rwX /etc/php5/ && \
    chgrp -R 0 /etc/php5/
    
RUN chmod -R g+rwX /var/log/ && \
    chgrp -R 0 /var/log

RUN chgrp -R 0 /opt/racktables

RUN echo "TLS_REQCERT allow" > /etc/openldap/ldap.conf

VOLUME /opt/racktables/wwwroot
EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/php-fpm5"]

USER 1000
