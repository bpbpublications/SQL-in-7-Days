-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number
FROM    inventory
EXCEPT
SELECT  inventory_number
FROM    service;