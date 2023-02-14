-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number
FROM    inventory
WHERE   name LIKE '%Mop%'
        AND price BETWEEN 10 AND 40;