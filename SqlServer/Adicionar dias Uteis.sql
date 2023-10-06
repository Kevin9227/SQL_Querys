ALTER FUNCTION [dbo].[BusDaysDateAdd] 
(
   @FromDate datetime,
   @DaysToAdd int
)
RETURNS datetime
AS
BEGIN
   DECLARE @Result datetime
 
   SET @Result = DATEADD(day, (@DaysToAdd % 5) + CASE ((@@DATEFIRST + DATEPART(weekday, @FromDate) + (@DaysToAdd % 5)) % 7)
                                                 WHEN 0 THEN 2
                                                 WHEN 1 THEN 1
                                                 ELSE 0 END, DATEADD(week, (@DaysToAdd / 5), @FromDate))
 
   RETURN @Result
END
