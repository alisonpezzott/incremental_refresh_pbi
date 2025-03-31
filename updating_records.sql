-- searching target row
SELECT date_transaction, id, product_key, quantity, update_on
FROM  fact_production
WHERE product_key = 1166 AND date_transaction = '2025-02-12T19:42:55'; 

-- Restoring initial record
DELETE FROM fact_production
WHERE product_key = 1166 AND date_transaction = '2025-02-12T19:42:55'; 
INSERT INTO fact_production (date_transaction, id, product_key, quantity, update_on)
VALUES ('2025-02-12T19:42:55', 19429218, 1166, 204, '2025-02-12T19:43:41');

-- Causing error
UPDATE fact_production
SET product_key = 1166,    
    quantity = 204000000        
WHERE product_key = 1166 AND date_transaction = '2025-02-12T19:42:55'; 

-- Correcting error
UPDATE fact_production
SET product_key = 1166,    
    quantity = 204,
	update_on = GETDATE()
WHERE product_key = 1166 AND date_transaction = '2025-02-12T19:42:55'; 

-- Method Offset Entry
INSERT INTO fact_production (date_transaction, id, product_key, quantity, update_on)
VALUES 
	('2025-02-12T19:42:55', 19429218, 1166, -204000000, GETDATE()),
	('2025-02-12T19:42:55', 19429218, 1166, 204, GETDATE());
