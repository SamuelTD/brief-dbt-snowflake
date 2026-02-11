SELECT
  "Airport_fee",
  "DOLocationID",
  "PULocationID",
  "RatecodeID",
  "VendorID",
  "cbd_congestion_fee",
  "congestion_surcharge",
  "extra",
  "fare_amount",
  "improvement_surcharge",
  "mta_tax",
  "passenger_count",
  "payment_type",
  "store_and_fwd_flag",
  "tip_amount",
  "tolls_amount",
  "total_amount",
  "tpep_dropoff_datetime",
  "tpep_pickup_datetime",
  "trip_distance",
  datediff(
    minute,
    to_timestamp_ntz("tpep_pickup_datetime" / 1000),
    to_timestamp_ntz("tpep_dropoff_datetime" / 1000)
  ) AS "trip_duration",
  TO_VARCHAR(
    TO_TIMESTAMP_NTZ("tpep_pickup_datetime" / 1000000),
    'DD-MM'
  ) AS "date",
  "trip_distance" / ("trip_duration" / 60.0) as "mean_speed",
  CASE 
    WHEN "tip_amount" > 0 THEN "tip_amount"/"total_amount"*100.0
    ELSE 0
  END AS "tip_percent"
FROM {{ source('raw', 'RAW_NYC_TAXI') }}
WHERE "fare_amount" >= 0 
AND "total_amount" >= 0 
AND "tpep_pickup_datetime" < "tpep_dropoff_datetime" 
AND ("trip_distance" >= 0.1 AND "trip_distance" <= 100)
AND "PULocationID" IS NOT NULL 
AND "DOLocationID" IS NOT NULL