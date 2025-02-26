ALTER TABLE price_list
ADD COLUMN id_dish INTEGER;

UPDATE price_list
SET id_dish = (
    SELECT id_dish
    FROM dishes
    WHERE dishes.id_price = price_list.id_price
);

ALTER TABLE dishes
DROP COLUMN id_price;

ALTER TABLE order_positions 
DROP COLUMN discount;
