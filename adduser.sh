#!/bin/bash

# Add aspen user
useradd aspen

# Ensure userid matches host userid
usermod -o -u "${LOCAL_USER_ID}" aspen

# Add all existing users to the aspen group
for ID in $(cat /etc/passwd | grep /home | cut -d ':' -f1); do (usermod -a -G aspen $ID);done

# Add the aspen_apache group as well for files that need to be readable (and writable) by apache
groupadd aspen_apache

# Add www-data and aspen to the aspen_apache group
usermod -a -G aspen_apache www-data
usermod -a -G aspen_apache aspen

# Add solr user
useradd solr

# Add solr to the aspen group
usermod -a -G aspen solr
