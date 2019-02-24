steps to run it locally - 

```
1. minikube start
2. create secret for pgdbpassword
3. apply ingress config, enable minikube for it
4. kubectl apply -f k8s 
```

Notes for deployment on google cloud - 

1. setup travis - 
# google cloud service account -
 created service account for google cloud at https://console.cloud.google.com/iam-admin/serviceaccounts?project=fibo-kubernetes, downloaded the service-account.json. 

 run - docker run -it -v $(pwd):/app ruby:2.3 sh (totally optional to run the container with ruby)

 commands need to run-
 ```
 travis
 tavis login
 travis encrypt-file service-account.json -r Abhay-Joshi-Git/fibo-kubernetes
```
 which creates enc file, which can be pushed to github - which happens in travis.yml - before install. We also configure goolge cloud to authenticate with the service-account.json, set correct project, compute zone

# check deploy.sh file - 
  a. we build docker images with tag equal to comming SHA and push that to dockerhub
  b. set the image imperatively for deployments client, server, worker so that they start deploying with new images

2. installing nginx ingress service with helm (using cloud shell)

installing helm with cloud shell - 
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
```
 - creating service accout, cluster role, setting up role binding to cluster-admin, initializing service account, installing ingress nginx
 - commands to execute with cloud shell - 
 ```
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-role --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  helm init --service-account tiller --upgrade
  helm install stable/nginx-ingress --name my-nginx --set rbac.create=true
```

