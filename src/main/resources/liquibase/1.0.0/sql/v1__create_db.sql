create schema if not exists shop;

-- Создание таблицы Authors
CREATE TABLE Author
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Создание таблицы Genres
CREATE TABLE Genre
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Создание таблицы Books
CREATE TABLE Book
(
    id           SERIAL PRIMARY KEY,
    title        VARCHAR(255)   NOT NULL,
    genre_id     INT REFERENCES Genre (id),
    author_id    INT REFERENCES Author (id),
    price        DECIMAL(10, 2) NOT NULL,
    sale         INT            NOT NULL default 0,
    isBestseller boolean        NOT NULL default false,
    isNew        boolean        NOT NULL default false,
    image_path   varchar(255),
    CHECK (sale >= 0 and sale <= 100)
);

Create table Book_author
(
    book_id   INT REFERENCES Book (id),
    author_id INT REFERENCES Author (id),
    UNIQUE (book_id, author_id)
);

-- Создание таблицы Customers
CREATE TABLE Customer
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(255)        NOT NULL,
    email    VARCHAR(255) UNIQUE NOT NULL,
    phone    VARCHAR(20) UNIQUE,
    login    VARCHAR(50) UNIQUE,
    password VARCHAR(50)         NOT NULL
);

-- Создание таблицы Orders
CREATE TABLE Orders
(
    id          SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer (id) NOT NULL,
    order_date  DATE                         NOT NULL DEFAULT now(),
    total_price DECIMAL(10, 2)               NOT NULL
);

-- Создание таблицы Order_Status
CREATE TABLE Order_status
(
    id          varchar(15) PRIMARY KEY,
    description varchar(50) not null
);

-- Создание таблицы Order_Status
CREATE TABLE Order_status_history
(
    order_id INT REFERENCES Orders (id)               NOT NULL,
    status   varchar(15) REFERENCES Order_status (id) NOT NULL,
    end_date DATE                                     NOT NULL,
    UNIQUE (order_id, status, end_date)
);

-- Создание таблицы Order_Details
CREATE TABLE Order_Details
(
    order_id INT REFERENCES Orders (id),
    book_id  INT REFERENCES Book (id),
    quantity INT NOT NULL DEFAULT 1,
    CHECK (quantity > 0),
    UNIQUE (order_id, book_id)
);

-- Создание таблицы Stock
CREATE TABLE Stock
(
    id                SERIAL PRIMARY KEY,
    book_id           INT REFERENCES Book (id),
    quantity_in_stock INT NOT NULL DEFAULT 0,
    reserved_quantity INT NOT NULL DEFAULT 0,
    CHECK (quantity_in_stock >= 0),
    CHECK (reserved_quantity >= 0 and reserved_quantity <= quantity_in_stock)
);

-- Создание таблицы Reviews
CREATE TABLE Review
(
    id          SERIAL PRIMARY KEY,
    book_id     INT REFERENCES Book (id),
    customer_id INT REFERENCES Customer (id),
    rating      INT CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT
);
