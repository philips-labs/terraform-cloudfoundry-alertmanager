data "cloudfoundry_space" "my_space" {
  name = "myspace"
  org  = data.cloudfoundry_org.my_org.id
}

data "cloudfoundry_org" "my_org" {
  name = "myorg"
}

module "alertmanager" {
  source = "../../"

  cf_space_id                = data.cloudfoundry_space.my_space.id
  teams_incoming_webhook_url = "https://teamschannel.webhook.office.com/1234"
  alerts_source_app_id       = "prometheusappid"
}
