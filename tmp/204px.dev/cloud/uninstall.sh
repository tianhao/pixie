
kubectl delete -f 3.cloud_public.yaml
kubectl delete -f 2.cloud_deps_public.yaml
kubectl delete -f 1.cloud_deps_base_elastic_operator.yaml
./del-pvc.sh

kubectl delete namespace plc