-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  i.name, s.*
FROM    inventory AS i, service AS s
WHERE   s.inventory_number = i.inventory_number
        AND s.service_date = '2021-01-03';