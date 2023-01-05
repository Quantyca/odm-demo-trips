###########################
#  COMMON DATA SOURCES    #
###########################

data "confluent_environment" "environment" {
  id = var.env_id
}

data "confluent_kafka_cluster" "dev-cluster" {
  id = var.cluster_id
  environment {
    id = var.env_id
  }
}

data "confluent_schema_registry_cluster" "schemaregistry" {
  display_name = "Stream Governance Package"
  environment {
    id = var.env_id
  }
}