#!/bin/bash

CONFIG_PATH="/etc/php/7.1/fpm/conf.d/99-snuffleupagus.ini"
echo "extension=snuffleupagus.so" | sudo tee $CONFIG_PATH
echo 'sp.disable_function.function("eval").drop();' | sudo tee -a $CONFIG_PATH

# รีสตาร์ต PHP-FPM
sudo /etc/init.d/php7.1-fpm restart

