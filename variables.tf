variable "ami" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3a.micro"
}

variable "disable_api_stop" {
  type    = bool
  default = false
}

variable "disable_api_termination" {
  type    = bool
  default = false
  validation {
    condition     = var.disable_api_termination == true || var.disable_api_termination == false
    error_message = "The variable, disable_api_temrination must be either true or false."
  }
}
