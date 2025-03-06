BEGIN;

DO $$
DECLARE
    client_id INTEGER := 11;
    order_count INTEGER;
BEGIN

    SELECT COUNT(*)
    INTO order_count
    FROM client_orders
    JOIN work_statuses ON client_orders.work_status = work_statuses.status_number
    JOIN paid_statuses ON client_orders.paid_status = paid_statuses.status_number
    WHERE client_orders.id_client = client_id
      AND (work_statuses.work_sign NOT IN (4, 5) OR paid_statuses.paid_sign NOT IN (4, 5));

    IF order_count > 0 THEN
        RAISE EXCEPTION 'Клиент имеет открытые или неоплаченные заказы. Удаление невозможно.';
    END IF;

    UPDATE client_orders
    SET system_status = 12
    WHERE id_client = client_id;

    DELETE FROM clients
    WHERE id_client = client_id;

    RAISE NOTICE 'Клиент успешно удален.';
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Произошла ошибка: %', SQLERRM;

END $$;

COMMIT;
