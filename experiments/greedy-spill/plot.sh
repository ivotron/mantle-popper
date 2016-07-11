#!/bin/bash

for i in cache nocache; do
  rm results/$i/*.png >> /dev/null 2>&1
  rm -r results/$i/utilization/tmp results/$i/utilization/*.out >> /dev/null 2>&1
done

set -x

sudo chown -R ${USER}:${USER} .

echo "plot: prepare CPU utilizations"
for site in cache nocache; do
  cd results/$site/utilization
  for i in `ls`; do 
    tar xzf $i
    node="${i%.tar.gz}"
    echo "... dumping cpu utilization for $node"
    docker run --rm \
      -v `pwd`/tmp:/tmp \
      --entrypoint=whisper-dump.py \
      michaelsevilla/graphite \
      /tmp/graphite/whisper/$node/cputotals/user.wsp > cpu-$node.out
  
    echo "... dumping requests for $node"
    docker run --rm \
      -v `pwd`/tmp:/tmp \
      --entrypoint=whisper-dump.py \
      michaelsevilla/graphite \
      /tmp/graphite/whisper/$node/mds/reply.wsp > reply-$node.out
  
    echo "... dumping requests for $node"
    docker run --rm \
      -v `pwd`/tmp:/tmp \
      --entrypoint=whisper-dump.py \
      michaelsevilla/graphite \
      /tmp/graphite/whisper/$node/mds/reply_latency/avgcount.wsp > avgcount-$node.out
  done
  cd -
done

echo "plot: construct actual graphs"
docker run --rm \
  -v "`pwd`:/home/jovyan/work" \
  jupyter/scipy-notebook \
  jupyter nbconvert \
  --stdout --execute results/visualize.ipynb \
  >> /dev/null 

for i in cache nocache; do
  cp results/$i/*.png ../graphs/
done
