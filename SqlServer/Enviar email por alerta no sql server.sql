--Ative o "Database Mail":
USE msdb;
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO

--Configure o perfil de email:
EXEC msdb.dbo.sysmail_add_profile_sp
@profile_name = 'Nome do Perfil',
@description = 'Descrição do Perfil';

--Adicione uma conta de email:
EXEC msdb.dbo.sysmail_add_account_sp
@account_name = 'Nome da Conta',
@description = 'Descrição da Conta',
@email_address = 'endereço_de_email@dominio.com',
@display_name = 'Nome de Exibição',
@mailserver_name = 'nome_do_servidor_smtp',
@port = 587,
@username = 'nome_de_usuario',
@password = 'senha',
@enable_ssl = 1;

--Adicione o perfil à conta:
EXEC msdb.dbo.sysmail_add_profileaccount_sp
@profile_name = 'Nome do Perfil',
@account_name = 'Nome da Conta',
@sequence_number = 1;

--Crie uma tarefa de trabalho SQL Server Agent:
USE msdb;
GO
EXEC sp_add_job @job_name = N'Nome do Trabalho',
@enabled = 1,
@notify_level_eventlog = 0,
@notify_level_email = 2,
@notify_level_netsend = 0,
@notify_level_page = 0,
@delete_level = 0,
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'sa',
@job_id = @job_id OUTPUT;

--Adicione uma etapa ao trabalho:
EXEC sp_add_jobstep @job_name = N'Nome do Trabalho',
@step_name = N'Nome da Etapa',
@step_id = 1,
@cmdexec_success_code = 0,
@on_success_action = 1,
@on_success_step_id = 0,
@on_fail_action = 2,
@on_fail_step_id = 0,
@retry_attempts = 0,
@retry_interval = 0,
@os_run_priority = 0,
@subsystem = N