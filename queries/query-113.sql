-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name,
        COALESCE(service_jobs_count, 0) AS service_jobs_count,
        COALESCE(authorized_users_count, 0) AS authorized_users_count
FROM    inventory
LEFT JOIN
        (
        SELECT  inventory_number, COUNT(*) AS service_jobs_count
        FROM    service
        GROUP BY
                inventory_number
        ) AS service_jobs
USING   (inventory_number)
LEFT JOIN
        (
        SELECT  inventory_number, COUNT(*) AS authorized_users_count
        FROM    staff_inventory
        GROUP BY
                inventory_number
        ) AS authorized_users
USING   (inventory_number)
ORDER BY
        price DESC
LIMIT   5;