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

provider "confluent" {
  cloud_api_key       = var.confluent_cloud_api_key
  cloud_api_secret    = var.confluent_cloud_api_secret
  kafka_api_key       = var.kafka_api_key
  kafka_api_secret    = var.kafka_api_secret 
  kafka_rest_endpoint = var.rest_endpoint
}

###########################
#         MODULES         #
###########################

module "topics" {
  cluster_id  = data.confluent_kafka_cluster.dev-cluster.id
  source = "./modules/topics"
}

module "schema" {
  confluent_cloud_environment = data.confluent_environment.environment
  confluent_schema_registry = data.confluent_schema_registry_cluster.schemaregistry
  confluent_schema_registry_key = var.schema_registry_key
  confluent_schema_registry_secret = var.schema_registry_secret
  source = "./modules/schema"
}