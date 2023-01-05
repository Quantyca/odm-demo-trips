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

resource "confluent_service_account" "app-ksql" {
  display_name = "app-ksql"
  description  = "Service account to manage ksqlDB cluster"
}

resource "confluent_role_binding" "app-ksql-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-ksql.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = var.confluent_kafka_cluster.rbac_crn
}

resource "confluent_role_binding" "app-ksql-schema-registry-resource-owner" {
  principal   = "User:${confluent_service_account.app-ksql.id}"
  role_name   = "ResourceOwner"
  crn_pattern = format("%s/%s", var.confluent_schema_registry.resource_name, "subject=*")
}

resource "confluent_ksql_cluster" "myksqldb" {
  display_name = "myksqldb"
  csu          = 1
  kafka_cluster {
    id = var.confluent_kafka_cluster.id
  }
  credential_identity {
    id = confluent_service_account.app-ksql.id
  }
  environment {
    id = var.confluent_cloud_environment.id
  }
  depends_on = [
    confluent_role_binding.app-ksql-schema-registry-resource-owner
  ]
}