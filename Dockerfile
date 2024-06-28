FROM php:8.2.6-apache

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libicu-dev \
    g++ \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip intl opcache

ADD https://download.nextcloud.com/server/releases/nextcloud-29.0.3.tar.bz2 /var/www/html/
RUN tar -xjf /var/www/html/nextcloud-29.0.3.tar.bz2 -C /var/www/html --strip-components=1 \
    && rm /var/www/html/nextcloud-29.0.3.tar.bz2

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
