**Introduction**

This repository contains a sample data product descriptor used to implement a real time use case.
Suppose we are a logistic company, our vectors continuously generate data about their position and the status of their related trip: we would like to create a data product that collects this information and generate some insights like the current status and the history of all the positions of each trip, both in real-time.
The data product to implement this use case has three ports:
* the input port *tripEvent* is a topic that collects a stream of events related to trip and its behaviour.
* the output port *tripCurrentSnapshot* tracks the last known information about each trip.
* the output port *tripRouteHistory* tracks all the positions recorded for the vector binded to each trip in real-time

While its internal components are: 
* an infrastructure based on Confluent Cloud - a topic to collect data coming from the input port, a KTable to contain data for the first output port and a KStream for the third port
* an application based on KSQL

The infrastructure is provisioned thanks to a terraform template saved on a separate repository and referenced by the descriptor.

**Requirements**

The following resources must already exists in your confluent cloud account:
* environment
* kafka cluster
* stream governance
* ksqldb

**How to**

In order to create the data product you need to:
1. Modify all port APIs, application and infrastructure definition files and specify configuration values to connect to a specific Confluent Cloud environment
3. Use Open Data Mesh Platform Data Product Experience Plane API to manage the descriptor defined in this repository

**TO DO External**

* develop open data mesh utility plane adapter to run KSQL scripts

**TO DO Internal**

* check which property the utility plane adapter requires to execute KSQL scripts and add them to the application configurations
* application definition must be completed  ( find the minimal set of configurations needed )
* understand how to treat in a single centralized place all variables used for port and asyncapi schema definitions