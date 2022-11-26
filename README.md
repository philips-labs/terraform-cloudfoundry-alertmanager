# terraform-cloudfoundry-alertmanager

The Alertmanager will handle alerts sent by the Prometheus server. It will route the alerts to the correct receiver integration.

## Supported receiver integrations

- Microsoft Teams notifications

## Example of Alertmanager Terraform

```
module "alertmanager" {
    source = "philips-labs/alertmanager/cloudfoundry"
    version = "0.0.1"

    cf_space_id = "test"
    teams_incoming_webhook_url = "https://teamschannel.webhook.office.com"
    alerts_source_app_id = "prometheusappid"
}
```

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >= 0.15.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | >= 0.15.5 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.alertmanager](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_app.prometheusmsteams](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_network_policy.alertmanager](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) | resource |
| [cloudfoundry_network_policy.prometheusmsteams](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) | resource |
| [cloudfoundry_route.alertmanager_internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [cloudfoundry_route.prometheusmsteams_internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [random_id.id](https://registry.terraform.io/providers/random/latest/docs/resources/id) | resource |
| [cloudfoundry_domain.apps_internal_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alertmanager"></a> [alertmanager](#input\_alertmanager) | n/a | <pre>object({<br>    docker_image    = optional(string, "prom/alertmanager:v0.23.0")<br>    memory          = optional(number, 128)<br>    config_file     = optional(string, "")<br>    docker_username = optional(string)<br>    docker_password = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_alertmanager_service_bindings"></a> [alertmanager\_service\_bindings](#input\_alertmanager\_service\_bindings) | A list of service instances that should be bound to the alertmanager | `list(object({ service_instance = string }))` | `[]` | no |
| <a name="input_alerts_source_app_id"></a> [alerts\_source\_app\_id](#input\_alerts\_source\_app\_id) | Cloudfoundry app id that will send the alerts. E.g Thanos, Prometheus.. | `string` | n/a | yes |
| <a name="input_cf_space_id"></a> [cf\_space\_id](#input\_cf\_space\_id) | Cloudfoundry SPACE id to use for deploying the alertmanager components. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Pass environment variable to the app | `map(any)` | `{}` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the app names, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| <a name="input_prometheusmsteams_docker_image"></a> [prometheusmsteams\_docker\_image](#input\_prometheusmsteams\_docker\_image) | The docker image to use for the Prometheus MS Teams app | `string` | `"quay.io/prometheusmsteams/prometheus-msteams:latest"` | no |
| <a name="input_prometheusmsteams_service_bindings"></a> [prometheusmsteams\_service\_bindings](#input\_prometheusmsteams\_service\_bindings) | A list of service instances that should be bound to the prometheusmsteams | `list(object({ service_instance = string }))` | `[]` | no |
| <a name="input_teams_incoming_webhook_url"></a> [teams\_incoming\_webhook\_url](#input\_teams\_incoming\_webhook\_url) | Teams incoming webhook URL | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alertmanager_app_id"></a> [alertmanager\_app\_id](#output\_alertmanager\_app\_id) | App id of Alertmanager |
| <a name="output_alertmanager_internal_endpoint"></a> [alertmanager\_internal\_endpoint](#output\_alertmanager\_internal\_endpoint) | Internal route of alertmanager |

<!--- END_TF_DOCS --->

# Contact / Getting help

Please start a [discussion](https://github.com/philips-labs/terraform-cloudfoundry-alertmanager/discussions)

# License

License is MIT
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >= 0.15.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | >= 0.15.5 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.alertmanager](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_app.prometheusmsteams](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_network_policy.alertmanager](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) | resource |
| [cloudfoundry_network_policy.prometheusmsteams](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) | resource |
| [cloudfoundry_route.alertmanager_internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [cloudfoundry_route.prometheusmsteams_internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [random_id.id](https://registry.terraform.io/providers/random/latest/docs/resources/id) | resource |
| [cloudfoundry_domain.apps_internal_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alertmanager"></a> [alertmanager](#input\_alertmanager) | n/a | <pre>object({<br>    docker_image    = optional(string, "prom/alertmanager:v0.23.0")<br>    memory          = optional(number, 128)<br>    config_file     = optional(string, "")<br>    docker_username = optional(string)<br>    docker_password = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_alertmanager_service_bindings"></a> [alertmanager\_service\_bindings](#input\_alertmanager\_service\_bindings) | A list of service instances that should be bound to the alertmanager | `list(object({ service_instance = string }))` | `[]` | no |
| <a name="input_alerts_source_app_id"></a> [alerts\_source\_app\_id](#input\_alerts\_source\_app\_id) | Cloudfoundry app id that will send the alerts. E.g Thanos, Prometheus.. | `string` | n/a | yes |
| <a name="input_cf_space_id"></a> [cf\_space\_id](#input\_cf\_space\_id) | Cloudfoundry SPACE id to use for deploying the alertmanager components. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Pass environment variable to the app | `map(any)` | `{}` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the app names, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| <a name="input_prometheusmsteams_docker_image"></a> [prometheusmsteams\_docker\_image](#input\_prometheusmsteams\_docker\_image) | The docker image to use for the Prometheus MS Teams app | `string` | `"quay.io/prometheusmsteams/prometheus-msteams:latest"` | no |
| <a name="input_prometheusmsteams_service_bindings"></a> [prometheusmsteams\_service\_bindings](#input\_prometheusmsteams\_service\_bindings) | A list of service instances that should be bound to the prometheusmsteams | `list(object({ service_instance = string }))` | `[]` | no |
| <a name="input_teams_incoming_webhook_url"></a> [teams\_incoming\_webhook\_url](#input\_teams\_incoming\_webhook\_url) | Teams incoming webhook URL | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alertmanager_app_id"></a> [alertmanager\_app\_id](#output\_alertmanager\_app\_id) | App id of Alertmanager |
| <a name="output_alertmanager_internal_endpoint"></a> [alertmanager\_internal\_endpoint](#output\_alertmanager\_internal\_endpoint) | Internal route of alertmanager |
<!-- END_TF_DOCS -->