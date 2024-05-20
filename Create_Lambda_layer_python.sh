#! /bin/bash
set -e
layername="$1"
architectures="x86_64"
supportruntime="python3.8 python3.9 python3.10 python3.11"
echo "================================="

echo "LayerName: $layername"
echo "support-runtime: $supportruntime"
echo "================================="

layer_install_path="python"

rm -rf $layer_install_path

mkdir $layer_install_path

pip install -t python -r requirements.txt

zip -rg lambda-layer.zip python

echo "Uploading lambda layer to AWS"
aws lambda publish-layer-version --compatible-architectures "$architectures" --layer-name "$layername" --compatible-runtimes $supportruntime --zip-file "fileb://lambda-layer.zip"
echo "Finished"
