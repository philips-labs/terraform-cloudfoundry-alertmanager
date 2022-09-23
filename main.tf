locals {
  alertmanager_routes       = [cloudfoundry_route.alertmanager_internal.id]
  webhook_url               = var.teams_incoming_webhook_url != "" ? "http://${cloudfoundry_route.prometheusmsteams_internal[0].endpoint}:2000/alertmanager" : "http://localhost:5001"
  alertmanager_config       = var.alertmanager.config_file == "" ? templatefile("${path.module}/templates/alertmanager.yml", { url = local.webhook_url }) : var.alertmanager.config_file
  alertmanager_default_port = "9093"
}

resource "cloudfoundry_app" "prometheusmsteams" {
  count        = var.teams_incoming_webhook_url != "" ? 1 : 0
  name         = "tf-prometheusmsteams-${local.postfix}"
  space        = var.cf_space_id
  docker_image = var.prometheusmsteams_docker_image
  memory       = 64
  disk_quota   = 1024
  environment = {
    TEAMS_REQUEST_URI          = "alertmanager"
    TEAMS_INCOMING_WEBHOOK_URL = var.teams_incoming_webhook_url
  }

  routes {
    route = cloudfoundry_route.prometheusmsteams_internal[count.index].id
  }

  dynamic "service_binding" {
    for_each = var.prometheusmsteams_service_bindings

    content {
      service_instance = service_binding.value.service_instance
    }
  }
}

resource "cloudfoundry_route" "prometheusmsteams_internal" {
  count    = var.teams_incoming_webhook_url != "" ? 1 : 0
  domain   = data.cloudfoundry_domain.apps_internal_domain.id
  space    = var.cf_space_id
  hostname = "tf-prometheusmsteams-${local.postfix}"
}

resource "cloudfoundry_app" "alertmanager" {
  name         = "tf-alertmanager-${local.postfix}"
  space        = var.cf_space_id
  memory       = var.alertmanager.memory
  disk_quota   = 2048
  docker_image = var.alertmanager.docker_image
  docker_credentials = {
    username = var.alertmanager.docker_username
    password = var.alertmanager.docker_password
  }
  environment = merge({
    ALERTMANAGER_CONFIG_BASE64 = base64encode(local.alertmanager_config)
  }, var.environment)
  command = "echo $ALERTMANAGER_CONFIG_BASE64 | base64 -d > /etc/alertmanager/alertmanager.yml && /bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml --storage.path=/alertmanager --web.route-prefix=/alertmanager"

  dynamic "routes" {
    for_each = local.alertmanager_routes
    content {
      route = routes.value
    }
  }

  dynamic "service_binding" {
    for_each = var.alertmanager_service_bindings

    content {
      service_instance = service_binding.value.service_instance
    }
  }
}

resource "cloudfoundry_route" "alertmanager_internal" {
  domain   = data.cloudfoundry_domain.apps_internal_domain.id
  space    = var.cf_space_id
  hostname = "tf-alertmanager-${local.postfix}"
}

resource "cloudfoundry_network_policy" "prometheusmsteams" {
  count = var.teams_incoming_webhook_url != "" ? 1 : 0

  policy {
    source_app      = cloudfoundry_app.alertmanager.id
    destination_app = cloudfoundry_app.prometheusmsteams[count.index].id
    protocol        = "tcp"
    port            = "2000"
  }
}

resource "cloudfoundry_network_policy" "alertmanager" {
  policy {
    source_app      = var.alerts_source_app_id
    destination_app = cloudfoundry_app.alertmanager.id
    protocol        = "tcp"
    port            = local.alertmanager_default_port
  }
}
