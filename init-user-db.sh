#!/usr/bin/env bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOF
CREATE USER elsie WITH ENCRYPTED PASSWORD 'elsie';
CREATE DATABASE basic WITH OWNER elsie;
CREATE DATABASE advanced WITH OWNER elsie;
EOF

psql -v ON_ERROR_STOP=1 --username elsie --dbname basic -f /scripts/basic/populate.sql
psql -v ON_ERROR_STOP=1 --username elsie --dbname advanced -f /scripts/advanced/populate.sql
