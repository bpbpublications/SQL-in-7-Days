-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  (
        SELECT  COUNT(*)
        FROM    service
        WHERE   inventory_number IN
                (
                SELECT  inventory_number
                FROM    inventory
                ORDER BY
                        price DESC
                LIMIT   10
                )
        ) AS service_job_count,
        (
        SELECT  SUM(price)
        FROM    (
                SELECT  *
                FROM    inventory
                ORDER BY
                        price DESC
                LIMIT   10
                ) top_inventory
        ) AS total_price;