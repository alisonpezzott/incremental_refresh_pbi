SELECT 
	date_transaction,
	id, 
	product_key,
	quantity,
	update_on
FROM
	fact_production
WHERE id = 12345678;  

UPDATE fact_production
SET product_key = 1137,    
    quantity = 374,        
    update_on = GETDATE()  
WHERE id = 12345678;          

UPDATE fact_production
SET product_key = 1137,    
    quantity = 373,        
    update_on = CONVERT(datetime, '2023-08-14 13:19:55', 120)
WHERE id = 12345678; 

