locals {
  environment = terraform.workspace
  project_map = {
    dev  = "latamxp-sandbox"
    tst  = "latamxp-st"
    prd  = "latamxp-rr"
  }
  project_id = local.project_map[local.environment]
  region     = var.region
}