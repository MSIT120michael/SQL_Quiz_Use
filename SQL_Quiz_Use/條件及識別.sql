use Northwind
set identity_insert[dbo].[Shippers] off ---關閉識別屬性/規格
set identity_insert[dbo].[Shippers] on ---開啟識別規格為是
insert [Shippers](CompanyName) --插入shipper表內，括號內加入欲修改之欄位
values ('aaa')

Select * from [dbo].[Shippers]

use Northwind
insert [dbo].[Employees] ([LastName],[FirstName]) Values ('aaa','aaa') --default add region NY
select * from [dbo].[Employees]

sp_helpconstraint [Employees]--系統自然會產生DB
go 
UPDATE Employees SET BirthDate = (GETDATE() +1) -- 執行這個以前要先加入條件式，因條件而無法執行
WHERE EmployeeID = 1
GO

