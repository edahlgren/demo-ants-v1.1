#!/bin/bash

mkdir -p shared

# Seems too complicated
#
# docker ps -l | grep ant-colony-test | get container ID
if [ ! -d "shared/src" ]; then
    docker cp a96177722503:/root/src shared/
fi
if [ ! -d "shared/papers" ]; then
    docker cp a96177722503:/root/papers shared/
fi

sudo docker run \
     -w /root \
     -v $(pwd)/shared:/root/shared \
     -it \
     ant-colony-test
