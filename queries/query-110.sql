-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  price_range,
        COUNT(*)
FROM    (
        SELECT  *,
                CASE
                WHEN price < 20 THEN 'cheap'
                WHEN price < 40 THEN 'medium'
                WHEN price < 60 THEN 'pricey'
                ELSE 'expensive' END AS price_range
        FROM    inventory
        ) AS labeled_inventory
GROUP BY
        price_range
HAVING  price_range <> 'cheap';