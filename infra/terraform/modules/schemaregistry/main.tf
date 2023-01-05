###########################
#	    PROVIDERS         #
###########################

terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.23.0"
    }
  }
}

###########################
#	    RESOURCES         #
###########################
data "confluent_schema_registry_region" "myregion" {
  cloud   = var.confluent_cloud_provider
  region  = var.confluent_cloud_region
  package = "ESSENTIALS"
}

resource "confluent_schema_registry_cluster" "myschemaregistry" {
  package = data.confluent_schema_registry_region.myregion.package

  environment {
    id = var.confluent_cloud_environment.id
  }

  region {
    id = data.confluent_schema_registry_region.myregion.id
  }
}

resource "confluent_service_account" "env-manager" {
  display_name = "env-manager"
  description  = "Service account to manage the environment"
}

resource "confluent_role_binding" "env-manager-environment-admin" {
  principal   = "User:${confluent_service_account.env-manager.id}"
  role_name   = "EnvironmentAdmin"
  crn_pattern = var.confluent_cloud_environment.resource_name
}

resource "confluent_api_key" "env-manager-schema-registry-api-key" {
  display_name = "env-manager-schema-registry-api-key"
  description  = "Schema Registry API Key that is owned by 'env-manager' service account"
  owner {
    id          = confluent_service_account.env-manager.id
    api_version = confluent_service_account.env-manager.api_version
    kind        = confluent_service_account.env-manager.kind
  }

  managed_resource {
    id          = confluent_schema_registry_cluster.myschemaregistry.id
    api_version = confluent_schema_registry_cluster.myschemaregistry.api_version
    kind        = confluent_schema_registry_cluster.myschemaregistry.kind

    environment {
      id = var.confluent_cloud_environment.id
    }
  }
  depends_on = [
    confluent_role_binding.env-manager-environment-admin
  ]
}

output "confluent_schema_registry_key" {
  value = confluent_api_key.env-manager-schema-registry-api-key.id
}

output "confluent_schema_registry_secret" {
  value = confluent_api_key.env-manager-schema-registry-api-key.secret
}

output "confluent_schema_registry" {
  value = confluent_schema_registry_cluster.myschemaregistry
}