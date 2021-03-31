data "newrelic_entity" "foo" {
  name = "santhi"
  domain = "APM"
  type = "APPLICATION"
}

# Create an alert policy
resource "newrelic_alert_policy" "alert" {
  name = "alert policy name"
}

# Add a condition
resource "newrelic_nrql_alert_condition" "foo" {
  policy_id                    = newrelic_alert_policy.alert.id
  type                         = "static"
  name                         = "foo"
  description                  = "Alert when transactions are taking too long"
  runbook_url                  = "https://mail.google.com/mail/u/0/#inbox"
  enabled                      = true
  value_function               = "single_value"
  violation_time_limit_seconds = 3600

  nrql {
    query             = "SELECT average(duration) FROM Transaction where appName = '${data.newrelic_entity.foo.name}'"
    evaluation_offset = 3
  }

  critical {
    operator              = "above"
    threshold             = 5.5
    threshold_duration    = 300
    threshold_occurrences = "ALL"
  }
}

# Add a notification channel
resource "newrelic_alert_channel" "email" {
  name = "email"
  type = "email"

  config {
    recipients              = "santipriyat@gmail.com"
    include_json_attachment = "1"
  }
}

# Link the channel to the policy
resource "newrelic_alert_policy_channel" "alert_email" {
  policy_id  = newrelic_alert_policy.alert.id
  channel_ids = [
    newrelic_alert_channel.email.id
  ]
}