#!/bin/bash
# This version is shell script
# set --query "Endpoints[?Attributes.Enabled=='false'].EndpointArn" is filter endpoint status is disable
# set --attributes Enabled=true is set endpoint status is enable

All_SNS_ENDPOINTS=$(aws sns list-endpoints-by-platform-application --platform-application-arn [platform-application-arn] --query "Endpoints[?Attributes.Enabled=='true'].EndpointArn" --region [your-region-name] --output text)

for endpoint in $All_SNS_ENDPOINTS
do
  echo $endpoint
  aws sns set-endpoint-attributes --endpoint-arn $endpoint --attributes Enabled=false --region [your-region-name]
done
