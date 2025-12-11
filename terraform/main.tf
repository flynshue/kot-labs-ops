# locals {
#    image_sizes = { for image in data.digitalocean_images.ubuntu_images.images : image.slug => "${image.size_gigabytes}gb" }
# }

# data "digitalocean_images" "ubuntu_images" {
#     filter {
#       key = "distribution"
#       values = ["Ubuntu"]
#     }
#     filter {
#         key = "slug"
#         values = ["ubuntu"]
#         match_by = "substring"
#     }
# }

# output "images" {
#   value = local.image_sizes
# }

data "digitalocean_ssh_keys" "keys" {
  sort {
    key       = "name"
    direction = "asc"
  }
}

resource "digitalocean_droplet" "web-server" {
  image = var.droplet_image
  name = "${var.droplet_name_prefix}-${var.do_region}-01"
  region = var.do_region
  size = "s-1vcpu-1gb"
  tags = ["web-server"]
  ssh_keys = data.digitalocean_ssh_keys.keys.ssh_keys[*].id
}

resource "digitalocean_record" "records" {
  for_each = toset(var.app_domains)
  domain = var.do_domain
  name = each.key
  type = "A"
  value = digitalocean_droplet.web-server.ipv4_address
}