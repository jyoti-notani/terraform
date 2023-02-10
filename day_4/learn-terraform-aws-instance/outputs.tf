output "instance_ids" {
  description = "IDs of EC2 instances"
  value       = aws_instance.app_server.*.id
}

output "s3_bucket_id" {
  description = "The id of the bucket."
  value       = data.aws_s3_bucket.selected.id
}

output "s3_bucket_arn" {
  description = "The name of the bucket."
  value       = data.aws_s3_bucket.selected.arn
}

output "s3_bucket_name" {
  description = "The name of the bucket."
  value       = data.aws_s3_bucket.selected.bucket
}