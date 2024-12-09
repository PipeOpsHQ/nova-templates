variable "do_token" {
  type    = string

}

variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type        = string
  default     = "pks-lon1"
}
variable "bucket_name" {
  description = "Name of S3 bucket to store loki data"
  default     = "grafana-loki-pipeops"
}

variable "aws_config_path" {
  description = "path to aws config"
  type        = list(string)

}

variable "aws_profile" {
  description = "AWS PROFILE"

}

variable "aws_region" {
  description = "AWS region to launch servers."

}