#!/usr/bin/env bash

doppler secrets download --no-file | jq -r '. | to_entries[] | "SetEnv \(.key) \"\(.value)\""' > apache/env-vars.conf
docker run --rm -it --init \
	--name php \
	-p 8080:80 \
	-v "$(pwd)/apache/env-vars.conf":/etc/apache2/conf-enabled/apache-env-vars.conf \
	doppler-php-apache 
rm -f apache/env-vars.conf
