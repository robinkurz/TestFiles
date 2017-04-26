provider "digitalocean" {
  token = "<REDACTED>"
}

resource "digitalocean_droplet" "node" {
  ssh_keys           = [7340841]
  count              = 4
  image              = "${var.ubuntu}"
  region             = "${var.do_fra1}"
  size               = "4GB"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "node-${count.index}"
}
