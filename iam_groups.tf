locals {
  group_policies = {
    for item in flatten([
      for group, value in var.iam_groups : [
        for policy in value.policy_arns : {
          group = group
          policy_arn = policy
        }
      ]
    ]) : "${item.group}_${item.policy_arn}" => item
  }

  group_policy_attachments = flatten([
    for group, value in var.iam_groups : [
      for policy in value.policy_arns : {
        name       = "${group}_${policy}"
        group      = group
        policy_arn = policy
      }
    ]
  ])
}

variable "iam_groups" {
  type        = map(object({
    policy_arns = set(string)
  }))
  description = "(Required) - A map of groups to create. The key is the name of the group, and the value is a map of the group configuration."
  default = {
    group1 = {
      policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
    },
    group2 = {
      policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
    }
  }
  # Example:
  # groups = {
  #   group1 = {
  #     policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
  #   },
  #   group2 = {
  #     policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  #   }
  # }
}