FROM php:7.4-apache

# Use to cache bust system dependencies, e.g. Doppler CLI
ENV LAST_UPDATED 2020-12-14
RUN (curl -Ls https://cli.doppler.com/install.sh || wget -qO- https://cli.doppler.com/install.sh) | sh

RUN apt-get update && apt-get install jq -y

COPY app /usr/src/app
COPY public /var/www/html

# Override existing entrypoint script to conditionally generate env vars file if $DOPPLER_TOKEN var exists
COPY apache/docker-php-entrypoint /usr/local/bin/
