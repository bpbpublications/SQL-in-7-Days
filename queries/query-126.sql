-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

WITH    RECURSIVE level AS
        (
        SELECT  staff_id AS chain_bottom, staff_id AS superior_or_himself, reports_to
        FROM    staff
        UNION ALL
        SELECT  chain_bottom, staff_id AS superior_or_himself, staff.reports_to
        FROM    level
        JOIN    staff
        ON      staff.staff_id = level.reports_to
        )
SELECT  *
FROM    level;