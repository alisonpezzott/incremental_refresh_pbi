CREATE DATABASE sandbox;
GO

USE sandbox;
GO 

CREATE TABLE fact_production (
    date_transaction DATETIME,
    id INT,
    product_key INT,
    quantity INT,
    update_on DATETIME
);
GO

BULK INSERT fact_production
FROM 'C:/Temp/fact_production.csv'
WITH (
	CODEPAGE = '65001',
	FIELDTERMINATOR = ',',
	FIRSTROW = 2
);
GO

SELECT TOP(100)
    date_transaction,
    id,
    product_key,
    quantity,
    update_on
FROM 
	fact_production;
