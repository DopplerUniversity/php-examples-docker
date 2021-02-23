### APACHE ####

# Mount env vars file inside container without modifying base images
.PHONY: apache
apache:
	./bin/apache.sh

apache-doppler-build:
	docker image build -t doppler-php-apache -f apache/Dockerfile .

# Custom Docker image with embedded CLI to generate env vars in container
# Expects Service Token `DOPPLER_TOKEN` env var to be set
# usage: DOPPLER_TOKEN=dp.st.dev.xxx apache-doppler-token
apache-doppler-token: apache-doppler-build
	./bin/apache-doppler-token.sh

# Custom Docker image with embedded CLI that skips creating env vars as no service token supplied and env vars are mounted
apache-doppler-vars-file: apache-doppler-build
	./bin/apache-doppler-vars-file.sh


# ---

### FPM ####

# Mount env vars file inside container without modifying base images
.PHONY: fpm
fpm: 
	./bin/fpm.sh

fpm-doppler-build:
	docker image build -t doppler-php-fpm -f fpm/Dockerfile .

# Custom Docker image with embedded CLI to generate env vars in container
# Expects Service Token `DOPPLER_TOKEN` env var to be set
# usage: DOPPLER_TOKEN=dp.st.dev.xxx make fpm-doppler-token
fpm-doppler-token: fpm-doppler-build
	./bin/fpm-doppler-token.sh

# Custom Docker image with embedded CLI that skips creating env vars as no service token  supplied and env vars are mounted
fpm-doppler-vars-file: fpm-doppler-build
	./bin/fpm-doppler-vars-file.sh


# ---

### DOTENV ####

dotenv-build:
	docker image build -t doppler-php-dotenv -f dotenv/Dockerfile .

# Custom Docker image with embedded CLI to generate .env file inside container
# Expects `DOPPLER_TOKEN` env var to be set
# usage: DOPPLER_TOKEN=dp.st.dev.xxx make dotenv-doppler-token
dotenv-doppler-token: dotenv-build
	./bin/dotenv-doppler-token.sh

# Mount .env file inside container
dotenv-file: dotenv-build
	./bin/dotenv-file.sh

# ---

### LARAVEL ####

LARAVEL_DOPPLER_ARGS = --project laravel --config dev
laravel-project-create:
	doppler projects create laravel
	doppler secrets upload $(LARAVEL_DOPPLER_ARGS) laravel/sample.env

laravel-build:
	docker image build -t doppler-laravel -f laravel/Dockerfile .

laravel-dotenv-file: laravel-build
	doppler run $(LARAVEL_DOPPLER_ARGS) -- ./bin/laravel-dotenv-file.sh

# Generate .env file inside container
# Expects `DOPPLER_TOKEN` env var to be set
# usage: DOPPLER_TOKEN=dp.st.dev.xxx make laravel-doppler-token
laravel-doppler-token: laravel-build
	doppler run $(LARAVEL_DOPPLER_ARGS) -- ./bin/laravel-doppler-token.sh

# ---

### CLEANUP ###

# Delete all Docker images and resource folders
cleanup:
	-docker image rm -f doppler-php-dotenv doppler-php-apache doppler-php-laravel
	-rm -fr mysql laravel/vendor
	-doppler projects delete laravel -y