# Deployments

```sa-frontend-deployment.yaml```

1. Kind: A deployment.
2. Replicas is a property of the deployments Spec object that defines how many pods we want to run. So only 2.
3. Type specifies the strategy used in this deployment when moving from the current version to the next. The strategy RollingUpdate ensures Zero Downtime deployments.
4. MaxUnavailable is a property of the RollingUpdate object that specifies the maximum unavailable pods allowed (compared to the desired state) when doing a rolling update. For our deployment which has 2 replicas this means that after terminating one Pod, we would still have one pod running, this way keeping our application accessible.
5. MaxSurge is another property of the RollingUpdate object that defines the maximum amount of pods added to a deployment (compared to the desired state). For our deployment, this means that when moving to a new version we can add one pod, which adds up to 3 pods at the same time.
6. Template: specifies the pod template that the Deployment will use to create new pods. Most likely the resemblance with Pods struck you immediately.
7. app: sa-frontend the label to use for the pods created by this template.
8. ImagePullPolicy when set to Always, it will pull the container images on each redeployment.

## Apply a deployment

```kubectl apply -f sa-frontend-deployment.yaml```

and verify 

```kubectl get pods```

Now we see 4 running pods. The other two are the from our earlier, so we can delete.

```kubectl delete pod <pod-name>```

now delete one of the new pod and see what happens.

You now have a self healing desired state !!!