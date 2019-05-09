# Pods

```sa-frontend-pod.yaml```

1. Kind: specifies the kind of the Kubernetes Resource that we want to create. In our case, a Pod.
2. Name: defines the name for the resource. We named it sa-frontend.
3. Spec is the object that defines the desired state for the resource. The most important property of a Pods Spec is the Array of containers.
4. Image is the container image we want to start in this pod.
5. Name is the unique name for a container in a pod.
6. Container Port:is the port at which the container is listening. This is just an indicator for the reader (dropping the port doesn't restrict access).


## Create a Pod

```kubectl create -f sa-frontend-pod.yaml```

Check the pod is running

```kubectl get pods```

you can use the ```--watch``` argument to follow the state in the terminal.

## Access a Pod (the quick debug way)

```kubectl port-forward sa-frontend 88:80```

This is handy for debugging, resource type of ```service``` is the primary way to access

Open your browser in 127.0.0.1:88 and you will get to the react application.

## Create a additional Pod

kubectl create -f sa-frontend-pod2.yaml

Verify that the second pod is running by executing

Attention: this is not the final solution, and it has many flaws. We will improve this in the section for another Kubernetes resource Deployments.