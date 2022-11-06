#!/bin/bash

kubectl get pvc -n plc | awk '{print $1}' | grep -v NAME | xargs kubectl delete pvc -n plc