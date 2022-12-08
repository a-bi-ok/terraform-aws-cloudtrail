resource "aws_cloudtrail" "default" {
  count                         = module.this.enabled ? 1 : 0
  name                          = module.this.id
  enable_logging                = var.enable_logging
  s3_bucket_name                = var.s3_bucket_name
  enable_log_file_validation    = var.enable_log_file_validation
  sns_topic_name                = var.sns_topic_name
  is_multi_region_trail         = var.is_multi_region_trail
  include_global_service_events = var.include_global_service_events
  cloud_watch_logs_role_arn     = var.cloud_watch_logs_role_arn
  cloud_watch_logs_group_arn    = var.cloud_watch_logs_group_arn
  tags                          = module.this.tags
  kms_key_id                    = var.kms_key_arn
  is_organization_trail         = var.is_organization_trail
  s3_key_prefix                 = var.s3_key_prefix

  dynamic "insight_selector" {
    for_each = var.insight_selector
    content {
      insight_type = insight_selector.value.insight_type
    }
  }

  # dynamic "advanced_event_selector" {
  #   for_each = var.advanced_event_selector
  #   content {
  #     name = lookup(advanced_event_selector.value, "name", "placeholder")
  #     dynamic "field_selector" {
  #       for_each = lookup(advanced_event_selector.value, "field_selector", [])
  #       content {
  #         field           = field_selector.value.field
  #         equals          = field_selector.value.equals
  #         # ends_with       = lookup(field_selector.value, "ends_with", [])==[]? []: field_selector.value.ends_with
  #         # not_ends_with   = field_selector.value.not_ends_with
  #         # not_equals      = field_selector.value.not_equals
  #         # not_starts_with = field_selector.value.not_starts_with
  #         # starts_with     = field_selector.value.starts_with
  #       }
  #     }
  #   }
  # }

  dynamic "event_selector" {
    for_each = var.event_selector
    content {
      include_management_events = lookup(event_selector.value, "include_management_events", null )
      read_write_type           = lookup(event_selector.value, "read_write_type", null )

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








