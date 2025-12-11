variable "do_domain" {
  type = string
  default = "kot-labs.com"
}

variable "do_region" {
  type = string
  default = "nyc3"
}

variable app_domains {
  type = list(string)
  default = [
    "plate-stack",
    "cod",
    "snappass",
    "kot-labs-web"
  ]
}

variable "droplet_image" {
  type = string
  default = "ubuntu-24-04-x64"
}

variable "droplet_name_prefix" {
  type = string
  default = "kot-labs-web"
}