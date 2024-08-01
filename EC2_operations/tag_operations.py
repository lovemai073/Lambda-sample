"""
#### event payload
{
  "instanceId": "i-0123456789abcdef",
  "tagKey": "Environment",
  "tagValue": "Production",
  "operation": "create"
}

#### IAM permission
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Resource": "*"
        }
    ]
}
"""
import boto3

# Create an EC2 client
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    # Get the instance IDs, tag key, tag value, and operation from the event
    instance_ids = event['instanceIds']
    tag_key = event['tagKey']
    tag_value = event['tagValue']
    operation = event['operation']

    # Create the tag specification
    tags = [
        {
            'Key': tag_key,
            'Value': tag_value
        }
    ]

    if operation == 'create':
        # Create the tag on the instances
        response = ec2.create_tags(
            Resources=instance_ids,
            Tags=tags
        )
        message = 'Tags created successfully'

    elif operation == 'delete':
        # Delete the tag from the instances
        response = ec2.delete_tags(
            Resources=instance_ids,
            Tags=tags
        )
        message = 'Tags deleted successfully'

    else:
        return {
            'statusCode': 400,
            'body': 'Invalid operation specified'
        }

    # Log the response
    print(response)

    return {
        'statusCode': 200,
        'body': message
    }
