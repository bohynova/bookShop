-- Создание основной таблицы 'user'
CREATE TABLE users
(
    username VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

-- Создание таблицы-лога 'user_log'
CREATE TABLE users_log
(
    username    VARCHAR(255) NOT NULL,
    password    VARCHAR(255) NOT NULL,
    change_type VARCHAR(50)  NOT NULL,
    change_date TIMESTAMP DEFAULT NOW(),
    UNIQUE (username, change_type, change_date)
);

CREATE OR REPLACE FUNCTION users_log_trigger()
    RETURNS TRIGGER AS '
    BEGIN
        IF TG_OP = ''INSERT'' THEN
            INSERT INTO users_log (username, password, change_type) VALUES (NEW.username, NEW.password, ''CREATE'');
        ELSIF TG_OP = ''UPDATE'' THEN
            INSERT INTO users_log (username, password, change_type) VALUES (NEW.username, NEW.password, ''UPDATE'');
        ELSIF TG_OP = ''DELETE'' THEN
            INSERT INTO users_log (username, password, change_type) VALUES (OLD.username, OLD.password, ''DELETE'');
        END IF;
        RETURN NULL;
    END;
' LANGUAGE plpgsql;

CREATE TRIGGER users_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON users_log
    FOR EACH ROW
EXECUTE FUNCTION users_log_trigger();