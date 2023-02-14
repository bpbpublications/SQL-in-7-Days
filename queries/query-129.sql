-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name
FROM    inventory
WHERE   inventory_number = ANY('{BRO-00001, BRO-00002}'::VARCHAR(100)[]);