/*觸發器，訂單增加，所以存貨減少*/
USE Northwind
IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'TR' AND name = 'OrdDet_Insert' )
    DROP TRIGGER OrdDet_Insert
GO

CREATE TRIGGER OrdDet_Insert
ON [Order Details]
FOR INSERT --有做了inset動作
AS
UPDATE P SET 
UnitsInStock = (P.UnitsInStock - I.Quantity)-- 執行左側 存貨減少
FROM Products AS P INNER JOIN Inserted AS I
ON P.ProductID = I.ProductID
GO

SELECT * FROM Products WHERE ProductID = 22 --先看存貨量100多

INSERT [Order Details]
(OrderID, ProductID, UnitPrice, Quantity, Discount) --做了insert動作
VALUES (11077, 22, 21.00, 50, 0.0)
GO

SELECT name FROM sysobjects
   WHERE type = 'TR'
   ORDER BY type, name
GO

sp_helptrigger [Order Details]

