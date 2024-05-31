# Lambda-sample
This repository store some test code on AWS Lambda
#### 1.Get_DefaultModule
This code will query all pre-installed modules on Lambda execution environment.

#### 2. Create_Lambda_layer_python (Python)
The files associated with this script is:
```
|-Create_Lambda_layer_python.sh
|-requirements.txt
```
This script does not use container image to install the module and can be used on AWS CloudShell or other environments where disk space is limited.
Run command:
> $ sh Create_Lambda_layer_python.sh [your_Layer_name]

#### 3. Create_Lambda_layer_nodejs (Node.js)
The files associated with this script is:
```
|-Create_Lambda_layer_nodejs.sh
|-package.json
```
This script does not use container image to install the module and can be used on AWS CloudShell or other environments where disk space is limited.
Run command:
> $ sh Create_Lambda_layer_nodejs.sh [your_Layer_name]

#### 4. ContainerPackage
Use the official container image to install the required modules without install multiple runtime versions in the local environment or EC2.
