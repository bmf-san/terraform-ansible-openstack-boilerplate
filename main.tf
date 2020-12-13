terraform {
  required_version = ">= 0.14"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.33.0"
    }
  }
}

provider "openstack" {
  user_name   = (var.user_name)
  password    = (var.password)
  tenant_name = (var.tenant_name)
  auth_url = (var.auth_url)
}

resource "openstack_compute_keypair_v2" "example_keypair" {
  name       = (var.keypair_name)
  public_key = file(var.path_to_public_key_for_root)
}

resource "openstack_compute_instance_v2" "example_instance" {
  name        = (var.instance_name)
  image_name  = (var.image_name)
  flavor_name = (var.flavor_name)
  key_pair    = (var.keypair_name)

  security_groups = [
    "gncs-ipv4-ssh",
    "gncs-ipv4-web",
  ]

  metadata = {
    instance_name_tag = (var.instance_name_tag)
  }
}

data "template_file" "hosts" {
  template = file("./templates/playbooks/hosts.tpl")

  vars = {
    host = (var.host)
    ip = (openstack_compute_instance_v2.example_instance.access_ip_v4)
  }

  depends_on = [openstack_compute_instance_v2.example_instance]
}

resource "local_file" "save_hosts" {
  content  = (data.template_file.hosts.rendered)
  filename = "./playbooks/hosts"

  depends_on = [openstack_compute_instance_v2.example_instance]
}

data "template_file" "setup" {
  template = file("./templates/playbooks/setup.tpl")

  vars = {
    host = (var.host)
    new_user_name = (var.new_user_name)
    new_user_password = (var.new_user_password)
    shell = (var.shell)
    new_user_public_key = file(var.path_to_public_key)
    port = (var.port)
  }

  depends_on = [openstack_compute_instance_v2.example_instance]
}

resource "local_file" "save_setup" {
  content  = (data.template_file.setup.rendered)
  filename = "./playbooks/setup.yml"

  depends_on = [openstack_compute_instance_v2.example_instance]
}

resource "null_resource" "example_provisoner" {
  provisioner "local-exec" {
    command = "ansible-playbook ./playbooks/setup.yml -i ./playbooks/hosts --private-key=${var.path_to_private_key_for_root}"
  }

  depends_on = [openstack_compute_instance_v2.example_instance]
}