#!/bin/bash

set -ex

root=`pwd`

for experiment in greedy-spill; do 
  cd $root/$experiment
  ./run.sh
done

cd $root
