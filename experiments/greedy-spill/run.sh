#!/bin/bash
set -ex

export ANSIBLE_LOG_PATH="../results/logs/greedy-spill.log"
export WORKLOAD="../workloads"
export RUN="ansible-playbook --skip-tags with_pkg"

cd site
$RUN cleanup.yml
$RUN mantle.yml $WORKLOAD/mdtest.yml collect.yml
cd -

tar czf ../greedy-spill.tar.gz ../greedy-spill
