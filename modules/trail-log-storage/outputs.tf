output "trail_log_bucket" {
  description = "The name of the log bucket."
  value       = aws_s3_bucket.matter_trail_logs_bucket.id
}