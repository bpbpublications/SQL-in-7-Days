-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

WITH    RECURSIVE level AS
        (
        SELECT  staff_id AS chain_top, staff_id AS subordinate_or_himself
        FROM    staff
        UNION ALL
        SELECT  chain_top, staff_id AS subordinate_or_himself
        FROM    level
        JOIN    staff
        ON      staff.reports_to = level.subordinate_or_himself
        )
SELECT  chain_top, top.name AS chain_top_name,
        subordinate_or_himself, subordinate.name AS subordinate_or_himself_name
FROM    level
JOIN    staff AS top
ON      top.staff_id = chain_top
JOIN    staff AS subordinate
ON      subordinate.staff_id = subordinate_or_himself
ORDER BY
        chain_top;