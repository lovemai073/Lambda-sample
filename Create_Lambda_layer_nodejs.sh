#! /bin/bash
# NOTE: nodejs24.x no longer supports callback-based function handlers.
# Only async/await handlers are supported. If your layer consumers use
# legacy callback-style handlers (e.g., exports.handler = function(event, context, callback){...}),
# they must migrate to async handlers before using nodejs24.x.

set -e
layername="$​1(31.56 TWD)"
architectures="x86_64 arm64"
supportruntime="nodejs20.x nodejs22.x nodejs24.x"
echo "================================="

echo "LayerName: $layername"
echo "support-runtime: $supportruntime"
echo "================================="

layer_install_path="nodejs"

rm -rf $layer_install_path

mkdir $layer_install_path

cp package.json ./$layer_install_path
cd $layer_install_path && npm install --production && cd ..

zip -rg lambda-layer-nodejs.zip $layer_install_path

echo "Uploading lambda layer to AWS"
aws lambda publish-layer-version --compatible-architectures "$architectures" --layer-name "$layername" --compatible-runtimes $supportruntime --zip-file "fileb://lambda-layer-nodejs.zip"
echo "Finished"
