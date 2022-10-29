#!/bin/bash

set -x
cd $(dirname $0)/../..


kustomize build k8s/cloud_deps/base/elastic/operator  > tmp/deps-dev/1.cloud_deps_base_elastic_operator.yaml
kustomize build k8s/cloud_deps/dev > tmp/deps-dev/2.cloud_deps_dev.yaml

cd tmp/deps-dev
grep 'image:' [123].*.yaml | awk '{print "docker pull "$NF}' | grep -v "pull image"| sort | uniq > pull-images.sh
