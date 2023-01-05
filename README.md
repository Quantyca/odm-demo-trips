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

**TO DO External**

* develop open data mesh utility plane adapter to run KSQL scripts
* verify if terraform templates can be processed from open data mesh utility plane from any URL or if they can only be a standalone git repository

**TO DO Internal**

* check which property the utility plane adapter requires to execute KSQL scripts and add them to the application configurations
* application definition must be completed  ( find the minimal set of configurations needed )
* verify that on confluent cloud the binding between topic and schemas works: it could require the cluster to be dedicated or some properties to be specified, otherwise it could be done from the adapter by executing some CLI operations
* verify that KSQL script works (at the moment the streams don't read any events written in the topics..) and make it more meaningful
* understand how to treat in a single centralized place all variables used for port and asyncapi schema definitions
* add second outputport that computes average trip duration by category (after completing first version of data product)
* the schemas used in the topics at the moment are saved only in terraform dir and then referenced from asyncapi schema definition: is this fine?