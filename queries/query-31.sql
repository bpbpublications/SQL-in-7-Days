-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name, price, price * 100 AS price_in_cents
FROM    inventory
WHERE   LENGTH(comment) >= 10;