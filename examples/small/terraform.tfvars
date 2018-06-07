# Specify existing VPC ID to use it:
# vpc_id = "vpc-9651acf1"

# Or, create a new VPC:
name = "my-vpc"

cidr = "10.10.0.0/16"

azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

public_subnets = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
