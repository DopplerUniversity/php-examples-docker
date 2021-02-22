#!/usr/bin/env bash

docker-compose -f laravel/docker-compose.yml up
docker-compose -f laravel/docker-compose.yml rm -fsv
docker volume rm laravel_app-volume
