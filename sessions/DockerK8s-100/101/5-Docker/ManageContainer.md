
# Managing Containers

### Stop command
Run a container to stop

```docker run -d --name test ubuntu:16.04 /bin/bash```

List the names of the containers

```docker ps -a```

Stop using the name or id

```docker stop test```

### Start command

```docker start test```

### Logs of container
Here is a container that will generate some logs

```docker run --name test2 -d busybox sh -c "while true; do $(echo date); sleep 1; done"```

To view the logs of the container as a snapshot use the following command.

```docker logs test2```

To see the logs in real time by following the logs. use the ```-f``` switch

```docker logs -f test2```

### SSH into a Container or Attaching to a running container

Use ```docker ps``` to get the name of the existing container

Use the command ```docker exec -it <container name> /bin/bash``` to get a bash shell in the container

Generically, use ```docker exec -it <container name> <command>``` to execute whatever command you specify in the container.

```docker run -d --name test nginx```

```docker attach test```

careful as stopping this will stop the container

The following command will not stop the container when exiting the shell

```docker exec -it test bash```
