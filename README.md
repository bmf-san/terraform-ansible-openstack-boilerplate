# terraform-ansible-openstack-boilerplate
Boilerplate for building vps using terraform and ansible.

# Features
- Terraform
- Ansible
- OpenStack

# Get started
## Generate a ssh key
Before you start, generate a key for root and a key for the execution user.

ex.
`ssh-keygen -t rsa -b 4096 -C "example@example.com"`

## Setup tfvars
Copy `example.tfvars` with any name you like, and edit it like this.

ex.
```sh
user_name="user1234"
password="password1234"
tenant_name="tenant1234"
auth_url="https://identity.tyo2.conoha.io/v2.0"
image_name="vmi-ubuntu-20.04-amd64-30gb"
flavor_name="g-1gb"
keypair_name="keypair1234"
path_to_public_key_for_root="~/.ssh/publickey.pub"
path_to_private_key_for_root="~/.ssh/privatekey"
instance_name="instance1234"
instance_name_tag="instancetag1234"
host="web"
new_user_name="admin"
new_user_password="password1234"
shell="/bin/bash"
path_to_public_key="~/.ssh/publickey.pub"
port="22"
```

If you give tfvars file a name other than `terraform.tfvars`, you need to use option when executing a command. 
`terraform COMMAND -var-file anyname.tfvars`

If you name it `terraform.tfvars`, you do not need to specify `-var-file` option.

## Init
`terraform init`

## Plan
`terraform plan`

## Apply
`terraform apply`

## Check ssh connection
`ssh username@ipaddress -i path_to_private_key`

## Destroy
`terraform destory`

# Reference
- [gist.github.com - san-tak/tf-bookmark.md](https://gist.github.com/san-tak/9ef4d15eafb4c8a42af33ffa04464739)
- [blog.mosuke.tech](https://blog.mosuke.tech/entry/2019/03/26/terraform-integrated-with-ansible/)
- [www.redhat.com - HASHICORP TERRAFORM AND RED HAT ANSIBLE AUTOMATION](https://www.redhat.com/cms/managed-files/pa-terraform-and-ansible-overview-f14774wg-201811-en.pdf)
- [note.com - AnsibleとTerraformと](https://note.com/santak/n/n22dbb35f6c01)
- [conoha.jp - ConoHa API Documentation](https://www.conoha.jp/docs/)
- [registry.terraform.io - openstack_compute_keypair_v2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_keypair_v2)
- [registry.terraform.io - openstack_compute_instance_v2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2)
- [qiita.com - TerraformでConoHaのインスタンスを立ててみる](https://qiita.com/kaminchu/items/d0776c381213d54a3a69)
- [qiita.com - TerraformからAnsibleのplaybookを実行する](https://qiita.com/hayaosato/items/ee0d6eabb7b3d0a22136)
- [blog.adachin.me - [OpenStack]TerraformでConoHa VPSのインスタンスを立ち上げてみた！](https://blog.adachin.me/archives/10378)
- [github.com - maki0922/terraform_in_conoha](https://github.com/maki0922/terraform_in_conoha)
- [github.com - hobbby-kube](https://github.com/hobby-kube/provisioning)
- [github.com - r0b2g1t/terraform-openstack-ansible](https://github.com/r0b2g1t/terraform-openstack-ansible)
- [github.com - dan4ex/Terraform](https://github.com/dan4ex/Terraform)

# License
This project is licensed under the terms of the MIT license.
