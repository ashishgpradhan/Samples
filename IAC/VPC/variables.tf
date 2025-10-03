variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "secret_key" {
  description = "The AWS secret key."
  type        = string

}

variable "access_key" {
  description = "The AWS access key."
  type        = string

}