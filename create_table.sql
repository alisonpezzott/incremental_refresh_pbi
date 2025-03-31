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

WITH Numbers AS (
    -- Sequence from 1 to 20000000
    SELECT TOP (20000000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS id
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
    CROSS JOIN sys.all_objects c
),
Params AS (
    -- Date parameters
    SELECT 
        CAST('2021-01-01T00:00:00' AS DATETIME) AS start_date,
        DATEADD(DAY, -1, CAST(GETDATE() AS DATE)) AS end_date,
        DATEDIFF(SECOND, '2021-01-01T00:00:00', DATEADD(DAY, -1, CAST(GETDATE() AS DATE))) AS total_seconds
)
INSERT INTO fact_production (date_transaction, id, product_key, quantity, update_on)
SELECT 
    DATEADD(SECOND, 
        (n.id - 1) * p.total_seconds / (20000000 - 1), 
        p.start_date
    ) AS date_transaction,
    n.id,
    1001 + ABS(CHECKSUM(NEWID())) % 201 AS product_key,
    100 + ABS(CHECKSUM(NEWID())) % 401 AS quantity,
    DATEADD(SECOND, 
        3 + ABS(CHECKSUM(NEWID())) % 48,
        DATEADD(SECOND, 
            (n.id - 1) * p.total_seconds / (20000000 - 1),
            p.start_date
        )
    ) AS update_on
FROM Numbers n
CROSS JOIN Params p
ORDER BY date_transaction;
