-- searching target row
SELECT 
	date_transaction,
	id, 
	product_key,
	quantity,
	update_on
FROM 
	fact_production
WHERE 
	product_key = 1166 AND
	date_transaction = CONVERT(datetime, '2025-02-12 19:42:55', 120); 

-- Restoring initial record
DELETE FROM fact_production
WHERE product_key = 1166 AND
	date_transaction = CONVERT(datetime, '2025-02-12 19:42:55', 120); 
INSERT INTO fact_production (date_transaction, id, product_key, quantity, update_on)
VALUES
	(CONVERT(datetime, '2025-02-12 19:42:55', 120), 19429218, 1166, 204, CONVERT(datetime, '2025-02-12 19:43:41', 120));

-- Causing error
UPDATE fact_production
SET product_key = 1166,    
    quantity = 204000000,        
    update_on = GETDATE()  
WHERE product_key = 1166 AND
	date_transaction = CONVERT(datetime, '2025-02-12 19:42:55', 120); 

-- Method Offset Entry
INSERT INTO fact_production (date_transaction, id, product_key, quantity, update_on)
VALUES 
	(CONVERT(datetime, '2025-02-12 19:42:55', 120), 19429218, 1166, -204000000, GETDATE()),
	(CONVERT(datetime, '2025-02-12 19:42:55', 120), 19429218, 1166, 204, GETDATE());

