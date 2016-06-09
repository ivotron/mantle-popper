#!/bin/bash
set -ex

ANSIBLE_LOG_PATH="../results/logs/greedy-spill.log"
WORKLOAD="../workloads"
RUN="ansible-playbook --skip-tags with_pkg"

cd site
$RUN mantle.yml
$RUN $WORKLOAD/mdtest.yml
$RUN collect.yml
cd -

#tar czf mdtest.tar.gz baseliner
#cd -
