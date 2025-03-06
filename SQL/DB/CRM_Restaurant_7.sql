CREATE INDEX CONCURRENTLY idx_client_orders_order_number
ON client_orders (order_number);

CREATE INDEX CONCURRENTLY idx_order_positions_order_number
ON order_positions (order_number);
