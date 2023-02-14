-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

WITH    level1 AS
        (
        SELECT  staff_id AS chain_bottom, staff_id AS superior_or_himself, reports_to
        FROM    staff
        ),
        level2 AS
        (
        SELECT  chain_bottom, staff_id AS superior_or_himself, staff.reports_to
        FROM    level1
        JOIN    staff
        ON      staff.staff_id = level1.reports_to
        ),
        level3 AS
        (
        SELECT  chain_bottom, staff_id AS superior_or_himself, staff.reports_to
        FROM    level2
        JOIN    staff
        ON      staff.staff_id = level2.reports_to
        ),
        level4 AS
        (
        SELECT  chain_bottom, staff_id AS superior_or_himself, staff.reports_to
        FROM    level3
        JOIN    staff
        ON      staff.staff_id = level3.reports_to
        )
SELECT  *
FROM    level1
UNION ALL
SELECT  *
FROM    level2
UNION ALL
SELECT  *
FROM    level3
UNION ALL
SELECT  *
FROM    level4;