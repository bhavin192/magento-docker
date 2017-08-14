FROM php:5.6-apache

LABEL maintainer="bhavin7392@gmail.com"

RUN curl -O -L https://github.com/OpenMage/magento-mirror/archive/1.9.3.2.tar.gz \
	&& tar xf 1.9.3.2.tar.gz
RUN mv ./magento-mirror-1.9.3.2/* /var/www/html/
RUN chmod -R o+w /var/www/html

#install mcrypt, gd, soap
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng12-dev \
		libxml2-dev \
		php-soap \
		php5-mysql \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install iconv mcrypt gd soap pdo_mysql

#run startup sh to create database 'magento'

#Specify Volume
VOLUME /var/www/html
