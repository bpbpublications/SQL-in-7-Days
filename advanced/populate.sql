SET client_min_messages TO WARNING;

CREATE TABLE IF NOT EXISTS inventory
	(
        inventory_number VARCHAR(100) NOT NULL PRIMARY KEY,
        name VARCHAR(200) NOT NULL,
        price NUMERIC(12, 2) NOT NULL,
        comment VARCHAR(200)
	);

CREATE INDEX IF NOT EXISTS inventory_price ON inventory(price);

CREATE TABLE IF NOT EXISTS service (
        service_id BIGSERIAL NOT NULL PRIMARY KEY,
        inventory_number VARCHAR(100) NOT NULL REFERENCES inventory,
        service_date DATE NOT NULL,
        comment VARCHAR(200) NOT NULL
);

CREATE INDEX IF NOT EXISTS service_date ON service(service_date);
CREATE INDEX IF NOT EXISTS service_inventory_number ON service (inventory_number);

CREATE TABLE IF NOT EXISTS staff
	(
	staff_id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	title VARCHAR(100) NOT NULL,
	reports_to BIGINT
	);

ALTER TABLE staff ADD CONSTRAINT fk_reports_to_staff FOREIGN KEY (reports_to) REFERENCES staff;

CREATE TABLE IF NOT EXISTS staff_inventory
	(
	staff_id BIGINT NOT NULL REFERENCES staff,
	inventory_number VARCHAR(100) NOT NULL REFERENCES inventory,
	PRIMARY KEY (staff_id, inventory_number),
	UNIQUE(inventory_number, staff_id)
	);

CREATE TABLE IF NOT EXISTS passkey
	(
	serial BIGINT NOT NULL PRIMARY KEY,
	code UUID NOT NULL UNIQUE,
	staff BIGINT UNIQUE REFERENCES staff
	);

CREATE TABLE IF NOT EXISTS inventory_service_stats
	(
	inventory_number VARCHAR(100) PRIMARY KEY NOT NULL REFERENCES inventory,
	job_count BIGINT NOT NULL
	);

TRUNCATE TABLE inventory_service_stats CASCADE;

TRUNCATE TABLE inventory CASCADE;

SELECT	SETSEED(0.20210203);

WITH	nouns (noun) AS
	(
	VALUES
	('vacuum'),
	('bucket'),
	('mop'),
	('broom'),
	('dustpan'),
	('cloth'),
	('roomba'),
	('scrubber'),
	('polisher')
	),
	colors (color) AS
	(
	VALUES
	('red'),
	('orange'),
	('yellow'),
	('green'),
	('blue'),
	('indigo'),
	('violet'),
	('magenta'),
	('purple'),
	('auburn'),
	('turqoise'),
	('beige'),
	('brown'),
	('white'),
	('black'),
	('cerise'),
	('cyan'),
	('grey'),
	('khaki'),
	('pink')
	),
	qualities (quality) AS
	(
	VALUES
	('worn'),
	('new'),
	('good'),
	('squeaky'),
	('rigid'),
	('used'),
	('shiny'),
	('old'),
	('rusty'),
	('fancy'),
	('cheap'),
	('expensive'),
	('nondescript'),
	('smelly'),
	('beautiful'),
	('ugly'),
	('sturdy'),
	('fragile'),
	('antique')
	)
INSERT
INTO	inventory(inventory_number, name, price, comment)
SELECT	UPPER(LEFT(noun, 3)) || '-' || RIGHT('00000' || ROW_NUMBER() OVER(PARTITION BY noun ORDER BY color, quality), 5),
	INITCAP(quality) || ' ' || INITCAP(color) || ' ' || INITCAP(noun),
	10 + (RANDOM() * 60)::NUMERIC(12, 2),
	'This ' || INITCAP(noun) || ' is ' || color || ' and ' || quality
FROM	nouns, colors, qualities;

TRUNCATE TABLE service;


ALTER TABLE service DISABLE TRIGGER USER;

SELECT	SETSEED(0.20210203);

WITH	inventory AS
	(
	SELECT	inventory_number,
		'2020-01-01'::DATE + '1 day'::INTERVAL * (rnd3 * 500)::INT AS service_date,
		ROW_NUMBER() OVER (ORDER BY rn) AS service_id,
		'This was ' ||
		CASE FLOOR(rnd3 * 4)::INT WHEN 0 THEN 'an awesome' WHEN 1 THEN 'a good' WHEN 2 THEN 'a mediocre' ELSE 'an awful' END ||
		' job' AS comment
	FROM	(
		SELECT	*,
			ROW_NUMBER() OVER (ORDER BY inventory_number, batch) rn,
			RANDOM() AS rnd1,
			RANDOM() AS rnd2,
			RANDOM() AS rnd3
		FROM	inventory
		CROSS JOIN
			GENERATE_SERIES(1, 10) batch
		) q
	WHERE	rnd1 < 0.5
	)
INSERT
INTO	service (service_id, inventory_number, service_date, comment)
SELECT	service_id, inventory_number, service_date, comment
FROM	inventory;

SELECT  SETVAL('service_service_id_seq', COUNT(*))
FROM    service;

ALTER TABLE service ENABLE TRIGGER USER;

TRUNCATE TABLE staff CASCADE;

SELECT	SETSEED(0.20210203);

INSERT
INTO	staff (staff_id, name, title, reports_to)
VALUES	(1, 'Elsie', 'Manager', NULL),
	(2, 'Donnie', 'Supervisor', 1),
	(3, 'Ashley', 'Supervisor', 1),
	(4, 'Alec', 'Janitor', 2),
	(5, 'Barbara', 'Janitor', 2),
	(6, 'Shawn', 'Janitor', 2),
	(7, 'Desmond', 'Janitor', 3),
	(8, 'Claire', 'Janitor', 3),
	(9, 'Robin', 'Janitor', 3),
	(10, 'Alice', 'Technician', 1);

SELECT  SETVAL('staff_staff_id_seq', COUNT(*))
FROM    staff;

INSERT
INTO	staff_inventory
SELECT	staff_id, inventory_number
FROM	(
	SELECT	inventory_number, staff_id, RANDOM() rnd1
	FROM	inventory, staff
	) q
WHERE	rnd1 < 0.1;

INSERT
INTO	passkey (serial, code, staff)
VALUES	(1, '94310691-b07f-4c97-b534-7a7e4a633f75', 1),
	(2, 'e98c8807-eb6a-4fc0-88a9-35b5628f2ce1', 2),
	(3, 'fd8079d4-801e-46b8-ade7-4afca1d8a29d', 3),
	(4, '0b234cc6-80f0-4c6c-8b55-9b0efeb78d13', 10),
	(5, 'e68e73a6-ecd2-4cf7-9858-95f58be28655', NULL);

CREATE TABLE IF NOT EXISTS
	inventory_staff_1nf
	(
	inventory_number VARCHAR(100) NOT NULL PRIMARY KEY REFERENCES inventory,
	staff_ids BIGINT[]
	);

INSERT
INTO	inventory_staff_1nf (inventory_number, staff_ids)
SELECT	inventory_number, ARRAY_AGG(staff_id ORDER BY staff_id)
FROM	staff_inventory
GROUP BY
	inventory_number;

CREATE TABLE IF NOT EXISTS
	staff_inventory_2nf
	(
	staff_id BIGINT NOT NULL REFERENCES staff,
	inventory_number VARCHAR(100) NOT NULL REFERENCES inventory,
	staff_reports_to BIGINT REFERENCES staff
	);

INSERT
INTO	staff_inventory_2nf (staff_id, inventory_number, staff_reports_to)
SELECT	staff_id, inventory_number, reports_to
FROM	staff_inventory
JOIN	staff
USING	(staff_id);

CREATE TABLE IF NOT EXISTS
	shift
	(
	shift_id BIGSERIAL NOT NULL PRIMARY KEY,
	shift_start TIMESTAMP NOT NULL,
	shift_end TIMESTAMP NOT NULL,
	CONSTRAINT
		ex_shift_start_end
	EXCLUDE USING GIST (TSRANGE(shift_start, shift_end) WITH &&)
	);

TRUNCATE TABLE shift;

INSERT
INTO	shift (shift_id, shift_start, shift_end)
SELECT	d + 1,
	start_date + '1 days'::INTERVAL * d + '6 hours'::INTERVAL,
	start_date + '1 days'::INTERVAL * d + '22 hours'::INTERVAL
FROM	(
	VALUES ('2020-01-01'::DATE, '2022-01-01'::DATE)
	) AS dates (start_date, end_date)
CROSS JOIN LATERAL
	GENERATE_SERIES(0, end_date - start_date) AS d;

SELECT  SETVAL('shift_shift_id_seq', COUNT(*))
FROM    shift;

CREATE TABLE IF NOT EXISTS
	shift_staff
	(
	shift_id BIGINT NOT NULL REFERENCES shift,
	staff_id BIGINT NOT NULL REFERENCES staff,
	PRIMARY KEY
		(shift_id, staff_id)
	);

CREATE INDEX IF NOT EXISTS
	ix_shift_staff_staff_id
ON	shift_staff (staff_id);

TRUNCATE TABLE shift_staff;

SELECT	SETSEED(0.20210203);

WITH	supervisors AS
	(
	SELECT	staff_id,
		ROW_NUMBER() OVER (ORDER BY staff_id) AS rn,
		COUNT(*) OVER () AS cnt
	FROM	staff
	WHERE	title = 'Supervisor'
	),
	janitors AS
	(
	SELECT	staff_id, reports_to,
		ROW_NUMBER() OVER (PARTITION BY reports_to ORDER BY staff_id) AS rn,
		COUNT(*) OVER (PARTITION BY reports_to) AS cnt
	FROM	staff
	WHERE	title = 'Janitor'
	)
INSERT
INTO	shift_staff (shift_id, staff_id)
SELECT	shift_id, shift_staff.staff_id
FROM	(
	SELECT	*,
		RANDOM() AS rnd_supervisor,
		RANDOM() AS rnd_janitor
	FROM	shift
	) shift
CROSS JOIN LATERAL
	(
	SELECT	staff_id
	FROM	supervisors
	WHERE	rn = TRUNC(rnd_supervisor * cnt)::INT + 1
	) shift_supervisor
CROSS JOIN LATERAL
	(
	SELECT	shift_supervisor.staff_id
	UNION ALL
	SELECT	staff_id
	FROM	janitors
	WHERE	reports_to = shift_supervisor.staff_id
		AND rn <> TRUNC(rnd_janitor * cnt)::INT + 1
	) shift_staff;

CREATE TABLE IF NOT EXISTS
	parking_spot
	(
	id INT NOT NULL PRIMARY KEY,
	color TEXT NOT NULL
	);

TRUNCATE TABLE parking_spot;

INSERT
INTO	parking_spot (id, color)
VALUES	(1, 'green'),
	(2, 'blue');

INSERT
INTO	inventory_service_stats (inventory_number, job_count)
SELECT	inventory_number, COUNT(*) AS job_count
FROM	service
GROUP BY
	inventory_number;

CREATE OR REPLACE FUNCTION
	fn_service_inventory_service_stats_insert()
RETURNS TRIGGER
AS
$$
BEGIN
	WITH	new_values AS
		(
		SELECT	inventory_number, SUM(job_count_diff) AS job_count_diff
		FROM	(
			SELECT	inventory_number, 1 AS job_count_diff
			FROM	inserted
			) q
		GROUP BY
			inventory_number
		),
		old_values AS
		(
		SELECT	inventory_number, job_count
		FROM	new_values
		JOIN	inventory_service_stats
		USING	(inventory_number)
		),
		diff AS
		(
		SELECT	inventory_number, job_count_diff,
			COALESCE(old_values.job_count, 0) + job_count_diff <> 0 AS is_new,
			old_values IS NOT NULL AS is_old
		FROM	new_values
		LEFT JOIN
			old_values
		USING	(inventory_number)
		),
		do_insert AS
		(
		INSERT
		INTO	inventory_service_stats
		SELECT	inventory_number, job_count_diff
		FROM	diff
		WHERE	is_new
			AND NOT is_old
		),
		do_update AS
		(
		UPDATE	inventory_service_stats AS target
		SET	job_count = job_count + job_count_diff
		FROM	diff
		WHERE	diff.inventory_number = target.inventory_number
			AND is_new
			AND is_old
		)
	DELETE
	FROM	inventory_service_stats AS target
	USING	diff
	WHERE	diff.inventory_number = target.inventory_number
		AND NOT is_new
		AND is_old;

	RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION
	fn_service_inventory_service_stats_update()
RETURNS TRIGGER
AS
$$
BEGIN
	WITH	new_values AS
		(
		SELECT	inventory_number, SUM(job_count_diff) AS job_count_diff
		FROM	(
			SELECT	inventory_number, 1 AS job_count_diff
			FROM	inserted
			UNION ALL
			SELECT	inventory_number, -1 AS job_count_diff
			FROM	deleted
			) q
		GROUP BY
			inventory_number
		),
		old_values AS
		(
		SELECT	inventory_number, job_count
		FROM	new_values
		JOIN	inventory_service_stats
		USING	(inventory_number)
		),
		diff AS
		(
		SELECT	inventory_number, job_count_diff,
			COALESCE(old_values.job_count, 0) + job_count_diff <> 0 AS is_new,
			old_values IS NOT NULL AS is_old
		FROM	new_values
		LEFT JOIN
			old_values
		USING	(inventory_number)
		),
		do_insert AS
		(
		INSERT
		INTO	inventory_service_stats
		SELECT	inventory_number, job_count_diff
		FROM	diff
		WHERE	is_new
			AND NOT is_old
		),
		do_update AS
		(
		UPDATE	inventory_service_stats AS target
		SET	job_count = job_count + job_count_diff
		FROM	diff
		WHERE	diff.inventory_number = target.inventory_number
			AND is_new
			AND is_old
		)
	DELETE
	FROM	inventory_service_stats AS target
	USING	diff
	WHERE	diff.inventory_number = target.inventory_number
		AND NOT is_new
		AND is_old;

	RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION
	fn_service_inventory_service_stats_delete()
RETURNS TRIGGER
AS
$$
BEGIN
	WITH	new_values AS
		(
		SELECT	inventory_number, SUM(job_count_diff) AS job_count_diff
		FROM	(
			SELECT	inventory_number, -1 AS job_count_diff
			FROM	deleted
			) q
		GROUP BY
			inventory_number
		),
		old_values AS
		(
		SELECT	inventory_number, job_count
		FROM	new_values
		JOIN	inventory_service_stats
		USING	(inventory_number)
		),
		diff AS
		(
		SELECT	inventory_number, job_count_diff,
			COALESCE(old_values.job_count, 0) + job_count_diff <> 0 AS is_new,
			old_values IS NOT NULL AS is_old
		FROM	new_values
		LEFT JOIN
			old_values
		USING	(inventory_number)
		),
		do_insert AS
		(
		INSERT
		INTO	inventory_service_stats
		SELECT	inventory_number, job_count_diff
		FROM	diff
		WHERE	is_new
			AND NOT is_old
		),
		do_update AS
		(
		UPDATE	inventory_service_stats AS target
		SET	job_count = job_count + job_count_diff
		FROM	diff
		WHERE	diff.inventory_number = target.inventory_number
			AND is_new
			AND is_old
		)
	DELETE
	FROM	inventory_service_stats AS target
	USING	diff
	WHERE	diff.inventory_number = target.inventory_number
		AND NOT is_new
		AND is_old;

	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS
	trigger_service_inventory_service_stats_insert
ON	service;

CREATE TRIGGER
	trigger_service_inventory_service_stats_insert
AFTER	INSERT
ON	service
REFERENCING NEW TABLE AS inserted
FOR EACH STATEMENT
EXECUTE FUNCTION fn_service_inventory_service_stats_insert();

DROP TRIGGER IF EXISTS
	trigger_service_inventory_service_stats_update
ON	service;

CREATE TRIGGER
	trigger_service_inventory_service_stats_update
AFTER	UPDATE
ON	service
REFERENCING OLD TABLE AS deleted NEW TABLE AS inserted
FOR EACH STATEMENT
EXECUTE FUNCTION fn_service_inventory_service_stats_update();

DROP TRIGGER IF EXISTS
	trigger_service_inventory_service_stats_delete
ON	service;

CREATE TRIGGER
	trigger_service_inventory_service_stats_delete
AFTER	DELETE
ON	service
REFERENCING OLD TABLE AS deleted
FOR EACH STATEMENT
EXECUTE FUNCTION fn_service_inventory_service_stats_delete();

CREATE MATERIALIZED VIEW IF NOT EXISTS
	mv_inventory_service_stats
AS
SELECT	inventory_number, COUNT(*) AS job_count
FROM	service
GROUP BY
	inventory_number;

CREATE UNIQUE INDEX IF NOT EXISTS
	ux_mb_inventory_service_stats
ON	mv_inventory_service_stats (inventory_number);

CREATE OR REPLACE FUNCTION
        fn_create_shift
        (
        p_shift_start TIMESTAMP,
        p_shift_end TIMESTAMP,
        p_staff BIGINT[]
        )
RETURNS BIGINT
AS
$$
DECLARE
        v_shift_id BIGINT;
BEGIN
        ASSERT ARRAY_LENGTH(p_staff, 1) > 0, 'p_staff should not be empty';


        INSERT
        INTO    shift (shift_start, shift_end)
        VALUES  (p_shift_start, p_shift_end)
        RETURNING
                shift_id
        INTO    v_shift_id;

        INSERT
        INTO    shift_staff (shift_id, staff_id)
        SELECT  v_shift_id, staff_id
        FROM    UNNEST(p_staff) AS staff_id;

        RETURN  v_shift_id;
END;
$$
LANGUAGE plpgsql;
