# Docker Files
## Creating images
### Build command

Docker has a command called ```build``` which will uses a file called a ```dockerfile``` (notice no extension) to produce a image. ```-t``` tags the image.

```docker build -t utils . ```

or without tagging

```docker build .```

This then can be run using the following command

```docker run -it --rm utils curl -I google.com```

