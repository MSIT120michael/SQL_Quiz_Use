/*Ĳ�o���A�q��W�[�A�ҥH�s�f���*/
USE Northwind
IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'TR' AND name = 'OrdDet_Insert' )
    DROP TRIGGER OrdDet_Insert
GO

CREATE TRIGGER OrdDet_Insert
ON [Order Details]
FOR INSERT --�����Finset�ʧ@
AS
UPDATE P SET 
UnitsInStock = (P.UnitsInStock - I.Quantity)-- ���楪�� �s�f���
FROM Products AS P INNER JOIN Inserted AS I
ON P.ProductID = I.ProductID
GO

SELECT * FROM Products WHERE ProductID = 22 --���ݦs�f�q100�h

INSERT [Order Details]
(OrderID, ProductID, UnitPrice, Quantity, Discount) --���Finsert�ʧ@
VALUES (11077, 22, 21.00, 50, 0.0)
GO

SELECT name FROM sysobjects
   WHERE type = 'TR'
   ORDER BY type, name
GO

sp_helptrigger [Order Details]

