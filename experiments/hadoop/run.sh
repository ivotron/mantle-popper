#!/bin/bash
set -ex

export WORKLOAD="../workloads"
export RUN="ansible-playbook --skip-tags with_pkg"

cd site
for i in 1 5 10 20; do
  export SITE="$i-nodes"
  export ANSIBLE_LOG_PATH="../results/$SITE/logs/hadoop.log"
  $RUN -i inventory/$SITE --extra-vars site=$SITE cleanup.yml
  $RUN -i inventory/$SITE --extra-vars site=$SITE \
    site.yml \
    $WORKLOAD/randomtextwriter.yml \
    collect.yml
done
cd -

tar czf ../hadoop.tar.gz ../hadoop
