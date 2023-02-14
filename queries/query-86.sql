-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, comment
FROM    service
WHERE   inventory_number = 'VAC-00292'
ORDER BY
        service_date DESC, service_id DESC;