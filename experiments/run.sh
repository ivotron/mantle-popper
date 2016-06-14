#!/bin/bash

set -ex

root=`dirname $0`
mydir=`pwd`

for experiment in baseliner greedy-spill; do 
  cd $root/$experiment
  #./run.sh
done

cd $mydir
