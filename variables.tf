variable "region" {
  default = "us-east-1"
}
variable "cidr_block" {
    type = string
    default = "172.0.0.0/16"
}

variable "subnets" {
  type = map
  default = {
      subnet-a = {
          az = "us-east-1a"
          cidr = "172.0.1.0/24"
      }
      subnet-b = {
          az = "us-east-1b"
          cidr = "172.0.2.0/24"
      }
      subnet-c = {
          az = "us-east-1c"
          cidr = "172.0.3.0/24"
      }
  }
}

variable "web_ingress" {
  type = map(object({
    description = string
    port        = number
    protocol    = string
    cidr        = list(string)
  }))

  default = {
    "80" = {
      description = "HTTP traffic"
      port        = 80
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }

    "443" = {
      description = "HTTPS traffic"
      port        = 443
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }

    "22" = {
      description = "SSH traffic"
      port        = 22
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }
  }
}