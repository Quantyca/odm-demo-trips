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

resource "confluent_environment" "myenvironment" {
  display_name = var.confluent_cloud_environment
}

output "confluent_cloud_environment" {
  value = confluent_environment.myenvironment
}