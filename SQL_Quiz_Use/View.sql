use Northwind
go
/*Alter*/create view FormaggiProductsView
as
Select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, Discontinued
from Products
WHERE SupplierID = 14
with check option --限制條件，不能修改
go

select * from FormaggiProductsView

update FormaggiProductsView
set SupplierID = 15
where ProductID = 31

