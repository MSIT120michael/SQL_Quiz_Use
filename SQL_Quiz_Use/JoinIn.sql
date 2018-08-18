/*Line 1*/
use Library
Select [firstname] + ' ' + [middleinitial] + ' ' +[lastname] as name ,[street],[city],[state],[zip]
from[dbo].[member] as m 
join[dbo].[adult]  as a
On m.member_no = a.member_no --combine with same member number

/*Line2*/
Select m.[member_no] , [firstname] + ' ' + [middleinitial] + ' ' + [lastname] as name ,isbn,log_date
From [dbo].[member] as m left outer join [dbo].[reservation] as r
on m.[member_no] = r.[member_no] --key
where m.[member_no] in (250, 341, 1675) --limit

/*Line 3*/
Select c.isbn , copy_no, on_loan, title, translation,cover
from [dbo].[title] as t
join [dbo].[item] as i
on t.[title_no] =  i.title_no
join [dbo].[copy] as c
on c.isbn = i.isbn
where c.isbn in (1,500,1000)
order by c.isbn

/*Self join*/
Select b.[Name] as 'Select Mgr name'
From [dbo].[Emp] as a
join [dbo].[Emp] as b
on a.[Magr_id] = b.[Emp_id]
where a.[Name] = 'Peter'

/*combine muti search*/ 
use Northwind
Select ([FirstName]+''+[LastName]) as name ,[City],[PostalCode]
From [dbo].[Employees]
Union
Select [CompanyName],[City],[PostalCode]
from [dbo].[Customers]