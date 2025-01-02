terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    #    version = "2.25.0"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = var.token_linode
  }

# Create a Linode
resource "linode_instance" "linodePC" {
 label           = "simple_instance"
  image           = "linode/ubuntu24.04"
  region          = "it-mil"
  type            = "g6-nanode-1"
  authorized_keys = [var.ssh-pass]
  root_pass       = var.root_pass


#  tags       = ["foo"]
#   swap_size  = 256
#   private_ip = true
}
resource "local_file" "Linode_ip" {
  filename = "linode_ip.txt"
  content = linode_instance.linodePC.ip_address
  depends_on = [ linode_volume.additional_volume ]
  
}
resource "linode_volume" "additional_volume" {
  label = "additional_volume"
  size= 10
  region = linode_instance.linodePC.region
  linode_id = linode_instance.linodePC.id
}

resource "local_file" "Linode_ip_var" {
  filename = "generated_variables.tf"  # A separate file for generated variables
  content  = <<-EOT
  variable "instance_ip" {
    description = "Dynamically generated instance IP"
    default     = "${linode_instance.linodePC.ip_address}"
  }
  EOT

  depends_on = [linode_volume.additional_volume]
}


output "instance_ip" {
  value=linode_instance.linodePC.ip_address
}

output "volume_id" {
  value = linode_volume.additional_volume.id
}