#!/bin/bash

function persist_dir {
    local link=/var/lib/opendj/$1
    local target=/data/opendj/$1
    if [ -d /data ] && [ ! -L $link ]; then
        if [ ! -d $target ]; then
            echo "Configuring persistence of opendj/$1..."
            mkdir -p `dirname $target`
            mv $link $target
        else
            echo "Restoring persisted opendj/$1..."
            rm -rf $link
        fi

        ln -f -s $target $link
    fi
}

# Persist data
for directory in db config logs bak; do
    persist_dir $directory
done


# Start opendj

ulimit -n 10240
# Source function library
cd /var/lib/opendj

exec /sbin/setuser opendj bin/start-ds -N
