# 1. Serverless NEG que apunta a una Cloud Function
resource "google_compute_region_network_endpoint_group" "hello_neg" {
  name                  = "hello-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_function {
    function = var.function_name
  }
  project = var.project_id
}

# 2. Backend Service que usa el NEG
resource "google_compute_backend_service" "hello_backend" {
  name                            = "hello-backend"
  protocol                        = "HTTP"
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  backend {
    group = google_compute_region_network_endpoint_group.hello_neg.id
  }
  #health_checks = [google_compute_health_check.hello_http_health_check.id]
  security_policy = google_compute_security_policy.hello_cloud_armor_policy.id
  enable_cdn = false
  port_name  = "http"
  project    = var.project_id
}

# 3. URL Map para enrutar tráfico
resource "google_compute_url_map" "hello_load_balancer" {
  name            = "hello-load-balancer"
  default_service = google_compute_backend_service.hello_backend.self_link
  project         = var.project_id
}

# 4. HTTP Proxy
resource "google_compute_target_http_proxy" "hello_http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.hello_load_balancer.self_link
  project = var.project_id
}

# 4. Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "hello_fw_rule" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.hello_http_proxy.self_link
  port_range = "80"
  project    = var.project_id
  ip_protocol = "TCP"
}

#resource "google_compute_health_check" "hello_http_health_check" {
#  name               = "hello-ttp-health-check"
#  check_interval_sec = 5
#  timeout_sec        = 5
#  healthy_threshold  = 2
#  unhealthy_threshold = 2
#
#  http_health_check {
#    port = 80
#    request_path = "/"
#  }
#
#  project = var.project_id
#}

#Cloud Armor: security
resource "google_compute_security_policy" "hello_cloud_armor_policy" {
  name = "hello-cloud-armor-owasp"

  rule {
    action = "deny(403)"
    priority = 1000
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["1.2.3.4/32"] # ejemplo, puedes bloquear IPs maliciosas o regiones
      }
    }
    description = "Bloquea IPs maliciosas conocidas"
  }

  rule {
    action   = "deny(403)"
    priority = 1001
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-stable')"
      }
    }
    description = "Bloqueo de XSS (OWASP)"
  }

  rule {
    action   = "deny(403)"
    priority = 1002
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
      }
    }
    description = "Bloqueo de SQL Injection"
  }

  rule {
    priority    = 2147483647
    description = "Default allow rule"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    action = "allow"
  }
}

