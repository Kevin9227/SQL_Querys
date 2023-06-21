


EXEC sp_EnviarEmail

CREATE  PROCEDURE sp_EnviarEmail
AS
BEGIN
Declare @Header nvarchar(max), @Email_body nvarchar(max),@nfatura CHAR(10),@nfechos CHAR(10),@ncotacao CHAR(10), @data_atual CHAR(10)
set @nfatura =(select count(*) from ft where ndoc =3 and fdata <= CONVERT (date, GETDATE()))
SET @nfechos =(SELECT count(*) from u_caixa where loja =3  AND data <=CONVERT (date, GETDATE()))
SET @ncotacao =(SELECT count(*) from BO where ndos =84  AND dataobra <=CONVERT (date, GETDATE()))
set @data_atual = CONVERT(NVARCHAR, GETDATE(), 105)


SELECT @Header =  '<h2/><h2/>Titulo :'+@data_atual +'<br/>'
Select @Email_body =@Header+' <br/>Descrição 1: '+@nfatura +
'<br/><br/>'+'Descrição 2 :'+@nfechos
+'<br/><br/>'+'Descrição 3 : '+@ncotacao

EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'NOME DO PROFIL DO DBEMAIL',
@recipients = 'teste@teste.com',
@copy_recipients = Null,
@blind_copy_recipients = null,
@subject = 'TITULO DE RELATORIO ',
@body = @Email_body,
@body_format = 'HTML',
@importance = 'High',
@sensitivity = 'Normal',
@file_attachments = null,
@query = '',
@execute_query_database ='',
@attach_query_result_as_file = 0,
@query_attachment_filename='',
@query_result_header = 1,
@query_result_width = 32767,
@query_result_separator='',
@exclude_query_output=0,
@append_query_error = 1,
@query_no_truncate = 0,
@query_result_no_padding = 1
END 

