#!/bin/bash

set -ex

sudo chown -R ${USER}:${USER} .

echo "plot: prepare CPU utilizations"
for site in `ls results`; do
  if [ -d results/$site ]; then
    cd results/$site/utilization
    for i in `ls *.tar.gz`; do 
      tar xzf $i
      node="${i%.tar.gz}"
      echo "... dumping cpu utilization for $node"
      docker run --rm \
        -v `pwd`/tmp:/tmp \
        --entrypoint=whisper-dump.py \
        michaelsevilla/graphite \
        /tmp/graphite/whisper/$node/cputotals/user.wsp > cpu-$node.out
    done
    cd -
  fi
done

echo "plot: construct actual graphs"
docker run --rm \
  -v "`pwd`:/home/jovyan/work" \
  jupyter/scipy-notebook \
  jupyter nbconvert --execute results/visualize.ipynb

cp results/visualize.html ../graphs/hadoop.html
