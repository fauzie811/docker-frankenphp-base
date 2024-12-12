FROM dunglas/frankenphp:php8.2-alpine

# Install system dependencies
RUN apk update && apk add --no-cache dcron busybox-suid libcap curl zip unzip git

# Install PHP extensions
RUN install-php-extensions intl bcmath gd pdo_mysql pdo_pgsql opcache redis uuid exif pcntl zip sockets

# Install supervisord implementation
COPY --from=ochinchina/supervisord:latest /usr/local/bin/supervisord /usr/local/bin/supervisord

# Install composer
COPY --from=composer/composer:2 /usr/bin/composer /usr/local/bin/composer

# Instal additional dependencies
RUN apk add --no-cache py3-pip py3-pillow py3-cffi py3-brotli gcc musl-dev python3-dev pango font-noto && pip install weasyprint --break-system-packages
RUN apk add --no-cache mariadb-client
RUN apk add --no-cache chromium-swiftshader ttf-freefont font-noto-arabic