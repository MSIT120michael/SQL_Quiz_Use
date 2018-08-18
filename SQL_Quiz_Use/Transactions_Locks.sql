/*A*/
USE Northwind
BEGIN TRAN
  PRINT 'trancount value:'
  SELECT @@trancount
  PRINT 'Before update:'
  SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
  UPDATE Customers SET ContactName = 'Howard Snyder_Updatedaaa' WHERE CustomerID ='GREAL'
  PRINT 'After update:'
  SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
  PRINT 'trancount value:'
  SELECT @@trancount --可查看有幾筆交易
  --COMMIT TRANSACTION
Rollback ---交易數歸零
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL' /*與B搭配用*/

/*B 需要另外開新頁面*/
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'--無法執行，因為沒有COMMIT TRANSACTION

/*C 需要另外開新頁面*/
set transaction isolation level read uncommitted --將tran設為DirtyRead
set transaction isolation level snapshot --將tran設為snapshot
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL' --TryAgain
set transaction isolation level read committed

/*D 死結時，連線逾時用*/
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
set lock_timeout 3000 ---設定連線time out
set lock_timeout -1 ---取消timeout
