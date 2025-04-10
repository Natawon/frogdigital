#!/bin/sh

chown -Rf www-data:www-data /var/www/html
service nginx start
service php7.1-fpm start

touch /etc/php/7.1/fpm/snuffleupagus.rules
echo 'sp.disable_function.function("eval").drop();' > /etc/php/7.1/fpm/snuffleupagus.rules

touch /etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini
echo 'extension=snuffleupagus.so' > /etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini
echo 'sp.configuration_file=/etc/php/7.1/fpm/snuffleupagus.rules' >> /etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini


sed -i '/pattern="PDF"/s/rights="none"/rights="read | write"/' /etc/ImageMagick-6/policy.xml

service php7.1-fpm restart

while true; do sleep 60; done
