If you get ahead in the regular tasks, you could try some of these extra improvements

## Create multiple functions

Rather than having a single function, use API gateway to do the API routing for you and define a separate lambda for your different API routes.

You will also need separate handlers in the JS app for each function you define.

## Remove stray files

You can filter what goes into your lambda function on the cloud like this. How small can you make your deployment package?

```yml
package:
    exclude:
        - src/**
        - .gitignore
    include:
        - src/important-file
```

(As we go though the main activities, more and more can be excluded)

## Add more API endpoints

Create API endpoints for other useful functions, like listing all the images and getting a single image.