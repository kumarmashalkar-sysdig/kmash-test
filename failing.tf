resource "google_compute_firewall" "open_firewall" {
  name    = "open-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
