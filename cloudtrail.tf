
locals {
  event_selector = [
    {
      include_management_events = true,
      read_write_type           = "All",
      data_resource = [
        {
          type   = "AWS::S3::Object",
          values = ["arn:aws:s3:::matter-dev-assets-20210907170738040000000010/"]
        },
      ]
    }
  ]
  insight_selector = [
    { insight_type = "ApiCallRateInsight",
    },
    {
      insight_type = "ApiErrorRateInsight",
    }
  ]
  prefix                        = "apigw"
  name                          = "matter-${var.env}-${local.prefix}-trail"
  enable_logging                = true
  enable_log_file_validation    = false
  sns_topic_name                = ""
  is_multi_region_trail         = true
  include_global_service_events = true
  cloud_watch_logs_role_arn     = ""
  cloud_watch_logs_group_arn    = ""
  kms_key_arn                   = ""
  is_organization_trail         = false
}

module "trail_log_storage" {
  source = "./modules/trail-log-storage"
  env    = var.env
  prefix = local.prefix

}

resource "aws_cloudtrail" "trail" {
  name                          = local.name
  enable_logging                = local.enable_logging
  s3_bucket_name                = module.trail_log_storage.trail_log_bucket
  enable_log_file_validation    = local.enable_log_file_validation
  sns_topic_name                = local.sns_topic_name
  is_multi_region_trail         = local.is_multi_region_trail
  include_global_service_events = local.include_global_service_events
  cloud_watch_logs_role_arn     = local.cloud_watch_logs_role_arn
  cloud_watch_logs_group_arn    = local.cloud_watch_logs_group_arn
  kms_key_id                    = local.kms_key_arn
  is_organization_trail         = local.is_organization_trail
  s3_key_prefix                 = local.prefix


  dynamic "insight_selector" {
    for_each = local.insight_selector
    content {
      insight_type = insight_selector.value.insight_type
    }
  }

  dynamic "event_selector" {
    for_each = local.event_selector
    content {
      include_management_events = lookup(event_selector.value, "include_management_events", null)
      read_write_type           = lookup(event_selector.value, "read_write_type", null)

      dynamic "data_resource" {
        for_each = lookup(event_selector.value, "data_resource", [])
        content {
          type   = data_resource.value.type
          values = data_resource.value.values
        }
      }
    }
  }
}
