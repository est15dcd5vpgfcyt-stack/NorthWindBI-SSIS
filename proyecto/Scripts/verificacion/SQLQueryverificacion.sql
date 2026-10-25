USE NorthwindDW;
GO

SELECT 'dim.DimCustomer' AS Tabla, COUNT(*) AS Filas FROM dim.DimCustomer
UNION ALL SELECT 'dim.DimProduct',  COUNT(*) FROM dim.DimProduct
UNION ALL SELECT 'dim.DimEmployee', COUNT(*) FROM dim.DimEmployee
UNION ALL SELECT 'dim.DimShipper',  COUNT(*) FROM dim.DimShipper
UNION ALL SELECT 'dim.DimDate',     COUNT(*) FROM dim.DimDate
UNION ALL SELECT 'fact.FactSales',  COUNT(*) FROM fact.FactSales;
GO

-- Comparación con el origen
SELECT 'Origen: Order Details' AS Tabla, COUNT(*) AS Filas FROM Northwind.dbo.[OrderDetails]
UNION ALL
SELECT 'DW: FactSales', COUNT(*) FROM fact.FactSales;