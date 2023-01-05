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
  #kafka_api_key       = var.kafka_api_key
  #kafka_api_secret    = var.kafka_api_secret 
  #kafka_rest_endpoint = var.rest_endpoint
}

###########################
#         MODULES         #
###########################

module "environment" {
  confluent_cloud_environment = var.confluent_cloud_environment
  source = "./modules/environment"
}

module "kafkacluster" {
  confluent_cloud_environment = module.environment.confluent_cloud_environment
  confluent_cloud_provider = var.confluent_cloud_provider
  confluent_cloud_region = var.confluent_cloud_region
  source = "./modules/kafkacluster"
}

# module "schemaregistry" {
#   confluent_cloud_environment = module.environment.confluent_cloud_environment
#   confluent_cloud_provider = var.confluent_cloud_provider
#   confluent_cloud_region = var.confluent_cloud_region
#   source = "./modules/schemaregistry"
# }

# module "topics" {
#   confluent_kafka_cluster = module.kafkacluster.confluent_kafka_cluster
#   confluent_kafka_cluster_key = module.kafkacluster.confluent_kafka_cluster_key
#   confluent_kafka_cluster_secret = module.kafkacluster.confluent_kafka_cluster_secret
#   source = "./modules/topics"
# }

# module "schema" {
#   confluent_cloud_environment = module.environment.confluent_cloud_environment
#   confluent_schema_registry = module.schemaregistry.confluent_schema_registry
#   confluent_schema_registry_key = module.schemaregistry.confluent_schema_registry_key
#   confluent_schema_registry_secret = module.schemaregistry.confluent_schema_registry_secret
#   source = "./modules/schema"
# }

# module "ksqldb" {
#   confluent_kafka_cluster = module.kafkacluster.confluent_kafka_cluster
#   confluent_schema_registry = module.schemaregistry.confluent_schema_registry
#   confluent_cloud_environment = module.environment.confluent_cloud_environment
#   source = "./modules/ksqldb"
# }