variable "user_name" {
    type = string
    default = "user1234"
    description = "API user name"
}

variable "password" {
    type = string
    default = "password1234"
    description = "API user password"
}

variable "tenant_name" {
    type = string
    default = "tenant1234"
    description = "tenant name"
}

variable "auth_url" {
    type = string
    default = "https://identity.tyo2.conoha.io/v2.0"
    description = "endpoint of api for authentication"
}

variable "image_name" {
    type = string
    default = "vmi-ubuntu-20.04-amd64-30gb"
    description = "image name to create"
}

variable "flavor_name" {
    type = string
    default = "g-1gb"
    description = "flavor name to create"
}

variable "keypair_name" {
    type = string
    default = "keypair1234"
    description = "keypair name to create"
}

variable "path_to_public_key_for_root" {
    type = string
    default = "~/.ssh/publickey.pub"
    description = "path to public key for root to create"
}

variable "path_to_private_key_for_root" {
    type = string
    default = "~/.ssh/privatekey"
    description = "path to private key for root to create"
}

variable "instance_name" {
    type = string
    default = "instance1234"
    description = "instance name to create"
}

variable "instance_name_tag" {
    type = string
    default = "instancetag1234"
    description = "instance name tag to create"
}

variable "host" {
    type = string
    default = "web"
    description = "host name to create"
}

variable "new_user_name" {
    type = string
    default = "admin"
    description = "new user name to create"
}

variable "new_user_password" {
    type = string
    default = "passsword1234"
    description = "new user password to create"
}

variable "shell" {
    type = string
    default = "/bin/bash"
    description = "login shell for new user to create"
}

variable "path_to_public_key" {
    type = string
    default = "~/.ssh/publickey.pub"
    description = "path to public key for new user to create"
}

variable "port" {
    type = number
    default="22"
    description = "port number to create"
}