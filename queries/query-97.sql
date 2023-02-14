-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number
FROM    inventory
WHERE   price > 69.90
UNION ALL
SELECT  inventory_number
FROM    service
WHERE   service_date = '2020-01-14'
        AND inventory_number LIKE 'VAC%';