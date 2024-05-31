# Use Case

Use the public Lambda base image to package application modules or layer, so that users can quickly and correctly package the application package on any operating systems that support containers.

# Benefit

Users do not need to install and config multiple versions of the same runtime in the local environment.
Cross OS platform.
Not need to launch an EC2 instance with Amazon Linux AMI to install package.

# Minimum IAM Permission:

(If you need update function code or layer to Lambda function.)

    - lambda:UpdateFunctionCode
    - lambda:PublishLayerVersion

# Pre-requirements

Need to be pre-installed Docker client. https://www.docker.com/products/docker-desktop/
Prepare an application directory in local environment.

## Steps
#### Step 1: Prepare the work directory, for example: can specify the application root directory.
```
my_application
|- custom_module1.py
|- custom_module2.py
...
|- lambda_function.py
|- requirements.txt
``` 

If would like to package the Layer, we need to meet the path requirements. For example, the directory structure in python runtime is like this:

```
my_layer
│ python/PIL
└ python/Pillow-5.3.0.dist-info

```

#### Step 2. Choose a public images for SAM build.

Please refer to document [1] to select a public Image repositories to use In this case I use Python 3.10 as an example, or you can directly visit the page [2] to select the version you want to use

>>Python 3.10 : public.ecr.aws/sam/build-python3.10

[1] Image repositories - Image repository URIs - https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-image-repositories.html#serverless-image-repository-uris

[2] https://gallery.ecr.aws/sam?page=1

#### Step 3. Use the command "docker run" with some parameter to set the container environment for the installation package.

- use the parameter -v to mount the local directory to the directory in the container.
- use the parameter -w to specify the work dir.
- Use the parameter -c to execute the command in the container environment.

#### (Optional) Step 4. Execute command line in the container.

#### (Optional) Step 5. Exit container environment, we can see that the relevant packages have been installed in the local directory.

#### Step 6. we can zip the package directly in the container or back to the local environment to zip package.

[Command]
```
#!/bin/sh

# Set SAM Container Image
sam_image="public.ecr.aws/sam/build-python3.10:latest"

# Set Python application root path
localhost_AppRootPath="/Users/username/my_application"

# Set Layer root path (if you need to package layer)
install_layer_path="python"

# Execution container run container environment 
# -v Mount local path to container environment
# -w Set the container working directory
# -it Log in to bach directly after startup
# --rm Close the container directly after exit

# Package application bundle command

$ docker run --rm -v "$localhost_AppRootPath:/workdir" -w "/workdir" "$sam_image" /bin/bash -c "pip install -r requirements.txt -t ."


# Package Layer command

$ docker run --rm -v "$localhost_AppRootPath:/workdir" -w "/workdir" "$sam_image" /bin/bash -c "mkdir $install_layer_path && pip install -r requirements.txt -t $install_layer_path"

# Exit container
exit
```
[zip command]
```
[Application bundle]

zip -r package.zip * -x '*/__pycache__/*'

[Layer]

zip -r package.zip $install_layer_path/* -x '*/__pycache__/*'
````
After exiting the container, we can see that the installed packages/modules already exists in the application directory on the local environment. Can choose to package it directly into a .zip file in the container or manually package it in the local environment.



