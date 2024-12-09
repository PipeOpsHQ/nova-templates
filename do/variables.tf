variable "do_token" {
  type    = string
  default = "dop_v1_189982c0462a0d892d72f4a8666446c40cc4da0735be56a243dff726a365bae5"
}

variable "create_cluster" {
  description = "Specifies whether a cluster should be created"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type        = string
  default     = "pks-lon1"
}

variable "region" {
  description = "Region where the DOKS cluster will be created"
  type        = string
  default     = "lon1"
}

variable "k8s_version" {
  description = "Kubernetes version for the DOKS cluster"
  type        = string
  default     = "1.29.9-do.4"
}

variable "node_size" {
  description = "Size of the worker nodes"
  type        = string
  default     = "s-4vcpu-16gb-amd"
}

variable "node_count" {
  description = "Number of worker nodes in the cluster"
  type        = number
  default     = 3
}

variable "bucket_name" {
  description = "Name of S3 bucket to store loki data"
  default     = "grafana-loki-pipeops"
}

variable "access_id" {
  default = "DO00DZTELXMXN47FDED8"
}

variable "secret_key" {
  default = "J3jnTXdSIGyXcxjXT/zmdX3SoxcdiepIVhZXX01FciU"
}
variable "aws_config_path" {
  description = "path to aws config"
  type        = list(string)
  default     = ["~/.aws/credentials"]
}

variable "aws_profile" {
  description = "AWS PROFILE"
  default     = "default"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-2"
}