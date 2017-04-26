provider "digitalocean" {
  token = "<REDACTED>"
}

resource "digitalocean_droplet" "nomad-server-first" {
  ssh_keys           = [7340841]
  count              = 1
  image              = "${var.ubuntu}"
  region             = "${var.do_fra1}"
  size               = "4GB"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "nomad-bootstrapserver-${count.index}"

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      #twice because else it doesnt work
      "apt-get update",
      "apt-get install unzip",
      "curl -o consul.zip https://releases.hashicorp.com/consul/0.8.0/consul_0.8.0_linux_amd64.zip?_ga=1.221313115.219306615.1492263910",
      "unzip consul.zip",
      "sudo mkdir /etc/consul.d",
      "./consul agent -server -bootstrap-expect=3 -data-dir=/tmp/consul -node=agent-bootstrap -bind=${digitalocean_droplet.nomad-server-first.0.ipv4_address} -config-dir=/etc/consul.d &",
      "curl -o nomad.zip https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip?_ga=1.20052347.219306615.1492263910",
      "unzip nomad.zip",
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }
}

resource "digitalocean_droplet" "nomad-server" {
  ssh_keys           = [7340841]
  count              = 2
  image              = "${var.ubuntu}"
  region             = "${var.do_fra1}"
  size               = "4GB"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "nomad-server-${count.index}"

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      #twice because else it doesnt work
      "apt-get update",
      "apt-get install unzip",
      "curl -o consul.zip https://releases.hashicorp.com/consul/0.8.0/consul_0.8.0_linux_amd64.zip?_ga=1.221313115.219306615.1492263910",
      "unzip consul.zip",
      "sudo mkdir /etc/consul.d",
      "./consul join ${digitalocean_droplet.nomad-server-first.0.ipv4_address}",
      "./consul agent -server -bootstrap-expect=3 -data-dir=/tmp/consul -node=agent-${count.index} -bind=${self.ipv4_address} -config-dir=/etc/consul.d",
      "curl -o nomad.zip https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip?_ga=1.20052347.219306615.1492263910",
      "unzip nomad.zip",
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }
}

resource "digitalocean_droplet" "nomad-client" {
  ssh_keys           = [7340841]
  count              = 2
  image              = "${var.ubuntu}"
  region             = "${var.do_fra1}"
  size               = "4GB"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "nomad-client-${count.index}"

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      #twice because else it doesnt work
      "apt-get update",
      "apt-get install unzip",
      "curl -o consul.zip https://releases.hashicorp.com/consul/0.8.0/consul_0.8.0_linux_amd64.zip?_ga=1.221313115.219306615.1492263910",
      "unzip consul.zip",
      "sudo mkdir /etc/consul.d",
      "./consul join ${digitalocean_droplet.nomad-server-first.0.ipv4_address}",
      "./consul agent -data-dir=/tmp/consul -node=agent-${count.index} -bind=${self.ipv4_address} -config-dir=/etc/consul.d",
      "curl -o nomad.zip https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip?_ga=1.20052347.219306615.1492263910",
      "unzip nomad.zip"
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }
}
