/*預存程序(Normal)*/
use Northwind
go
create proc FiveMostExpensiveProducts
as
Select top 5 ProductName,UnitPrice
From Products
order by unitprice desc
FiveMostExpensiveProducts --直接key進去不需要加入Select From % EXEC

/*預存程序(含參數)*/
use Northwind
go
create proc UpdateEmployeePhone
@aa nvarchar(24),@bb int --宣告aa為Homephone為nvchar /bb為員工ID int
as
Update [dbo].[Employees]
set HomePhone = @aa
where [EmployeeID] = @bb
go
UpdateEmployeePhone '1111',1

Select * from [dbo].[Employees]
where [EmployeeID] = 1

/*預存程序練習*/
use Northwind
go
alter view Partitioned
as
Select[LastName],[FirstName],[City],[Address] ,('Employees') as Form from [dbo].[Employees]
union
Select[CustomerID],[CompanyName],[City],[Address] ,('Customers') from [dbo].[Customers]
go
select * from Partitioned

/*執行預存程序P.104*/
sp_configure /*只會看到17項預設*/ 'show advanced options',1 /*開啟進階選項*/
RECONFIGURE --/*重整*/
exec sp_configure 'xp_cmdshell',1 /*開啟xpcmdshell*/
RECONFIGURE 
EXEC master..xp_cmdshell 'dir c:\' --執行
GO
/*自行建立訊息P.105*/
sp_addmessage 50001,10,'恭喜你成功惹','us_english','true',replace 
/*spaddmessage (msg_id , 嚴重度,訊息,語言,with log true,第一次都是replace*/

Select * from sys.messages --可以看到以建立在sys.msg

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
Raiserror (50001,10,1) --剛剛建的msg在此派上用場 

usp_UpdateShippeddate '2018-08-16',10248 --可以看到訊息show出

/*預存函數Return運用*/

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

SELECT * FROM Orders WHERE  ShippedDate IS not Null --Vinet Shipdate目前不是空值(check)
go
declare @test int,@test2 int  --Return 一定要是int型態 宣告第二個變數@test2，代表傳回Return值
exec @test2 = dbo.OrderCount 'VINET', @test output 
select @test , @test2  


