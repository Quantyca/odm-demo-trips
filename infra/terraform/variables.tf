variable "confluent_cloud_api_key" {
    type = string
    description = "Confluent Cloud API KEY. Go to the Confluent Cloud console with an admin account to retrieve this."
    sensitive = true
}

variable "confluent_cloud_api_secret" {
    type = string
    description = "Confluent Cloud API Secret. Go to the Confluent Cloud console with an admin account to retrieve this."
    sensitive = true
}

variable "kafka_api_key" {
   type = string
   description = "Cluster API KEY. Go to the Confluent Cloud console to retrieve this."
   sensitive = true
}

variable "kafka_api_secret" {
   type = string
   description = "Cluster API Secret. Go to the Confluent Cloud console to retrieve this."
   sensitive = true
}

variable "env_id" {
   type = string
   description = "Confluent Cloud Environment ID. Go to the Confluent Cloud console, in Cluster Setting page, to retrieve this."
}

variable "cluster_id" {
   type = string
   description = "Confluent Cloud Cluster ID. Go to the Confluent Cloud console, in Cluster Setting page, to retrieve this."
}

variable "rest_endpoint" {
   type = string
   description = "Confluent Cloud Cluster REST Endpoint. Go to the Confluent Cloud console, in Cluster Setting page, to retrieve this."
}

variable "schema_registry_url" {
   type = string
}

variable "schema_registry_key" {
   type = string
}

variable "schema_registry_secret" {
   type = string
}