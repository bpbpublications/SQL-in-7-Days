-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  i.inventory_number, i.name
FROM    inventory AS i
JOIN    service AS s
ON      s.inventory_number = i.inventory_number;