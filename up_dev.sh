#!/bin/bash

args="'$*'"

containerRepositoryBackend='api_pdb_dev'
containerRepositoryFrontend='pdb_frontend'

docker-compose down

# Delete volume gem cahe
docker volume rm web_pdb_shared_data web_pdb_gem_cache_dev
# Delete image
docker rmi $containerRepositoryBackend:latest
docker rmi $containerRepositoryFrontend:latest

# Create images
docker build -t $containerRepositoryBackend:latest --build-arg USER_ID="${USER_ID:-1000}" --build-arg GROUP_ID="${GROUP_ID:-1000}" -f ./api_pdb/Dockerfile ./api_pdb
docker build -t $containerRepositoryFrontend:latest -f ./frontend/Dockerfile ./frontend

# Execute docker compose to start services described in "docker-compose.yml"
# Adding "-d" hide logs. To show logs execute "docker-compose logs"
docker-compose up -d