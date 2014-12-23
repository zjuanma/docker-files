FROM phusion/passenger-customizable:0.9.14

# Set correct environment variables.
ENV HOME /root

RUN /usr/sbin/enable_insecure_key

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Ruby 2.1
RUN /build/ruby2.1.sh

# Clean up APT when done.
USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Change app uid/gid to local uid/gi
RUN usermod -u 1000 app;                        \
    groupmod -g 1000 app;                          \
    find /home/app -user 9999 -exec chown -h 1000 {} \;  ;   \
    find /home/app -group 9999 -exec chgrp -h 1000 {} \; ;   \
    usermod -g 1000 app

# Bundle Install
RUN mkdir /home/app/gems
ENV GEM_HOME /home/app/gems
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
USER root
COPY docker/rails_mysql/bash_aliases /home/app/.bash_aliases
RUN chown -R app:app /home/app/.bash_aliases

# Rails Port
EXPOSE 3000
