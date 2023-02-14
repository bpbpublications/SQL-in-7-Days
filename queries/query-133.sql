-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  EXISTS
        (
        SELECT  *
        FROM    staff_inventory_2nf
        WHERE   inventory_number = 'BRO-00001'
                AND staff_reports_to = 2
        );