variable "region" {
  description = "The AWS region where the S3 bucket will be created."
  type        = string
  default     = "us-east-1"

}

variable "access_key" {
  description = "The AWS access key for authentication."
  type        = string
}

variable "secret_key" {
  description = "The AWS secret key for authentication."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type = map(object({
    dev  = string
    prod = string
  }))
}