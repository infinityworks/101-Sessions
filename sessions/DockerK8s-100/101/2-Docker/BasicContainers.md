# 2
## Run Switch Docker CLI commands

### Interactive with Console

To run a container locally and interact with the terminal use ```-i and -t``` switch. 
This can be combined to ```-it```

```docker run -it ubuntu bash```

to exit the bash terminal use ```exit```

### Destroy the container afterwards
Often you wish to run a container and then destroy it. This happen a lot when editing and changing your containers in dev. You can use the ```--rm``` option to do this.

```docker run -it --rm ubuntu bash```

### Image names, Repositories and DockerHub

The run command takes a string as a parameter, the above example used ```ubuntu``` this is the key for the image that will be used to run a container. It will look for the image locally first and then default to DockerHub.

```https://hub.docker.com```

You can change the location of where docker looks for a image. This often is a internal vetted repository of image that is approved for you organisation.

Example this command will get the latest version of ```Mongo```

```docker run mongo```

use ```control-c``` to exit

### Detached Mode

In the real world you dont want to keep an open terminal session open to the active container. By using the ```-d``` you can detach the container to run in the background

```docker run -d mongo```

then run

```docker ps -a```

You should see the container running.

### Stop/Remove containers and Remove images

At this stage you will have to tidy up your docker environment.
Firstly stop all running containers.

#### Containers

```docker stop my_container```

or to stop all 

```docker stop $(docker ps -q)```

or if you really need to kill all

```docker kill $(docker ps -q)```

Then you can remove them all

```docker rm $(docker ps -a -q)```

#### Images

```docker rmi my_image```

or all

```docker rmi $(docker images -q)```


### Versions, Tags and Names

In addition to the name of the docker image you can specify a version and or a tag. You can also give a name to the container using the ```--name```

So below we are combining a number of commands we have looked at before with the exception of the ```-p``` switch. This will map a port from the host to the container.
So ```-p 8000:80``` will map the ports and you can use you local browser to view the container hosted web sever. Windows hosts might need to us the ip address of the container by using the ```docker exec aspnetcore_sample ipconfig``` command.


```docker run -it --rm -p 8000:80 --name aspnetcore_sample mcr.microsoft.com/dotnet/core/samples:aspnetapp```

it runs a interactive terminal which will remove itself when it exits. It will be named "aspnetcore_sample" and be sourced with key "mcr.microsoft.com/dotnet/core/samples" and filtered using the tag aspnetapp. 
