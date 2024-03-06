CREATE OR REPLACE PROCEDURE set_sale_for_genre(IN genre_name VARCHAR(255), IN sale_value INT)
    LANGUAGE plpgsql
AS '
    BEGIN
        UPDATE book
        SET sale = sale_value
        WHERE genre_id = (SELECT id FROM genre WHERE name = genre_name);
    END;
';

CREATE OR REPLACE FUNCTION avg_rating_for_book(IN bookid INT)
    RETURNS DECIMAL(3, 2)
    LANGUAGE plpgsql
AS '
    DECLARE
        total_rating INT;
        total_reviews INT;
    BEGIN
        SELECT SUM(rating), COUNT(*)
        INTO total_rating, total_reviews
        FROM review
        WHERE book_id = bookid;

        IF total_reviews = 0 THEN
            RETURN NULL;
        ELSE
            RETURN total_rating::DECIMAL / total_reviews;
        END IF;
    END;
';

CREATE OR REPLACE FUNCTION calculate_order_total(IN orderid INT)
    RETURNS DECIMAL(10, 2)
    LANGUAGE plpgsql
AS '
    DECLARE
        order_total DECIMAL(10, 2);
    BEGIN
        SELECT SUM(b.price * od.quantity)
        INTO order_total
        FROM order_details od
                 JOIN book b ON od.book_id = b.id
        WHERE od.order_id = orderid;

        RETURN order_total;
    END;
';

CREATE OR REPLACE PROCEDURE update_order_status(IN o_id INT, IN new_status VARCHAR(15))
    LANGUAGE plpgsql
AS '
    BEGIN
        update order_status_history set end_date = CURRENT_DATE
        where order_id = o_id and end_date = null;

        INSERT INTO order_status_history (order_id, status, end_date)
        VALUES (o_id, new_status, null);
    END;
';

CREATE OR REPLACE PROCEDURE add_to_stock(IN b_id INT, IN quantity_added INT)
    LANGUAGE plpgsql
AS '
BEGIN
    UPDATE stock
    SET quantity_in_stock = quantity_in_stock + quantity_added
    WHERE book_id = book_id;
END;
';

CREATE OR REPLACE FUNCTION get_available_quantity(IN b_id INT)
    RETURNS INT
    LANGUAGE plpgsql
AS '
DECLARE
    total_quantity INT;
BEGIN
    SELECT (quantity_in_stock - reserved_quantity)
    INTO total_quantity
    FROM shop.stock
    WHERE book_id = b_id;

    RETURN total_quantity;
END;
';

CREATE OR REPLACE PROCEDURE delete_review_by_id(IN review_id INT)
    LANGUAGE plpgsql
AS '
BEGIN
    DELETE FROM shop.review
    WHERE id = review_id;
END;
';

CREATE OR REPLACE PROCEDURE reserve_stock(IN b_id INT, IN quantity_reserved INT)
    LANGUAGE plpgsql
AS '
DECLARE
    available_quantity INT;
BEGIN
    -- Получаем доступное количество товара в stock
    SELECT (quantity_in_stock - reserved_quantity)
    INTO available_quantity
    FROM shop.stock
    WHERE book_id = b_id;

    IF quantity_reserved <= available_quantity THEN
        -- Обновляем reserved_quantity
        UPDATE shop.stock
        SET reserved_quantity = reserved_quantity + quantity_reserved
        WHERE book_id = b_id;
    ELSE
        RAISE EXCEPTION ''Недостаточно товара на складе для резервирования'';
    END IF;
END;
';

CREATE OR REPLACE PROCEDURE set_order_paid(IN order_id INT)
    LANGUAGE plpgsql
AS '
BEGIN
    call update_order_status(order_id, ''Paid'');
END;
';

