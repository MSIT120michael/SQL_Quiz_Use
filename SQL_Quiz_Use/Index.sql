use Northwind
go
Select * from [dbo].[Employees]

use AdventureWorks  
Select * from [dbo].[NewTable] with(index(aa))  ---�j��������
where [EmployeeID] > 10

use AdventureWorks  
Select[EmployeeID],[LoginID] from [dbo].[NewTable] --SELECT�P�D�O�����޿�����ۦP�A�]���|��ܫD�O����
where [EmployeeID] > 10

use AdventureWorks
Select[ContactID],[ManagerID]from [dbo].[NewTable] -- SELECT���P�D�O�����L���A�]������O����
where [EmployeeID] > 10  -- �O�����P�ɨt�������Ƨǫإ߯��ު����!!) 
