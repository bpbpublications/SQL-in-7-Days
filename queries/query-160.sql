-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

CREATE TRIGGER
        trigger_service_inventory_service_stats_insert
AFTER   INSERT
ON      service
REFERENCING NEW TABLE AS inserted
FOR EACH STATEMENT
EXECUTE FUNCTION fn_service_inventory_service_stats_insert();

CREATE TRIGGER
        trigger_service_inventory_service_stats_update
AFTER   UPDATE
ON      service
REFERENCING OLD TABLE AS deleted NEW TABLE AS inserted
FOR EACH STATEMENT
EXECUTE FUNCTION fn_service_inventory_service_stats_update();

CREATE TRIGGER
        trigger_service_inventory_service_stats_delete
AFTER   DELETE
ON      service
REFERENCING OLD TABLE AS deleted
FOR EACH STATEMENT
EXECUTE FUNCTION fn_service_inventory_service_stats_delete();