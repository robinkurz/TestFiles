
variable "digitalocean_token" {
  description = "Your DigitalOcean API key"
}

variable "ssh_key_fingerprint" {
  description = "Your SSH Public Key"
}

variable "region" {
  description = "DigitalOcean Region"
  default = "NYC2"
}

variable "agent_size" {
  description = "DCOS Agent Droplet Size"
  default = "4GB"
}

variable "master_size" {
  description = "DCOS Master Droplet Size"
  default = "4GB"
}

variable "boot_size" {
  description = "DCOS Boot Server Droplet Size"
  default = "4GB"
}

variable "dcos_cluster_name" {
  description = "Name of your cluster. Alpha-numeric and hyphens only, please."
  default = "digitalocean-dcos"
}

variable "dcos_master_count" {
  default = "3"
  description = "Number of master nodes. 1, 3, or 5."
}

variable "dcos_agent_count" {
  description = "Number of agents to deploy"
  default = "4"
}

variable "dcos_public_agent_count" {
  description = "Number of public agents to deploy"
  default = "1"
}

variable "dcos_ssh_public_key_path" {
  description = "Path to your public SSH key path"
  default = "./do-key.pub"
}

variable "dcos_installer_url" {
  description = "Path to get DCOS"
  default = "https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh"
}

variable "dcos_ssh_key_path" {
  description = "Path to your private SSH key for the project"
  default = "./do-key"
}
