### APACHE ####

.PHONY: apache
apache:
	doppler secrets download --no-file | jq -r '. | to_entries[] | "SetEnv \(.key) \"\(.value)\""' > apache/env-vars.conf
	docker run --rm -it --init \
		--name php \
		-p 8080:80 \
		-v "$(shell pwd)/app":/usr/src/app \
		-v "$(shell pwd)/public":/var/www/html \
		-v "$(shell pwd)/apache/env-vars.conf":/etc/apache2/conf-enabled/apache-env-vars.conf \
		php:7.4-apache
	rm apache/env-vars.conf

.PHONY: apache-doppler-build
apache-doppler-build:
	docker image build -t dopplerhq/php-apache -f apache/Dockerfile .

# Expects `DOPPLER_TOKEN` env var to be set
.PHONY: apache-doppler-token
apache-doppler-token: apache-doppler-build
	docker run --rm -it --init --name php -p 8080:80 -e DOPPLER_TOKEN="${DOPPLER_TOKEN}" dopplerhq/php-apache

.PHONY: apache-doppler-vars-file
apache-doppler-vars-file: apache-doppler-build
	doppler secrets download --no-file | jq -r '. | to_entries[] | "SetEnv \(.key) \"\(.value)\""' > apache/env-vars.conf
	docker run --rm -it --init \
		--name php \
		-p 8080:80 \
		-v "$(shell pwd)/apache/env-vars.conf":/etc/apache2/conf-enabled/apache-env-vars.conf \
		dopplerhq/php-apache 
	rm -f apache/env-vars.conf


#---

### FPM ####

.PHONY: fpm
fpm:
	doppler secrets download --no-file | jq -r '. | to_entries[] | "env[\(.key)] = \(.value)"' > fpm/env-vars.conf	
	docker-compose -f fpm/docker-compose.yml up
	rm -f fpm/env-vars.conf
	docker-compose -f fpm/docker-compose.yml down
	docker-compose -f fpm/docker-compose.yml rm -fsv

.PHONY: pm-doppler-build
fpm-doppler-build:
	docker image build -t dopplerhq/php-fpm -f fpm/Dockerfile .

# Expects `DOPPLER_TOKEN` env var to be set
.PHONY: fpm-doppler-token
fpm-doppler-token: fpm-doppler-build
	docker-compose -f fpm/docker-compose.yml -f fpm/docker-compose-doppler.yml up
	docker-compose -f fpm/docker-compose.yml down
	docker-compose -f fpm/docker-compose.yml rm -fsv

.PHONY: fpm-doppler-vars-file
fpm-doppler-vars-file: fpm-doppler-build
	doppler secrets download --no-file | jq -r '. | to_entries[] | "env[\(.key)] = \(.value)"' > fpm/env-vars.conf	
	docker-compose -f fpm/docker-compose.yml -f fpm/docker-compose-doppler.yml up
	rm -f fpm/env-vars.conf
	docker-compose -f fpm/docker-compose.yml down
	docker-compose -f fpm/docker-compose.yml rm -fsv


#---

### CLI ####

# Coming soon..
