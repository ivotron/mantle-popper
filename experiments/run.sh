#!/bin/bash
rm *.tar.gz
set -ex

root=`pwd`

for experiment in baseliner greedy-spill hadoop; do
  cd $root/$experiment
  ./run.sh
done

cd $root
