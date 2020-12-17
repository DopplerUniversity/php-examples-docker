#!/usr/bin/env bash

docker-compose -f fpm/docker-compose.yml -f fpm/docker-compose-doppler.yml up
docker-compose -f fpm/docker-compose.yml rm -fsv