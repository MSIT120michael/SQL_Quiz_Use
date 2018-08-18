use Northwind
go
Select * from [dbo].[Employees]

use AdventureWorks  
Select * from [dbo].[NewTable] with(index(aa))  ---強制執行索引
where [EmployeeID] > 10

use AdventureWorks  
Select[EmployeeID],[LoginID] from [dbo].[NewTable] --SELECT與非叢集索引選擇欄位相同，因此會選擇非叢集式
where [EmployeeID] > 10

use AdventureWorks
Select[ContactID],[ManagerID]from [dbo].[NewTable] -- SELECT欄位與非叢集欄位無關，因此選擇叢集式
where [EmployeeID] > 10  -- 叢集式同時系統幫忙排序建立索引的欄位!!) 
