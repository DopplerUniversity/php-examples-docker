#!/usr/bin/env bash

doppler secrets download --no-file --format env > dotenv/.env
docker-compose -f dotenv/docker-compose.yml -f dotenv/docker-compose-env-file.yml up
rm -f dotenv/.env
docker-compose -f dotenv/docker-compose.yml rm -fsv