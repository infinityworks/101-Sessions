# Full Stack Deployment

See slides

## Deployment Logic layer

```kubectl apply -f sa-logic-deploy```

 It labeled them with app: sa-logic. This labeling enables us to target them using a selector from the SA-Logic service.

## Service Logic layer

```kubectl apply -f service-sa-logic.yaml```

This is the entry point accessing the Logic layer

## Deployment Web App

Lets look at the ```sa-web-app-deployment.yaml```

what is sa-logic ?

## kube-dns

As default all Pods use a special Pod called kube-dns. kube-dns will create a DNS entry for each service.

This means that services can be reference by name

back to the Web app and lets deploy

```kubectl apply -f sa-web-app-deployment.yaml --record```

## Service Web App

```kubectl apply -f service-sa-web-app-lb.yaml```

## Check everything is run

```kubectl apply -f service-sa-frontend-lb.yaml```
```kubectl apply -f sa-frontend-deployment.yaml```


### To Be continued

```minikube service list```


|-------------|----------------------|-----------------------------|
|  NAMESPACE  |         NAME         |             URL             |
|-------------|----------------------|-----------------------------|
| default     | kubernetes           | No node port                |
| default     | sa-frontend-lb       | http://192.168.99.100:30795 |
| default     | sa-logic             | No node port                |
| default     | sa-web-app-lb        | http://192.168.99.100:31741 |
| kube-system | kube-dns             | No node port                |
| kube-system | kubernetes-dashboard | No node port                |
|-------------|----------------------|-----------------------------|