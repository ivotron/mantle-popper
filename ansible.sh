#!/bin/bash

set -e
set -x

docker run --rm -it \
  --name="ansible" \
  --net=host \
  -v /tmp:/tmp \
  -v `pwd`:/home \
  -v ~/.ssh:/root/.ssh \
  --workdir /home \
  michaelsevilla/ansible
