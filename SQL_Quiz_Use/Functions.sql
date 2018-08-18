/*�ϥΪ̦ۭq��ơA���uID���D*/
USE Northwind
GO
Select * from fn_FindReports(2) --��employeeID�����
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

/*�ϥΪ̦ۭq��ơA�ⲣ�~�|�v(ILTV Function*/
USE Northwind
GO
create function fn_TaxRate --�إߨ��TaxRate
(@ProductID int) --�������J���ȡA���ŧi�ܼƻP���A
Returns numeric (3,2) --TaxRate �p�U��3��ơA�p���I����
begin
return --�^��begin�Pend��������
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
   END AS TaxRate --�i���i�L
FROM Products 
where ProductID = @ProductID  --����@ProductID��ProductID
)
end
go

Select * ,[dbo].[fn_TaxRate] ([ProductID])/*<��J�Ѽ�*/ as TaxRate from [dbo].[Products]