# terraform-cloudfoundry-alertmanager

The Alertmanager will handle alerts sent by the Prometheus server. It will route the alerts to the correct receiver integration.

## Supported integrations

- Microsoft Teams notifications

## Example of Alertmanager Terraform

```
module "alertmanager" {
    source = "philips-labs/alertmanager/cloudfoundry"
    version = "0.0.1"

    cf_space_id = "test"
    teams_incoming_webhook_url = "https://teamschannel.webhook.office.com"
}
```

<!--- BEGIN_TF_DOCS --->

<!--- END_TF_DOCS --->

# Contact / Getting help

Please start a [discussion](https://github.com/philips-labs/terraform-cloudfoundry-alertmanager/discussions)

# License

License is MIT