-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  service_date, COUNT(*)
FROM    service
WHERE   service_date BETWEEN '2021-01-04' AND '2021-01-10'
GROUP BY
        service_date;