-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name, price,
        SUM(price) OVER (ORDER BY price, inventory_number) AS running_total
FROM    inventory
ORDER BY
        price, inventory_number
LIMIT   10;