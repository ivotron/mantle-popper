#!/bin/bash

set -ex

cd site
ANSIBLE_LOG_PATH="../logs/reqlatency.log" \
ansible-playbook --forks 50 --skip-tags "with_pkg" \
  ceph.yml \
 ../workloads/stat.yml
cd -
#  workloads/osdbench.yml \
#  workloads/netbench.yml \
#collect.yml
#
#tar czf ../baseliner.tar.gz ../baseliner
