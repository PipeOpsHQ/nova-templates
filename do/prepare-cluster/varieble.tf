variable "do_token" {
  type    = string

}

variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type        = string
  default     = "pipeops-altschool"
}

variable "service_account_ns" {
  type = string
  description = "Namespace to create pipeops admin service account"
  default = "pipeops"
}

variable "aws_access_key_s3" {
  description = "Access Key to AWS acc where the s3 bucket is created"

}

variable "aws_secret_key_s3" {
  description = "Secret Key to AWS acc where the s3 bucket is created"

}

variable "aws_region_S3" {
  description = "Region where s3 bucket is created"
  default = "eu-west-2"

}

variable "dns_zone" {
  type        = string
  default     = "pipeops.co"
  
}