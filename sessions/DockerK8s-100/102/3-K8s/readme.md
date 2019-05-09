# Services

The Kubernetes Service resource acts as the entry point to a set of pods that provide the same functional service. This resource does the heavy lifting, of discovering services and load balancing between them

slides...

## Word on Labels
Labels provide a simple method for organizing your Kubernetes Resources. They represent a key-value pair and can be applied to every resource. 

Look at ```service-sa-frontend-lb.yaml```

1. Kind: A service.
2. Type: Specification type, we choose LoadBalancer because we want to balance the load between the pods.
3. Port: Specifies the port in which the service gets requests.
4. Protocol: Defines the communication.
5. TargetPort: The port at which incoming requests are forwarded.
6. Selector: Object that contains properties for selecting pods.
7. app: sa-frontend Defines which pods to target, only pods that are labeled with "app: sa-frontend"


## Show Pod Labels

```kubectl get pods --show-labels```

## Create a service

```kubectl create -f service-sa-frontend-lb.yaml```

and check the service 

```kubectl get svc```

The External-IP is in pending state (and don't wait, as it's not going to change). This is only because we are using Minikube. If we would have executed this in a cloud provider like Azure or GCP, we would get a Public IP, which makes our services worldwide accessible.

## Test a service

```minikube service sa-frontend-lb```