alter table author_log
    drop constraint author_log_author_id_fkey;

alter table author_log
    drop constraint author_log_pkey;

alter table author_log
    drop column id;

alter table author_log
    add constraint author_log_pk
        unique (author_id, name, change_date, change_type);


alter table customer_log
    drop constraint customer_log_pkey;

create unique index customer_log_pkey
    on customer_log (customer_id, change_type, change_date);

drop index customer_log_pkey;

alter table customer_log
    drop column id;

alter table customer_log
    drop constraint customer_log_customer_id_fkey;


alter table genre_log
    drop constraint genre_log_pkey;

alter table genre_log
    drop constraint genre_log_genre_id_fkey;

alter table genre_log
    drop column id;

alter table genre_log
    add constraint genre_log_pk
        unique (genre_id, change_date, change_type);


alter table order_details_log
    add constraint order_details_log_pk
        unique (order_id, book_id, change_type, change_date);


alter table order_status_history_log
    add constraint order_status_history_log_pk
        unique (order_id, status_id, change_type, change_date);

alter table order_status_history_log
    drop constraint order_status_history_log_order_id_fkey;


alter table order_status_log
    drop constraint order_status_log_pkey;

alter table order_status_log
    drop column id;

alter table order_status_log
    add constraint order_status_log_pk
        unique (order_id, status_id, change_type, change_date);

alter table order_status_log
    drop constraint order_status_log_order_id_fkey;



alter table orders_log
    drop constraint orders_log_pkey;

alter table orders_log
    drop column id;

alter table orders_log
    add constraint orders_log_pk
        unique (order_id, change_date, change_type);

alter table orders_log
    drop constraint orders_log_order_id_fkey;


alter table review_log
    drop constraint review_log_pkey;

alter table review_log
    drop column id;

alter table review_log
    add constraint review_log_pk
        unique (book_id, change_type, change_date);

alter table review_log
    drop constraint review_log_book_id_fkey;

alter table review_log
    drop constraint review_log_customer_id_fkey;



alter table stock_log
    drop constraint stock_log_pkey;

alter table stock_log
    drop column id;

alter table stock_log
    add constraint stock_log_pk
        unique (book_id, change_date, change_type);

alter table stock_log
    drop constraint stock_log_book_id_fkey;


alter table book_log
    drop constraint book_log_pkey;

alter table book_log
    drop column id;

alter table book_log
    add constraint book_log_pk
        unique (book_id, change_type, change_date);

alter table book_log
    drop constraint book_log_book_id_fkey;

drop sequence if exists genre_log_id_seq;

drop sequence if exists book_log_id_seq;

drop sequence if exists customer_log_id_seq;

drop sequence if exists orders_log_id_seq;

drop sequence if exists order_status_log_id_seq;

drop sequence if exists stock_log_id_seq;

drop sequence if exists review_log_id_seq;

