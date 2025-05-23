output "load_balancer_ip" {
  value = module.load_balancer.ip
}

output "function_url" {
  value = module.cloud_function.url
}

output "current_environment" {
  value = local.environment
}

output "project_id" {
  value = local.project_id
}