FROM php:7.3-cli-alpine

# For Timezone
RUN apk add --no-cache tzdata

# For snailweb/php-daemon
RUN docker-php-ext-install pcntl

# For snailweb/php-supervisor
RUN docker-php-ext-install posix

# Create virtual package "PHPbuildDeps" to build PHP extensions
RUN apk add --no-cache --update --virtual PHPbuildDeps $PHPIZE_DEPS

# Install uopz (for PHPUnit testing protected, private, static or final methods)
RUN pecl install uopz \
 && docker-php-ext-enable uopz 

# Install Xdebug
RUN pecl install xdebug-beta \
    && docker-php-ext-enable xdebug

# Delete "PHPbuildDeps"
RUN apk del PHPbuildDeps

CMD ["/usr/local/bin/php"]
