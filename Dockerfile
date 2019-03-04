FROM php:7.3-cli-alpine

# For Timezone
RUN apk add --no-cache tzdata

# For snailweb/php-daemon
RUN docker-php-ext-install pcntl

# For snailweb/php-supervisor
RUN docker-php-ext-install posix

# For PHPUnit (for testing protected,private, static or final methods)
RUN docker-php-ext-install uopz

# Install Xdebug
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-beta \
    && docker-php-ext-enable xdebug


CMD ["/usr/local/bin/php"]
