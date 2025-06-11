#!/bin/sh

docker run \
  --name bnenv \
  -v $HOME/data/mounted/bnenv/:/mnt/ \
  -p 2225:22 \
  -p 6080:6080 \
  -p 56780:56780 \
  lan22h/bnenv:latest
