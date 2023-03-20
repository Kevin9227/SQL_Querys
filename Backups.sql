
--sqlcmd  -S nomeservidor -E -i nomeficheiro.sql

DECLARE @BD as varchar(100)
declare @varsql as nvarchar(1000)

DECLARE backup_cursor CURSOR FOR 
SELECT name
FROM sys.databases where database_id>4 and state=0

OPEN backup_cursor

FETCH NEXT FROM backup_cursor 
INTO @BD

WHILE @@FETCH_STATUS = 0
BEGIN
   set @varsql='BACKUP DATABASE ' + @BD + ' TO DISK = ''d:\testeluis\' + @BD + datename(dw,getdate()) + '.Bak''
   WITH FORMAT,  MEDIANAME = ''' + @bd + ' backup'', NAME = ''Full Backup of ' + @bd + ''''

   exec sp_executesql @varsql

   FETCH NEXT FROM backup_cursor 
	INTO @BD
END 
CLOSE backup_cursor;
DEALLOCATE backup_cursor;