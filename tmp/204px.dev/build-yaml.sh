#!/bin/bash

set -x
SCRIPT_PATH=$PWD/$(dirname "$0")
echo "SCRIPT_PATH=${SCRIPT_PATH}"
# shellcheck disable=SC2046
cd $(dirname "$0")/../.. || exit


kustomize build k8s/cloud_deps/base/elastic/operator  > "${SCRIPT_PATH}"/1.cloud_deps_base_elastic_operator.yaml
kustomize build k8s/cloud_deps/public > "${SCRIPT_PATH}"/2.cloud_deps_public.yaml
kustomize build k8s/cloud/public/ > "${SCRIPT_PATH}"/3.cloud_public.yaml

grep 'image:' "${SCRIPT_PATH}"/[123].*.yaml | awk '{print $NF}' | grep -vE "^image:"| sort | uniq > "${SCRIPT_PATH}"/images.txt
grep 'image:' "${SCRIPT_PATH}"/[123].*.yaml | awk '{print "docker pull "$NF}' | grep -v "pull image"| sort | uniq > "${SCRIPT_PATH}"/pull-images.sh
grep 'image:' "${SCRIPT_PATH}"/[123].*.yaml | awk '{print "docker images "$NF" | wc -l"}' | grep -v "pull image"| sort | uniq > "${SCRIPT_PATH}"/check-images.sh
