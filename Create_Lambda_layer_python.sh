#! /bin/bash
set -e
layername="$1"
architectures="x86_64 arm64"
supportruntime="python3.12 python3.13 python3.14"
echo "================================="

echo "LayerName: $layername"
echo "support-runtime: $supportruntime"
echo "================================="

layer_install_path="python"

rm -rf $layer_install_path

mkdir $layer_install_path

pip install -t python -r requirements.txt \
   --platform manylinux2014_x86_64 \
   --platform manylinux2014_aarch64 \
   --only-binary=:all:

zip -rg lambda-layer.zip python

echo "Uploading lambda layer to AWS"
aws lambda publish-layer-version --compatible-architectures "$architectures" --layer-name "$layername" --compatible-runtimes $supportruntime --zip-file "fileb://lambda-layer.zip"
echo "Finished"
