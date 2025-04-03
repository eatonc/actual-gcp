resource "google_service_account" "container_host" {
  account_id   = "container-host-sa"
  display_name = "Custom SA for Container Host VM Instance"
}

resource "google_compute_disk" "container_host_boot_disk" {
  name  = "container-host-boot-disk"
  type  = "pd-standard"
  image = data.google_compute_image.container_optimized.self_link
  size  = 10
  labels = {
    managed_by = "terraform"
  }
  physical_block_size_bytes = 4096
}

resource "google_compute_disk" "container_host_data_disk" {
  name = "container-host-data-disk"
  type = "pd-standard"
  size = 20
  labels = {
    managed_by = "terraform"
  }
  physical_block_size_bytes = 4096
}

resource "google_compute_instance" "container_host" {
  name                      = "containerhost01"
  machine_type              = var.vm_size
  allow_stopping_for_update = true

  tags = var.container_host_network_tags

  boot_disk {
    source = google_compute_disk.container_host_boot_disk.self_link
  }

  attached_disk {
    source = google_compute_disk.container_host_data_disk.self_link
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral public IP
      network_tier = "STANDARD"
    }
  }

  metadata = {
    ssh-keys  = "${var.user}:${fileexists(var.public_key_path) ? file(var.public_key_path) : var.public_key}"
    user-data = local.cloud_config
  }

  scheduling {
    preemptible        = false
    automatic_restart  = true
    provisioning_model = "STANDARD"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.container_host.email
    scopes = ["cloud-platform"]
  }
}