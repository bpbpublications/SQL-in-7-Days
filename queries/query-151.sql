-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

UPDATE  inventory
SET     comment = comment || ' – not to put on the head!'
WHERE   inventory_comment LIKE 'BUC%';