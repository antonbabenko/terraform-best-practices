variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = "list"
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = "list"
  default     = []
}
