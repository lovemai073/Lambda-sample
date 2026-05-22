# Lambda-sample

This repository contains sample scripts and tools for AWS Lambda development.

---

## 1. Get_DefaultModule

Query all pre-installed modules on the Lambda execution environment.

---

## 2. Create_Lambda_layer_python (Python)

Create and publish a Lambda Layer for Python runtimes.

**Supported runtimes:** `python3.12`, `python3.13`, `python3.14`  
**Supported architectures:** `x86_64`, `arm64`

**Associated files:**
```
├── Create_Lambda_layer_python.sh
└── requirements.txt
```

**Prerequisites:**
- AWS CLI configured with appropriate permissions
- `pip` installed
- `zip` command available

**Usage:**
```bash
sh Create_Lambda_layer_python.sh <your_layer_name>
```

> **Note:** This script uses `--platform` and `--only-binary` pip flags to ensure native C extensions are compatible with both x86_64 and arm64 architectures. If your `requirements.txt` only contains pure-Python packages (e.g., `requests`, `boto3`), you can simplify by removing these flags from the script.

---

## 3. Create_Lambda_layer_nodejs (Node.js)

Create and publish a Lambda Layer for Node.js runtimes.

**Supported runtimes:** `nodejs20.x`, `nodejs22.x`, `nodejs24.x`  
**Supported architectures:** `x86_64`, `arm64`

**Associated files:**
```
├── Create_Lambda_layer_nodejs.sh
└── package.json
```

**Prerequisites:**
- AWS CLI configured with appropriate permissions
- `npm` installed
- `zip` command available

**Usage:**
```bash
sh Create_Lambda_layer_nodejs.sh <your_layer_name>
```

> **Note:** `nodejs24.x` no longer supports callback-based function handlers. Only `async/await` handlers are supported. If your layer consumers still use legacy callback-style handlers, they must migrate before using `nodejs24.x`.

---

## 4. ContainerPackage

Use the official AWS Lambda container base image to install required modules without needing multiple runtime versions in the local environment or EC2.

---

## Environment Compatibility

These scripts are lightweight and do not require container images. They can be used on:
- AWS CloudShell
- EC2 instances
- Local environments with limited disk space

---

## Runtime Support Reference

| Language | Supported Runtimes | EOL Notes |
|----------|-------------------|-----------|
| Python | 3.12, 3.13, 3.14 | python3.11 entering deprecation in 2026 |
| Node.js | 20.x, 22.x, 24.x | nodejs18.x entering deprecation in 2025 |

For the latest runtime support status, see [AWS Lambda Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html).
