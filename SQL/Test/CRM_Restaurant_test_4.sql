WITH generated_orders AS (
    SELECT 
        (floor(random() * 10) + 1)::INTEGER AS id_staffshift,
        (floor(random() * 5) + 1)::INTEGER AS id_client,
        (floor(random() * 7) + 1)::INTEGER AS id_table,
        (floor(random() * 6))::INTEGER AS id_promocode,
        (TIMESTAMP '2023-01-01 00:00:00' + 
        (floor(random() * (EXTRACT(EPOCH FROM TIMESTAMP '2025-12-31 23:59:59') - 
         EXTRACT(EPOCH FROM TIMESTAMP '2023-01-01 00:00:00'))) * INTERVAL '1 second')) AS open_datetime,
        (ARRAY[100, 110, 120])[floor(random() * 3 + 1)] AS system_status,
        (ARRAY[210, 220, 230, 240, 250, 260, 270, 280, 290, 291])[floor(random() * 10 + 1)] AS work_status,
        (ARRAY[300, 310, 320, 330, 340, 350, 360])[floor(random() * 7 + 1)] AS paid_status
    FROM generate_series(1, 10000) AS s
)

INSERT INTO client_orders (id_staffshift, id_client, id_table, id_promocode, open_datetime, close_datetime, 
order_number, system_status, work_status, paid_status)
SELECT 
    id_staffshift,
    id_client,
    id_table,
    id_promocode,
    open_datetime,
    (open_datetime + (INTERVAL '10 minutes' + (floor(random() * (240 - 10 + 1)) * INTERVAL '1 minute')) + 
    (floor(random() * 240) * INTERVAL '1 minute')) AS close_datetime,
    (id_client::TEXT || '-' || (floor(random() * (10000 - 1000 + 1)) + 1000)::TEXT) AS order_number,
    system_status,
    work_status,
    paid_status
FROM generated_orders;


INSERT INTO order_positions (id_dish, count_dish, price, order_number, start_time, system_status, work_status, paid_status)
SELECT 
    floor(random() * 16 + 1)::INTEGER AS id_dish,
    floor(random() * 10 + 1)::INTEGER AS count_dish,
    floor(random() * (1500 - 100 + 1) + 100)::INTEGER / 10 * 10 AS price, order_number,
    open_datetime + (floor(random() * EXTRACT(EPOCH FROM (close_datetime - open_datetime))) * INTERVAL '1 second') AS start_time,
    (ARRAY[100, 110, 120])[floor(random() * 3 + 1)] AS system_status,
    (ARRAY[500, 510, 520, 530, 540, 550, 560, 570])[floor(random() * 8 + 1)] AS work_status,
    (ARRAY[400, 410, 420, 430, 440, 450])[floor(random() * 6 + 1)] AS paid_status
FROM (
    SELECT 
        order_number,
        open_datetime,
        close_datetime
    FROM client_orders
    ORDER BY random()
    LIMIT 10000
) AS random_orders;

INSERT INTO clients (id_client, name_client, phone_number, day_of_birth) VALUES
    (11, 'John Doe', '89999999999', '1990-01-01'),
    (12, 'Jane Smith', '88888888888', '1985-05-15'),
    (13, 'Mike Johnson', '87777777777', '1995-12-31');

INSERT INTO client_orders (id_order, id_staffshift, id_client, id_table, id_promocode, open_datetime, close_datetime, 
order_number, system_status, work_status, paid_status) VALUES
    (1, 10, 11, 1, 0, '2023-10-02 12:00:00', '2023-10-02 13:00:00', '11-1', 100, 280, 340),
    (2, 10, 11, 1, 0, '2023-10-02 12:00:00', '2023-10-02 13:00:00', '11-2', 100, 290, 360),
    (3, 10, 12, 1, 0, '2023-10-02 12:00:00', '2023-10-02 13:00:00', '12-1', 100, 220, 310),
    (4, 10, 12, 1, 0, '2023-10-02 12:00:00', '2023-10-02 13:00:00', '12-2', 100, 230, 320),
    (5, 10, 13, 1, 0, '2023-10-02 12:00:00', '2023-10-02 13:00:00', '13-1', 100, 260, 330),
    (6, 10, 13, 1, 0, '2023-10-02 12:00:00', '2023-10-02 13:00:00', '13-2', 100, 280, 340);

INSERT INTO order_positions (id_position, id_dish, count_dish, price, start_time, order_number, system_status, work_status, paid_status) VALUES
    (1, 10, 1, 200, '2023-10-02 12:00:00', '11-1', 0, 540, 430),
    (2, 12, 5, 250, '2023-10-02 12:00:00', '11-2', 0, 540, 430),
    (3, 11, 6, 300, '2023-10-02 12:00:00', '12-1', 0, 540, 430),
    (4, 13, 3, 350, '2023-10-02 12:00:00', '12-2', 0, 540, 430),
    (5, 14, 2, 400, '2023-10-02 12:00:00', '13-1', 0, 540, 430),
    (6, 15, 4, 450, '2023-10-02 12:00:00', '13-2', 0, 540, 430);