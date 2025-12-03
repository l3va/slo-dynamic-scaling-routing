variable "aws_region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS region"
}

variable "aws_profile" {
  type        = string
  default     = "default" # або твій, якщо інший
  description = "AWS CLI profile"
}

variable "project_name" {
  type        = string
  default     = "slo-lab"
  description = "Prefix for all resources"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ecs_desired_count" {
  type        = number
  default     = 2
}

variable "container_port" {
  type        = number
  default     = 80
}

variable "ecs_min_capacity" {
  type        = number
  default     = 2
  description = "Minimum number of ECS tasks"
}

variable "ecs_max_capacity" {
  type        = number
  default     = 2
  description = "Maximum number of ECS tasks"
}

variable "monitoring_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for monitoring EC2"
}

variable "monitoring_disk_size" {
  type        = number
  default     = 30
  description = "Root disk size for monitoring EC2 (GiB)"
}
