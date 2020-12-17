#!/usr/bin/env bash

doppler secrets download --no-file | jq -r '. | to_entries[] | "SetEnv \(.key) \"\(.value)\""' > apache/env-vars.conf
docker run --rm -it --init \
    --name php \
    -p 8080:80 \
    -v "$(pwd)/app":/usr/src/app \
    -v "$(pwd)/public":/var/www/html \
    -v "$(pwd)/apache/env-vars.conf":/etc/apache2/conf-enabled/apache-env-vars.conf \
    php:7.4-apache
rm apache/env-vars.conf