/*page.8*/
use Northwind
go 
sp_help employees
go


Select * from sys.sysusers -- Query User form
Select USER_NAME() --in () that is UserID 在括弧內指的是使用者ID
Select SUSER_NAME() -- add s means UserName (Sa and III/Windows) 使用者名稱
-- sa password is P@ssw0rd

-- add 1 table to test below code
Select *from INFORMATION_SCHEMA.Tables 

