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
  SELECT @@trancount --�i�d�ݦ��X�����
  --COMMIT TRANSACTION
Rollback ---������k�s
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL' /*�PB�f�t��*/

/*B �ݭn�t�~�}�s����*/
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'--�L�k����A�]���S��COMMIT TRANSACTION

/*C �ݭn�t�~�}�s����*/
set transaction isolation level read uncommitted --�Ntran�]��DirtyRead
set transaction isolation level snapshot --�Ntran�]��snapshot
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL' --TryAgain
set transaction isolation level read committed

/*D �����ɡA�s�u�O�ɥ�*/
SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
set lock_timeout 3000 ---�]�w�s�utime out
set lock_timeout -1 ---����timeout
