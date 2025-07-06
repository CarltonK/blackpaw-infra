# ####################
# # IAM MEMBER ROLES #
# ####################
# resource "google_project_iam_custom_role" "operator_role" {
#   project     = var.project_id
#   role_id     = "OperatorRole"
#   title       = "Operator Custom Role"
#   description = "Created by TF"
#   permissions = concat(var.operator_custom_role_permissions)
# }

# resource "google_project_iam_member" "developer_member" {
#   count   = length(var.ops_users)
#   project = var.project_id
#   role    = element(google_project_iam_custom_role.operator_role, count.index).name
#   member  = "user:${element(var.ops_users, count.index)}"

#   depends_on = [
#     google_project_iam_custom_role.operator_role
#   ]
# }

locals {
  user_role_pairs = flatten([
    for user in var.ops_users : [
      for role in var.ops_roles : {
        user = user
        role = role
      }
    ]
  ])
}

resource "google_project_iam_member" "ops_user_roles" {
  for_each = {
    for pair in local.user_role_pairs :
    "${pair.user}-${pair.role}" => pair
  }

  project = var.project_id
  role    = each.value.role
  member  = "user:${each.value.user}"
}

# Build SA
data "google_service_account" "build_service_account" {
  account_id = "terraform-agent"
  project    = var.project_id
}

# Cloud Functions SA
resource "google_service_account" "cloud_functions_sa" {
  project      = var.project_id
  account_id   = "cloud-functions-deployer"
  display_name = "Cloud Functions Deployer SA"
}

resource "google_project_iam_member" "cloud_functions_sa_binding" {
  project = var.project_id
  count   = length(var.cloud_functions_sa_roles)
  role    = var.cloud_functions_sa_roles[count.index]
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}
