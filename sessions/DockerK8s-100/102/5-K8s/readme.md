# Zero-Downtime deployment

Our Product manager came to us with a new requirement, our clients want to have a green button in the frontend. The developers shipped their code and provided us with the only thing we need, the container image.

We have change the image file in the deployment file but everything else is the same. The tag or the version has changed, thats it.

```sa-frontend-deployment-green.yaml```

## Roll out a change

```kubectl apply -f sa-frontend-deployment-green.yaml --record```

```--record``` will give a view on whats going on here.

use ```kubectl rollout status deployment sa-frontend``` to view.

According to the output the deployment was rolled out. It was done in such a fashion that the replicas were replaced one by one. Meaning that our application was always on

## Verifying the deployment

```minikube service sa-frontend-lb```

Rolling back to a previous state

```kubectl rollout history deployment sa-frontend```

pick at version

```kubectl rollout undo deployment sa-frontend --to-revision=2```

