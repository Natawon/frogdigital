#!/bin/bash

set -e

# ตรวจสอบเวอร์ชัน PHP ว่าเป็น 7.1 หรือไม่
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
if [[ "$PHP_VERSION" != "7.1" ]]; then
  echo "❌ PHP version is $PHP_VERSION — this script is only for PHP 7.1"
  exit 1
fi

echo "✅ PHP version is 7.1 — continuing..."

# ติดตั้งเครื่องมือและ dependency
apt install sudo
sudo apt update
sudo apt install -y php7.1-dev php7.1-cli git make gcc g++ autoconf pkg-config

# โคลน repo Snuffleupagus
git clone https://github.com/jvoisin/snuffleupagus.git
cd snuffleupagus

# คอมไพล์สำหรับ PHP 7.1
make PHP_VERSION=7.1

# ติดตั้ง
sudo make install

# สร้างไฟล์ config
CONFIG_PATH="/etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini"
echo "extension=snuffleupagus.so" | sudo tee $CONFIG_PATH
echo 'sp.disable_function.function("eval").drop();' | sudo tee -a $CONFIG_PATH

# รีสตาร์ต PHP-FPM
sudo /etc/init.d/php7.1-fpm restart

echo ""
echo "🎉 Snuffleupagus ติดตั้งสำเร็จและบล็อก eval() แล้วบน PHP 7.1!"