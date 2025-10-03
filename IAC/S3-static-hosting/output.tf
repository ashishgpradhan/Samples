output "aws_s3_bucket_id" {
  description = "The ID of the S3 bucket."
  value       = aws_s3_bucket_website_configuration.static_site_website.website_endpoint

}