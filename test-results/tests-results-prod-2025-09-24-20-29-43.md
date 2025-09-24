# 🧪 Cluster Test Results for `prod`

## 📋 Summary
- **Generated:** 2025-09-24 20:29:44 CEST
- **Environment:** `prod`
- **Cluster Name:** `vyking-prod`
- **Kubeconfig Path:** `~/.kube/vyking-prod-config`
- **tfvars source:** `terraform/env/prod.tfvars`

## 🧭 Access Checks
### kubectl version
```bash
+ kubectl version
Client Version: v1.33.5
Kustomize Version: v5.6.0
Server Version: v1.31.5+k3s1
WARNING: version difference between client (1.33) and server (1.31) exceeds the supported minor version skew of +/-1
```

### Current context
```bash
+ kubectl config current-context
k3d-vyking-prod
```

### Available contexts
```bash
+ kubectl config get-contexts
CURRENT   NAME              CLUSTER           AUTHINFO                NAMESPACE
          k3d-vyking-dev    k3d-vyking-dev    admin@k3d-vyking-dev    
*         k3d-vyking-prod   k3d-vyking-prod   admin@k3d-vyking-prod   
```

## 🌐 Cluster Overview
### cluster-info
```bash
+ kubectl get cluster-info
error: the server doesn't have a resource type "cluster-info"
[command failed 0]
```

### nodes
```bash
+ kubectl get nodes nodes
Error from server (NotFound): nodes "nodes" not found
[command failed 0]
```

### ns
```bash
+ kubectl get ns ns
Error from server (NotFound): namespaces "ns" not found
[command failed 0]
```

### pv
```bash
+ kubectl get pv pv
Error from server (NotFound): persistentvolumes "pv" not found
[command failed 0]
```

### storageclass
```bash
+ kubectl get storageclass storageclass
Error from server (NotFound): storageclasses.storage.k8s.io "storageclass" not found
[command failed 0]
```

### pods (all namespaces)
```bash
+ kubectl get pods -A -o wide
NAMESPACE       NAME                                                READY   STATUS              RESTARTS       AGE     IP           NODE                       NOMINATED NODE   READINESS GATES
argocd-prod     argocd-application-controller-0                     1/1     Running             0              6m15s   10.42.1.5    k3d-vyking-prod-agent-0    <none>           <none>
argocd-prod     argocd-applicationset-controller-7bc5864576-8tz2f   1/1     Running             0              6m18s   10.42.1.4    k3d-vyking-prod-agent-0    <none>           <none>
argocd-prod     argocd-dex-server-5f859bdd4f-sdmmv                  1/1     Running             0              6m18s   10.42.3.5    k3d-vyking-prod-agent-1    <none>           <none>
argocd-prod     argocd-notifications-controller-785fbccdc6-v4wrs    1/1     Running             0              6m18s   10.42.3.4    k3d-vyking-prod-agent-1    <none>           <none>
argocd-prod     argocd-redis-7c7fb7fc74-gvcg8                       1/1     Running             0              6m18s   10.42.0.3    k3d-vyking-prod-server-0   <none>           <none>
argocd-prod     argocd-repo-server-7c88d9cd6-7lbfr                  1/1     Running             0              6m10s   10.42.1.7    k3d-vyking-prod-agent-0    <none>           <none>
argocd-prod     argocd-repo-server-7c88d9cd6-mtglc                  1/1     Running             0              6m10s   10.42.3.7    k3d-vyking-prod-agent-1    <none>           <none>
argocd-prod     argocd-server-6d495bb947-dmrtt                      1/1     Running             0              6m15s   10.42.1.6    k3d-vyking-prod-agent-0    <none>           <none>
argocd-prod     argocd-server-6d495bb947-ld9z6                      1/1     Running             0              6m18s   10.42.3.6    k3d-vyking-prod-agent-1    <none>           <none>
backend-prod    backend-backend-54f748f8b5-k45n4                    0/1     Running             0              3m40s   10.42.3.10   k3d-vyking-prod-agent-1    <none>           <none>
backend-prod    backend-backend-54f748f8b5-qrskk                    0/1     ImagePullBackOff    0              3m40s   10.42.0.5    k3d-vyking-prod-server-0   <none>           <none>
backend-prod    backend-backend-5d7d8cb99d-52z92                    0/1     ContainerCreating   0              12s     <none>       k3d-vyking-prod-agent-1    <none>           <none>
frontend-prod   frontend-frontend-cfd96d7cf-2pkcf                   0/1     Error               5 (100s ago)   3m46s   10.42.1.8    k3d-vyking-prod-agent-0    <none>           <none>
frontend-prod   frontend-frontend-cfd96d7cf-f27cw                   0/1     Error               5 (101s ago)   3m46s   10.42.3.9    k3d-vyking-prod-agent-1    <none>           <none>
ingress-nginx   ingress-nginx-controller-599c5c76cc-c46mj           1/1     Running             0              2m51s   10.42.1.9    k3d-vyking-prod-agent-0    <none>           <none>
kube-system     coredns-ccb96694c-6fkg4                             1/1     Running             0              36m     10.42.1.2    k3d-vyking-prod-agent-0    <none>           <none>
kube-system     local-path-provisioner-5cf85fd84d-f8dhm             1/1     Running             0              36m     10.42.0.2    k3d-vyking-prod-server-0   <none>           <none>
kube-system     metrics-server-5985cbc9d7-sxrw5                     1/1     Running             0              36m     10.42.1.3    k3d-vyking-prod-agent-0    <none>           <none>
kube-system     sealed-secrets-controller-79c4ffdbd7-z972m          1/1     Running             0              8m11s   10.42.3.2    k3d-vyking-prod-agent-1    <none>           <none>
mysql-prod      mysql-0                                             0/1     Init:0/1            0              4m15s   <none>       k3d-vyking-prod-server-0   <none>           <none>
```

### svc (all namespaces)
```bash
+ kubectl get svc -A -o wide
NAMESPACE       NAME                                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE     SELECTOR
argocd-prod     argocd-application-controller-metrics   ClusterIP   10.43.186.152   <none>        8082/TCP                     6m23s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-application-controller
argocd-prod     argocd-applicationset-controller        ClusterIP   10.43.222.204   <none>        7000/TCP                     6m23s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-prod     argocd-dex-server                       ClusterIP   10.43.188.45    <none>        5556/TCP,5557/TCP,5558/TCP   6m23s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-prod     argocd-redis                            ClusterIP   10.43.211.217   <none>        6379/TCP                     6m23s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-prod     argocd-redis-metrics                    ClusterIP   None            <none>        9121/TCP                     6m23s   app.kubernetes.io/component=redis,app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-prod     argocd-repo-server                      ClusterIP   10.43.84.82     <none>        8081/TCP                     6m23s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-prod     argocd-repo-server-metrics              ClusterIP   10.43.7.160     <none>        8084/TCP                     6m23s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-prod     argocd-server                           ClusterIP   10.43.214.125   <none>        80/TCP,443/TCP               6m23s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
backend-prod    backend-backend                         ClusterIP   10.43.195.220   <none>        8081/TCP                     3m44s   app=backend-backend
default         kubernetes                              ClusterIP   10.43.0.1       <none>        443/TCP                      37m     <none>
frontend-prod   frontend-frontend                       ClusterIP   10.43.73.122    <none>        8080/TCP                     3m49s   app=frontend-frontend
ingress-nginx   ingress-nginx-controller                NodePort    10.43.18.81     <none>        80:30080/TCP,443:30443/TCP   2m55s   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
ingress-nginx   ingress-nginx-controller-admission      ClusterIP   10.43.54.123    <none>        443/TCP                      2m55s   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
kube-system     kube-dns                                ClusterIP   10.43.0.10      <none>        53/UDP,53/TCP,9153/TCP       37m     k8s-app=kube-dns
kube-system     metrics-server                          ClusterIP   10.43.47.184    <none>        443/TCP                      36m     k8s-app=metrics-server
kube-system     sealed-secrets-controller               ClusterIP   10.43.121.12    <none>        8080/TCP                     8m13s   name=sealed-secrets-controller
kube-system     sealed-secrets-controller-metrics       ClusterIP   10.43.166.90    <none>        8081/TCP                     8m14s   name=sealed-secrets-controller
mysql-prod      mysql                                   ClusterIP   10.43.218.10    <none>        3306/TCP                     4m18s   app.kubernetes.io/component=primary,app.kubernetes.io/instance=mysql,app.kubernetes.io/name=mysql,app.kubernetes.io/part-of=mysql
mysql-prod      mysql-headless                          ClusterIP   None            <none>        3306/TCP                     4m18s   app.kubernetes.io/component=primary,app.kubernetes.io/instance=mysql,app.kubernetes.io/name=mysql
```

### ingress (all namespaces)
```bash
+ kubectl get ingress -A -o wide
NAMESPACE       NAME                CLASS    HOSTS                 ADDRESS       PORTS     AGE
backend-prod    backend-backend     <none>   frontend.local                      80        3m43s
frontend-prod   frontend-frontend   <none>   frontend-prod.local   10.43.18.81   80, 443   3m48s
```

### deploy (all namespaces)
```bash
+ kubectl get deploy -A -o wide
NAMESPACE       NAME                               READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS                  IMAGES                                                                                                                     SELECTOR
argocd-prod     argocd-applicationset-controller   1/1     1            1           6m23s   applicationset-controller   quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-prod     argocd-dex-server                  1/1     1            1           6m23s   dex-server                  ghcr.io/dexidp/dex:v2.44.0                                                                                                 app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-prod     argocd-notifications-controller    1/1     1            1           6m23s   notifications-controller    quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-notifications-controller
argocd-prod     argocd-redis                       1/1     1            1           6m23s   redis                       ecr-public.aws.com/docker/library/redis:7.2.8-alpine                                                                       app.kubernetes.io/name=argocd-redis
argocd-prod     argocd-repo-server                 2/2     2            2           6m23s   repo-server                 quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-prod     argocd-server                      2/2     2            2           6m23s   server                      quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
backend-prod    backend-backend                    0/2     1            0           3m45s   backend                     vyking-backend:prod                                                                                                        app=backend-backend
frontend-prod   frontend-frontend                  0/2     2            0           3m50s   frontend                    vyking-frontend:prod                                                                                                       app=frontend-frontend
ingress-nginx   ingress-nginx-controller           1/1     1            1           2m56s   controller                  registry.k8s.io/ingress-nginx/controller:v1.11.1@sha256:e6439a12b52076965928e83b7b56aae6731231677b01e81818bce7fa5c60161a   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
kube-system     coredns                            1/1     1            1           37m     coredns                     rancher/mirrored-coredns-coredns:1.12.0                                                                                    k8s-app=kube-dns
kube-system     local-path-provisioner             1/1     1            1           36m     local-path-provisioner      rancher/local-path-provisioner:v0.0.30                                                                                     app=local-path-provisioner
kube-system     metrics-server                     1/1     1            1           36m     metrics-server              rancher/mirrored-metrics-server:v0.7.2                                                                                     k8s-app=metrics-server
kube-system     sealed-secrets-controller          1/1     1            1           8m15s   sealed-secrets-controller   docker.io/bitnami/sealed-secrets-controller:0.27.1                                                                         name=sealed-secrets-controller
```

### statefulset (all namespaces)
```bash
+ kubectl get statefulset -A -o wide
NAMESPACE     NAME                            READY   AGE     CONTAINERS               IMAGES
argocd-prod   argocd-application-controller   1/1     6m24s   application-controller   quay.io/argoproj/argocd:v3.1.5
mysql-prod    mysql                           0/1     4m20s   mysql                    docker.io/bitnami/mysql:9.4.0-debian-12-r1
```

### cronjobs (all namespaces)
```bash
+ kubectl get cronjobs -A -o wide
NAMESPACE    NAME           SCHEDULE       TIMEZONE   SUSPEND   ACTIVE   LAST SCHEDULE   AGE     CONTAINERS     IMAGES                                        SELECTOR
mysql-prod   mysql-backup   0 */48 * * *   <none>     False     0        <none>          4m21s   mysql-backup   docker.io/bitnami/mysql:8.0.39-debian-12-r1   <none>
```

### hpa (all namespaces)
```bash
+ kubectl get hpa -A -o wide
NAMESPACE       NAME                REFERENCE                      TARGETS                                     MINPODS   MAXPODS   REPLICAS   AGE
backend-prod    backend-backend     Deployment/backend-backend     cpu: <unknown>/70%, memory: <unknown>/80%   2         6         2          3m48s
frontend-prod   frontend-frontend   Deployment/frontend-frontend   cpu: <unknown>/70%, memory: <unknown>/80%   2         5         2          3m54s
mysql-prod      mysql-hpa           StatefulSet/mysql              cpu: <unknown>/70%                          1         3         1          4m24s
```

### Resource usage (nodes)
```bash
+ kubectl top nodes
NAME                       CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)   
k3d-vyking-prod-agent-0    318m         10%      653Mi           8%          
k3d-vyking-prod-agent-1    421m         14%      472Mi           5%          
k3d-vyking-prod-server-0   486m         16%      773Mi           9%          
```

### Resource usage (pods, all namespaces)
```bash
+ kubectl top pods -A
NAMESPACE       NAME                                                CPU(cores)   MEMORY(bytes)   
argocd-prod     argocd-application-controller-0                     39m          98Mi            
argocd-prod     argocd-applicationset-controller-7bc5864576-8tz2f   3m           120Mi           
argocd-prod     argocd-dex-server-5f859bdd4f-sdmmv                  0m           55Mi            
argocd-prod     argocd-notifications-controller-785fbccdc6-v4wrs    2m           25Mi            
argocd-prod     argocd-redis-7c7fb7fc74-gvcg8                       5m           3Mi             
argocd-prod     argocd-repo-server-7c88d9cd6-7lbfr                  4m           43Mi            
argocd-prod     argocd-repo-server-7c88d9cd6-mtglc                  26m          92Mi            
argocd-prod     argocd-server-6d495bb947-dmrtt                      3m           27Mi            
argocd-prod     argocd-server-6d495bb947-ld9z6                      5m           26Mi            
backend-prod    backend-backend-54f748f8b5-k45n4                    92m          28Mi            
ingress-nginx   ingress-nginx-controller-599c5c76cc-c46mj           4m           53Mi            
kube-system     coredns-ccb96694c-6fkg4                             12m          29Mi            
kube-system     local-path-provisioner-5cf85fd84d-f8dhm             2m           21Mi            
kube-system     metrics-server-5985cbc9d7-sxrw5                     18m          30Mi            
kube-system     sealed-secrets-controller-79c4ffdbd7-z972m          11m          12Mi            
```

## 🚦 Argo CD 
### Pods
```bash
+ kubectl get pods -n argocd-prod -o wide
NAME                                                READY   STATUS    RESTARTS   AGE     IP          NODE                       NOMINATED NODE   READINESS GATES
argocd-application-controller-0                     1/1     Running   0          6m26s   10.42.1.5   k3d-vyking-prod-agent-0    <none>           <none>
argocd-applicationset-controller-7bc5864576-8tz2f   1/1     Running   0          6m29s   10.42.1.4   k3d-vyking-prod-agent-0    <none>           <none>
argocd-dex-server-5f859bdd4f-sdmmv                  1/1     Running   0          6m29s   10.42.3.5   k3d-vyking-prod-agent-1    <none>           <none>
argocd-notifications-controller-785fbccdc6-v4wrs    1/1     Running   0          6m29s   10.42.3.4   k3d-vyking-prod-agent-1    <none>           <none>
argocd-redis-7c7fb7fc74-gvcg8                       1/1     Running   0          6m29s   10.42.0.3   k3d-vyking-prod-server-0   <none>           <none>
argocd-repo-server-7c88d9cd6-7lbfr                  1/1     Running   0          6m21s   10.42.1.7   k3d-vyking-prod-agent-0    <none>           <none>
argocd-repo-server-7c88d9cd6-mtglc                  1/1     Running   0          6m21s   10.42.3.7   k3d-vyking-prod-agent-1    <none>           <none>
argocd-server-6d495bb947-dmrtt                      1/1     Running   0          6m26s   10.42.1.6   k3d-vyking-prod-agent-0    <none>           <none>
argocd-server-6d495bb947-ld9z6                      1/1     Running   0          6m29s   10.42.3.6   k3d-vyking-prod-agent-1    <none>           <none>
```

### Deploy
```bash
+ kubectl get deploy -n argocd-prod -o wide
NAME                               READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS                  IMAGES                                                 SELECTOR
argocd-applicationset-controller   1/1     1            1           6m32s   applicationset-controller   quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-dex-server                  1/1     1            1           6m32s   dex-server                  ghcr.io/dexidp/dex:v2.44.0                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-notifications-controller    1/1     1            1           6m32s   notifications-controller    quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-notifications-controller
argocd-redis                       1/1     1            1           6m32s   redis                       ecr-public.aws.com/docker/library/redis:7.2.8-alpine   app.kubernetes.io/name=argocd-redis
argocd-repo-server                 2/2     2            2           6m32s   repo-server                 quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-server                      2/2     2            2           6m32s   server                      quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
```

### Statefulset
```bash
+ kubectl get statefulset -n argocd-prod -o wide
NAME                            READY   AGE     CONTAINERS               IMAGES
argocd-application-controller   1/1     6m32s   application-controller   quay.io/argoproj/argocd:v3.1.5
```

### Svc
```bash
+ kubectl get svc -n argocd-prod -o wide
NAME                                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE     SELECTOR
argocd-application-controller-metrics   ClusterIP   10.43.186.152   <none>        8082/TCP                     6m35s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-application-controller
argocd-applicationset-controller        ClusterIP   10.43.222.204   <none>        7000/TCP                     6m35s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-dex-server                       ClusterIP   10.43.188.45    <none>        5556/TCP,5557/TCP,5558/TCP   6m35s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-redis                            ClusterIP   10.43.211.217   <none>        6379/TCP                     6m35s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-redis-metrics                    ClusterIP   None            <none>        9121/TCP                     6m35s   app.kubernetes.io/component=redis,app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-repo-server                      ClusterIP   10.43.84.82     <none>        8081/TCP                     6m35s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-repo-server-metrics              ClusterIP   10.43.7.160     <none>        8084/TCP                     6m35s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-server                           ClusterIP   10.43.214.125   <none>        80/TCP,443/TCP               6m35s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
```

### Ingress
```bash
+ kubectl get ingress -n argocd-prod -o wide
No resources found in argocd-prod namespace.
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n argocd-prod
NAME                                                CPU(cores)   MEMORY(bytes)   
argocd-application-controller-0                     39m          98Mi            
argocd-applicationset-controller-7bc5864576-8tz2f   3m           120Mi           
argocd-dex-server-5f859bdd4f-sdmmv                  0m           55Mi            
argocd-notifications-controller-785fbccdc6-v4wrs    2m           25Mi            
argocd-redis-7c7fb7fc74-gvcg8                       5m           3Mi             
argocd-repo-server-7c88d9cd6-7lbfr                  4m           43Mi            
argocd-repo-server-7c88d9cd6-mtglc                  26m          92Mi            
argocd-server-6d495bb947-dmrtt                      3m           27Mi            
argocd-server-6d495bb947-ld9z6                      5m           26Mi            
```

## 🎨 Frontend (`frontend-prod`)
### Pods
```bash
+ kubectl get pods -n frontend-prod -o wide
NAME                                READY   STATUS             RESTARTS      AGE    IP          NODE                      NOMINATED NODE   READINESS GATES
frontend-frontend-cfd96d7cf-2pkcf   0/1     CrashLoopBackOff   5 (29s ago)   4m2s   10.42.1.8   k3d-vyking-prod-agent-0   <none>           <none>
frontend-frontend-cfd96d7cf-f27cw   0/1     CrashLoopBackOff   5 (32s ago)   4m2s   10.42.3.9   k3d-vyking-prod-agent-1   <none>           <none>
```

### Deploy
```bash
+ kubectl get deploy -n frontend-prod -o wide
NAME                READY   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS   IMAGES                 SELECTOR
frontend-frontend   0/2     2            0           4m3s   frontend     vyking-frontend:prod   app=frontend-frontend
```

### Statefulset
```bash
+ kubectl get statefulset -n frontend-prod -o wide
No resources found in frontend-prod namespace.
```

### Svc
```bash
+ kubectl get svc -n frontend-prod -o wide
NAME                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE    SELECTOR
frontend-frontend   ClusterIP   10.43.73.122   <none>        8080/TCP   4m5s   app=frontend-frontend
```

### Ingress
```bash
+ kubectl get ingress -n frontend-prod -o wide
NAME                CLASS    HOSTS                 ADDRESS       PORTS     AGE
frontend-frontend   <none>   frontend-prod.local   10.43.18.81   80, 443   4m3s
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n frontend-prod
error: Metrics not available for pod frontend-prod/frontend-frontend-cfd96d7cf-2pkcf, age: 4m5.586835301s
[command failed 0]
```

## ⚙️ Backend (`backend-prod`)
### Pods
```bash
+ kubectl get pods -n backend-prod -o wide
NAME                               READY   STATUS             RESTARTS   AGE   IP           NODE                       NOMINATED NODE   READINESS GATES
backend-backend-54f748f8b5-k45n4   0/1     Running            0          4m    10.42.3.10   k3d-vyking-prod-agent-1    <none>           <none>
backend-backend-54f748f8b5-qrskk   0/1     ImagePullBackOff   0          4m    10.42.0.5    k3d-vyking-prod-server-0   <none>           <none>
backend-backend-5d7d8cb99d-52z92   0/1     Running            0          32s   10.42.3.12   k3d-vyking-prod-agent-1    <none>           <none>
```

### Deploy
```bash
+ kubectl get deploy -n backend-prod -o wide
NAME              READY   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS   IMAGES                SELECTOR
backend-backend   0/2     1            0           4m1s   backend      vyking-backend:prod   app=backend-backend
```

### Statefulset
```bash
+ kubectl get statefulset -n backend-prod -o wide
No resources found in backend-prod namespace.
```

### Svc
```bash
+ kubectl get svc -n backend-prod -o wide
NAME              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE    SELECTOR
backend-backend   ClusterIP   10.43.195.220   <none>        8081/TCP   4m3s   app=backend-backend
```

### Ingress
```bash
+ kubectl get ingress -n backend-prod -o wide
NAME              CLASS    HOSTS            ADDRESS   PORTS   AGE
backend-backend   <none>   frontend.local             80      4m1s
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n backend-prod
NAME                               CPU(cores)   MEMORY(bytes)   
backend-backend-54f748f8b5-k45n4   88m          31Mi            
backend-backend-5d7d8cb99d-52z92   52m          23Mi            
```

## 🛢️ MySQL (`mysql-prod`)
### Pods
```bash
+ kubectl get pods -n mysql-prod -o wide
NAME      READY   STATUS     RESTARTS   AGE     IP       NODE                       NOMINATED NODE   READINESS GATES
mysql-0   0/1     Init:0/1   0          4m38s   <none>   k3d-vyking-prod-server-0   <none>           <none>
```

### Deploy
```bash
+ kubectl get deploy -n mysql-prod -o wide
No resources found in mysql-prod namespace.
```

### Statefulset
```bash
+ kubectl get statefulset -n mysql-prod -o wide
NAME    READY   AGE     CONTAINERS   IMAGES
mysql   0/1     4m40s   mysql        docker.io/bitnami/mysql:9.4.0-debian-12-r1
```

### Svc
```bash
+ kubectl get svc -n mysql-prod -o wide
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE     SELECTOR
mysql            ClusterIP   10.43.218.10   <none>        3306/TCP   4m41s   app.kubernetes.io/component=primary,app.kubernetes.io/instance=mysql,app.kubernetes.io/name=mysql,app.kubernetes.io/part-of=mysql
mysql-headless   ClusterIP   None           <none>        3306/TCP   4m41s   app.kubernetes.io/component=primary,app.kubernetes.io/instance=mysql,app.kubernetes.io/name=mysql
```

### Ingress
```bash
+ kubectl get ingress -n mysql-prod -o wide
No resources found in mysql-prod namespace.
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n mysql-prod
error: Metrics not available for pod mysql-prod/mysql-0, age: 4m44.092353104s
[command failed 0]
```

✅ Tests complete.
