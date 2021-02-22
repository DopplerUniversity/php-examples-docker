#!/usr/bin/env bash

# 1. Download .env file
doppler secrets download --project laravel --config dev --no-file --format env-no-quotes > laravel/.env

# 2. Use `laravel/docker-compose-env-file.yml` override to mount .env file in laravel container
docker-compose -f laravel/docker-compose.yml -f laravel/docker-compose-env-file.yml up

# 3. On SIGINT, remove .env file
rm -f laravel/.env

# 4. Clean up all containers and volumes created
docker-compose -f laravel/docker-compose.yml rm -fsv
docker volume rm laravel_app-volume