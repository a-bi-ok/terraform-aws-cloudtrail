variable "enable_log_file_validation" {
  type        = bool
  default     = true
  description = "Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs"
}

variable "is_multi_region_trail" {
  type        = bool
  default     = true
  description = "Specifies whether the trail is created in the current region or in all regions"
}

variable "include_global_service_events" {
  type        = bool
  default     = false
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files"
}

variable "enable_logging" {
  type        = bool
  default     = true
  description = "Enable logging for the trail"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name for CloudTrail logs"
}

variable "cloud_watch_logs_role_arn" {
  type        = string
  description = "Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group"
  default     = ""
}

variable "cloud_watch_logs_group_arn" {
  type        = string
  description = "Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered"
  default     = ""
}

variable "insight_selector" {
  type = list(object({
    insight_type = string
  }))

  description = "Specifies an insight selector for type of insights to log on a trail"
  default     = []
}

variable "example" {
type = list(object({
  a = string
  b = bool
  d = list(list(string))
}))
default = [{a="xy", b=true, d=[["q","r","s"],[1,2,3]]}]
}

variable "event_selector" {
  type = list(object({
    include_management_events = bool
    read_write_type           = string
    data_resource = list(object({
      type   = string
      values = list(string)
    }))
  }))

  description = "Specifies an event selector for enabling data event logging. See: https://www.terraform.io/docs/providers/aws/r/cloudtrail.html for details on this variable"
  default     = [
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
}

variable "advanced_event_selector" {
  type = list(object({
    name = string
    field_selector    = list(object({
      field           = string
      equals          = list(string)
      # ends_with       = list(string)
      # not_ends_with   = list(string)
      # not_equals      = list(string)
      # not_starts_with = list(string)
      # starts_with     = list(string)
    }))
  }))

  description = "Specifies an advanced event selector for enabling data event logging. See: https://www.terraform.io/docs/providers/aws/r/cloudtrail.html for details on this variable"
  default     =  [
  {
    name = "Log Delete* events for one S3 bucket",
    field_selector = [
      {
        field = "eventCategory",
        equals = ["Data"],
      },
      {
        field = "eventName",
        equals = [ 
          "PutObject",
          "DeleteObject"
          ],
      },
      {
        field = "resources.ARN",
        equals = ["arn:aws:s3:::mock-api-550416381825-lambda/"],
      },
      {
        field = "readOnly",
        equals = ["false"],
      },
      {
        field = "resources.type",
        equals = ["AWS::S3::Object"],
      },
    ]
  },
]  
}


variable "kms_key_arn" {
  type        = string
  description = "Specifies the KMS key ARN to use to encrypt the logs delivered by CloudTrail"
  default     = ""
}

variable "is_organization_trail" {
  type        = bool
  default     = false
  description = "The trail is an AWS Organizations trail"
}

variable "sns_topic_name" {
  type        = string
  description = "Specifies the name of the Amazon SNS topic defined for notification of log file delivery"
  default     = null
}

variable "s3_key_prefix" {
  type        = string
  description = "Prefix for S3 bucket used by Cloudtrail to store logs"
  default     = null
}