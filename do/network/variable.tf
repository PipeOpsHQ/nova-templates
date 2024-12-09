variable "do_token" {
  type    = string

}

variable "region" {
  description = "Region where the VPC will be created"
  type        = string
  default     = "lon1"
}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
  default = "pipeops-vpc"
}