/**/
USE northwind
SELECT or1.orderid, customerid
 FROM orders AS or1
 join [order details] AS od
 on or1.orderid = od.orderid
 WHERE 20 < quantity AND od.productid = 23
GO
/*Exercise 1: Using a Subquery to Correlate Data 找出罰款總額*/
/*子查詢方法*/
USE library
SELECT [member_no], [firstname],[lastname]
 FROM [dbo].[member] AS m
 WHERE 5 < ( SELECT SUM([fine_assessed])
              FROM [dbo].[loanhist] AS lh
              WHERE m.member_no = lh.member_no )

/*Join on 方法*/
USE LIBRARY
SELECT m.member_no,[firstname], lastname, SUM(fine_assessed) AS 'Total Fines'
 FROM member as m
 JOIN loanhist as l
  ON m.[member_no] = l.[member_no]
 GROUP BY m.[member_no] ,[firstname], [lastname]
 HAVING SUM(fine_assessed) > 5
GO

/*課本 page78* 使用Join*/
USE pubs
SELECT DISTINCT t1.type --Full type
FROM [dbo].[titles] AS t1
INNER JOIN [dbo].[titles] AS t2
ON t1.type = t2.type
WHERE t1.pub_id <> t2.pub_id

/*Exercise 2: Using a Subquery as a Derived Table*/
/*找出有三個以上未成年子女的會員*/
use library
Select distinct a.[member_no]as adult_Number,[expr_date],count(*) as 小孩數量
From[dbo].[adult] as a
join[dbo].[juvenile]
on a.[member_no] = [adult_member_no] --小孩的adult number
Group by a.[member_no],[expr_date]
Having count(*) > 3

/*Exercise 3: Using a Subquery as an Expression*/
/*找出支付罰款金額等於最高罰款金額的會員*/
Select member.firstname, member.lastname, loanhist.isbn,loanhist.fine_paid
from[dbo].[member]
join[dbo].[loanhist]
on member.[member_no] = loanhist.[member_no]
Group by member.firstname, member.lastname, loanhist.isbn,loanhist.fine_paid
Having [fine_paid] =(Select max ([fine_paid]) from [dbo].[loanhist])

/* Question 2*/
use library
Select l.title_no, title, r.isbn, count(*) as 'Total Reserved'
from [dbo].[title] as t
join[dbo].[loan] as l
on t.title_no = l.title_no
join[dbo].[reservation] as r
on l.isbn = r.isbn
group by l.title_no, title, r.isbn
Having count(*) > 50

/*CTE*/
USE AdventureWorks
GO

WITH Managers AS 
(
    SELECT	EmployeeID, 
			ManagerID
    FROM HumanResources.Employee
    WHERE ManagerID IS NULL

	UNION ALL

    SELECT	emp.EmployeeID, 
			emp.ManagerID
	FROM HumanResources.Employee emp INNER JOIN Managers mgr
		ON emp.ManagerID = mgr.EmployeeID 
)
SELECT * FROM Managers

/* Exercise 1: Using the INSERT Statement */
/*Q1*/
use Library
insert [dbo].[item]([isbn],[title_no],[translation],[cover],[loanable])
values (10001,8,'ENGLISH','HARDBACK','Y')
insert [dbo].[item]([isbn],[title_no],[translation],[cover],[loanable])
values (10101,8,'ENGLISH','SOFTBACK','Y')
/*執行後，下面可以看到書已經加進去*/
Select * from item
order by [isbn] desc
/* Exercise 1: Using the INSERT Statement */
/*Q2*/
insert[dbo].[copy]([isbn],[copy_no],[title_no],[on_loan])
values(10001,1,8,'N')
/*執行後，下面可以看到書已經加進去*/
Select * from copy
order by [isbn] desc

/*Select into*/
use AdventureWorks
Select * into NewTable from [HumanResources].[Employee]

/*Delete isbn 10101 book*/
use Library
Delete [dbo].[item]
where isbn = 10101


/*Exercise 3: Using the UPDATE Statement*/
/*Find out 507 person*/
use Library
Select* from[dbo].[member]
where ([member_no]= 507)
/*Change 507 name*/
Update [dbo].[member]
set [lastname] = 'Chang'
where ([member_no]= 507)

/*Exercise 6: Modifying Tables Based on Data in Other Tables*/
use Library
insert [dbo].[adult]
Select j.[member_no],[street],[city],[state],[zip],[phone_no],dateadd(yy,1,getdate())
from [dbo].[adult] as a
join [dbo].[juvenile] as j
on a.[member_no] = j.[adult_member_no]
where dateadd(yy,18,birth_date)< GETDATE()
/*Search 8891*/
select * from [dbo].[adult]

/*Exercise 6: Modifying Tables Based on Data in Other Tables*/
/*Q2*/
use Library
Delete from [dbo].[juvenile]
--Select *
from [dbo].[adult] as a
join[dbo].[juvenile] as j
on a.[member_no] = j.[member_no]
/*Search 1110*/
select * from[dbo].[juvenile]


/**/
use AdventureWorks
Select *
From [Sales].[SalesOrderDetail]
tablesample (30 percent) --快速從大型資料表傳回取樣的資料列

USE northwind
SELECT orderid, customerid
 FROM orders AS or1
 WHERE 20 < (SELECT quantity
             FROM [order details] AS od
             WHERE or1.orderid = od.orderid
              AND od.productid = 23)
GO
USE northwind
SELECT or1.orderid, customerid
 FROM orders AS or1
 join [order details] AS od
 on or1.orderid = od.orderid
 WHERE 20 < quantity AND od.productid = 23
GO

