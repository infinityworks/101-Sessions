# Full Example: Build and Host Node.js application

### Build image

Run the `docker build` command with the name set to `node101` via the `-t` option and selecting the current directory:

`docker build -t node101 .`

## Run docker container

Execute the following command to launch the container and publish it on the host and map our local 1337 port to 8080 on the container:

`docker run -p 1337:8080 node101`

The visit the following URL in your local web browser:

`http://localhost:1337` and you should see "Hello 101ers!"
