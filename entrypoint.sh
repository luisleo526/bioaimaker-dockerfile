#!/bin/bash
set -e

# Check supervisor log folder
SUPERVISOR_FOLDER=/var/log/supervisor
if [ ! -d "$SUPERVISOR_FOLDER" ]; then
    mkdir $SUPERVISOR_FOLDER
fi

supervisord -c /usr/local/etc/supervisord.conf
