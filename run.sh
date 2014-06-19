#!/bin/sh
set -e

if [ -z "$(ls -A /var/lib/mysql)" ]; then
    mysql_install_db --datadir=/var/lib/mysql
    echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '' WITH GRANT OPTION;" > /tmp/mysql-first-time.sql
    echo "FLUSH PRIVILEGES;" >> /tmp/mysql-first-time.sql

    chown -R mysql:mysql /var/lib/mysql
    exec "$@" --init-file=/tmp/mysql-first-time.sql
fi

chown -R mysql:mysql /var/lib/mysql
exec "$@"
