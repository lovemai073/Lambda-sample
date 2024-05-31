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
