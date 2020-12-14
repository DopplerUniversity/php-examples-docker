.PHONY: apache

apache:
	doppler secrets download --no-file | jq -r '. | to_entries[] | "SetEnv \(.key) \"\(.value)\""' > conf/apache-env-vars.conf
	docker run --rm -it --init \
		--name php \
		-p 8080:80 \
		-v "$(shell pwd)/app":/usr/src/app \
		-v "$(shell pwd)/public":/var/www/html \
		-v "$(shell pwd)/conf/apache-env-vars.conf":/etc/apache2/conf-enabled/apache-env-vars.conf \
		php:7.4-apache
	rm conf/apache-env-vars.conf

php-apache-doppler:
	docker image build -t dopplerhq/php-apache -f apache/Dockerfile .
	docker run --rm -it --init --name php -p 8080:80 -e DOPPLER_TOKEN="${DOPPLER_TOKEN}" dopplerhq/php-apache 

	
shell:
	docker exec -it php bash
