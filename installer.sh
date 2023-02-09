#!/bin/sh

#This will need to be copied to the server manually to do the setup.
#Expects to be installed on Debian 10 Buster
#Run as sudo ./installer.sh
#service apache2 start
#systemctl enable apache2
# New PHP ini file
# - Change max_memory to 256M (from 128M)
# - Increase max file size to 50M
# - Increase max post size to 50M
echo "Backing up php.ini"
mv -v /etc/php/7.3/apache2/php.ini /etc/php/7.3/apache2/php.ini.old

echo "Installing custom php.ini" 
cp -v /usr/local/aspen-discovery/install/php.ini /etc/php/7.3/apache2/php.ini
#apt install -y mariadb-server
#mv /etc/mysql/mariadb.cnf /etc/mysql/mariadb.cnf.old
#cp mariadb.cnf /etc/mysql/mariadb.cnf

#Create temp smarty directories
echo "Create /usr/local/aspen-discovery/tmp"
mkdir -v -p /usr/local/aspen-discovery/tmp
echo "Fixing permissions on /usr/local/aspen-discovery/tmp"
chown -R www-data:www-data /usr/local/aspen-discovery/tmp
chmod -R 755 /usr/local/aspen-discovery/tmp
cd /usr/local/aspen-discovery || exit

#Increase entropy
cp -v /usr/local/aspen-discovery/install/limits.conf /etc/security/limits.conf
mkdir -v -p /usr/lib/systemd/system
cp -v /usr/local/aspen-discovery/install/rngd.service /usr/lib/systemd/system/rngd.service

#systemctl daemon-reload
#systemctl start rngd

#apt install -y python-certbot-apache

#bash ./samlsso_installer_debian.sh

#echo "Generate new root password for mariadb at: https://passwordsgenerator.net/ and store in passbolt"
#mysql_secure_installation
#echo "Enter the timezone of the server"
#read timezone
#timedatectl set-timezone $timezone

#Create aspen MySQL superuser
#read -p "Please enter the username for the Aspen MySQL superuser (can't be root) : " username
#read -p "Please enter the password for the Aspen MySQL superuser ($username) : " password
#query="GRANT ALL PRIVILEGES ON *.* TO $username@'localhost' IDENTIFIED BY '$password'";
#mysql -e "$query"
#query="GRANT ALL PRIVILEGES ON *.* TO $username@'127.0.0.1' IDENTIFIED BY '$password'";
#mysql -e "$query"
#mysql -e "flush privileges"

#cd /usr/local/aspen-discovery/install
#from bash ./setup_aspen_user_debian.sh
#######################################

##create a new user and user group to run Aspen Discovery
#useradd aspen
##Set aspen user to mimmick host user id
#usermod -o -u "${LOCAL_USER_ID}" aspen
##Add all existing users to the group
#for ID in $(cat /etc/passwd | grep /home | cut -d ':' -f1); do (usermod -a -G aspen $ID);done
#
##create an aspen_apache group as well for files that need to be readable (and writable) by apache
#groupadd aspen_apache
##Add www-data, aspen to the aspen_apache group
#usermod -a -G aspen_apache www-data
#usermod -a -G aspen_apache aspen
#useradd solr
#usermod -a -G aspen solr

#Change file permissions so /usr/local/aspen-discovery is owned by the aspen user
chown -R aspen:aspen /usr/local/aspen-discovery
#Now change files back for those that need apache to own them
mkdir -v -p /usr/local/aspen-discovery/tmp || {
    echo "Failed to mkdir"
    exit 1
}
chown -R www-data:aspen_apache /usr/local/aspen-discovery/tmp
chmod -R 755 /usr/local/aspen-discovery/tmp
chown -R www-data:aspen_apache /usr/local/aspen-discovery/code/web
chown -R www-data:aspen_apache /usr/local/aspen-discovery/sites
chown -R aspen:aspen_apache /usr/local/aspen-discovery/sites/default
chown -R solr:aspen /usr/local/aspen-discovery/sites/default/solr-7.6.0

#Change file permissions so /data is owned by the aspen user
mkdir -v -p /data/aspen-discovery
chown -R aspen:aspen_apache /data/aspen-discovery

#Change file permissions so /var/log/aspen-discovery is owned by the aspen user
mkdir -v -p /var/log/aspen-discovery;
chown -R aspen:aspen /var/log/aspen-discovery
