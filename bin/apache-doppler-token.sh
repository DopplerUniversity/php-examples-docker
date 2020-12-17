#!/usr/bin/env bash

docker run --rm -it --init \
    --name php \
    -p 8080:80 \
    -e DOPPLER_TOKEN="$DOPPLER_TOKEN" \
    doppler-php-apache
