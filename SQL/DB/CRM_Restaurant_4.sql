ALTER TABLE
    client_orders
ADD
    COLUMN System_status INTEGER DEFAULT 0,
ADD
    COLUMN Work_status INTEGER,
ADD
    COLUMN Paid_status INTEGER;

UPDATE
    client_orders
SET
    System_status = 100,
    Work_status = 350,
    Paid_status = 280;

ALTER TABLE
    client_orders DROP COLUMN status_order;

ALTER TABLE
    order_positions
ADD
    COLUMN System_status INTEGER DEFAULT 0,
ADD
    COLUMN Work_status INTEGER,
ADD
    COLUMN Paid_status INTEGER;

UPDATE
    order_positions
SET
    System_status = 0,
    Work_status = 430,
    Paid_status = 550;

ALTER TABLE
    order_positions DROP COLUMN status_position;

ALTER TABLE
    staff_shift
ADD
    COLUMN staff_shift_status INTEGER DEFAULT 0;

UPDATE
    staff_shift
SET
    staff_shift_status = 120;

ALTER TABLE
    staff_shift DROP COLUMN status_staffshift;

ALTER TABLE
    shift
ADD
    COLUMN shift_status INTEGER DEFAULT 0;

UPDATE
    shift
SET
    shift_status = 120;

ALTER TABLE
    shift DROP COLUMN status_shift;