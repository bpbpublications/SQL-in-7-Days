-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, price, name, service_date, service.comment
FROM    service
JOIN    inventory
USING   (inventory_number)
WHERE   price >= 50
        AND service_date = '2020-05-26';