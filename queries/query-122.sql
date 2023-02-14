-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

WITH    level1 AS
        (
        SELECT  staff_id AS chain_bottom, staff_id AS superior_or_himself, reports_to
        FROM    staff
        )
SELECT  *
FROM    level1;