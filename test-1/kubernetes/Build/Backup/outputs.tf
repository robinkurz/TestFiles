output "Public ips" {
  value = "${join(",",digitalocean_droplet.node.*.ipv4_address)}"
}

output "Names" {
  value = "${join(",",digitalocean_droplet.node.*.name)}"
}
