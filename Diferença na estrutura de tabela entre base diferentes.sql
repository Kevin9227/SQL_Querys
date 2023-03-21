declare @tabela varchar(10), @cmd varchar(MAX), @cmd1 varchar(MAX)
set @tabela = 'TABELA DE EXEMPLO'
set @cmd = ''
set @cmd1 = ''

declare cmds cursor for 
select   'select '+char(39)+ col.name+ char(39)+' campo , registos from (select count(1) registos from (select distinct '+ col.name + ' from '+@tabela+' (nolock) )x)x '
from    sys.types typ inner join sys.columns col on typ.system_type_id = col.system_type_id
where   object_id = object_id(@tabela) and typ.name != 'text' and col.name not in (select name from Auto_Duque.sys.columns a where   object_id = object_id(@tabela) ) 

open cmds
while 1=1
begin
    fetch cmds into @cmd
    if @@fetch_status != 0 break
    select @cmd1 = @cmd1 + @cmd + '   union all '
end
close cmds;
deallocate cmds

select @cmd1 = substring(@cmd1, 1, len(@cmd1) - 10) + ' order by registos'
exec(@cmd1)