variable "groups" {
  type = set(string)
  default = [
    "admins",
    "users",
    "terraform"
  ]
}

variable "target_accounts" {
  type = set(string)
  default = [
    "12",
    "34",
    "56",
    "78"
  ]
}

variable "group_ids" {
  type = map(object({
    display_name = string
    description  = string
    users        = optional(set(string))
  }))
  default = {
    admins = {
      display_name = "Admins"
      description  = "Admins of the AWS account"
      users = [
        "user1",
        "user2"
      ]
    }
    users = {
      display_name = "Users"
      description  = "Users of the AWS account"
      users = [
        "user3",
        "user4"
      ]
    }
    terraform = {
      display_name = "Terraform"
      description  = "Terraform users of the AWS account"
      users = [
        "user5",
        "user6"
      ]
    }
  }
}
