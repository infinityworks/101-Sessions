
Install  setup
Presentation 
minikube

```minikube start```

Test ```kubectl```

SQL Server Example
Single pod resilient 

Persistent Data (Volumes)
Security storage

```kubectl create secret generic mssql --from-literal=SA_PASSWORD="MyC0m9l&xP@ssw0rd"```


claim a persistent storage.
```kubectl apply -f pv-claim.yml```


```minikube dashboard```


```service mssql-deployment --url```
