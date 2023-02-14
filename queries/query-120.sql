-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  report.staff_id, report.name, report.reports_to, manager.name AS manager
FROM    staff AS report
LEFT JOIN
        staff AS manager
ON      manager.staff_id = report.reports_to;