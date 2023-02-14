-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  *
FROM    (VALUES ('a'), ('a'), ('b'), ('b')) AS first
INTERSECT ALL
SELECT  *
FROM    (VALUES ('a'), ('b'), ('b'), ('b'), ('c')) AS second;