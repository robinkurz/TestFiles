provider "digitalocean" {
  token = "<REDACTED>"
}

resource "digitalocean_droplet" "node" {
  ssh_keys           = [7340841]
  count              = 5
  image              = "${var.ubuntu}"
  region             = "${var.do_fra1}"
  size               = "4GB"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "node-${count.index}"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get --assume-yes install docker.io"
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }
}
