provider "google" {
  project = var.project_id
  region  = var.region
}

# SSL Policy
resource "google_compute_ssl_policy" "test_ssl_policy" {
  name            = "test-ssl-policy"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

# Global IP Address
resource "google_compute_global_address" "test_global_ip" {
  name = "test-global-ip"
}

# Cloud Armor Security Policy
resource "google_compute_security_policy" "test_security_policy" {
  name = "test-security-policy"

  rule {
    priority = 1000
    action   = "deny(403)"

    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["0.0.0.0/0"]
      }
    }

    description = "Deny all traffic"
  }

  rule {
    priority = 2147483647
    action   = "allow"

    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }

    description = "Default allow rule"
  }
}
