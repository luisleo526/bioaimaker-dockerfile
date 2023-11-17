#!/bin/bash
set -e

if [ ! -z "$PASSWORD" ]; then
    echo "root:$PASSWORD" | chpasswd
fi

exec /usr/sbin/sshd -D
