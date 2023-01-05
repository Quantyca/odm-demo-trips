CREATE STREAM tripsFromSystemA
  (tripId BIGINT,
   tripCategory VARCHAR,
   tripStatus VARCHAR,
   tripStartTs TIMESTAMP,
   currentTs TIMESTAMP)
  WITH (KAFKA_TOPIC='tripsFromSystemA',
        VALUE_FORMAT='AVRO');

CREATE STREAM tripsFromSystemB
  (id BIGINT,
   "status" VARCHAR,
   startTs TIMESTAMP,
   currentTs TIMESTAMP)
  WITH (KAFKA_TOPIC='tripsFromSystemB',
        VALUE_FORMAT='AVRO');

CREATE STREAM trips
  (tripId BIGINT,
   tripCategory VARCHAR,
   tripStatus VARCHAR,
   tripStartTs TIMESTAMP,
   currentTs TIMESTAMP)
   WITH (KAFKA_TOPIC='trips',
        VALUE_FORMAT='AVRO');

INSERT INTO trips 
SELECT tripId, tripCategory, tripStatus, tripStartTs, currentTs
FROM tripsFromSystemA EMIT CHANGES;

INSERT INTO trips 
SELECT id as tripId, 'B' as tripCategory, "status" as tripStatus, startTs as tripStartTs, currentTs
FROM tripsFromSystemB EMIT CHANGES;

CREATE TABLE AvgDurationByCategory AS
  SELECT tripCategory,
         AVG(currentTs - tripStartTs) AS AVG_DURATION
  FROM trips
  WHERE tripStatus = 'ENDED'
  GROUP BY tripCategory
  EMIT CHANGES;