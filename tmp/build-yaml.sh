#!/bin/bash

set -x
cd $(dirname $0)/..

kustomize build k8s/cloud_deps/base/elastic/operator  > tmp/1.cloud_deps_base_elastic_operator.yaml
kustomize build k8s/cloud_deps/public > tmp/2.cloud_deps_public.yaml
kustomize build k8s/cloud/public > tmp/3.cloud_public.yaml
