-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

UPDATE  inventory
SET     comment = comment || ' – expensive!'
WHERE   price >= 60;