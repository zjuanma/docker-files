FROM phusion/baseimage:0.9.15

# Set correct environment variables.
ENV HOME /root


RUN /usr/sbin/enable_insecure_key

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install mysql
RUN add-apt-repository universe
RUN apt-get update
RUN apt-get install -y mysql-server mysql-client
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Init mysql
RUN mkdir /etc/service/mysqld
ADD mysqld.sh /etc/service/mysqld/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3306
