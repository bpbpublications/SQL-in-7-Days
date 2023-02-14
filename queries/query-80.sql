-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  COUNT(*), COUNT(inventory_number), SUM(price), MAX(price), MIN(price)
FROM    inventory
WHERE   false;