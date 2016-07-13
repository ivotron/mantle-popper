#!/bin/bash
set -ex

export WORKLOAD="../workloads"
export RUN="ansible-playbook --skip-tags with_pkg"

cd site
for conf in cache.conf nocache.conf; do
  export ANSIBLE_LOG_PATH="../results/$site/logs/greedy-spill.log"
  export RUN_VARS="$RUN --extra-vars @group_vars/ceph_conf/$conf"
  $RUN_VARS cleanup.yml
  $RUN_VARS site.yml $WORKLOAD/mdtest.yml collect.yml
done
cd -

tar czf ../greedy-spill.tar.gz ../greedy-spill
