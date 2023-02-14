-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

CREATE TABLE (
        inventory_number VARCHAR(100) NOT NULL PRIMARY KEY,
        name VARCHAR(200) NOT NULL,
        price NUMERIC(12, 2) NOT NULL,
        comment VARCHAR(200)
);