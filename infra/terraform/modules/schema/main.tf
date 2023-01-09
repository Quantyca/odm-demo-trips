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
resource "confluent_schema" "tripEvent" {
  schema_registry_cluster {
    id = var.confluent_schema_registry.id
  }
  format = "AVRO"
  rest_endpoint = var.confluent_schema_registry.rest_endpoint
  subject_name = "tripEvent"
  schema = file("${path.module}/tripEvent-iport-schema.avsc")
  credentials {
    key    = var.confluent_schema_registry_key
    secret = var.confluent_schema_registry_secret
  }
}
resource "confluent_schema" "tripCurrentSnapshot" {
  schema_registry_cluster {
    id = var.confluent_schema_registry.id
  }
  format = "AVRO"
  rest_endpoint = var.confluent_schema_registry.rest_endpoint
  subject_name = "tripCurrentSnapshot"
  schema = file("${path.module}/tripCurrentSnapshot-oport-schema.avsc")
  credentials {
    key    = var.confluent_schema_registry_key
    secret = var.confluent_schema_registry_secret
  }
}
resource "confluent_schema" "tripRouteHistory" {
  schema_registry_cluster {
    id = var.confluent_schema_registry.id
  }
  format = "AVRO"
  rest_endpoint = var.confluent_schema_registry.rest_endpoint
  subject_name = "tripRouteHistory"
  schema = file("${path.module}/tripRouteHistory-oport-schema.avsc")
  credentials {
    key    = var.confluent_schema_registry_key
    secret = var.confluent_schema_registry_secret
  }
}