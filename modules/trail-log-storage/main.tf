data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "matter_trail_logs_bucket" {
  bucket_prefix = "matter-${var.env}-trail-logs-"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "matter_trail_logs_bucket_acl" {
  bucket = aws_s3_bucket.matter_trail_logs_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_sse" {
  bucket = aws_s3_bucket.matter_trail_logs_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "trail_logs_bucket_policy" {
  bucket = aws_s3_bucket.matter_trail_logs_bucket.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.matter_trail_logs_bucket.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.matter_trail_logs_bucket.arn}/${var.prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
   
    ]
}
POLICY
}