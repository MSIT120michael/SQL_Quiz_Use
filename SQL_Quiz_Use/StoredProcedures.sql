/*�w�s�{��(Normal)*/
use Northwind
go
create proc FiveMostExpensiveProducts
as
Select top 5 ProductName,UnitPrice
From Products
order by unitprice desc
FiveMostExpensiveProducts --����key�i�h���ݭn�[�JSelect From % EXEC

/*�w�s�{��(�t�Ѽ�)*/
use Northwind
go
create proc UpdateEmployeePhone
@aa nvarchar(24),@bb int --�ŧiaa��Homephone��nvchar /bb�����uID int
as
Update [dbo].[Employees]
set HomePhone = @aa
where [EmployeeID] = @bb
go
UpdateEmployeePhone '1111',1

Select * from [dbo].[Employees]
where [EmployeeID] = 1

/*�w�s�{�ǽm��*/
use Northwind
go
alter view Partitioned
as
Select[LastName],[FirstName],[City],[Address] ,('Employees') as Form from [dbo].[Employees]
union
Select[CustomerID],[CompanyName],[City],[Address] ,('Customers') from [dbo].[Customers]
go
select * from Partitioned

/*����w�s�{��P.104*/
sp_configure /*�u�|�ݨ�17���w�]*/ 'show advanced options',1 /*�}�Ҷi���ﶵ*/
RECONFIGURE --/*����*/
exec sp_configure 'xp_cmdshell',1 /*�}��xpcmdshell*/
RECONFIGURE 
EXEC master..xp_cmdshell 'dir c:\' --����
GO
/*�ۦ�إ߰T��P.105*/
sp_addmessage 50001,10,'���ߧA���\�S','us_english','true',replace 
/*spaddmessage (msg_id , �Y����,�T��,�y��,with log true,�Ĥ@�����Oreplace*/

Select * from sys.messages --�i�H�ݨ�H�إߦbsys.msg

/*Raiserror P.105*/
USE [Northwind]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[usp_UpdateShippeddate]
@aa datetime ,@bb int
as
update [dbo].[Orders]
set[ShippedDate] = @aa
where [OrderID] = @bb
Raiserror (50001,10,1) --���ت�msg�b�����W�γ� 

usp_UpdateShippeddate '2018-08-16',10248 --�i�H�ݨ�T��show�X

/*�w�s���Return�B��*/

USE Northwind
GO
CREATE PROC dbo.OrderCount
    @CustomerID nchar (5),
    @OrderCount int OUTPUT
AS
IF EXISTS 
  (SELECT * FROM Orders WHERE CustomerID = @CustomerID AND ShippedDate IS Null)
  BEGIN
     SELECT @OrderCount=COUNT(*) 
     FROM Orders 
     WHERE CustomerID = @CustomerID 
     RETURN (1) 
  END 
ELSE RETURN (0)
GO

SELECT * FROM Orders WHERE  ShippedDate IS Null

declare @test int
exec dbo.OrderCount 'ERNSH', @test output
select @test --A:30

go

SELECT * FROM Orders WHERE  ShippedDate IS not Null
go
declare @test int
exec dbo.OrderCount 'VINET', @test output
select @test  --A:NULL

SELECT * FROM Orders WHERE  ShippedDate IS not Null --Vinet Shipdate�ثe���O�ŭ�(check)
go
declare @test int,@test2 int  --Return �@�w�n�Oint���A �ŧi�ĤG���ܼ�@test2�A�N��Ǧ^Return��
exec @test2 = dbo.OrderCount 'VINET', @test output 
select @test , @test2  


