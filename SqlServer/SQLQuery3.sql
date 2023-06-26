create Table calendar (CalendarDate datetime)
 declare @StartDate datetime,
  @EndDate datetime ,  @Calendario date 

set @StartDate = GETDATE() 
set @EndDate = '12 /31/2021 '

 WHILE @StartDate < = @EndDate
 
 begin Insert  Calendar( CalendarDate ) select @StartDate
set @StartDate = dateadd (dd , 1, @StartDate ) end

select GETDATE()+336 from calendar 

DELETE FROM calendar  