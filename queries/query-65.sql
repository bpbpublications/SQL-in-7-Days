-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  *
FROM    inventory
WHERE   inventory_number NOT IN ('VAC-0001', 'MOP-0001');