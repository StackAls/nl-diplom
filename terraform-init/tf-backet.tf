resource "yandex_storage_bucket" "stackals-tfm-bkt" {
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket                = var.s3_name
  max_size              = var.s3_size
  default_storage_class = var.s3_class
}