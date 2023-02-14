-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

CREATE TABLE IF NOT EXISTS inventory_service_stats
        (
        inventory_number VARCHAR(100) PRIMARY KEY NOT NULL REFERENCES inventory,
        job_count BIGINT NOT NULL
        );