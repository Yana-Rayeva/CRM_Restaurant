ALTER TABLE
    client_orders
ADD
    COLUMN order_number CHARACTER VARYING(30);

WITH NumberedOrders AS (
    SELECT
        id_client,
        id_order,
        ROW_NUMBER() OVER (
            PARTITION BY id_client
            ORDER BY
                id_order
        ) AS order_sequence
    FROM
        client_orders
)
UPDATE
    client_orders
SET
    order_number = client_orders.id_client || '-' || order_sequence
FROM
    NumberedOrders
WHERE
    client_orders.id_order = NumberedOrders.id_order;

ALTER TABLE
    order_positions
ADD
    COLUMN order_number CHARACTER VARYING(30);

UPDATE
    order_positions
SET
    order_number = (
        SELECT
            order_number
        FROM
            client_orders
        WHERE
            order_positions.id_order = client_orders.id_order
    );

ALTER TABLE
    order_positions DROP COLUMN id_order;

create table System_statuses (
    id_status SERIAL PRIMARY KEY,
    status_number INTEGER,
    status_type CHARACTER VARYING(20),
    status_category CHARACTER VARYING(20),
    status_name_ru CHARACTER VARYING(20),
    status_information CHARACTER VARYING(200)
);

create table Paid_statuses (
    id_status SERIAL PRIMARY KEY,
    status_number INTEGER,
    status_category CHARACTER VARYING(20),
    paid_sign INTEGER,
    status_name_ru CHARACTER VARYING(20),
    status_information CHARACTER VARYING(200)
);

create table Work_statuses (
    id_status SERIAL PRIMARY KEY,
    status_number INTEGER,
    status_category CHARACTER VARYING(20),
    work_sign INTEGER,
    status_name_ru CHARACTER VARYING(20),
    status_information CHARACTER VARYING(200)
);

create table Shift_statuses (
    id_status SERIAL PRIMARY KEY,
    status_number INTEGER,
    status_category CHARACTER VARYING(20),
    shift_sign INTEGER,
    status_name_ru CHARACTER VARYING(20),
    status_information CHARACTER VARYING(200)
);


