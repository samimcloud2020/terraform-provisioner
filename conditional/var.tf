/* A list variable holds a list of values */

variable ins_type {
  description = " instance type aws"
  type = list(string)
  default = [ "t2.nano", "t2.micro", "t3.medium"]
}

/*A map value is a lookup table from string keys to string values.
 This is useful for selecting a value based on some other provided value.*/

variable instance_type {
    type = map(string)
    default = {
    "us-east-1a" = "t2.micro"
    "us-east-1b" = "t3.micro"
    "us-east-1c" = "t3.medium"
  }
}

variable az {
    type = map(string)
    default = {
    "az1" = "us-east-1a"
    "az2" = "us-east-1b"
    "az3" = "us-east-1c"
  }
}

variable region {
  type =string
  default = "us-east-1"
}

variable "plans" {
    type = map(string)
    default = {
        "5USD"  = "1xCPU-1GB"
        "10USD" = "1xCPU-2GB"
        "20USD" = "2xCPU-4GB"
    }
}

variable "storage_sizes" {
    type = map(string)
    default = {
        "1xCPU-1GB"  = "25"
        "1xCPU-2GB"  = "50"
        "2xCPU-4GB"  = "80"
    }
}

