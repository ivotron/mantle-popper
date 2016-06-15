#!/bin/bash
cd utilization
rm -r tmp *.out >> /dev/null 2>&1

for i in `ls`; do 
  tar xzf $i
  node="${i%.tar.gz}"
  echo "... dumping cpu utilization for $node"
  docker run \
    -v `pwd`/tmp:/tmp \
    --entrypoint=whisper-dump.py \
    michaelsevilla/graphite \
    /tmp/graphite/whisper/$node/cpuload/avg1.wsp > cpu-$node.out
done
cd -
    #-v `pwd`/tmp:/tmp \
#https://github.com/michaelsevilla/malacology-popper/blob/master/experiments/mds-zlog-seq-migrate/results/prepare-visualize.py
