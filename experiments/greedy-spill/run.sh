#!/bin/bash
set -ex

export WORKLOAD="../workloads"
export RUN="ansible-playbook --skip-tags with_pkg"

cd site
for conf in cache.conf nocache.conf; do
  export ANSIBLE_LOG_PATH="../results/$site/logs/greedy-spill.log"
  $RUN --extra-vars @group_vars/ceph_conf/$conf cleanup.yml
  $RUN --extra-vars @group_vars/ceph_conf/$conf \
    site.yml \
    $WORKLOAD/mdtest.yml \
    collect.yml
done
cd -

tar czf ../greedy-spill.tar.gz ../greedy-spill
