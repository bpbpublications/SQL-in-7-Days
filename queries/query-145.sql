-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, price, name, (HASHTEXT(inventory_number) % 100 + 100) % 100 AS bucket
FROM    inventory
WHERE   price > 50
ORDER BY
        inventory_number
LIMIT   5;