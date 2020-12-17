#!/usr/bin/env bash
    
doppler secrets download --no-file | jq -r '. | to_entries[] | "env[\(.key)] = \(.value)"' > fpm/env-vars.conf	
docker-compose -f fpm/docker-compose.yml -f fpm/docker-compose-vars-file.yml up
rm -f fpm/env-vars.conf
docker-compose -f fpm/docker-compose.yml rm -fsv