#!/bin/bash

set -ex

for experiment in baseliner greedy-spill; do 
  cd $experiment
  ./run.sh
  cd -

  tar czf $experiment.tar.gz $experiment
done
