#!/bin/bash
rm *.tar.gz
set -ex

root=`pwd`

for experiment in reqlatency reqlatency-nocache; do
  cd $root/$experiment
  ./run.sh
  cd -
done

cd $root
