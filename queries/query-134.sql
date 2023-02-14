-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  EXISTS
        (
        SELECT  *
        FROM    staff_inventory
        JOIN    staff
        USING   (staff_id)
        WHERE   inventory_number = 'BRO-00001'
                AND reports_to = 2
        );