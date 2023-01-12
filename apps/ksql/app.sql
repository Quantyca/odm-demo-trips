CREATE STREAM tripEvent (
    tripId VARCHAR,
    tripStatus VARCHAR,
    vectorPositionLat VARCHAR,
    vectorPositionLong VARCHAR,
    eventTimestamp TIMESTAMP
  ) WITH (
    KAFKA_TOPIC = 'tripEvent',
    VALUE_FORMAT = 'AVRO'
  );

CREATE STREAM tripRouteHistory (
    tripId VARCHAR,
    vectorCurrentPositionLat VARCHAR,
    vectorCurrentPositionLong VARCHAR,
    eventTimestamp TIMESTAMP
  ) WITH (
    KAFKA_TOPIC = 'tripRouteHistory',
    VALUE_FORMAT = 'AVRO'
  );

INSERT INTO tripRouteHistory
select tripId,
vectorPositionLat as vectorCurrentPositionLat, 
vectorPositionLong as vectorCurrentPositionLong, 
eventTimestamp
from TRIPEVENT
EMIT CHANGES;

CREATE TABLE  tripCurrentSnapshot
WITH (KAFKA_TOPIC = 'tripCurrentSnapshot',
    VALUE_FORMAT='AVRO') as
SELECT tripId,
       LATEST_BY_OFFSET(tripStatus) as tripCurrentStatus,
       LATEST_BY_OFFSET(vectorPositionLat) as vectorCurrentPositionLat,
       LATEST_BY_OFFSET(vectorPositionLong) as vectorCurrentPositionLong,
       LATEST_BY_OFFSET(eventTimestamp) as eventTimestamp
FROM TRIPEVENT
GROUP BY tripId
EMIT CHANGES;