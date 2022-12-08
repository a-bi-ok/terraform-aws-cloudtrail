# basic selectors
# The following resource types are also available through advanced event selectors. 
# Basic event selector resource types are valid in advanced event selectors, 
# but advanced event selector resource types are not valid in basic event selectors. 
# For more information, see AdvancedFieldSelector:Field.

event_selector = [
  {
    include_management_events = true,
    read_write_type = "All",
    data_resource = [
      {
        type = "AWS::Lambda::Function",
        values = ["arn:aws:lambda"]
      },
      {
        type = "AWS::Lambda::Function",
        values = ["arn:aws:lambda:us-east-1:550416381825:function:mock-api-lambda-function"]
      },
      {
        type = "AWS::S3::Object",
        values = ["arn:aws:s3"]
      },
      {
        type = "AWS::S3::Object",
        values = ["arn:aws:s3:::mock-api-550416381825-lambda/"]
      },
      {
        type = "AWS::DynamoDB::Table",
        values = ["arn:aws:dynamodb"]
      },
      {
        type = "AWS::DynamoDB::Table",
        values = ["arn:aws:dynamodb:us-east-1:550416381825:table/mock-spur-database"]
      }
    ]
  }
]

# advanced selectors
# For AWS Config configuration item records, the only supported field is eventCategory.
# • readOnly 
# • eventSource 
# • eventName 
# • eventCategory - This is required and must be set to Equals. For CloudTrail event records, the
# • resources.type - 
# • AWS::S3::Object
# • AWS::Lambda::Function
# • AWS::DynamoDB::Table
# • AWS::S3Outposts::Object
# • AWS::ManagedBlockchain::Node
# • AWS::S3ObjectLambda::AccessPoint
# • AWS::EC2::Snapshot
# • AWS::S3::AccessPoint
# • AWS::DynamoDB::Stream
# • AWS::Glue::Table
# • AWS::FinSpace::Environment
# You can have only one resources.type field per selector.
# • resources.ARN - You can use any operator with resources.ARN, but if you use Equals

# https://docs.aws.amazon.com/pdfs/awscloudtrail/latest/APIReference/awscloudtrail-api.pdf#API_AdvancedFieldSelector
advanced_event_selector = []


# Amazon API Gateway is integrated with AWS CloudTrail, a service that provides a record of 
# actions taken by a user, a role, or an AWS service in API Gateway. CloudTrail captures all 
# REST API calls for API Gateway service APIs as events, 
# including calls from the API Gateway console and from code calls to the API Gateway service APIs.





# references
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-aws-service-specific-topics.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# https://docs.aws.amazon.com/awscloudtrail/latest/APIReference/API_AdvancedFieldSelector.html
# https://docs.aws.amazon.com/pdfs/awscloudtrail/latest/APIReference/awscloudtrail-api.pdf#API_AdvancedFieldSelector
# https://docs.aws.amazon.com/awscloudtrail/latest/APIReference/API_DataResource.html
# https://docs.aws.amazon.com/apigateway/latest/developerguide/cloudtrail.html
# https://docs.aws.amazon.com/appsync/latest/devguide/logging-using-cloudtrail.html








