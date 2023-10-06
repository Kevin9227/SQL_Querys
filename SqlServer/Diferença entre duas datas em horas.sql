select top 1 
	datediff(HOUR,
	dateadd(
			minute, 
			convert(
					decimal(10,0), 
					substring(hora,4,2)), 
					dateadd(hour,convert(decimal(10,0), substring('DATA1',1,2)), 'DATA')),
	dateadd(
			minute, 
			convert(
					decimal(10,0), 
					substring(hora,4,2)), 
					dateadd(hour,convert(decimal(10,0), substring(hora,1,2)), data)))

from 'TABELA'
where nopat=pa.nopat 
 order by data, hora