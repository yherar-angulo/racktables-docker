#!/bin/sh -e

: "${DBNAME:=racktables}"
: "${DBHOST:=mariadb}"
: "${DBUSER:=racktables}"

: "${LDAP_SEARCH_ATTR:=uid}"
: "${LDAP_GROUP_SEARCH_ATTR:=cn}"
: "${LDAP_GROUP_SEARCH_MEMBER_ATTR:=memberuid}"
: "${LDAP_DISPLAYNAME_ATTR:=cn}"


if [ ! -e /opt/racktables/wwwroot/inc/secret.php ]; then
    cat > /opt/racktables/wwwroot/inc/secret.php <<EOF
<?php

\$pdo_dsn = 'mysql:host=${DBHOST};dbname=${DBNAME}';
\$db_username = '${DBUSER}';
\$db_password = '${DBPASS}';

\$user_auth_src = 'ldap';
\$require_local_account = FALSE;

\$LDAP_options = array
(
        'server' => '${LDAPHOST}',
        'search_attr' => '${LDAP_SEARCH_ATTR}',
        'search_dn' => '${LDAP_SEARCH_DN}',
        'group_search_dn' => '${LDAP_GROUP_SEARCH_DN}',
        'group_search_attr' => '${LDAP_GROUP_SEARCH_ATTR}',
        'group_search_member_attr' => '${LDAP_GROUP_SEARCH_MEMBER_ATTR}',
        'displayname_attrs' => '${LDAP_DISPLAYNAME_ATTR}',
        'use_tls' => 1,         // 0 == don't attempt, 1 == attempt, 2 == require,
);
?>
EOF
fi

chgrp 0 /opt/racktables/wwwroot/inc/secret.php

echo 'To initialize the db, first go to /?module=installer&step=5'

exec "$@"
