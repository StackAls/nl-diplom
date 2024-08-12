terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"

  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket   = "stackals-tfm-bkt"
    region   = "ru-central1"
    key      = "tfstate/project.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    # skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    # skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  }
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("../../authorized_key.json")
}
