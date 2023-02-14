CREATE TABLE inventory (
        inventory_number VARCHAR(100) NOT NULL PRIMARY KEY,
        name VARCHAR(200) NOT NULL,
        price NUMERIC(12, 2) NOT NULL,
        comment VARCHAR(200)
);


INSERT
INTO    inventory
VALUES  ('VAC-0001', 'Vacuum', 50.00, NULL);

INSERT
INTO    inventory
VALUES  ('MOP-0001', 'Fancy Mop', 10.00, 'I like this mop!');

CREATE TABLE service (
        service_id BIGSERIAL NOT NULL PRIMARY KEY,
        inventory_number VARCHAR(100) NOT NULL REFERENCES inventory,
        service_date DATE NOT NULL,
        comment VARCHAR(200) NOT NULL
);

INSERT
INTO    service (inventory_number, service_date, comment)
VALUES
        ('VAC-0001', '2021-01-03', 'Eddie from The World Of Vacuums replaced the turbo brush'),
        ('VAC-0001', '2021-01-04', 'Donnie from The Vacuum Emporium cleaned the motor'),
        ('MOP-0001', '2021-01-03', 'Elsie went to Walmart and bought a replacement handle');
