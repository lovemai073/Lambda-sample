import json

def lambda_handler(event, context):
    print("---------------")
    module_obj= help('modules')
    print(module_obj)
    print("---------------")
