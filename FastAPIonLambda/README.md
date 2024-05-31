### Build command
```
#!/bin/sh

# Set SAM Container Image
sam_image="public.ecr.aws/sam/build-python3.11:latest"

# Set Python application root path
localhost_AppRootPath="/fastapi-lambda"

# Execution container run container environment 
# -v Mount local path to container environment
# -w Set the container working directory
# -it Log in to bach directly after startup
# --rm Close the container directly after exit

# Package application bundle command

docker run --rm -v "$localhost_AppRootPath:/workdir" -w "/workdir" "$sam_image" /bin/bash -c "pip install -r requirements.txt -t ."

# Exit container
exit
```

### zip command
```
$ zip -r ../lambda-package.zip * -x '*/__pycache__/*'
```

### Check zip file
```
$ unzip -l lambda-package.zip

Archive:  lambda-package.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
      983  05-31-2024 03:59   app.py
....
        0  05-31-2024 02:58   fastapi/
     1081  05-31-2024 02:58   fastapi/__init__.py
    23134  05-31-2024 02:58   fastapi/_compat.py
   176342  05-31-2024 02:58   fastapi/applications.py
....
        0  05-31-2024 02:58   pygments/
     2959  05-31-2024 02:58   pygments/__init__.py
      348  05-31-2024 02:58   pygments/__main__.py
    23536  05-31-2024 02:58   pygments/cmdline.py
....
       27  05-31-2024 02:50   requirements.txt
....
        0  05-31-2024 02:58   uvicorn/
      147  05-31-2024 02:58   uvicorn/__init__.py
       62  05-31-2024 02:58   uvicorn/__main__.py
....
```

### Deploy to Lambda function
```
$ aws lambda update-function-code --function-name [functionName] --zip-file fileb://lambda-package.zip --region [Region]
```

### Test command
[GET]
```
curl --location 'https://rr3xrvyxarqixcya4opoanfy3a0qammw.lambda-url.ap-northeast-1.on.aws/xxxx'
```
[POST]
```
$ curl --location 'https://xxxxx.lambda-url.region.on.aws/xxxx' \
--header 'Content-Type: application/json' \
--data '{
    "key1":"Value1",
    "key2":"Value2",
    "key3":1000.0
}'
```
