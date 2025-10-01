variable "region" {
  description = "The AWS region to deploy the S3 bucket in."
  type        = string
  default     = "us-east-1"

}

variable "access_key" {
  description = "The AWS access key."
  type        = string
    default = "AKIA2RQ6ZHLELGUOIPE2"
}

variable "secret_key" {
  description = "The AWS secret key."
  type        = string
  default = "9WqGblqC2ukpvfBX9Ede4tRan40kPLcmgkNOWIBC"
}
