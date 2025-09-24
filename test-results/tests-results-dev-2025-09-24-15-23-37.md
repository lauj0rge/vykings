# 🧪 Cluster Test Results for `dev`

## 📋 Summary
- **Generated:** 2025-09-24 15:23:37 CEST
- **Environment:** `dev`
- **Cluster Name:** `vyking-dev`
- **Kubeconfig Path:** `~/.kube/vyking-dev-config`
- **tfvars source:** `terraform/env/dev.tfvars`

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
k3d-vyking-dev
```

### Available contexts
```bash
+ kubectl config get-contexts
CURRENT   NAME             CLUSTER          AUTHINFO               NAMESPACE
*         k3d-vyking-dev   k3d-vyking-dev   admin@k3d-vyking-dev   
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
NAMESPACE       NAME                                                READY   STATUS             RESTARTS     AGE     IP          NODE                      NOMINATED NODE   READINESS GATES
argocd-dev      argocd-application-controller-0                     1/1     Running            0            2m14s   10.42.0.6   k3d-vyking-dev-agent-0    <none>           <none>
argocd-dev      argocd-applicationset-controller-78f49df558-t5vvt   1/1     Running            0            2m14s   10.42.2.5   k3d-vyking-dev-server-0   <none>           <none>
argocd-dev      argocd-dex-server-796678d5bc-fmb2g                  1/1     Running            0            2m14s   10.42.1.4   k3d-vyking-dev-agent-1    <none>           <none>
argocd-dev      argocd-notifications-controller-6d84bf8458-lfjfc    1/1     Running            0            2m13s   10.42.1.5   k3d-vyking-dev-agent-1    <none>           <none>
argocd-dev      argocd-redis-7c7fb7fc74-x27ws                       1/1     Running            0            2m14s   10.42.2.3   k3d-vyking-dev-server-0   <none>           <none>
argocd-dev      argocd-repo-server-d587f667c-8vfjg                  1/1     Running            0            2m14s   10.42.2.4   k3d-vyking-dev-server-0   <none>           <none>
argocd-dev      argocd-repo-server-d587f667c-s79v7                  1/1     Running            0            2m14s   10.42.0.5   k3d-vyking-dev-agent-0    <none>           <none>
argocd-dev      argocd-server-556b554c94-fjsnx                      1/1     Running            0            2m14s   10.42.1.6   k3d-vyking-dev-agent-1    <none>           <none>
argocd-dev      argocd-server-556b554c94-rrvjc                      1/1     Running            0            2m14s   10.42.0.4   k3d-vyking-dev-agent-0    <none>           <none>
backend-dev     backend-backend-558f8b5b6-mkmt6                     0/1     Running            0            6s      10.42.0.8   k3d-vyking-dev-agent-0    <none>           <none>
backend-dev     backend-backend-d875b6fbb-5p4qj                     1/1     Running            0            51s     10.42.2.6   k3d-vyking-dev-server-0   <none>           <none>
frontend-dev    frontend-frontend-58f8cfc665-7p4lc                  0/1     CrashLoopBackOff   3 (7s ago)   49s     10.42.2.7   k3d-vyking-dev-server-0   <none>           <none>
ingress-nginx   ingress-nginx-controller-599c5c76cc-8kf6m           1/1     Running            0            39s     10.42.1.8   k3d-vyking-dev-agent-1    <none>           <none>
kube-system     coredns-ccb96694c-4gsqs                             1/1     Running            0            19m     10.42.1.2   k3d-vyking-dev-agent-1    <none>           <none>
kube-system     local-path-provisioner-5cf85fd84d-hmctk             1/1     Running            0            19m     10.42.0.2   k3d-vyking-dev-agent-0    <none>           <none>
kube-system     metrics-server-5985cbc9d7-45clc                     1/1     Running            0            19m     10.42.2.2   k3d-vyking-dev-server-0   <none>           <none>
kube-system     sealed-secrets-controller-79c4ffdbd7-fkwmv          1/1     Running            0            3m42s   10.42.0.3   k3d-vyking-dev-agent-0    <none>           <none>
```

### svc (all namespaces)
```bash
+ kubectl get svc -A -o wide
NAMESPACE       NAME                                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE     SELECTOR
argocd-dev      argocd-application-controller-metrics   ClusterIP   10.43.4.66      <none>        8082/TCP                     2m17s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-application-controller
argocd-dev      argocd-applicationset-controller        ClusterIP   10.43.120.242   <none>        7000/TCP                     2m17s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-dev      argocd-dex-server                       ClusterIP   10.43.115.154   <none>        5556/TCP,5557/TCP,5558/TCP   2m17s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-dev      argocd-redis                            ClusterIP   10.43.230.93    <none>        6379/TCP                     2m17s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-dev      argocd-redis-metrics                    ClusterIP   None            <none>        9121/TCP                     2m17s   app.kubernetes.io/component=redis,app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-dev      argocd-repo-server                      ClusterIP   10.43.148.217   <none>        8081/TCP                     2m17s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-dev      argocd-repo-server-metrics              ClusterIP   10.43.58.147    <none>        8084/TCP                     2m17s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-dev      argocd-server                           ClusterIP   10.43.248.25    <none>        80/TCP,443/TCP               2m17s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
backend-dev     backend-backend                         ClusterIP   10.43.214.154   <none>        8081/TCP                     53s     app=backend-backend
default         kubernetes                              ClusterIP   10.43.0.1       <none>        443/TCP                      19m     <none>
frontend-dev    frontend-frontend                       ClusterIP   10.43.233.7     <none>        8080/TCP                     52s     app=frontend-frontend
ingress-nginx   ingress-nginx-controller                NodePort    10.43.43.251    <none>        80:30080/TCP,443:30443/TCP   40s     app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
ingress-nginx   ingress-nginx-controller-admission      ClusterIP   10.43.125.70    <none>        443/TCP                      40s     app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
kube-system     kube-dns                                ClusterIP   10.43.0.10      <none>        53/UDP,53/TCP,9153/TCP       19m     k8s-app=kube-dns
kube-system     metrics-server                          ClusterIP   10.43.32.221    <none>        443/TCP                      19m     k8s-app=metrics-server
kube-system     sealed-secrets-controller               ClusterIP   10.43.74.177    <none>        8080/TCP                     3m43s   name=sealed-secrets-controller
kube-system     sealed-secrets-controller-metrics       ClusterIP   10.43.196.244   <none>        8081/TCP                     3m43s   name=sealed-secrets-controller
```

### ingress (all namespaces)
```bash
+ kubectl get ingress -A -o wide
NAMESPACE      NAME                CLASS    HOSTS                ADDRESS        PORTS   AGE
backend-dev    backend-backend     <none>   frontend-dev.local                  80      52s
frontend-dev   frontend-frontend   <none>   frontend-dev.local   10.43.43.251   80      50s
```

### deploy (all namespaces)
```bash
+ kubectl get deploy -A -o wide
NAMESPACE       NAME                               READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS                  IMAGES                                                                                                                     SELECTOR
argocd-dev      argocd-applicationset-controller   1/1     1            1           2m16s   applicationset-controller   quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-dev      argocd-dex-server                  1/1     1            1           2m16s   dex-server                  ghcr.io/dexidp/dex:v2.44.0                                                                                                 app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-dev      argocd-notifications-controller    1/1     1            1           2m16s   notifications-controller    quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-notifications-controller
argocd-dev      argocd-redis                       1/1     1            1           2m16s   redis                       ecr-public.aws.com/docker/library/redis:7.2.8-alpine                                                                       app.kubernetes.io/name=argocd-redis
argocd-dev      argocd-repo-server                 2/2     2            2           2m16s   repo-server                 quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-dev      argocd-server                      2/2     2            2           2m16s   server                      quay.io/argoproj/argocd:v3.1.5                                                                                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
backend-dev     backend-backend                    1/1     1            1           52s     backend                     vyking-backend:dev                                                                                                         app=backend-backend
frontend-dev    frontend-frontend                  0/1     1            0           51s     frontend                    vyking-frontend:dev                                                                                                        app=frontend-frontend
ingress-nginx   ingress-nginx-controller           1/1     1            1           40s     controller                  registry.k8s.io/ingress-nginx/controller:v1.11.1@sha256:e6439a12b52076965928e83b7b56aae6731231677b01e81818bce7fa5c60161a   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
kube-system     coredns                            1/1     1            1           19m     coredns                     rancher/mirrored-coredns-coredns:1.12.0                                                                                    k8s-app=kube-dns
kube-system     local-path-provisioner             1/1     1            1           19m     local-path-provisioner      rancher/local-path-provisioner:v0.0.30                                                                                     app=local-path-provisioner
kube-system     metrics-server                     1/1     1            1           19m     metrics-server              rancher/mirrored-metrics-server:v0.7.2                                                                                     k8s-app=metrics-server
kube-system     sealed-secrets-controller          1/1     1            1           3m43s   sealed-secrets-controller   docker.io/bitnami/sealed-secrets-controller:0.27.1                                                                         name=sealed-secrets-controller
```

### statefulset (all namespaces)
```bash
+ kubectl get statefulset -A -o wide
NAMESPACE    NAME                            READY   AGE     CONTAINERS               IMAGES
argocd-dev   argocd-application-controller   1/1     2m16s   application-controller   quay.io/argoproj/argocd:v3.1.5
```

### cronjobs (all namespaces)
```bash
+ kubectl get cronjobs -A -o wide
No resources found
```

### hpa (all namespaces)
```bash
+ kubectl get hpa -A -o wide
NAMESPACE      NAME                REFERENCE                      TARGETS                                     MINPODS   MAXPODS   REPLICAS   AGE
backend-dev    backend-backend     Deployment/backend-backend     cpu: <unknown>/70%, memory: 28%/80%         1         3         1          53s
frontend-dev   frontend-frontend   Deployment/frontend-frontend   cpu: <unknown>/70%, memory: <unknown>/80%   1         3         1          51s
```

### Resource usage (nodes)
```bash
+ kubectl top nodes
NAME                      CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)   
k3d-vyking-dev-agent-0    488m         16%      544Mi           6%          
k3d-vyking-dev-agent-1    269m         8%       560Mi           7%          
k3d-vyking-dev-server-0   467m         15%      1081Mi          13%         
```

### Resource usage (pods, all namespaces)
```bash
+ kubectl top pods -A
NAMESPACE       NAME                                                CPU(cores)   MEMORY(bytes)   
argocd-dev      argocd-application-controller-0                     33m          113Mi           
argocd-dev      argocd-applicationset-controller-78f49df558-t5vvt   2m           88Mi            
argocd-dev      argocd-dex-server-796678d5bc-fmb2g                  1m           116Mi           
argocd-dev      argocd-notifications-controller-6d84bf8458-lfjfc    1m           59Mi            
argocd-dev      argocd-redis-7c7fb7fc74-x27ws                       4m           10Mi            
argocd-dev      argocd-repo-server-d587f667c-8vfjg                  2m           95Mi            
argocd-dev      argocd-repo-server-d587f667c-s79v7                  5m           52Mi            
argocd-dev      argocd-server-556b554c94-fjsnx                      2m           39Mi            
argocd-dev      argocd-server-556b554c94-rrvjc                      3m           59Mi            
backend-dev     backend-backend-d875b6fbb-5p4qj                     2m           35Mi            
ingress-nginx   ingress-nginx-controller-599c5c76cc-8kf6m           4m           91Mi            
kube-system     coredns-ccb96694c-4gsqs                             6m           15Mi            
kube-system     local-path-provisioner-5cf85fd84d-hmctk             1m           7Mi             
kube-system     metrics-server-5985cbc9d7-45clc                     17m          23Mi            
kube-system     sealed-secrets-controller-79c4ffdbd7-fkwmv          5m           15Mi            
```

## 🚦 Argo CD 
### Pods
```bash
+ kubectl get pods -n argocd-dev -o wide
NAME                                                READY   STATUS    RESTARTS   AGE     IP          NODE                      NOMINATED NODE   READINESS GATES
argocd-application-controller-0                     1/1     Running   0          2m17s   10.42.0.6   k3d-vyking-dev-agent-0    <none>           <none>
argocd-applicationset-controller-78f49df558-t5vvt   1/1     Running   0          2m17s   10.42.2.5   k3d-vyking-dev-server-0   <none>           <none>
argocd-dex-server-796678d5bc-fmb2g                  1/1     Running   0          2m17s   10.42.1.4   k3d-vyking-dev-agent-1    <none>           <none>
argocd-notifications-controller-6d84bf8458-lfjfc    1/1     Running   0          2m16s   10.42.1.5   k3d-vyking-dev-agent-1    <none>           <none>
argocd-redis-7c7fb7fc74-x27ws                       1/1     Running   0          2m17s   10.42.2.3   k3d-vyking-dev-server-0   <none>           <none>
argocd-repo-server-d587f667c-8vfjg                  1/1     Running   0          2m17s   10.42.2.4   k3d-vyking-dev-server-0   <none>           <none>
argocd-repo-server-d587f667c-s79v7                  1/1     Running   0          2m17s   10.42.0.5   k3d-vyking-dev-agent-0    <none>           <none>
argocd-server-556b554c94-fjsnx                      1/1     Running   0          2m17s   10.42.1.6   k3d-vyking-dev-agent-1    <none>           <none>
argocd-server-556b554c94-rrvjc                      1/1     Running   0          2m17s   10.42.0.4   k3d-vyking-dev-agent-0    <none>           <none>
```

### Deploy
```bash
+ kubectl get deploy -n argocd-dev -o wide
NAME                               READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS                  IMAGES                                                 SELECTOR
argocd-applicationset-controller   1/1     1            1           2m19s   applicationset-controller   quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-dex-server                  1/1     1            1           2m19s   dex-server                  ghcr.io/dexidp/dex:v2.44.0                             app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-notifications-controller    1/1     1            1           2m19s   notifications-controller    quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-notifications-controller
argocd-redis                       1/1     1            1           2m19s   redis                       ecr-public.aws.com/docker/library/redis:7.2.8-alpine   app.kubernetes.io/name=argocd-redis
argocd-repo-server                 2/2     2            2           2m19s   repo-server                 quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-server                      2/2     2            2           2m19s   server                      quay.io/argoproj/argocd:v3.1.5                         app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
```

### Statefulset
```bash
+ kubectl get statefulset -n argocd-dev -o wide
NAME                            READY   AGE     CONTAINERS               IMAGES
argocd-application-controller   1/1     2m18s   application-controller   quay.io/argoproj/argocd:v3.1.5
```

### Svc
```bash
+ kubectl get svc -n argocd-dev -o wide
NAME                                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE     SELECTOR
argocd-application-controller-metrics   ClusterIP   10.43.4.66      <none>        8082/TCP                     2m20s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-application-controller
argocd-applicationset-controller        ClusterIP   10.43.120.242   <none>        7000/TCP                     2m20s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-dex-server                       ClusterIP   10.43.115.154   <none>        5556/TCP,5557/TCP,5558/TCP   2m20s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-redis                            ClusterIP   10.43.230.93    <none>        6379/TCP                     2m20s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-redis-metrics                    ClusterIP   None            <none>        9121/TCP                     2m20s   app.kubernetes.io/component=redis,app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-repo-server                      ClusterIP   10.43.148.217   <none>        8081/TCP                     2m20s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-repo-server-metrics              ClusterIP   10.43.58.147    <none>        8084/TCP                     2m20s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-server                           ClusterIP   10.43.248.25    <none>        80/TCP,443/TCP               2m20s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
```

### Ingress
```bash
+ kubectl get ingress -n argocd-dev -o wide
No resources found in argocd-dev namespace.
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n argocd-dev
NAME                                                CPU(cores)   MEMORY(bytes)   
argocd-application-controller-0                     33m          113Mi           
argocd-applicationset-controller-78f49df558-t5vvt   2m           88Mi            
argocd-dex-server-796678d5bc-fmb2g                  1m           116Mi           
argocd-notifications-controller-6d84bf8458-lfjfc    1m           59Mi            
argocd-redis-7c7fb7fc74-x27ws                       4m           10Mi            
argocd-repo-server-d587f667c-8vfjg                  2m           95Mi            
argocd-repo-server-d587f667c-s79v7                  5m           52Mi            
argocd-server-556b554c94-fjsnx                      2m           39Mi            
argocd-server-556b554c94-rrvjc                      3m           59Mi            
```

## 🎨 Frontend (`frontend-dev`)
### Pods
```bash
+ kubectl get pods -n frontend-dev -o wide
NAME                                 READY   STATUS             RESTARTS      AGE   IP          NODE                      NOMINATED NODE   READINESS GATES
frontend-frontend-58f8cfc665-7p4lc   0/1     CrashLoopBackOff   3 (13s ago)   55s   10.42.2.7   k3d-vyking-dev-server-0   <none>           <none>
```

### Deploy
```bash
+ kubectl get deploy -n frontend-dev -o wide
NAME                READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                SELECTOR
frontend-frontend   0/1     1            0           56s   frontend     vyking-frontend:dev   app=frontend-frontend
```

### Statefulset
```bash
+ kubectl get statefulset -n frontend-dev -o wide
No resources found in frontend-dev namespace.
```

### Svc
```bash
+ kubectl get svc -n frontend-dev -o wide
NAME                TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE   SELECTOR
frontend-frontend   ClusterIP   10.43.233.7   <none>        8080/TCP   58s   app=frontend-frontend
```

### Ingress
```bash
+ kubectl get ingress -n frontend-dev -o wide
NAME                CLASS    HOSTS                ADDRESS        PORTS   AGE
frontend-frontend   <none>   frontend-dev.local   10.43.43.251   80      56s
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n frontend-dev
error: metrics not available yet
[command failed 0]
```

## ⚙️ Backend (`backend-dev`)
### Pods
```bash
+ kubectl get pods -n backend-dev -o wide
NAME                              READY   STATUS    RESTARTS   AGE   IP          NODE                      NOMINATED NODE   READINESS GATES
backend-backend-558f8b5b6-mkmt6   0/1     Running   0          14s   10.42.0.8   k3d-vyking-dev-agent-0    <none>           <none>
backend-backend-d875b6fbb-5p4qj   1/1     Running   0          59s   10.42.2.6   k3d-vyking-dev-server-0   <none>           <none>
```

### Deploy
```bash
+ kubectl get deploy -n backend-dev -o wide
NAME              READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES               SELECTOR
backend-backend   1/1     1            1           59s   backend      vyking-backend:dev   app=backend-backend
```

### Statefulset
```bash
+ kubectl get statefulset -n backend-dev -o wide
No resources found in backend-dev namespace.
```

### Svc
```bash
+ kubectl get svc -n backend-dev -o wide
NAME              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE   SELECTOR
backend-backend   ClusterIP   10.43.214.154   <none>        8081/TCP   61s   app=backend-backend
```

### Ingress
```bash
+ kubectl get ingress -n backend-dev -o wide
NAME              CLASS    HOSTS                ADDRESS   PORTS   AGE
backend-backend   <none>   frontend-dev.local             80      60s
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n backend-dev
NAME                              CPU(cores)   MEMORY(bytes)   
backend-backend-d875b6fbb-5p4qj   2m           35Mi            
```

## 🛢️ MySQL (`mysql-dev`)
### Pods
```bash
+ kubectl get pods -n mysql-dev -o wide
No resources found in mysql-dev namespace.
```

### Deploy
```bash
+ kubectl get deploy -n mysql-dev -o wide
No resources found in mysql-dev namespace.
```

### Statefulset
```bash
+ kubectl get statefulset -n mysql-dev -o wide
No resources found in mysql-dev namespace.
```

### Svc
```bash
+ kubectl get svc -n mysql-dev -o wide
No resources found in mysql-dev namespace.
```

### Ingress
```bash
+ kubectl get ingress -n mysql-dev -o wide
No resources found in mysql-dev namespace.
```

### Resource Usage (pods)
```bash
+ kubectl top pods -n mysql-dev
No resources found in mysql-dev namespace.
```

✅ Tests complete.
