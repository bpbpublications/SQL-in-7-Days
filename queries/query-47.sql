-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory.name, service.service_date, service.comment
FROM    inventory
JOIN    service
ON      service.inventory_number = inventory.inventory_number
WHERE   service.service_date = '2021-01-03';