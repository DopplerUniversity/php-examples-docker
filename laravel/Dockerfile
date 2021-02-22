FROM php:7-fpm

# Use to cache bust system dependencies, e.g. Doppler CLI
ENV LAST_UPDATED 2021-02-22

# Configure Composer
ENV COMPOSER_HOME /.composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install the Doppler and Compose CLI
RUN (curl -Ls https://cli.doppler.com/install.sh || wget -qO- https://cli.doppler.com/install.sh) | sh && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    \
    apt-get update && apt-get install -y \
    jq \
    git \
    unzip && \
    apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/*

# Manually create the WORKDIR so the www-data user has permissions necessary to create a .env file
RUN mkdir /usr/src/app -p && chown www-data:www-data /usr/src/app

WORKDIR /usr/src/app

COPY --chown=www-data:www-data laravel /usr/src/app
RUN composer install

# Override existing php-fpm entrypoint script to conditionally generate env vars file if $DOPPLER_TOKEN env var exists
COPY laravel/docker-php-entrypoint /usr/local/bin/

USER www-data
