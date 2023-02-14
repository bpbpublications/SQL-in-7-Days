-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  *
FROM    service
ORDER BY
        service_date DESC, service_id DESC
OFFSET  10
LIMIT   10;