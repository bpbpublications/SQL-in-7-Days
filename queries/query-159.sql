-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

CREATE OR REPLACE FUNCTION
        fn_service_inventory_service_stats_update()
RETURNS TRIGGER
AS
$$
BEGIN
        WITH    new_values AS
                (
                SELECT  inventory_number, SUM(job_count_diff) AS job_count_diff
                FROM    (
                        SELECT  inventory_number, 1 AS job_count_diff
                        FROM    inserted
                        UNION ALL
                        SELECT  inventory_number, -1 AS job_count_diff
                        FROM    deleted
                        ) q
                GROUP BY
                        inventory_number
                ),
                old_values AS
                (
                SELECT  inventory_number, job_count
                FROM    new_values
                JOIN    inventory_service_stats
                USING   (inventory_number)
                ),
                diff AS
                (
                SELECT  inventory_number, job_count_diff,
                        COALESCE(old_values.job_count, 0) + job_count_diff <> 0 AS is_new,
                        old_values IS NOT NULL AS is_old
                FROM    new_values
                LEFT JOIN
                        old_values
                USING   (inventory_number)
                ),
                do_insert AS
                (
                INSERT
                INTO    inventory_service_stats
                SELECT  inventory_number, job_count_diff
                FROM    diff
                WHERE   is_new
                        AND NOT is_old
                ),
                do_update AS
                (
                UPDATE  inventory_service_stats AS target
                SET     job_count = job_count + job_count_diff
                FROM    diff
                WHERE   diff.inventory_number = target.inventory_number
                        AND is_new
                        AND is_old
                )
        DELETE
        FROM    inventory_service_stats AS target
        USING   diff
        WHERE   diff.inventory_number = target.inventory_number
                AND NOT is_new
                AND is_old;

        RETURN NULL;
END;
$$
LANGUAGE plpgsql;