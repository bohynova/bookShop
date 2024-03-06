CREATE TYPE change_type AS ENUM ('CREATE', 'UPDATE', 'DELETE');

CREATE TABLE Author_log
(
    id          SERIAL PRIMARY KEY,
    author_id   INT REFERENCES Author (id),
    name        VARCHAR(255),
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION author_log_trigger()
    RETURNS TRIGGER AS '
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Author_log (author_id, name, change_type) VALUES (NEW.id, NEW.name, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Author_log (author_id, name, change_type) VALUES (NEW.id, NEW.name, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Author_log (author_id, name, change_type) VALUES (OLD.id, OLD.name, ''DELETE'');
    END IF;
RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER author_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Author
    FOR EACH ROW
EXECUTE FUNCTION author_log_trigger();

-- Таблицы-логи для Genres
CREATE TABLE Genre_log
(
    id          SERIAL PRIMARY KEY,
    genre_id    INT REFERENCES Genre (id),
    name        VARCHAR(255),
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Genres
CREATE OR REPLACE FUNCTION genre_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Genre_log (genre_id, name, change_type) VALUES (NEW.id, NEW.name, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Genre_log (genre_id, name, change_type) VALUES (NEW.id, NEW.name, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Genre_log (genre_id, name, change_type) VALUES (OLD.id, OLD.name, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER genre_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Genre
    FOR EACH ROW
EXECUTE FUNCTION genre_log_trigger();

-- Таблицы-логи для Books
CREATE TABLE Book_log
(
    id           SERIAL PRIMARY KEY,
    book_id      INT REFERENCES Book (id),
    title        VARCHAR(255),
    genre_id     INT,
    author_id    INT,
    price        DECIMAL(10, 2),
    sale         INT,
    isBestseller BOOLEAN,
    isNew        BOOLEAN,
    image_path   VARCHAR(255),
    change_type  change_type NOT NULL,
    change_date  TIMESTAMP DEFAULT NOW()
);

-- Триггер для Books
CREATE OR REPLACE FUNCTION book_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Book_log (book_id, title, genre_id, author_id, price, sale, isBestseller, isNew, image_path,
                              change_type)
        VALUES (NEW.id, NEW.title, NEW.genre_id, NEW.author_id, NEW.price, NEW.sale, NEW.isBestseller, NEW.isNew,
                NEW.image_path, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Book_log (book_id, title, genre_id, author_id, price, sale, isBestseller, isNew, image_path,
                              change_type)
        VALUES (NEW.id, NEW.title, NEW.genre_id, NEW.author_id, NEW.price, NEW.sale, NEW.isBestseller, NEW.isNew,
                NEW.image_path, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Book_log (book_id, title, genre_id, author_id, price, sale, isBestseller, isNew, image_path,
                              change_type)
        VALUES (OLD.id, OLD.title, OLD.genre_id, OLD.author_id, OLD.price, OLD.sale, OLD.isBestseller, OLD.isNew,
                OLD.image_path, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER book_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Book
    FOR EACH ROW
EXECUTE FUNCTION book_log_trigger();

-- Таблицы-логи для Book_author
CREATE TABLE Book_author_log
(
    book_id     INT,
    author_id   INT,
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Book_author
CREATE OR REPLACE FUNCTION book_author_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Book_author_log (book_id, author_id, change_type) VALUES (NEW.book_id, NEW.author_id, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Book_author_log (book_id, author_id, change_type) VALUES (NEW.book_id, NEW.author_id, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Book_author_log (book_id, author_id, change_type) VALUES (OLD.book_id, OLD.author_id, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER book_author_log_trigger
    AFTER INSERT OR DELETE
    ON Book_author
    FOR EACH ROW
EXECUTE FUNCTION book_author_log_trigger();

-- Таблицы-логи для Customers
CREATE TABLE Customer_log
(
    id          SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer (id),
    name        VARCHAR(255),
    email       VARCHAR(255),
    phone       VARCHAR(20),
    login       VARCHAR(50),
    password    VARCHAR(50),
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Customers
CREATE OR REPLACE FUNCTION customer_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Customer_log (customer_id, name, email, phone, login, password, change_type)
        VALUES (NEW.id, NEW.name, NEW.email, NEW.phone, NEW.login, NEW.password, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Customer_log (customer_id, name, email, phone, login, password, change_type)
        VALUES (NEW.id, NEW.name, NEW.email, NEW.phone, NEW.login, NEW.password, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Customer_log (customer_id, name, email, phone, login, password, change_type)
        VALUES (OLD.id, OLD.name, OLD.email, OLD.phone, OLD.login, OLD.password, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER customer_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Customer
    FOR EACH ROW
EXECUTE FUNCTION customer_log_trigger();

-- Таблицы-логи для Orders
CREATE TABLE Orders_log
(
    id          SERIAL PRIMARY KEY,
    order_id    INT REFERENCES Orders (id),
    customer_id INT,
    order_date  DATE,
    total_price DECIMAL(10, 2),
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Orders
CREATE OR REPLACE FUNCTION orders_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Orders_log (order_id, customer_id, order_date, total_price, change_type)
        VALUES (NEW.id, NEW.customer_id, NEW.order_date, NEW.total_price, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Orders_log (order_id, customer_id, order_date, total_price, change_type)
        VALUES (NEW.id, NEW.customer_id, NEW.order_date, NEW.total_price, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Orders_log (order_id, customer_id, order_date, total_price, change_type)
        VALUES (OLD.id, OLD.customer_id, OLD.order_date, OLD.total_price, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER orders_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Orders
    FOR EACH ROW
EXECUTE FUNCTION orders_log_trigger();

-- Таблицы-логи для Order_Status
CREATE TABLE Order_Status_log
(
    id          SERIAL PRIMARY KEY,
    order_id    INT REFERENCES Orders (id),
    status_id   VARCHAR(15),
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Order_Status
CREATE OR REPLACE FUNCTION order_status_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Order_Status_log (order_id, status_id, change_type) VALUES (NEW.id, NEW.status_id, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Order_Status_log (order_id, status_id, change_type) VALUES (NEW.id, NEW.status_id, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Order_Status_log (order_id, status_id, change_type) VALUES (OLD.id, OLD.status_id, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER order_status_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Order_Status
    FOR EACH ROW
EXECUTE FUNCTION order_status_log_trigger();

-- Таблицы-логи для Order_status_history
CREATE TABLE Order_status_history_log
(
    order_id    INT REFERENCES Orders (id),
    status_id   VARCHAR(15),
    end_date    DATE,
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Order_status_history
CREATE OR REPLACE FUNCTION order_status_history_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Order_status_history_log (order_id, status_id, end_date, change_type)
        VALUES (NEW.order_id, NEW.status_id, NEW.end_date, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Order_status_history_log (order_id, status_id, end_date, change_type)
        VALUES (NEW.order_id, NEW.status_id, NEW.end_date, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Order_status_history_log (order_id, status_id, end_date, change_type)
        VALUES (OLD.order_id, OLD.status_id, OLD.end_date, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER order_status_history_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Order_status_history
    FOR EACH ROW
EXECUTE FUNCTION order_status_history_log_trigger();

-- Таблицы-логи для Order_Details
CREATE TABLE Order_Details_log
(
    order_id    INT,
    book_id     INT,
    quantity    INT,
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Order_Details
CREATE OR REPLACE FUNCTION order_details_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Order_Details_log (order_id, book_id, quantity, change_type)
        VALUES (NEW.order_id, NEW.book_id, NEW.quantity, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Order_Details_log (order_id, book_id, quantity, change_type)
        VALUES (NEW.order_id, NEW.book_id, NEW.quantity, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Order_Details_log (order_id, book_id, quantity, change_type)
        VALUES (OLD.order_id, OLD.book_id, OLD.quantity, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER order_details_log_trigger
    AFTER INSERT OR DELETE
    ON Order_Details
    FOR EACH ROW
EXECUTE FUNCTION order_details_log_trigger();

-- Таблицы-логи для Stock
CREATE TABLE Stock_log
(
    id                SERIAL PRIMARY KEY,
    book_id           INT REFERENCES Book (id),
    quantity_in_stock INT,
    reserved_quantity INT,
    change_type       change_type NOT NULL,
    change_date       TIMESTAMP DEFAULT NOW()
);

-- Триггер для Stock
CREATE OR REPLACE FUNCTION stock_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Stock_log (book_id, quantity_in_stock, reserved_quantity, change_type)
        VALUES (NEW.id, NEW.quantity_in_stock, NEW.reserved_quantity, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Stock_log (book_id, quantity_in_stock, reserved_quantity, change_type)
        VALUES (NEW.id, NEW.quantity_in_stock, NEW.reserved_quantity, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Stock_log (book_id, quantity_in_stock, reserved_quantity, change_type)
        VALUES (OLD.id, OLD.quantity_in_stock, OLD.reserved_quantity, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER stock_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Stock
    FOR EACH ROW
EXECUTE FUNCTION stock_log_trigger();

-- Таблицы-логи для Reviews
CREATE TABLE Review_log
(
    id          SERIAL PRIMARY KEY,
    book_id     INT REFERENCES Book (id),
    customer_id INT REFERENCES Customer (id),
    rating      INT,
    comment     TEXT,
    change_type change_type NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Триггер для Reviews
CREATE OR REPLACE FUNCTION review_log_trigger()
    RETURNS TRIGGER AS
'
BEGIN
    IF TG_OP = ''INSERT'' THEN
        INSERT INTO Review_log (book_id, customer_id, rating, comment, change_type)
        VALUES (NEW.id, NEW.customer_id, NEW.rating, NEW.comment, ''CREATE'');
    ELSIF TG_OP = ''UPDATE'' THEN
        INSERT INTO Review_log (book_id, customer_id, rating, comment, change_type)
        VALUES (NEW.id, NEW.customer_id, NEW.rating, NEW.comment, ''UPDATE'');
    ELSIF TG_OP = ''DELETE'' THEN
        INSERT INTO Review_log (book_id, customer_id, rating, comment, change_type)
        VALUES (OLD.id, OLD.customer_id, OLD.rating, OLD.comment, ''DELETE'');
    END IF;
    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER review_log_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Review
    FOR EACH ROW
EXECUTE FUNCTION review_log_trigger();

