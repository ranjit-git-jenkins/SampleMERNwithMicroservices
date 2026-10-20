variable "subscription_id" { type = string }
variable "location" { type = string; default = "centralindia" }
variable "prefix" { type = string; default = "mernaksdemo" }
variable "ssh_public_key" { type = string; description = "OpenSSH public key for Linux AKS nodes" }
