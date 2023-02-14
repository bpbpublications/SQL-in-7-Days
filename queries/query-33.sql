-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  *
FROM    (
        VALUES
        (1, 'foo', TRUE),
        (2, 'bar', FALSE)
        ) AS transient_table (int_field, string_field, boolean_field);