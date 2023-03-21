select 
	substring(convert(varchar(3), convert(int, valor)/60+100),2,2)
	+ 
	':'
	+ substring(convert(varchar(3), convert(int, valor)%60+100),2,2) 

from para1 where descricao = 'mx_pend'


------------Alternativamente-------------------

select convert(varchar(2), CONVERT(int, @horas / 60)) + ':' +  convert(varchar(2), @horas % 60)