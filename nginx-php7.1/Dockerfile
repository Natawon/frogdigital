FROM ubuntu:20.04
LABEL MAINTAINER="frogdigital"

ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_VERSION=7.1.27

# ติดตั้ง packages พื้นฐาน
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get install -y \
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
    g++ \
    make \
    autoconf \
    unzip \
    pkg-config \
    libssl-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libjpeg-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    libreadline-dev \
    libsqlite3-dev \
    libpq-dev \
    libxslt1-dev \
    libicu-dev \
    nginx \
    composer && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# คอมไพล์ PHP 7.1.27 จาก source
RUN curl -sSL https://museum.php.net/php7/php-${PHP_VERSION}.tar.gz | tar -xz && \
    cd php-${PHP_VERSION} && \
    ./configure \
        --prefix=/usr/local/php \
        --with-config-file-path=/usr/local/php/etc \
        --with-config-file-scan-dir=/usr/local/php/etc/conf.d \
        --enable-mbstring \
        --enable-soap \
        --enable-intl \
        --enable-bcmath \
        --enable-mysqlnd \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-curl \
        --with-openssl \
        --with-zlib \
        --with-readline \
        --with-zip \
        --with-gd \
        --enable-fpm \
        --enable-xml \
        --with-libxml-dir \
        --with-xsl \
        --enable-sockets \
    && make -j"$(nproc)" && make install && \
    cd .. && rm -rf php-${PHP_VERSION}

# symlink
RUN ln -s /usr/local/php/bin/php /usr/bin/php && \
    ln -s /usr/local/php/sbin/php-fpm /usr/sbin/php-fpm

# สร้าง php.ini
RUN mkdir -p /usr/local/php/etc/conf.d && \
    echo "date.timezone = Asia/Bangkok" > /usr/local/php/etc/conf.d/timezone.ini

# ติดตั้ง Snuffleupagus
RUN git clone https://github.com/jvoisin/snuffleupagus.git /opt/snuffleupagus && \
    cd /opt/snuffleupagus && \
    make && make install

# ตั้งค่า Snuffleupagus สำหรับ PHP-FPM
RUN mkdir -p /usr/local/php/etc/conf.d && \
    echo 'sp.disable_function.function("eval").drop();' > /usr/local/php/etc/snuffleupagus.rules && \
    echo 'extension=snuffleupagus.so' > /usr/local/php/etc/conf.d/99-snuffleupagus.ini && \
    echo 'sp.configuration_file=/usr/local/php/etc/snuffleupagus.rules' >> /usr/local/php/etc/conf.d/99-snuffleupagus.ini

# เพิ่มไฟล์ phpinfo ทดสอบ
RUN mkdir -p /var/www/html && echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# คัดลอกระบบไฟล์เพิ่มเติม (เช่น config nginx หรือ php-fpm)
COPY fs /

# สคริปต์สำหรับรัน nginx + php-fpm
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

EXPOSE 80 443

# Start everything
CMD ["/bin/sh", "/root/run.sh"]
