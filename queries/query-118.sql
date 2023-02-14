-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name, price,
        ROW_NUMBER() OVER (PARTITION BY LEFT(inventory_number, 3) ORDER BY price, inventory_number) AS row_number_by_type,
        SUM(price) OVER (PARTITION BY LEFT(inventory_number, 3) ORDER BY price, inventory_number) AS running_total_by_type
FROM    inventory
ORDER BY
        price, inventory_number
LIMIT   10;