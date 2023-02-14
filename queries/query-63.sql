-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  i.*
FROM    inventory i
LEFT JOIN
        service s
ON      i.inventory_number = s.inventory_number
WHERE   s.inventory_number IS NOT NULL;