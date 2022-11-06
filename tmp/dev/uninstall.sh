#!/bin/bash

set -x

kubectl get all -n plc-dev -o yaml > plc-dev-all.yaml
kubectl get all -n plc-dev-monitoring -o yaml > plc-dev-monitoring-all.yaml
kubectl get all -n pl-dev -o yaml > pl-dev-all.yaml

kubectl delete -f plc-dev-all.yaml
kubectl delete -f plc-dev-monitoring-all.yaml
kubectl delete -f pl-dev-all.yaml

kubectl get pvc -n plc-dev | grep -v NAME | awk '{print $1}' | xargs kubectl -n plc-dev delete pvc

kubectl delete namespace plc-dev
kubectl delete namespace plc-dev-monitoring
kubectl delete namespace pl-dev