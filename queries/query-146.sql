-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, comment, (HASHTEXT(inventory_number) % 100 + 100) % 100 AS bucket
FROM    service
WHERE   service_date = '2020-05-26'
LIMIT   5;