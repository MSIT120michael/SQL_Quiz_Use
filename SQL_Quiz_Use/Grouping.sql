/*Module 4: ��ƪ����s(Grouping) �P�K�n (Summarizing)*/
/* Line 1*/
USE northwind
SELECT Top 10 with ties orderid
      ,(unitprice * quantity) AS totalsale
 FROM [order details]
 ORDER BY (unitprice * quantity) DESC
GO

USE northwind

SELECT productid, grouping(productid),orderid,grouping(orderid),SUM(quantity) AS total_quantity
 FROM [order details]
 --where productid = 50
 GROUP BY productid, orderid
  WITH Cube
 ORDER BY productid, orderid
GO