DECLARE @STARTDATE      DATETIME;
DECLARE @ENDDATE        DATETIME;
DECLARE @YEARS          INTEGER;

SET @YEARS = 1;
SET @STARTDATE = dateadd(day, 1, eomonth(getdate(), -1))

--SELECT  @ENDDATE = DATEADD(DAY,-1,DATEADD(YEAR,@YEARS,@STARTDATE));
SELECT  @ENDDATE = eomonth(getdate())
DECLARE @FirstDayOfWeek INTEGER;

SET @FirstDayOfWeek = 6;

;WITH CTE_DATES
AS
(
    SELECT @STARTDATE AS [DATE],
    1 AS [Level]
    UNION ALL
    SELECT 
        DATEADD(DAY,1, [DATE] )  , [Level] + 1  
    FROM CTE_DATES
    WHERE [DATE] < @ENDDATE
)
SELECT 
	sum(8)
    /*[DATE],
    DATENAME(dw,[Date]) AS Daynamelong,
    LEFT(DATENAME(dw,[Date]),3) AS DaynameShort,
    DATEPART(dw,[Date]) AS NaturalDayNumber,
    CASE WHEN DATEPART(dw,[Date]) >= @FirstDayOfWeek THEN  (DATEPART(dw,[Date]) - (@FirstDayOfWeek)) +1
    ELSE 
        ((DATEPART(dw,[Date]) - (@FirstDayOfWeek)) +1) + 7
    END AS SpecialDayNumber,
    [Level]*/
FROM 
    CTE_DATES 
where DATEPART(dw,[Date]) not in (1,7)