-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  i1.inventory_number, i1.name, i1.price, SUM(i2.price) AS running_total
FROM    inventory i1, inventory i2
WHERE   i2.price < i1.price
        OR i2.price = i1.price AND i2.inventory_number <= i1.inventory_number
GROUP BY
        i1.inventory_number
ORDER BY
        i1.price, i1.inventory_number
LIMIT   10;