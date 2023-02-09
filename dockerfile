FROM debian:stable-slim

# Install base dependancies
RUN apt update
RUN apt install -y \
      wget \
      curl \
      apache2 \
      bind9 \
      bind9utils \
      unzip \
      apt-transport-https \
      lsb-release \ 
      ca-certificates \
      software-properties-common

# Add PHP 7 Reposiory
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN add-apt-repository "deb https://packages.sury.org/php/ $(lsb_release -sc) main"

# Install PHP 7 and PHP Modules
RUN apt update
RUN apt install -y \
      php7.3 \
      php7.3-mcrypt \
      php7.3-gd \
      php7.3-curl \
      php7.3-mysql \
      php7.3-zip \
      php7.3-xml \
      php7.3-intl \
      php7.3-mbstring \
      php7.3-pgsql \
      php7.3-ssh2

# Install Java, MySQL and RNG
RUN apt install -y \
      default-jdk \
      openjdk-11-jdk \
      default-mysql-client \
      rng-tools

# Enable apache mod-rewrite
RUN a2enmod rewrite

run mkdir -p /root/asd-installer
WORKDIR /root/asd-installer

# Add users
COPY adduser.sh /root/asd-installer/
RUN /root/asd-installer/adduser.sh

# Copy default configurations
COPY --chown=aspen:aspen /var /var
COPY --chown=aspen:aspen /etc /etc
COPY --chown=aspen:aspen /data /data

# Copy installer
COPY installer.sh /root/asd-installer/
RUN chmod +x /root/asd-installer/installer.sh
COPY createSitedocker.php /root/asd-installer/
RUN chmod +x /root/asd-installer/createSitedocker.php

# Copy runner
COPY dockerrun.sh /
RUN chmod +x /dockerrun.sh

# Run through installer (I believe this needs to be in a CMD
#COPY installer.sh /root/asd-installer/
#RUN installer.sh
#COPY createSitedocker.php /root/asd-installer/
#RUN php createSitedocker.php

ENTRYPOINT [ "/dockerrun.sh" ]
CMD [ "sleep", "infinity" ]
