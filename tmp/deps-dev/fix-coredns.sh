#!/bin/bash

kubectl scale --replicas=0 -n kube-system deployment coredns

sleep 5

kubectl -n kube-system get pods | grep coredns | awk '{print $1}' | xargs -I'{}' kubectl delete pod '{}' -n kube-system --grace-period=0 --force delete pod

sleep 5

kubectl scale --replicas=1 -n kube-system deployment coredns
