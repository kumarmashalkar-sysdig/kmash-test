terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "asia-south1"
}

# ---------------------------------------------------------------------------
# INSECURE EXAMPLE – SHOULD BE FLAGGED BY IaC SCAN
# ---------------------------------------------------------------------------

resource "google_compute_ssl_policy" "insecure_policy" {
  name            = "lb-ssl-policy-insecure"
  min_tls_version = "TLS_1_0"
  profile         = "COMPATIBLE"

  custom_features = [
    "TLS_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_RSA_WITH_AES_128_CBC_SHA",
    "TLS_RSA_WITH_AES_256_CBC_SHA",
    "TLS_RSA_WITH_3DES_EDE_CBC_SHA",
  ]
}

# ---------------------------------------------------------------------------
# SECURE EXAMPLE – SHOULD PASS IaC SCAN
# ---------------------------------------------------------------------------

resource "google_compute_ssl_policy" "secure_policy" {
  name            = "lb-ssl-policy-secure"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN" # or "RESTRICTED"
}
