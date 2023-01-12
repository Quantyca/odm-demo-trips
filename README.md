**Introduction**

This repository contains a sample data product descriptor used to implement a real time use case.
Suppose we are a logistic company, our vectors continuously generate data about their position and the status of their related trip: we would like to create a data product that collects this information and generate some insights like the current status and the history of all the positions of each trip, both in real-time.
The data product to implement this use case has three ports:
* the input port *tripEvent* is a topic that collects a stream of events related to trip and its behaviour.
* the output port *tripCurrentSnapshot* tracks the last known information about each trip.
* the output port *tripRouteHistory* tracks all the positions recorded for the vector binded to each trip in real-time

While its internal components are: 
* an infrastructure based on Confluent Cloud - three topics, one to collect data coming from the input port, one associated to a KTable to contain data for the first output port and one for a KStream for the third port
* an application based on KSQL

The infrastructure is provisioned thanks to a terraform template saved on a separate repository and referenced by the descriptor.

**Requirements**

The following resources must already exists in your confluent cloud account:
* environment
* kafka cluster
* stream governance
* ksqldb

**Notes**
In this scenario we already have a Confluent Cloud environment already equipped with its Kafka Cluster, KSQLDB and Schema Registry. It is possible of course to bind also this components to the data product definition in order to have a full isolation between data products, while in this scenario data products share the core infrastructure components and work on top of those. In fact, this data product would only aim to create the required topics, for which it is responsible, and their schemas, that would be used by the application and for governance purposes.
The application is entirely based on KSQL scripts that would be execute inside Confluent KSQLDB. Inside its definition, in the deployInfo section, we use a custom service that calls Confluent Cloud APIs to run these scripts and that requires all the necessary configurations to connect to the Confluent Cloud environment and its components.
The schema for *tripEvent* at the moment is created by the *Confluent Datagen* source connector and for this reason it is not created by Terraform.

**How to**

In order to create the data product you need to:

1. Specify configuration values to connect to a specific Confluent Cloud environment in the following sections of the descriptor:
    * *apps/processingapp.json* - the configurations section must have all the values defined for each variable
    * *infra/confluentcloud.json* - the configurations section must have all the values defined for each variable
    * *tripCurrentSnapshot-oport-api.json* - sections *servers* and *security* must define values for confluent components
    * *tripRouteHistory-oport-api.json* - sections *servers* and *security* must define values for confluent components
    * *tripEvent-iport-api.json* - sections *servers* and *security* must define values for confluent components
2. Use the **Open Data Mesh Platform** *Data Product Experience Plane* APIs to manage the descriptor defined in this repository

After deploying the data product you need to do some further actions directly on confluent cloud. First of all, you need to setup a connector to generate sample data:

1. Connect to your confluent cloud and select the environment and kafka cluster specified in the configurations
2. From the panel on the left, open "Connectors" tab and select *Datagen source*
3. Configure *Datagen source* to write data to *tripEvent* topic
4. Configure *Datagen source* to create Global access API credentials
5. Configure *Datagen source* to use *Avro* as outputrecord value format and for template choose *Use schema string instead*
6. As *schema string* paste the content of file *tripEvent-iport-schema.avsc*
7. Continue untile the connector is created and correctly generates data to tripEvent topic with the schema specified

To enable KSQLDB to read data from the tripEvent topic do the following:

1. from the panel on the left click on *KSQLDB*
2. click on your ksqldb instance
3. open *settings* tab
4. click on *access* option
5. allow access for *tripEvent*, *tripRouteHistory* and *tripCurrentSnapshot* topics


**TO DO External**

* develop an application to run commands against a confluent cloud cluster (ksql scripts or admin tasks)

**TO DO Internal**

* verify that all the configurations needed by the terraform template are listed in the infrastructure component
* without the application to run commands against a confluent cloud cluster, the application can't be executed automatically and the ksql code must be run manually on KSQLDB. Furthermore, when this application will be available you must assign all the required values to the application configuration
* find a way to treat all configuration values for the descriptor in a single centralized place (components?)

**Resources**

* [Repository](https://github.com/Quantyca/odm-demo-trips-terraform ) containing Terraform template to provision only part of Confluent Cloud components (assuming the others already exists and are managed by someone else)
* [Repository](https://github.com/Quantyca/odm-demo-trips-terraform-full) containing Terraform template to provision **ALL** Confluent Cloud components. Note that this repository can be useful to run some tests but the application in the data product descriptor needs to know in advance your Confluent Cloud configurations: you can’t use this terraform template on the infrastructure component of the data product since the application wouldn’t be able to know the environment variables.