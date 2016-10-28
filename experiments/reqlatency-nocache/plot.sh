#!/bin/bash
set -ex

#echo "plot: parse requests"
#for i in `seq 1 8`; do
#  cd results/scale-clients/${i}client
#  tar xzvf lttng-issdm-12.tar.gz
#  docker run --rm -v `pwd`:/home -it michaelsevilla/visualizer /latency.py -o /home/creates -d /home/lttng/ust/uid/64045/64-bit/
#  docker run --rm -v `pwd`:/home -it michaelsevilla/visualizer /latency.py -t CEPH_MDS_OP_READDIR -w 1 -o /home/readdir -d /home/lttng/ust/uid/64045/64-bit/
#  #tailplot creates -x 1 --field-format=1,date,HH:mm:ss --x-format=date,HH:mm:ss -f "lat" -s 3
#  cd -
#done

echo "plot: prepare CPU utilizations"
for i in `seq 1 8`; do
  cd results/scale-clients/${i}client/utilization
  rm *.out || true
  for i in `ls *.tar.gz`; do 
    tar xzf $i
    node="${i%.tar.gz}"
    echo "... dumping cpu utilization for $node"
    docker run --rm \
      -v `pwd`/tmp:/tmp \
      --entrypoint=whisper-dump.py \
      michaelsevilla/graphite \
      /tmp/graphite/whisper/$node/cputotals/user.wsp > $node.out
  done
  cd -
done



#rm results/*.png >> /dev/null 2>&1
#
#set -ex
#sudo chown -R ${USER}:${USER} .
#docker run --rm \
#  -v "`pwd`:/home/jovyan/work" \
#  jupyter/scipy-notebook \
#  jupyter nbconvert \
#  --execute results/visualize.ipynb
#
#cp results/visualize.html ../graphs/baseliner.html
