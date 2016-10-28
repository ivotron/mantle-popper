#!/bin/bash

set -ex

RESULTS=`pwd`/results/test
rm -r $RESULTS || true

cd site
for i in `seq 1 8`; do
  OUTPUT="$RESULTS/${i}client"
  mkdir -p $OUTPUT/utilization $OUTPUT/logs

  ANSIBLE_LOG_PATH="$OUTPUT/logs/reqlatency.log" \
  ansible-playbook --forks 50 --skip-tags "with_pkg" \
    -i inventory/${i}client -e "output=$OUTPUT" \
    ceph.yml lttng_start.yml \
      ../../workloads/scale-clients.yml \
    lttng_stop.yml collect.yml
done
cd -

tar czf ../reqlatency-nocache.tar.gz ../reqlatency-nocache
