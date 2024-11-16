# Variables
variable "nested_variable" {
  type = map(object({
    key = optional(string)
    nested_object = optional(object({
      nested_key = optional(string)
    }))
  }))
  default = {
    "top_key" = {
      key = "top_object"
      nested_object = {
        nested_key = "nested_value"
      }
    }
  }
}

# Locals
locals {
  nested_object = var.nested_variable.top_key.nested_object
  nested_value = var.nested_variable.top_key.nested_object.nested_key
}