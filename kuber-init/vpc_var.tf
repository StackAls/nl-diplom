variable "vpc_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}

variable "vpc_sub_public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24", "192.168.20.0/24", "192.168.40.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# variable "vpc_private" {
#   type    = string
#   default = "private"
# }

