#!/bin/bash
set -ex

export ANSIBLE_LOG_PATH="../results/logs/greedy-spill.log"
export WORKLOAD="../workloads"
export RUN="ansible-playbook --skip-tags with_pkg"

cd site
$RUN mantle.yml
$RUN $WORKLOAD/mdtest.yml
$RUN collect.yml
cd -


cd ../
tar czf greedy-spill.tar.gz greedy-spill
cd -

#tar czf mdtest.tar.gz baseliner
#cd -
