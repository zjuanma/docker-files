#!/bin/sh
# Oracle Client
if [ ! -f /opt/oracle/client ]; then
  apt-get update
  apt-get install -y unzip libaio1
  mkdir -p /opt/oracle/client
  cd /opt/oracle/client
  unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip
  unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip
  unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip

  cd /opt/oracle/client/instantclient_12_1
  ln -s libclntsh.so.12.1 libclntsh.so

  echo 'LD_LIBRARY_PATH=/opt/oracle/client/instantclient_12_1' >> /etc/environment
fi
