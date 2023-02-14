-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  *
FROM    (VALUES ('a'), ('a'), ('b')) AS first
UNION ALL
SELECT  *
FROM    (VALUES ('b'), ('c'), ('c')) AS second;