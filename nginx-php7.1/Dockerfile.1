FROM ubuntu:20.04

# Set timezone + no interaction
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# ติดตั้ง Dependency
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    git \
    build-essential \
    nano \
    lsb-release \
    ca-certificates \
    wget

# เพิ่ม PHP PPA (จาก ondrej)
RUN add-apt-repository ppa:ondrej/php -y && apt-get update

# ติดตั้ง PHP 7.1 + dev tools
RUN apt-get install -y php7.1 php7.1-cli php7.1-fpm php7.1-dev

# install packages
RUN apt-get -y install nginx php7.1 php7.1-fpm php7.1-cli php7.1-common php7.1-curl php7.1-gd php7.1-intl php7.1-json php7.1-mbstring php7.1-mysql php7.1-opcache php7.1-pgsql php7.1-soap php7.1-sqlite3 php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip php-imagick && \
cp -r /etc/php /etc/php.orig && \
cp -r /etc/nginx /etc/nginx.orig && \
apt-get autoclean && apt-get -y autoremove && \
echo "<?php phpinfo();?>" > /var/www/html/info.php

# ติดตั้ง Snuffleupagus
RUN git clone https://github.com/jvoisin/snuffleupagus.git && \
    cd snuffleupagus && make PHP_VERSION=7.1 && make install

# สร้าง config rule ปิด eval
RUN echo "sp.disable_function.function(\"eval\").drop();" > /etc/php/7.1/fpm/snuffleupagus.rules

# สร้างไฟล์โหลด extension
RUN echo "extension=snuffleupagus.so" > /etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini && \
    echo "sp.configuration_file=/etc/php/7.1/fpm/snuffleupagus.rules" >> /etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini


COPY fs /

# nginx ports
EXPOSE 80 443

ADD run.sh /root/run.sh
CMD /bin/sh /root/run.sh

