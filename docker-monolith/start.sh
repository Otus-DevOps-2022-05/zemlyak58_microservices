#!/bin/bash

/usr/bin/mongodb --fork --logpath /var/log/mongodb.log --config /etc/mongodb.conf

service mongodb start
source /reddit/db_config

cd /reddit && puma || exit
