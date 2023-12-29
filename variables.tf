variable "instance_type" {
  type        = string
  description = "Type of instance"
}
variable "instance_ami" {
  type        = string
  description = "AMI of instance"
}
variable "project_name" {
  type        = string
  description = "Project name"
}
variable "project_env" {
  type        = string
  description = "Environment of the project"
}
variable "project_owner" {
  type        = string
  description = "Owner of the project"
}
variable "hostname_domain_name" {
  type        = string
  description = "Root domain name"
}
variable "hostname" {
  type        = string
  description = "Hostname"
}
