// Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa-registry" {
  folder_id = var.folder_id
  name      = "sa-registry"
}

resource "yandex_container_registry_iam_binding" "puller" {
  registry_id = yandex_container_registry.registry.id
  role        = "container-registry.images.puller"

  members = [
    "system:allUsers",
  ]
}

resource "yandex_container_registry_iam_binding" "pusher" {
  registry_id = yandex_container_registry.registry.id
  role        = "container-registry.images.pusher"

  members = [
    "serviceAccount:sa-registry",
  ]
}

resource "yandex_iam_service_account_static_access_key" "registry-key" {
  service_account_id = yandex_iam_service_account.sa-registry.id
  description        = "static access key for registry"
}
