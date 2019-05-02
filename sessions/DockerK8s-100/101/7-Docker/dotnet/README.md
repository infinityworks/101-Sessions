# Full Example Build and Host dotnet core application

## Optional Download dotnet core 2.2

https://dotnet.microsoft.com/download/dotnet-core/2.2


create new folder and run 

```dotnet new console -o app -n myapp```

or copy ```app``` folder 


edit code and paste from the example in ```app```

Optional, check the app runs

```dotnet run```

or 

```dotnet run -- 5```

## Create docker file

Copy the contents of the ```dockerfile``` to your file and run the following command

```docker build -t testapp .```

then

```docker run testapp```