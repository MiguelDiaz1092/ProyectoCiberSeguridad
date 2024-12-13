FROM php:8.0-apache

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip

# Instalar extensiones PHP necesarias
RUN docker-php-ext-install mysqli pdo pdo_mysql zip

# Habilitar mod_rewrite para Apache
RUN a2enmod rewrite

# Configurar el documento root de Apache
WORKDIR /var/www/html

# Asegurarse de que los archivos tengan los permisos correctos
RUN chown -R www-data:www-data /var/www/html