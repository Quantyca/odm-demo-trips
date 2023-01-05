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
resource "confluent_kafka_cluster" "mykafkacluster" {
  display_name = "basic_kafka_cluster"
  availability = "SINGLE_ZONE"
  cloud        = var.confluent_cloud_provider
  region       = var.confluent_cloud_region

  #this is mandatory in order to use schema validation
  dedicated {
    cku = 1
  }

  environment {
    id = var.confluent_cloud_environment.id
  }
}

resource "confluent_service_account" "app-manager" {
  display_name = "app-manager"
  description  = "Service account to manage Kafka cluster"
}

resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.mykafkacluster.rbac_crn
}

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "app-manager-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-manager' service account"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.mykafkacluster.id
    api_version = confluent_kafka_cluster.mykafkacluster.api_version
    kind        = confluent_kafka_cluster.mykafkacluster.kind

    environment {
    id = var.confluent_cloud_environment.id
    }
  }

  depends_on = [
    confluent_role_binding.app-manager-kafka-cluster-admin
  ]
}

output "confluent_kafka_cluster_key" {
  value = confluent_api_key.app-manager-kafka-api-key.id
}

output "confluent_kafka_cluster_secret" {
  value = confluent_api_key.app-manager-kafka-api-key.secret
}

output "confluent_kafka_cluster" {
  value = confluent_kafka_cluster.mykafkacluster
}