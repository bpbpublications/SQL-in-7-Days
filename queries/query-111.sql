-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name, COUNT(service_id)
FROM    inventory
LEFT JOIN
        service
USING   (inventory_number)
GROUP BY
        inventory_number
ORDER BY
        price DESC
LIMIT   5;