variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
}


variable "secret_key" {
  description = "The secret key for accessing AWS resources."
  type        = string
}

variable "access_key" {
  description = "The access key for accessing AWS resources."
  type        = string
}


variable "users" {
  type        = list(string)
  default = [ "user1","user2","user3" ]
}