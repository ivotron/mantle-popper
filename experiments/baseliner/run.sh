#!/bin/bash

set -ex

ANSIBLE_LOG_PATH="logs/radosbench.log" \
ansible-playbook --forks 50 --skip-tags "with_pkg" \
ceph.yml \
  workloads/radosbench.yml \
  workloads/osdbench.yml \
  workloads/netbench.yml \
collect.yml
