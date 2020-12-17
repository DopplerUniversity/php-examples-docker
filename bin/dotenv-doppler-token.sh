#!/usr/bin/env bash

docker-compose -f dotenv/docker-compose.yml up
rm -f dotenv/.env
docker-compose -f dotenv/docker-compose.yml rm -fsv