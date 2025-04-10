FROM ubuntu:20.04
LABEL MAINTAINER="frogdigital"

ENV DEBIAN_FRONTEND noninteractive

#RUN sed -i -e "s/archive.ubuntu.com/mirror.ku.ac.th/g" /etc/apt/sources.list
RUN apt-get update && apt-get -y dist-upgrade && apt-get -y install apt-utils curl wget openssh-client git ffmpeg nano ca-certificates software-properties-common

##Add NGINX official stable repository
#RUN echo "deb http://nginx.org/packages/ubuntu/ bionic nginx" > /etc/apt/sources.list.d/nginx.list  && \
#echo "deb-src http://nginx.org/packages/ubuntu/ bionic nginx " >> /etc/apt/sources.list.d/nginx.list

RUN add-apt-repository -y  ppa:ondrej/nginx-mainline; add-apt-repository -y ppa:ondrej/php;

# install packages
RUN apt-get -y install nginx composer php7.1 php7.1-fpm php7.1-cli php7.1-common php7.1-curl php7.1-gd php7.1-intl php7.1-json php7.1-mbstring php7.1-mysql php7.1-opcache php7.1-pgsql php7.1-soap php7.1-sqlite3 php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip php-imagick && \
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

#VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]
##NGINX mountable directory for apps
#VOLUME ["/var/www"]

COPY fs /

# nginx ports
EXPOSE 80 443

ADD run.sh /root/run.sh
CMD /bin/sh /root/run.sh

