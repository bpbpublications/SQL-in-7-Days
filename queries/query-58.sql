-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  EXISTS
        (
        SELECT  *
        FROM    service
        WHERE   inventory_number = 'VAC-0001'
        );