CREATE TABLE tripCurrentSnapshot AS
SELECT tripId,
       LATEST_BY_OFFSET(tripStatus) as tripCurrentStatus,
       LATEST_BY_OFFSET(vectorPositionLat) as vectorCurrentPositionLat,
       LATEST_BY_OFFSET(vectorPositionLong) as vectorCurrentPositionLong,
       LATEST_BY_OFFSET(eventTimestamp) as eventTimestamp
FROM TRIPEVENT
GROUP BY tripId;