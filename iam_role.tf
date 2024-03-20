locals {
  policy_map = { for idx, policy_arn in var.policy_arns : "policy-${idx}" => {
    name       = "policy-${idx}"
    index      = idx
    policy_arn = policy_arn
  } }
}


variable "policy_arns" {
  type        = list(string)
  description = "(Required) - A set of ARNs of the policies which you want attached to the role."
  default     = ["arn:aws:iam::aws:policy/AmazonAppStreamReadOnlyAccess", "module.iam_policy_test.arn"]
}
