FROM debian:stable-slim

RUN apt-get update && \
      apt-get install -y \
      git \
      sudo \
      wget \
      software-properties-common
RUN git clone --depth 1 https://github.com/mdnoble73/aspen-discovery.git /usr/local/aspen-discovery
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN add-apt-repository "deb https://packages.sury.org/php/ $(lsb_release -sc) main"
RUN apt-get update
RUN apt-get install -y \
      apache2 \
      php7.3 \
      php7.3-mcrypt \
      php7.3-gd \
      php7.3-curl \
      php7.3-mysql \
      php7.3-zip \
      php7.3-xml \
      bind9 \
      bind9utils \
      php7.3-intl \
      php7.3-mbstring \
      php7.3-pgsql \
      php7.3-ssh2 \
      software-properties-common \
      default-jdk \
      openjdk-11-jdk \
      unzip \
      default-mysql-client \
      rng-tools
COPY installer.sh /
RUN /installer.sh
COPY createSitedocker.php /
RUN php /createSitedocker.php

COPY --chown=aspen:aspen /var /var
COPY --chown=aspen:aspen /etc /etc
COPY --chown=aspen:aspen /data /data
COPY --chown=aspen:aspen /site /test.localhostaspen
COPY dockerrun.sh /
RUN chmod +x /dockerrun.sh
ENTRYPOINT [ "/dockerrun.sh" ]
CMD [ "sleep", "infinity" ]
