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

resource "confluent_kafka_topic" "tripsFromSystemA" {
  kafka_cluster {
    id = var.cluster_id
  }
  config = {
    "confluent.value.schema.validation" = "true",
    "confluent.value.subject.name.strategy" = "io.confluent.kafka.serializers.subject.RecordNameStrategy"
  }
  topic_name         = "tripsFromSystemA"
  partitions_count   = 6
}
resource "confluent_kafka_topic" "tripsFromSystemB" {
  kafka_cluster {
    id = var.cluster_id
  }
  config = {
    "confluent.value.schema.validation" = "true",
    "confluent.value.subject.name.strategy" = "io.confluent.kafka.serializers.subject.RecordNameStrategy"
  }
  topic_name         = "tripsFromSystemB"
  partitions_count   = 6
}
resource "confluent_kafka_topic" "trips" {
  kafka_cluster {
    id = var.cluster_id
  }
  config = {
    "confluent.value.schema.validation" = "true",
    "confluent.value.subject.name.strategy" = "io.confluent.kafka.serializers.subject.RecordNameStrategy"
  }
  topic_name         = "trips"
  partitions_count   = 6
}
