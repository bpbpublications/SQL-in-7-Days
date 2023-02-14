-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  service_date, COUNT(*)
FROM    service
WHERE   inventory_number = 'VAC-00292'
GROUP BY
        service_date
ORDER BY
        COUNT(*) DESC, service_date DESC;