-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

SELECT  value->'field1', value->'field2'
FROM    JSON_ARRAY_ELEMENTS('[{"field1" : 1, "field2" : 2}, {"field1" : 10, "field2": 20}]');