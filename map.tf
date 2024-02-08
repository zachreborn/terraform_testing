locals {
  flatten_ids = flatten([
    for group in var.groups : [
      for account in var.target_accounts : {
        group_id   = group,
        account_id = account
      }
    ]
  ])

  map_ids = { for item in local.flatten_ids : "${item.group_id}_${item.account_id}" => item }

  oneshot = {
    for item in flatten([
      for group in var.groups : [
        for account in var.target_accounts : {
          group_id   = group,
          account_id = account
        }
      ]
    ]) : "${item.group_id}_${item.account_id}" => item
  }
}
