FROM ubuntu:20.04
LABEL MAINTAINER="frogdigital"

ENV DEBIAN_FRONTEND=noninteractive

# Base packages
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install \
        apt-utils \
        curl \
        wget \
        openssh-client \
        git \
        ffmpeg \
        nano \
        ca-certificates \
        software-properties-common \
        gcc \
        g++

# Add PHP and NGINX repositories
RUN add-apt-repository -y ppa:ondrej/nginx-mainline && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update

# Install PHP 7.1 and required packages
RUN apt-get -y install \
        nginx \
        composer \
        make \
        php7.1 \
        php7.1-fpm \
        php7.1-common \
        php7.1-tokenizer \
        php7.1-curl \
        php7.1-gd \
        php7.1-intl \
        php7.1-json \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-opcache \
        php7.1-pgsql \
        php7.1-soap \
        php7.1-sqlite3 \
        php7.1-xml \
        php7.1-xmlrpc \
        php7.1-xsl \
        php7.1-zip \
        php-imagick && \
    cp -r /etc/php /etc/php.orig && \
    cp -r /etc/nginx /etc/nginx.orig && \
    apt-get autoclean && \
    apt-get -y autoremove

# Install PHP dev tools
RUN apt-get install -y \
        php7.1-dev \
        php7.1-cli \
        git \
        gcc \
        make \
        autoconf \
        pkg-config

# Install Snuffleupagus
RUN git clone https://github.com/jvoisin/snuffleupagus.git /opt/snuffleupagus && \
    cd /opt/snuffleupagus && \
    make && \
    make install

# Configure Snuffleupagus
RUN echo 'sp.disable_function.function("eval").drop();' > /etc/php/7.1/fpm/snuffleupagus.rules && \
    echo 'extension=snuffleupagus.so' > /etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini && \
    echo 'sp.configuration_file=/etc/php/7.1/fpm/snuffleupagus.rules' >> /etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini

# Clean up newer PHP versions that may conflict
RUN apt-get remove -y php8.4 php8.4-cli php8.4-common || true && \
    apt-get autoremove -y

# Add PHP info test file
RUN echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# Copy filesystem overrides
COPY fs /

# Copy run script
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

# Expose ports for nginx
EXPOSE 80 443

# Start command
CMD ["/bin/sh", "/root/run.sh"]
