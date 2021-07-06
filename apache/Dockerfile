FROM php:7-apache

# Use to cache bust system dependencies, e.g. Doppler CLI
ENV LAST_UPDATED 2021-07-06

RUN (curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sh && \
    apt-get update && apt-get install jq -y && \
    apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/*

COPY app /var/www/

# Override existing entrypoint script to conditionally generate env vars file if $DOPPLER_TOKEN var exists
COPY apache/docker-php-entrypoint /usr/local/bin/
