-- This code is a part of the book "SQL in 7 Days" by Alex Bolenok
-- Copyright (c) 2020-2022 Alex Bolenok

INSERT
INTO    inventory (inventory_number, name, price, comment)
VALUES  ('VAC-0001', 'Vacuum', 50.00, DEFAULT),
        ('MOP-0001', 'Fancy Mop', 15.00, 'I like this mop!')
        ('BUC-0001', 'Galvanized steel bucket', 15.00, 'This bucket is very strong');