output "alertmanager_app_id" {
  description = "App id of Alertmanager"
  value       = cloudfoundry_app.alertmanager.id
}

output "alertmanager_internal_endpoint" {
  description = "Internal route of alertmanager"
  value       = "${cloudfoundry_route.alertmanager_internal.endpoint}:${local.alertmanager_default_port}"
}
