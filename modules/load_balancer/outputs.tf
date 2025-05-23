output "ip" {
  description = "Public IP address of the load balancer"
  value = google_compute_global_forwarding_rule.hello_fw_rule.ip_address
}