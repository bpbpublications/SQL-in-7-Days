-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  COUNT(*), SUM(price)
FROM    inventory
WHERE   inventory_number NOT IN
        (
        SELECT  inventory_number
        FROM    service
        );