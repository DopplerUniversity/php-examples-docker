FROM php:7-fpm

# Use to cache bust system dependencies, e.g. Doppler CLI
ENV LAST_UPDATED 2020-12-16

RUN (curl -Ls https://cli.doppler.com/install.sh || wget -qO- https://cli.doppler.com/install.sh) | sh && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apt-get update && apt-get install jq git unzip -y && \
    apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY app/composer.json app/composer.lock /usr/src/app/
RUN composer install

COPY app /usr/src/app
COPY public /var/www/html

# Override existing entrypoint script to conditionally generate env vars file if $DOPPLER_TOKEN var exists
COPY dotenv/docker-php-entrypoint /usr/local/bin/
