#!/bin/sh

set -e

export LANG=C
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export TZ=America/New_York

# set httpd port
if [ -z "$HTTPD_PORT" ] ; then
    export HTTPD_PORT=80
fi

# update LOG_LEVEL
if [ -z "$LOG_LEVEL" ] ; then
    export LOG_LEVEL=warn
fi

# update SERVER_ADMIN
if [ -z "$SERVER_ADMIN" ] ; then
    export SERVER_ADMIN=devops@broadinstitute.org
fi

# update SERVER_NAME
if [ -z "$SERVER_NAME" ] ; then
    export SERVER_NAME=localhost
fi

# set httpd ssl port
if [ -z "$SSL_HTTPD_PORT" ] ; then
    export SSL_HTTPD_PORT=443
fi

# set SSL protocol
if [ -z "$SSL_PROTOCOL" ] ; then
    export SSL_PROTOCOL='-SSLv3 -TLSv1 -TLSv1.1 +TLSv1.2'
fi

# set the SSL Cipher Suite
if [ -z "$SSL_CIPHER_SUITE" ] ; then
    export SSL_CIPHER_SUITE='ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-ES256-SHA:!3DES:!ADH:!DES:!DH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!EXPORT:!KRB5-DES-CBC3-SHA:!MD5:!PSK:!RC4:!aECDH:!aNULL:!eNULL'
fi

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

exec /usr/sbin/apachectl -DNO_DETACH -DFOREGROUND 2>&1
