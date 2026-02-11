SELECT 
    "date",
    COUNT("trip_distance") AS "nb_trips",
    AVG("trip_distance") AS "mean_distance",
    AVG("total_amount") AS "daily_total"
FROM {{ ref('stg_nyc_taxi') }}
GROUP BY "date"