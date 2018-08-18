use Library
/* Line 1 */
use Library
Select[title_no],[title]
from [dbo].[title]
/* Line 2 */
exec sp_help '[dbo].[title]'
/* Line 3 */
use Library
Select[title_no],[title]
from [dbo].[title]
where [title] like '%adventures%' -- Fuzzy
/* Line 4 */
select[member_no],[fine_assessed],[due_date]
from[dbo].[loanhist]
where [fine_assessed] between 8 and 9 --if use <=> , must add one more fine.assessed
/* Line 5 */
select [title_no][author]
from[dbo].[title]
where [author] in ('Charles Dickens' ,' Jane Austen') --remember ,
/* Line 6 */
select[member_no],[fine_assessed],[fine_paid]
from[dbo].[loanhist]
where[fine_assessed] > 0 and [fine_paid] is null -->0  = without zero value
/* Exercise 2: Manipulating Result Sets*/
/* Line 1 */
Select[title]
from[dbo].[title]
Order by [title] -- Start from A to Z
/* Line 2 */
Select distinct [city],[state]
from[dbo].[adult]
/* Line 3 */
Select member_no,isbn,fine_assessed,[fine_assessed]*2 as 'double fine' /*add one more*/
From[dbo].[loanhist]
Where [fine_assessed] > 0
/* Line 4 */
Select Lower([firstname] + [middleinitial] + Substring([lastname],1,2)) /* 1,2 = 1 to 2*/
From [dbo].[member]
where [lastname] = 'Anderson'
/* Line 5 */
Select 'The title is: '+[title]+'[title_no]'+convert(char(2),[title_no])
From [dbo].[title]
