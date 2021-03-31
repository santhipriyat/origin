terraform {
  required_version = ">= 0.13.2"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.6.1"
    }
  }
}

# Configure the New Relic provider
provider "newrelic" {
  account_id = "3091082"
  api_key    = "NRAK-M2E6HRIJVXAA5EFDOW7FN38NR2J"
  region     = "US"
}