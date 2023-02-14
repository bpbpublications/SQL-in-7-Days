-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

INSERT
INTO    shift (shift_start, shift_end)
VALUES  ('2021-03-10 06:00:00', '2021-03-10 22:00:00')
RETURNING
        shift_id;