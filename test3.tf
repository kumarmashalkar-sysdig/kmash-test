resource "google_compute_ssl_policy" "kmash_tls" {
  name            = "kmash-tls"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "google_compute_global_address" "kmash_ingress" {
  name         = "kmash-ingress"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_security_policy" "block_policy" {
  name        = "block-policy"
  description = "Test Cloud Armor policy to block all traffic"

  rule {
    priority    = 1000
    description = "Default deny-all"

    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }

    action = "deny(403)"
    preview = false
  }
}
