FROM php:7.3-cli-alpine

# For Timezone
RUN apk add --no-cache tzdata

# Set French Timezone
ENV TZ=Europe/Paris

# For snailweb/php-daemon
RUN docker-php-ext-install pcntl

# For snailweb/php-supervisor
RUN docker-php-ext-install posix

# Create virtual package "PHPbuildDeps" used to build PHP extensions
RUN apk add --no-cache --update --virtual PHPbuildDeps $PHPIZE_DEPS

# Install Xdebug
RUN pecl install xdebug-beta \
    && docker-php-ext-enable xdebug

# Delete "PHPbuildDeps"
RUN apk del PHPbuildDeps

CMD ["/usr/local/bin/php"]
