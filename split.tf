locals {
  unsplit = "349874e8-b0c1-70eb-e7ec-dd5dee06a408,GROUP,190150138842,AWS_ACCOUNT,arn:aws:sso:::permissionSet/ssoins-722371718bf465d6/ps-2ea393a047118400,arn:aws:sso:::instance/ssoins-722371718bf465d6"

  split = split(",", local.unsplit)
  map = {
    principal_id       = local.split[0]
    principal_type     = local.split[1]
    target_id          = local.split[2]
    target_type        = local.split[3]
    permission_set_arn = local.split[4]
    instance_arn       = local.split[5]
  }
}