
exec  [APspPEA_CarregaTabelau_pea2]



DECLARE @dt datetime, @WeekOfMonth tinyint, @ds numeric(15), @dw numeric(15)
SET @dt = '20190922'
set @dw = datepart(dw,@dt)
print @dw
select @ds =  dbo.fc_dia_semana_mes(@dt)
print  @ds 

select *  
from  u_peagp 
where nsemana  = @ds
and  case	when dom = 1 then 1  
			when seg = 1 then 2 
			when ter = 1  then 3 
			when qua =  1 then 4  
			when qui =  1 then 5  
			when sex =  1 then 6  
			when sab =  1 then 7 end = @dw 


-- Declara o cursor

Declare Cur Cursor Local static Forward_Only For  

	select stamp from stt

-- Declaração de variáveis para guardar os campos do Cursor
declare  @stamp varchar(25)


Open Cur -- Abre o Cursor  (quando abre fica no BOF)
Fetch Next From Cur Into @stamp   -- Avaça para o próximo registo do cursor
While @@Fetch_Status = 0 -- Testa de o Fetch moveu para um registo válido
Begin
	
		update aa set aa = aa where stamp = @stamp 
		
	
	Fetch Next From Cur Into @stamp   -- Avança para o próximo registo do cursor
End
Close Cur -- Fecha o cursor
Deallocate Cur -- Liberta a memória do cursor



go  

			
alter FUNCTION dbo.fc_dia_semana_mes 
(@data smalldatetime)
RETURNS  int
AS
BEGIN

	declare @dt_table table  
	(
	data smalldatetime not null default('19000101')
	, dw int  not null default(0)
	, ds int  not null default(0)
	)


	DECLARE @dt datetime, @WeekOfMonth tinyint, @dw numeric(15), @ds int
	declare @dt_aux smalldatetime , @i int , @j int   
	SET @dt = @data
	set @i = 1 
	set @j = 1  

	set @dt_aux =  @dt  - day(@dt)+1
	while @dt_aux <= @dt
	begin 
		if @j > 7 
		begin
			set @i = @i + 1 
			set @j = 1  
		end  
		insert into @dt_table (data, dw, ds)
		values(@dt_aux ,  DATEPART(dw,@dt_aux), @i )  
		set  @dt_aux = @dt_aux + 1 
		set   @j =  @j + 1 
	end  

	select @ds = ds  from @dt_table where  data = @dt 
	return isnull(@ds,0) 

END
GO

