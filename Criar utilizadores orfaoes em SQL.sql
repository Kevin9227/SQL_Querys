--Cria tabela temporária de utilizadores a intervir
create table #tabelaut(col1 varchar(50),col2 varchar(50))
insert into #tabelaut
exec sp_change_users_login 'Report'


--Actualiza/cria login no security do motor SQL

declare @ut as varchar(50)
declare uts cursor for
select col1 from #tabelaut
open uts 
fetch next from uts into @ut

while @@FETCH_STATUS=0
begin
            --Neste caso todos os utilizadores da base de dados onde estamos a correr o script ficam com a password 123
            exec sp_change_users_login 'Auto_Fix',@ut,NULL,'123'
            fetch next from uts into @ut
end
close uts
deallocate uts

--apagar a tabela temporária (não esquecer)
drop table #tabelaut
