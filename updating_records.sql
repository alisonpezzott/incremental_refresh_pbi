-- searching target row
SELECT date_transaction, id, product_key, quantity, update_on
FROM  fact_production
WHERE id = 19429218; 

-- Restoring initial record
DELETE FROM fact_production
WHERE id = 19429218; 
INSERT INTO fact_production (date_transaction, id, product_key, quantity, update_on)
VALUES ('2025-02-12T19:42:55', 19429218, 1166, 204000000, '2025-02-12T19:43:41');

-- Correcting error without correcting date_transaction
UPDATE fact_production
SET quantity = 204
WHERE id = 19429218; 

-- Correcting error correcting date_transaction
UPDATE fact_production
SET quantity = 204,
	update_on = GETDATE()
WHERE id = 19429218;  

-- Method Offset Entry
INSERT INTO fact_production (date_transaction, id, product_key, quantity, update_on)
VALUES 
	('2025-02-12T19:42:55', 19429218, 1166, -204000000, GETDATE()),
	('2025-02-12T19:42:55', 19429218, 1166, 204, GETDATE());
