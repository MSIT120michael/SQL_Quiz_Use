/*使用者自訂函數，員工ID問題*/
USE Northwind
GO
Select * from fn_FindReports(2) --傳employeeID給函數
go
create FUNCTION fn_FindReports (@InEmployeeID char(5))
RETURNS @reports TABLE
		(EmployeeID char(5) PRIMARY KEY,
		Name nvarchar(40) NOT NULL,
		Title nvarchar(30),
		MgrEmployeeID int,
		processed tinyint default 0)
AS
BEGIN
	DECLARE @RowsAdded int
	INSERT @reports
		SELECT EmployeeID, Name = FirstName + ' ' + LastName, Title, ReportsTo, 0
		FROM EMPLOYEES
		WHERE ReportsTo = @InEmployeeID

	SET @RowsAdded = @@rowcount
	WHILE @RowsAdded > 0
	BEGIN
		UPDATE @reports
		SET processed = 1
		WHERE processed = 0
		SET @RowsAdded = @@rowcount
		UPDATE @reports
		SET processed = 2
		WHERE processed = 1
	END
RETURN 
END
GO

/*使用者自訂函數，算產品稅率(ILTV Function*/
USE Northwind
GO
create function fn_TaxRate --建立函數TaxRate
(@ProductID int) --之後欲輸入的值，先宣告變數與型態
Returns numeric (3,2) --TaxRate 如下為3位數，小數點後兩位
begin
return --回傳begin與end之間的值
(
SELECT 
   --ProductID, CategoryID,
   CASE CategoryID 
      WHEN 1 THEN 1.10
      WHEN 2 THEN 1
      WHEN 3 THEN 1.10
      WHEN 4 THEN 1.05
      WHEN 5 THEN 1
      WHEN 6 THEN 1.05
      WHEN 7 THEN 1
      WHEN 8 THEN 1.05
   END AS TaxRate --可有可無
FROM Products 
where ProductID = @ProductID  --指派@ProductID為ProductID
)
end
go

Select * ,[dbo].[fn_TaxRate] ([ProductID])/*<輸入參數*/ as TaxRate from [dbo].[Products]