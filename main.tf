module "cloud_function" {
  source     = "./modules/cloud_function"
  project_id = local.project_id
  region     = local.region
}

module "load_balancer" {
  source     = "./modules/load_balancer"
  project_id = local.project_id
  region     = local.region
  function_name = module.cloud_function.name
}

module "security" {
  source     = "./modules/security"
  project_id = local.project_id
  region     = local.region
  function_name = module.cloud_function.name
}