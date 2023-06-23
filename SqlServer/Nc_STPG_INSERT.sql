USE [NCANGOLA]
GO
/****** Object:  StoredProcedure [dbo].[NC_Sinc_Insert]    Script Date: 24/01/2023 15:16:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[NC_Sinc_Insert] 
	-- Add the parameters for the stored procedure here
@schema varchar(100), @schema1 varchar(100), @tablename varchar(100), @stamp varchar(25), @fieldstamp varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare  @columns nvarchar(MAX), @insert nvarchar(max), @values nvarchar(MAX),@xid INT, @ident nvarchar(max);

set @columns = '';
set @ident = '';

select @columns = ltrim(rtrim(@columns)) +  ltrim(rtrim(phc.COLUMN_NAME)) + ','
from INFORMATION_SCHEMA.COLUMNS phc inner join INFORMATION_SCHEMA.COLUMNS dfx on phc.COLUMN_NAME = dfx.COLUMN_NAME
and  phc.table_name = dfx.table_name and phc.table_schema= @schema and dfx.table_schema= @schema1
where phc.table_name = ltrim(rtrim(@tablename));

set @columns = REPLACE(@columns, @tablename+'ID,', '')
set @values = @columns;
-- para o Identity
	if (upper(@tablename)='FT' or upper(@tablename)='BO' or upper(@tablename)='ST') 
	begin
		set @columns=@columns+LTRIM(RTRIM(@tablename))+'id,'
		set @values=replace(@values,LTRIM(RTRIM(@tablename))+'id','(select isnull(max('+LTRIM(RTRIM(@tablename))+'id),0)+1 from ['+LTRIM(RTRIM(@schema))+'].['+LTRIM(RTRIM(@tablename))+'])')
		set @ident='SET IDENTITY_INSERT ['+LTRIM(RTRIM(@schema))+'].['+LTRIM(RTRIM(@tablename))+']'
	end


set @insert =			'insert into ['+LTRIM(RTRIM(@schema))+'].['+LTRIM(RTRIM(@tablename))+'] ('+ substring(ltrim(rtrim(@columns)), 1, LEN(@columns)-1) + ')' + CHAR(13) + CHAR(10);
set @insert = @insert + ' select '  + substring(ltrim(rtrim(@values)), 1, LEN(@values)-1) + CHAR(13) + CHAR(10);
set @insert = @insert + ' from ['+LTRIM(RTRIM(@schema1))+'].['+LTRIM(RTRIM(@tablename))+']' + CHAR(13) + CHAR(10);
set @insert = @insert + ' where ['+LTRIM(RTRIM(@schema1))+'].['+LTRIM(RTRIM(@tablename))+'].'+LTRIM(RTRIM(@fieldstamp))+'='''+@stamp+'''';
set @insert = @insert + ' and ['+LTRIM(RTRIM(@schema1))+'].['+LTRIM(RTRIM(@tablename))+'].'+LTRIM(RTRIM(@fieldstamp))+' not in (select '+LTRIM(RTRIM(@fieldstamp))+' from ['+LTRIM(RTRIM(@schema))+'].['+LTRIM(RTRIM(@tablename))+'])'

--select @insert;
--print @insert;
	if (upper(@tablename)='FT' or upper(@tablename)='BO' or upper(@tablename)='ST')
	begin
	--select @ident;
	EXECUTE sp_executesql @ident;
	end
EXECUTE sp_executesql @insert;
END

