FROM php:7.2-apache

COPY ./app /UI
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite
RUN docker-php-ext-install pdo_mysql