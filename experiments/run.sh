#!/bin/bash

root=`dirname $0`
pwd=`pwd`

rm $root/*.tar.gz >> /dev/null 2>&1
set -ex

for experiment in baseliner greedy-spill; do 
  cd $root/$experiment
  ./run.sh
done

cd $pwd
