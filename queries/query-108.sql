-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  *
FROM    inventory
WHERE   EXISTS
        (
        SELECT  *
        FROM    service
        WHERE   service.inventory_number = inventory.inventory_number
                AND service_date = '2020-01-01'
        );