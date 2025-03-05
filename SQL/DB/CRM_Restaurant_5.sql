CREATE VIEW order_summary AS
SELECT
    client_orders.order_number,
    staff.fullname_staff,
    clients.name_client,
    system_statuses.status_name_ru AS system_status,
    paid_statuses.status_name_ru AS paid_status,
    work_statuses.status_name_ru AS work_status,
    promocodes.discount,
    COALESCE(
        SUM(
            order_positions.count_dish * order_positions.price
        ),
        0
    ) AS total_price,
    COALESCE(
        SUM(
            order_positions.count_dish * order_positions.price
        ),
        0
    ) * (100 - COALESCE(promocodes.discount, 0)) / 100 AS total_price_with_discount
FROM
    client_orders
    JOIN staff_shift ON client_orders.id_staffshift = staff_shift.id_staffshift
    JOIN staff ON staff_shift.id_staff = staff.id_staff
    JOIN clients ON client_orders.id_client = clients.id_client
    JOIN system_statuses ON client_orders.system_status = system_statuses.status_number
    JOIN paid_statuses ON client_orders.paid_status = paid_statuses.status_number
    JOIN work_statuses ON client_orders.work_status = work_statuses.status_number
    LEFT JOIN promocodes ON client_orders.id_promocode = promocodes.id_promocode
    LEFT JOIN order_positions ON client_orders.order_number = order_positions.order_number
GROUP BY
    client_orders.order_number,
    staff.fullname_staff,
    clients.name_client,
    system_statuses.status_name_ru,
    paid_statuses.status_name_ru,
    work_statuses.status_name_ru,
    promocodes.discount
ORDER BY
    client_orders.order_number;

CREATE VIEW staff_orders_summary AS
SELECT
    staff_shift.id_staffshift,
    staff_shift.id_staff,
    staff.fullname_staff,
    (
        SELECT
            COUNT(*)
        FROM
            client_orders
        WHERE
            client_orders.id_staffshift = staff_shift.id_staffshift
    ) AS order_count,
    staff_shift.open_datetime,
    staff_shift.close_datetime
FROM
    staff_shift
    JOIN staff ON staff_shift.id_staff = staff.id_staff
GROUP BY
    staff_shift.id_staffshift,
    staff_shift.id_staff,
    staff.fullname_staff,
    staff_shift.open_datetime,
    staff_shift.close_datetime
ORDER BY
    staff_shift.id_staffshift;