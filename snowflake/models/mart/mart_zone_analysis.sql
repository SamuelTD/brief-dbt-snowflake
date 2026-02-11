SELECT 
    "PULocationID",
    COUNT(*) AS "nb_trips",
    AVG("total_amount") AS "mean_amount",
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS "popularity_rank"
FROM {{ ref('stg_nyc_taxi') }}
GROUP BY "PULocationID"