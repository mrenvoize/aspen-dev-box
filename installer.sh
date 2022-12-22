#!/bin/sh

#This will need to be copied to the server manually to do the setup.
#Expects to be installed on Debian 10 Buster
#Run as sudo ./installer.sh
apt update
apt install -y wget
apt install -y apache2
apt -y install apt-transport-https lsb-release ca-certificates curl
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt update
apt install -y php7.3 php7.3-mcrypt php7.3-gd php7.3-curl php7.3-mysql php7.3-zip
apt install -y php7.3-xml
apt install -y bind9 bind9utils
apt install -y php7.3-intl
apt install -y php7.3-mbstring
apt install -y php7.3-pgsql
apt install -y php7.3-ssh2
service apache2 start
#systemctl enable apache2
# New PHP ini file
# - Change max_memory to 256M (from 128M)
# - Increase max file size to 50M
# - Increase max post size to 50M
mv /etc/php/7.3/apache2/php.ini /etc/php/7.3/apache2/php.ini.old
cp php.ini /etc/php/7.3/apache2/php.ini
a2enmod rewrite
#apt install -y mariadb-server
#mv /etc/mysql/mariadb.cnf /etc/mysql/mariadb.cnf.old
#cp mariadb.cnf /etc/mysql/mariadb.cnf
apt install -y software-properties-common
apt install -y default-jdk
apt install -y openjdk-11-jdk
apt install -y unzip

#Create temp smarty directories
cd /usr/local/aspen-discovery
mkdir tmp
chown -R www-data:www-data tmp
chmod -R 755 tmp

#Increase entropy
apt install -y -q rng-tools
cp install/limits.conf /etc/security/limits.conf
cp install/rngd.service /usr/lib/systemd/system/rngd.service

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
#bash ./setup_aspen_user_debian.sh


#!/bin/sh
#create a new user and user group to run Aspen Discovery
useradd aspen
#Add all existing users to the group
for ID in $(cat /etc/passwd | grep /home | cut -d ':' -f1); do (usermod -a -G aspen $ID);done

#create an aspen_apache group as well for files that need to be readable (and writable) by apache
groupadd aspen_apache
#Add www-data, aspen to the aspen_apache group
usermod -a -G aspen_apache www-data
usermod -a -G aspen_apache aspen
useradd solr
usermod -a -G aspen solr

#Change file permissions so /usr/local/aspen-discovery is owned by the aspen user
chown -R aspen:aspen /usr/local/aspen-discovery
#Now change files back for those that need apache to own them
chown -R www-data:aspen_apache /usr/local/aspen-discovery/tmp
chown -R www-data:aspen_apache /usr/local/aspen-discovery/code/web
chown -R www-data:aspen_apache /usr/local/aspen-discovery/sites
chown -R aspen:aspen_apache /usr/local/aspen-discovery/sites/default
chown -R solr:aspen /usr/local/aspen-discovery/sites/default/solr-7.6.0

#Change file permissions so /data is owned by the aspen user
mkdir -p /data/aspen-discovery
chown -R aspen:aspen_apache /data/aspen-discovery

#Change file permissions so /var/log/aspen-discovery is owned by the aspen user
mkdir -p /var/log/aspen-discovery;
chown -R aspen:aspen /var/log/aspen-discovery
