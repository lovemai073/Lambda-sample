import json
from importlib.metadata import packages_distributions, version

def lambda_handler(event, context):
    installed = [{“name”: pkg, “version”: version(pkg) } for pkgs in packages_distributions().values() for pkg in pkgs]
    return {
        ‘statusCode’: 200,
        ‘body’: installed
    }
