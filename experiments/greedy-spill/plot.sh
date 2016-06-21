#!/bin/bash

rm results/*.png >> /dev/null 2>&1
rm -r results/utilization/tmp results/utilization/*.out >> /dev/null 2>&1

set -ex

sudo chown -R ${USER}:${USER} .

echo "plot: prepare CPU utilizations"
cd results/utilization
for i in `ls`; do 
  tar xzf $i
  node="${i%.tar.gz}"
  echo "... dumping cpu utilization for $node"
  docker run \
    -v `pwd`/tmp:/tmp \
    --entrypoint=whisper-dump.py \
    michaelsevilla/graphite \
    /tmp/graphite/whisper/$node/cpuload/avg1.wsp > cpu-$node.out

  echo "... dumping requests for $node"
  docker run \
    -v `pwd`/tmp:/tmp \
    --entrypoint=whisper-dump.py \
    michaelsevilla/graphite \
    /tmp/graphite/whisper/$node/mds/reply.wsp > reply-$node.out
done
cd -

echo "plot: construct actual graphs"
docker run --rm \
  -v "`pwd`:/home/jovyan/work" \
  jupyter/scipy-notebook \
  jupyter nbconvert \
  --stdout --execute results/visualize.ipynb \
  >> /dev/null 
