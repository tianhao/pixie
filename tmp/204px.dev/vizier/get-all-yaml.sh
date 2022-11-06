#!/bin/bash

set -x

kubectl get all -n pl > pl-overview.txt
kubectl get all -n olm > olm-overview.txt
kubectl get all -n px-operator > px-operator-overview.txt

kubectl get all -n pl -o yaml > pl-all.yaml
kubectl get all -n olm -o yaml  > olm-all.yaml
kubectl get all -n px-operator -o yaml  > px-operator-all.yaml
#
#kubectl get pods -n pl -o yaml > pl-ns-pod.yaml
#kubectl get pods -n olm -o yaml > olm-ns-pod.yaml
#kubectl get pods -n px-operator -o yaml > px-operator-ns-pod.yaml
#
#
#kubectl get deploy -n pl -o yaml > pl-ns-deploy.yaml
#kubectl get deploy -n olm -o yaml > olm-ns-deploy.yaml
#kubectl get deploy -n px-operator -o yaml > px-operator-ns-deploy.yaml
#
#kubectl get svc -n pl -o yaml > pl-ns-svc.yaml
#kubectl get svc -n olm -o yaml > olm-ns-svc.yaml
#kubectl get svc -n px-operator -o yaml > px-operator-ns-svc.yaml

grep 'image:' *.yaml | awk '{print $NF}' | grep -vE "^image:" | sort | uniq > images.txt
