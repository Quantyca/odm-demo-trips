**Introduction**

This repository contains a sample data product definition that uses confluent cloud to read data from two topics and after a little processing it writes to a third topic. The first two topics are input ports while the other topic is the output port of this data product.
The infrastructural component are: these topics and their schemas on Schema Registry.
The application used by this data product is made of a ksql script.

**Requirements**
The following resources must already exists in your confluent cloud account:
* environment
* kafka cluster
* stream governance
* ksqldb

**How to**

In order to create the data product you need to:
1. Modify all port APIs and specify configuration values to connect to a specific Confluent Cloud environment
2. Have Open Data Mesh Platform running (it uses a separate repository: **TODO: add reference to the repository**)
3. Use Open Data Mesh Platform Data Product Experience Plane API to manage the descriptor defined in this repository by providing its URL

**TO DO External**

* develop open data mesh utility plane adapter to run KSQL scripts

**TO DO Internal**

* check which property the utility plane adapter requires to execute KSQL scripts and add them to the application configurations
* application definition must be completed  ( find the minimal set of configurations needed )
* verify that on confluent cloud the binding between topic and schemas works: it could require the cluster to be dedicated or some properties to be specified, otherwise it could be done from the adapter by executing some CLI operations
* verify that KSQL script works (at the moment the streams don't read any events written in the topics..) and make it more meaningful
* understand how to treat in a single centralized place all variables used for port and asyncapi schema definitions
* the schemas used in the topics at the moment are saved in two places: inside terraform dir and inside asyncapi schema definition: how can we avoid this
* EDIT: connection_string and security in input and output ports to specify the values related to your environment 