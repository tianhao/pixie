#!/bin/bash

set -x

kubectl get all -n olm | grep -v NAME | grep -vE "^$" | awk '{print $1}' | xargs kubectl -n olm delete
kubectl get all -n px-operator | grep -v NAME | grep -vE "^$" | awk '{print $1}' | xargs kubectl -n px-operator delete
kubectl get all -n pl | grep -v NAME | grep -vE "^$" | awk '{print $1}' | xargs kubectl -n pl delete
sleep 5
kubectl delete -f 3.*.yaml
sleep 5
kubectl delete -f 2.*.yaml
sleep 5
kubectl delete -f 1.*.yaml
kubectl get pvc -n plc | awk '{print $1}' | grep -v NAME | xargs kubectl delete pvc
sleep 5

kubectl delete ns olm
kubectl delete ns pl
kubectl delete ns px-operator
kubectl delete ns plc

kubectl get ns

