FROM phusion/passenger-customizable:0.9.14

# Set correct environment variables.
ENV HOME /root

RUN /usr/sbin/enable_insecure_key

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Ruby 2.1
RUN /build/ruby2.1.sh

# Install Oracle client
ADD ./docker/oracle/client/instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/
ADD ./docker/oracle/client/instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/
ADD ./docker/oracle/client/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip /tmp/
ADD ./docker/oracle/build_client.sh /tmp/
RUN /tmp/build_client.sh

# Change app uid/gid to local uid/gi
RUN usermod -u 1000 app;                        \
    groupmod -g 1000 app;                          \
    find /home/app -user 9999 -exec chown -h 1000 {} \;  ;   \
    find /home/app -group 9999 -exec chgrp -h 1000 {} \; ;   \
    usermod -g 1000 app

# Bundle Install
RUN mkdir /home/app/gems
ENV GEM_HOME /home/app/gems
ENV LD_LIBRARY_PATH /opt/oracle/client/instantclient_12_1
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
WORKDIR /tmp
RUN bundle install --without production
RUN chown -R app:app /home/app/gems;       \
    echo 'export GEM_HOME=/home/app/gems' >> /home/app/.bashrc

# Make application directory
USER app
RUN mkdir /home/app/sgds
ADD . /home/app/sgds

# Copy bash_alias
COPY ./docker/rails/bash_aliases /home/app/.bash_aliases
RUN chown -R app:app /home/app/.bash_aliases

# Init Rails server
RUN mkdir /etc/service/rails
ADD run_rails.sh /etc/service/rails/run



# Clean up APT when done.
USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Rails Port
EXPOSE 3000
