use Northwind
set identity_insert[dbo].[Shippers] off ---�����ѧO�ݩ�/�W��
set identity_insert[dbo].[Shippers] on ---�}���ѧO�W�欰�O
insert [Shippers](CompanyName) --���Jshipper���A�A�����[�J���ק蠟���
values ('aaa')

Select * from [dbo].[Shippers]

use Northwind
insert [dbo].[Employees] ([LastName],[FirstName]) Values ('aaa','aaa') --default add region NY
select * from [dbo].[Employees]

sp_helpconstraint [Employees]--�t�Φ۵M�|����DB
go 
UPDATE Employees SET BirthDate = (GETDATE() +1) -- ����o�ӥH�e�n���[�J���󦡡A�]����ӵL�k����
WHERE EmployeeID = 1
GO

