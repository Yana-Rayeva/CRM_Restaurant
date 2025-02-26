ALTER TABLE dishes
ADD COLUMN dish_cooking_time INTEGER;
UPDATE dishes
SET dish_cooking_time = CAST(REGEXP_REPLACE(cooking_time, '[^0-9]', '', 'g') AS INTEGER);
ALTER TABLE dishes
DROP COLUMN cooking_time;
ALTER TABLE dishes
RENAME COLUMN dish_cooking_time TO cooking_time;


