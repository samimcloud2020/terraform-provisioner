/* A list variable holds a list of values */

variable instance_type1 {
    type = list
    default = [ "t2.micro", "t3.micro" ]
}

/*A map value is a lookup table from string keys to string values.
 This is useful for selecting a value based on some other provided value.*/

variable instance_type2 {
    type = map(string)
    default = {
    "us-east-1" = "t2.micro"
    "us-west-2" = "t3.micro"
  }
}

variable az {
    type = map(string)
    default = {
    "us-east-1" = "us-east-1a"
    "us-west-2" = "us-west-2a"
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

