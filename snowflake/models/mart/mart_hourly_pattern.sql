SELECT 
    "hour",
    COUNT(*) AS "nb_trips",
    sum("total_amount") AS "hourly_total",
    AVG("mean_speed") AS "hourly_mean_speed"
FROM {{ ref('stg_nyc_taxi') }}
GROUP BY "hour"