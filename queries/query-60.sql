-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name,
        EXISTS
        (
        SELECT  *
        FROM    service AS s
        WHERE   s.inventory_number = i.inventory_number
        )
FROM    inventory AS i;