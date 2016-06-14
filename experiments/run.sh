#!/bin/bash

root=`dirname $0`
mydir=`pwd`

rm $root/*.tar.gz >> /dev/null 2>&1
set -ex

for experiment in baseliner greedy-spill; do 
  cd $root/$experiment
  ./run.sh
  cd $mydir
done
