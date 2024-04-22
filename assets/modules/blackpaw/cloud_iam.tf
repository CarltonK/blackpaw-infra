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

resource "google_project_iam_member" "ops_compute_admin_role" {
  count   = length(var.ops_users)
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "user:${element(var.ops_users, count.index)}"
}
