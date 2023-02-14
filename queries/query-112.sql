-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  inventory_number, name, COUNT(staff_id)
FROM    inventory
LEFT JOIN
        staff_inventory
USING   (inventory_number)
GROUP BY
        inventory_number
ORDER BY
        price DESC
LIMIT   5;