
## 1. 分支准备(已执行,本分支即新建的分支,跳过)
```shell
export LATEST_CLOUD_RELEASE=$(git tag | grep 'release/cloud'  | sort -r | head -n 1 | awk -F/ '{print $NF}')
git checkout "release/cloud/prod/${LATEST_CLOUD_RELEASE}"
git switch -c prod-2022-10-05
perl -pi -e "s|newTag: latest|newTag: \"${LATEST_CLOUD_RELEASE}\"|g" k8s/cloud/public/kustomization.yaml
```

## 2. 配置修改(本分支已修改)
本次: LATEST_CLOUD_RELEASE = 1664907260
修改域名配置 dev.withpixie.dev -> 204px.dev

```
k8s/cloud/public/proxy_envoy.yaml
k8s/cloud/public/domain_config.yaml
scripts/create_cloud_secrets.sh
```

es 配置修改:
```shell
k8s/cloud_deps/base/elastic/cluster/elastic_cluster.yaml # 内存大小从4G改为3G
k8s/cloud_deps/public/elastic/elastic_gcs_plugin.yaml # 删除 master 节点,保留 data 节点
k8s/cloud_deps/public/elastic/elastic_replica_patch.yaml # data 节点数改为 1, 增加 master 身份(默认有data 和 ingest 身份, master身份组master节点) 
```

postgres 配置修改
```
k8s/cloud_deps/public/postgres/postgres_service.yaml  # 改为 NodePort 类型
```

cloud_service 配置修改: 
```
k8s/cloud/overlays/exposed_services_ilb # 将 LoadBalancer 类型改成 NodePort
k8s/cloud/public/plugin_db_updater_job.yaml # 增加 imagePullPolicy: IfNotPresent
```


本机 /etc/hosts 配置
```shell
192.168.1.10 204px.dev work.204px.dev segment.204px.dev docs.204px.dev cloud.204px.dev
```
上面ip改为你要暴露的地址


## 3. 安装 cloud
```shell
mkcert -install
kubectl create namespace plc
./create_cloud_secrets.sh
cd tmp/204px.dev
sh build-yaml.sh # 生成yaml文件
kubectl apply -f 1.cloud_deps_base_elastic_operator.yaml
kubectl apply -f 2.cloud_deps_public.yaml
kubectl get pods -n plc # 等待所有 pod 都 Running 所有 job 都是 Completed
kubectl apply -f 3.cloud_public.yaml
kubectl get pods -n plc # 等待所有 pod 都 Running 所有 job 都是 Completed
```


## 4. 登录

px cli 安装
bash -c "$(curl -fsSL https://withpixie.ai/install.sh)"

kubectl get pod -n plc | grep create-admin
提取地址:
kubectl logs create-admin-job-<随机编码> -n plc
```
Defaulted container "create-admin-job" out of: create-admin-job, kratos-wait (init)
time="2022-11-06T01:23:20Z" level=info msg="Loading HTTP TLS certs" tlsCA=/certs/ca.crt tlsCertFile=/certs/client.crt tlsKeyFile=/certs/client.key
time="2022-11-06T01:23:20Z" level=info msg="Loading HTTP TLS certs" tlsCA=/certs/ca.crt tlsCertFile=/certs/client.crt tlsKeyFile=/certs/client.key
time="2022-11-06T01:23:22Z" level=info msg="Please go to 'https://work.204px.dev/oauth/kratos/self-service/recovery/methods/link?flow=c3928b10-e0ae-44b9-949b-a3ed474de9fb&token=ZVZHKIxID2eJFkP6hgOdshUQ90NF45xm' to set password for 'admin@default.com'"
```
https://work.204px.dev/oauth/kratos/self-service/recovery/methods/link?flow=c3928b10-e0ae-44b9-949b-a3ed474de9fb&token=ZVZHKIxID2eJFkP6hgOdshUQ90NF45xm
设置密码: 1qaz!QAZ
用户名: admin@default.com
注: 要用 Chrome 浏览器

## 5. 安装 vizier
```shell
$ export PL_CLOUD_ADDR=204px.dev

$ px auth login --manual
## 这里会输出和个地址, https://work.204px.dev:443/login?local_mode=true 用Chrome打开这个页面登录(用上面的用户名和密码),把页面中的token粘贴到这里

$ px deploy --dev_cloud_namespace plc --pem_memory_limit=1Gi --use_etcd_operator
```

用Chrome打开地址:
https://work.204px.dev

提前准备镜像: px/images.txt

