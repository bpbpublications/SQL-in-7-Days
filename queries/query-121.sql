-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  report.staff_id, report.name, report.reports_to, manager.name AS manager,
        manager.reports_to AS reports_to2, manager2.name AS manager2
FROM    staff AS report
LEFT JOIN
        staff AS manager
ON      manager.staff_id = report.reports_to
LEFT JOIN
        staff AS manager2
ON      manager2.staff_id = manager.reports_to;