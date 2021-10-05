module "alertmanager" {
  source = "../../"

  cf_space_id                = "test"
  teams_incoming_webhook_url = "https://teamschannel.webhook.office.com"
  alertsource_app_id         = "prometheusappid"
}
