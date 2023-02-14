-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

CREATE TABLE service (
        service_id BIGSERIAL NOT NULL PRIMARY KEY,
        inventory_number VARCHAR(100) NOT NULL REFERENCES inventory,
        service_date DATE NOT NULL,
        comment VARCHAR(200) NOT NULL
);