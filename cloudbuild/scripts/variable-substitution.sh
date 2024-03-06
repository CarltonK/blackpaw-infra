echo "***********************"
echo "$2"
echo "***********************"

echo "***********************"
echo "Variable substitution"
echo "***********************"

# PROD
awk '{gsub(/<INFRA_PROJECT_ID>/,"'$1'")}1' /workspace/environments/main/backend.tf >/workspace/tmp.tf && mv /workspace/tmp.tf /workspace/environments/main/backend.tf
awk '{gsub(/<INFRA_PROJECT_ID>/,"'$1'")}1' /workspace/environments/main/terraform.tfvars >/workspace/tmp.tf && mv /workspace/tmp.tf /workspace/environments/main/terraform.tfvars