/*Exercise 2: Using the GROUP BY and HAVING Clauses*/
USE northwind

SELECT orderid, SUM(quantity) AS total_quantity
 FROM [order details] AS od
 INNER JOIN products
  ON od.productid = products.productid
 --WHERE categoryid <3
 GROUP BY orderid /*must same as line 1*/
 Having SUM(orderid)> 250