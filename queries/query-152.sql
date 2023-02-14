-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
DECLARE
        inventory_printout
CURSOR FOR
SELECT  *
FROM    inventory
ORDER BY
        inventory_number;