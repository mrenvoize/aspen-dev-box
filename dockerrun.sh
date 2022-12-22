#!/bin/sh
#

# This script is used to run the docker container
docker exec containeraspen cp -R /test.localhostaspen /usr/local/aspen-discovery/sites
docker exec containeraspen service apache2 start;
docker exec containeraspen su aspen; ls; cd /usr/local/aspen-discovery/sites/test.localhostaspen/; ls; ./test.localhostaspen.sh start;


