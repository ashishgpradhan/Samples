output "users" {
  value       = values(aws_iam_user.users)[*].arn
  description = "List of IAM User names"
}
