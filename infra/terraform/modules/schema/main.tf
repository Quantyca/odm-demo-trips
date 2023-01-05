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
resource "confluent_schema" "tripsFromSystemA" {
  schema_registry_cluster {
    id = var.confluent_schema_registry.id
  }
  format = "AVRO"
  rest_endpoint = var.confluent_schema_registry.rest_endpoint
  subject_name = "tripsFromSystemA"
  schema = file("${path.module}/tripsFromSystemA.avsc")
  credentials {
    key    = var.confluent_schema_registry_key
    secret = var.confluent_schema_registry_secret
  }
}
resource "confluent_schema" "tripsFromSystemB" {
  schema_registry_cluster {
    id = var.confluent_schema_registry.id
  }
  format = "AVRO"
  rest_endpoint = var.confluent_schema_registry.rest_endpoint
  subject_name = "tripsFromSystemB"
  schema = file("${path.module}/tripsFromSystemB.avsc")
  credentials {
    key    = var.confluent_schema_registry_key
    secret = var.confluent_schema_registry_secret
  }
}
resource "confluent_schema" "trips" {
  schema_registry_cluster {
    id = var.confluent_schema_registry.id
  }
  format = "AVRO"
  rest_endpoint = var.confluent_schema_registry.rest_endpoint
  subject_name = "trips"
  schema = file("${path.module}/trips.avsc")
  credentials {
    key    = var.confluent_schema_registry_key
    secret = var.confluent_schema_registry_secret
  }
}