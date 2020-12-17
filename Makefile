### APACHE ####

# Mount env vars file inside container without modifying base images
.PHONY: apache
apache: docker-clean-up
	./bin/apache.sh

apache-doppler-build:
	docker image build -t doppler-php-apache -f apache/Dockerfile .

# Custom Docker image with embedded CLI to generate env vars in container
# Expects Service Token `DOPPLER_TOKEN` env var to be set
apache-doppler-token: apache-doppler-build
	./bin/apache-doppler-token.sh

# Custom Docker image with embedded CLI that skips creating env vars as no is supplied as and env vars are mounted
apache-doppler-vars-file: apache-doppler-build
	./bin/apache-doppler-vars-file.sh


#---

### FPM ####

# Mount env vars file inside container without modifying base images
.PHONY: fpm
fpm: 
	./bin/fpm.sh

fpm-doppler-build:
	docker image build -t doppler-php-fpm -f fpm/Dockerfile .

# Custom Docker image with embedded CLI to generate env vars in container
# Expects Service Token `DOPPLER_TOKEN` env var to be set
fpm-doppler-token: fpm-doppler-build
	./bin/fpm-doppler-token.sh

# Custom Docker image with embedded CLI that skips creating env vars as no is supplied as and env vars are mounted
fpm-doppler-vars-file: fpm-doppler-build
	./bin/fpm-doppler-vars-file.sh


#---

### DOTENV ####

dotenv-build:
	docker image build -t doppler-php-dotenv -f dotenv/Dockerfile .

# Custom Docker image with embedded CLI to generate .env file inside container
# Expects `DOPPLER_TOKEN` env var to be set
dotenv-doppler-token: dotenv-build
	./bin/dotenv-doppler-token.sh

# Mount .env file inside container
dotenv-file: dotenv-build
	./bin/dotenv-file.sh

