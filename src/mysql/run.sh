#!/usr/bin/env bash

puppet apply --modulepath=/src/mysql/run/modules /src/mysql/run/run.pp

DATA="/mysql/data"

if [ ! "$(ls -A ${DATA})" ]; then
  USER="container"
  PASSWORD="container"

  chown mysql.mysql -R /mysql
  chmod 750 ${DATA}

  mysqld --initialize-insecure --user="mysql" > /dev/null 2>&1
  mysqld_safe > /dev/null 2>&1 &

  TIMEOUT=30

  while ! mysqladmin status > /dev/null 2>&1
  do
    TIMEOUT=$((${TIMEOUT} - 1))

    if [ ${TIMEOUT} -eq 0 ]; then
      exit 1
    fi

    sleep 1
  done

  mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY '${PASSWORD}';"
  mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
  mysql -e "RENAME USER 'root' TO '${USER}';"
  mysql -e "CREATE DATABASE ${DEFAULT_DB};"
  mysql -e "FLUSH PRIVILEGES;"
  
  mysqladmin -u "${USER}" -p"${PASSWORD}" shutdown
fi

chown -R mysql.mysql "${DATA}"

supervisord -c /etc/supervisor/supervisord.conf
