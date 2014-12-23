#!/bin/bash
sysctl kernel.shmmax=18446744073692774399

chown db2inst1:db2inst1 /home/db2inst1

function create_instance {
  if [ ! -d /home/db2inst1/sqllib ]; then

    /opt/ibm/db2/V10.5/instance/db2icrt -u db2inst1 -p 50000 db2inst1

  fi
}

function start_server {
  # Start db2 server
  echo "Starting db2"

  su - db2inst1 -c "source /home/db2inst1/sqllib/db2profile && \
                    db2start"
}

function create_databases {
  start_server
  for database in $DB2_DATABASES
  do
    echo "Check database $database"
    found=`find /home/db2inst1 -type d -name "$database" -print -quit`
    if [ -z "$found"  ]; then
      echo "Creating database $database"
      su - db2inst1 -c "source /home/db2inst1/sqllib/db2profile && \
                        db2 create database $database"
    fi
  done
  su - db2inst1 -c "source /home/db2inst1/sqllib/db2profile && db2stop"
}

create_instance

create_databases

start_server

sleep 10s

tail -f /home/db2inst1/sqllib/log/instance.log
