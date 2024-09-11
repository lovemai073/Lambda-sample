import boto3

# Create an SNS client
sns = boto3.client('sns', region_name='region-name')

# Specify the platform application ARN
platform_app_arn = 'platform application ARN'

# Get a list of enabled endpoint ARNs for the platform application
response = sns.list_endpoints_by_platform_application(
    PlatformApplicationArn=platform_app_arn
)
enabled_endpoints = [
    endpoint['EndpointArn'] for endpoint in response['Endpoints']
    if endpoint['Attributes']['Enabled'] == 'true' # or set false to filter disabled
]

# Disable each enabled endpoint
for endpoint_arn in enabled_endpoints:
    print(f"Operation endpoint: {endpoint_arn}")
    sns.set_endpoint_attributes(
        EndpointArn=endpoint_arn,
        Attributes={
            'Enabled': 'false' # or set true to set endpoint status is enable
        }
    )
