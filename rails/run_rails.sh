#!/bin/sh

cd /home/app/sgds
exec chpst -u app bundle install
exec chpst -u app bundle exec rails s
