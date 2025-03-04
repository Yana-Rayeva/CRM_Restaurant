ALTER TABLE
    dishes
ADD
    COLUMN dish_cooking_time INTEGER;

UPDATE
    dishes
SET
    dish_cooking_time = CAST(
        REGEXP_REPLACE(cooking_time, '[^0-9]', '', 'g') AS INTEGER
    );

ALTER TABLE
    dishes DROP COLUMN cooking_time;

ALTER TABLE
    dishes RENAME COLUMN dish_cooking_time TO cooking_time;

ALTER TABLE
    price_list
ADD
    COLUMN id_dish INTEGER;

UPDATE
    price_list
SET
    id_dish = (
        SELECT
            id_dish
        FROM
            dishes
        WHERE
            dishes.id_price = price_list.id_price
    );

ALTER TABLE
    dishes DROP COLUMN id_price;

ALTER TABLE
    order_positions DROP COLUMN discount;

ALTER TABLE
    order_positions
ADD
    COLUMN status_of_position INTEGER;

UPDATE
    order_positions
SET
    status_of_position = CASE
        WHEN status_position = 'Создано' THEN 1
        WHEN status_position = 'Приготовление' THEN 2
        WHEN status_position = 'Выдан' THEN 3
        WHEN status_position = 'Отменён' THEN 4
        ELSE NULL
    END;

ALTER TABLE
    order_positions DROP COLUMN status_position;

ALTER TABLE
    order_positions RENAME COLUMN status_of_position TO status_position;

ALTER TABLE
    client_orders
ADD
    COLUMN status_of_order INTEGER;

UPDATE
    client_orders
SET
    status_of_order = CASE
        WHEN status_order = 'Создан' THEN 1
        WHEN status_order = 'Выполняется' THEN 2
        WHEN status_order = 'Завершён' THEN 3
        WHEN status_order = 'Отменён' THEN 4
        ELSE NULL
    END;

ALTER TABLE
    client_orders DROP COLUMN status_order;

ALTER TABLE
    client_orders RENAME COLUMN status_of_order TO status_order;

