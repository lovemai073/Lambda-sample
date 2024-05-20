#! /bin/bash
set -e
layername="$1"
architectures="x86_64"
supportruntime="nodejs16.x nodejs18.x"
echo "================================="

echo "LayerName: $layername"
echo "support-runtime: $supportruntime"
echo "================================="

layer_install_path="nodejs"

rm -rf $layer_install_path

mkdir $layer_install_path

cp package.json ./$layer_install_path
npm install --save $layer_install_path/ --prefix ./nodejs

zip -rg lambda-layer-nodejs.zip $layer_install_path

echo "Uploading lambda layer to AWS"
aws lambda publish-layer-version --compatible-architectures "$architectures" --layer-name "$layername" --compatible-runtimes $supportruntime --zip-file "fileb://lambda-layer-nodejs.zip"
echo "Finished"
