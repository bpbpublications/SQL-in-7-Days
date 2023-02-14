-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, COUNT(*)
FROM    service
WHERE   service_date = '2000-01-01'
GROUP BY
        inventory_number;