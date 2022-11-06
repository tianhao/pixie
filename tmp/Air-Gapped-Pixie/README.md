#  Air Gapped Pixie

参考自官方文档: 
https://docs.px.dev/installing-pixie/install-guides/airgap-pixie/

## deploy pixie cloud

```shell
git clone https://github.com/pixie-io/pixie.git
cd pixie
mkcert -install

kubectl create namespace plc
./scripts/create_cloud_secrets.sh
```

**Modify the pixie_cloud/yamls/cloud.yaml file to remove the plugin-db-updater-job job.**

```shell
kubectl apply -f yamls/cloud_deps_elastic_operator.yaml
kubectl apply -f yamls/cloud_deps.yaml

kubectl apply -f yamls/cloud.yaml
kubectl get pods -n plc
kubectl logs create-admin-job-<pod_string> -n plc
```



## deploy pixie

```shell
kubectl apply -f vizier/secrets.yaml
```

To deploy Pixie without etcd, use the following yamls:
```shell
kubectl apply -f vizier/vizier_metadata_persist_prod.yaml

kubectl apply -f vizier_deps/nats_prod.yaml
```

或

To deploy Pixie with etcd, use the following yamls:
```shell
kubectl apply -f vizier/vizier_etcd_metadata_prod.yaml
kubectl apply -f vizier_deps/etcd_prod.yaml
```

```shell
kubectl get pods -n pl
```
