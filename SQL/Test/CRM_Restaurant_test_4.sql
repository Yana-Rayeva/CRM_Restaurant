INSERT INTO client_orders (id_staffshift, id_client, id_table, id_promocode, open_datetime, close_datetime, order_number, system_status, work_status, paid_status)
SELECT 
    (floor(random() * 10) + 1)::INTEGER AS id_staffshift,
    (floor(random() * 5) + 1)::INTEGER AS id_client,
    (floor(random() * 7) + 1)::INTEGER AS id_table,
    (floor(random() * 6))::INTEGER AS id_promocode,
    (TIMESTAMP '2023-01-01 00:00:01' + (random() * (TIMESTAMP '2025-12-31 23:59:59' - TIMESTAMP '2023-01-01 00:00:01'))) AS open_datetime,
    (TIMESTAMP '2023-01-01 00:00:01' + (random() * (TIMESTAMP '2025-12-31 23:59:59' - TIMESTAMP '2023-01-01 00:00:01' - INTERVAL '1 second'))) + INTERVAL '1 minute' AS close_datetime, 
    (floor(random() * (10000 - 100 + 1)) + 100)::TEXT || '-' || (floor(random() * 5) + 1)::TEXT AS order_number,
    (ARRAY[100, 110, 120])[floor(random() * 3 + 1)] AS system_status,
    (ARRAY[210, 220, 230, 240, 250, 260, 270, 280, 290, 291])[floor(random() * 10 + 1)] AS work_status,
    (ARRAY[300, 310, 320, 330, 340, 350, 360])[floor(random() * 7 + 1)] AS paid_status
FROM generate_series(1, 1000) AS s;


INSERT INTO order_positions (id_dish, count_dish, price, order_number, start_time, system_status, work_status, paid_status)
SELECT 
    floor(random() * 16 + 1)::INTEGER AS id_dish,
    floor(random() * 10 + 1)::INTEGER AS count_dish,
    floor(random() * (1500 - 100 + 1) + 100)::INTEGER AS price,
    (SELECT order_number FROM client_orders ORDER BY random() LIMIT 1) AS order_number, 
    (SELECT open_datetime + (random() * EXTRACT(EPOCH FROM (close_datetime - open_datetime))) * INTERVAL '1 second'
     FROM client_orders 
     WHERE order_number = (SELECT order_number FROM client_orders ORDER BY random() LIMIT 1)) AS start_time,  
    0 AS system_status,
    (ARRAY[500, 510, 520, 530, 540, 550, 560, 570])[floor(random() * 8 + 1)] AS work_status,
    (ARRAY[400, 410, 420, 430, 440, 450])[floor(random() * 6 + 1)] AS paid_status
FROM generate_series(1, 10000) AS s;

