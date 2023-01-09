CREATE STREAM tripsFromSystemA
  (tripId BIGINT,
   tripCategory VARCHAR,
   tripStatus VARCHAR,
   tripStartTs TIMESTAMP)
  WITH (KAFKA_TOPIC='tripsFromSystemA',
        VALUE_FORMAT='AVRO');

CREATE STREAM tripsFromSystemB
  (id BIGINT,
   "status" VARCHAR,
   startTs TIMESTAMP)
  WITH (KAFKA_TOPIC='tripsFromSystemB',
        VALUE_FORMAT='AVRO');

CREATE STREAM trips
  (tripId BIGINT,
   tripCategory VARCHAR,
   tripStatus VARCHAR,
   tripStartTs TIMESTAMP)
   WITH (KAFKA_TOPIC='trips',
        VALUE_FORMAT='AVRO');

INSERT INTO trips 
SELECT tripId, tripCategory, tripStatus, tripStartTs, currentTs
FROM tripsFromSystemA EMIT CHANGES;

INSERT INTO trips 
SELECT id as tripId, 'B' as tripCategory, "status" as tripStatus, startTs as tripStartTs, currentTs
FROM tripsFromSystemB EMIT CHANGES;