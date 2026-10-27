SELECT version();

SELECT current_database(), current_user, current_timestamp;

CREATE SCHEMA IF NOT EXISTS lr8_check;

CREATE TABLE IF NOT EXISTS lr8_check.connection_test (
    id SERIAL PRIMARY KEY,
    checked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    message TEXT NOT NULL
);

INSERT INTO lr8_check.connection_test (message)
VALUES ('LR8 connection OK');

SELECT id, checked_at, message
FROM lr8_check.connection_test
ORDER BY id DESC
LIMIT 1;
