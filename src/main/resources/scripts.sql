-- Создание таблицы Authors
CREATE TABLE Author (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Создание таблицы Genres
CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Создание таблицы Books
CREATE TABLE Book (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT REFERENCES Author(id),
    genre_id INT REFERENCES Genre(id),
    price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    reserved_quantity INT NOT NULL DEFAULT 0,
    UNIQUE(title, author_id)
);

-- Создание таблицы Customers
CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE
);

-- Создание таблицы Orders
CREATE TABLE Order (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer(id),
    order_date DATE NOT NULL DEFAULT now(),
    total_price DECIMAL(10, 2) NOT NULL.
    status varchar(15) not null REFERENCES Order_status(id)
);

-- Создание таблицы Order_Details
CREATE TABLE Order_status (
    id varchar(15) PRIMARY KEY,
    description varchar(50) not null
)

-- Создание таблицы Order_Details
CREATE TABLE Order_Details (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Order(id),
    book_id INT REFERENCES Book(id),
    quantity INT NOT NULL DEFAULT 0,
    CHECK (quantity > 0)
);

-- Создание таблицы Employees
CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL
);

-- Создание таблицы Suppliers
CREATE TABLE Supplier (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone VARCHAR(20) UNIQUE
);

-- Создание таблицы Stock
CREATE TABLE Stock (
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(id),
    quantity_in_stock INT NOT NULL,
    CHECK (quantity_in_stock >= 0)
);

-- Создание таблицы Reviews
CREATE TABLE Review (
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Book(id),
    customer_id INT REFERENCES Customer(id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT
);
