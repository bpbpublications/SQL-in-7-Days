-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

CREATE MATERIALIZED VIEW IF NOT EXISTS
        mv_inventory_service_stats
AS
SELECT  inventory_number, COUNT(*) AS job_count
FROM    service
GROUP BY
        inventory_number;

CREATE UNIQUE INDEX IF NOT EXISTS
        ux_mb_inventory_service_stats
ON      mv_inventory_service_stats (inventory_number);