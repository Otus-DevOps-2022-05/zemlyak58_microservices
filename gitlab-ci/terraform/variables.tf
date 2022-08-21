variable "cloud_id" {
  description = "yc config list"
}

variable "folder_id" {
  description = "yc config list"
}

variable "zone" {
  description = "zone"
  default     = "ru-central1-a"
}

# variable "subnet_id" {
#   description = "yc vpc subnet list"
# }
# 
variable "service_account_key_file" {
  description = ".key.json"
}

variable "public_key_path" {
  description = "generate key ssh key"
  default     = "~/.ssh/appuser.pub"
}

variable "private_key_path" {
  description = "generate key ssh key"
  default     = "~/.ssh/appuser"
}

variable "gitlab_image" {
  description = "yc compute image list"
}

/* variable "app_disk_image" { */
/*   description = "yc compute image list" */
/* #   default     = "reddit-base-app" */
/* } */

