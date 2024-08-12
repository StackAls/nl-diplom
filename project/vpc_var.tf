variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_sub_public_a" {
  type        = string
  default     = "public-a"
  description = "VPC network & subnet name"
}

variable "vpc_sub_public_b" {
  type        = string
  default     = "public-b"
  description = "VPC network & subnet name"
}

variable "vpc_sub_public_d" {
  type        = string
  default     = "public-d"
  description = "VPC network & subnet name"
}

variable "my_ip_address" {
  type    = string
  default = "178.154.205.25"
}

variable "vpc_sub_public_a_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_sub_public_b_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_sub_public_d_cidr" {
  type        = list(string)
  default     = ["192.168.40.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# variable "vpc_private" {
#   type    = string
#   default = "private"
# }

