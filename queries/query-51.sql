-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  i.name, s.service_date AS date, s.comment
FROM    inventory AS i
LEFT OUTER JOIN
        service AS s
ON      s.inventory_number = i.inventory_number