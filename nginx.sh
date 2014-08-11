#!/bin/bash

## DOWNLOADS
sudo curl -OL h ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.01.tar.gz > /usr/local/src/pcre-8.01.tar.gz
sudo curl -OL h http://nginx.org/download/nginx-0.8.33.tar.gz > /usr/local/src/nginx-0.8.33.tar.gz

## Install PCRE
sudo mkdir -p /usr/local/src
cd /usr/local/src
tar xvzf pcre-8.01.tar.gz
cd pcre-8.01
./configure --prefix=/usr/local
make
sudo make install
cd ..

## Install Nginx
tar xvzf nginx-0.8.33.tar.gz
cd nginx-0.8.33
./configure --prefix=/usr/local --with-http_ssl_module
make
sudo make install

## Start Nginx
sudo nginx