-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  *
FROM    staff_inventory_2nf
ORDER BY
       inventory_number, staff_id
LIMIT 10;