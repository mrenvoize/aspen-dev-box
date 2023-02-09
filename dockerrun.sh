#!/usr/bin/env bash

# Last minute configurations
echo "Running installer"
/root/asd-installer/installer.sh
echo "Running site builder"
php /root/asd-installer/createSitedocker.php

# Run the app
echo "Starting apache"
service apache2 start
echo "Starting aspen"
su -c "/usr/local/aspen-discovery/sites/test.localhostaspen/test.localhostaspen.sh start" aspen;

exec "$@"
