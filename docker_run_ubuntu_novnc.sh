#!/bin/sh

# Check if a container with the name exists
if [ "$(docker ps -a -q -f name=$(cat app_name))" ]; then
    docker rm -f $(cat app_name)
fi

docker run \
  --name $(cat app_name) \
  -v $HOME/data/mounted/$(cat app_name)/:/mnt/ \
  -v /dev/shm:/dev/shm \
  -p 2225:22 \
  -p 6080:80 \
  -p 5900:5900 \
  -p 56780:56780 \
  lan22h/$(cat app_name):latest

# --user $(id -u):$(id -g) \
