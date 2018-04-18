--INTRODUCTION TO SQL FOR DATA SCIENCE

--DATA CAMP

--23.03.2018

--Sue Wallace

#######################################################################################################

--Onboarding | Tables

##########SELECT

SELECT AGE
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]


--##selecting multiple columns

SELECT AGE, ADMPOL
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--##select all columns from a table

SELECT *
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]


--##Select distinct

--SELECT DISTINCT
--Often your results will include many duplicate values. If you want to select all the unique values from a column, you can use the DISTINCT keyword.

SELECT DISTINCT AGE
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--##SELECT COUNT

--What if you want to count the number of employees in your employees table? The COUNT statement lets you do this by returning the number of rows in one or more columns.

SELECT COUNT (*)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--##COUNT DISTINCT

SELECT COUNT (DISTINCT ATT8)
FROM  [PDR].[Tier1].[KS4_Pupil2_MasterView]


--##WHERE

= equal
<> not equal 
< less than
> greater than
<= less than or equal to
>= greater than or equal to

--WHERE always comes after FROM

--count the number of pupils that are aged less than or equal to 15

SELECT COUNT (*)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE AGE < 15;


--##FILTERING TEXT

--select the number of distinct LADS

SELECT COUNT (DISTINCT [Local Authority District (Lower Tier)])
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--count the number of male pupils

SELECT COUNT (Gender)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE GENDER = 'M'

--##WHERE AND 

--you need to specify the column name separately for every AND condition

--select all details for male pupils over the age of 10

SELECT *
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE AGE >10
AND GENDER ='M'

--##WHERE AND OR

--you need to specify the column for every OR condition

--When combining AND and OR, be sure to enclose the individual clauses in parentheses:

SELECT *
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE (age = 10 OR age=11)
AND (ATT8 >0  OR ATT8 >1);

--##BETWEEN

SELECT *
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE AGE BETWEEN 10 AND 12
AND GENDER ='M'

--##WHERE IN

--The IN operator allows you to specify multiple values in a WHERE clause, making it easier and quicker to specify multiple OR conditions

SELECT *
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE age IN (11,12,15);

--##NULL and IS NULL

 --to count the number of missing ATT8 scores
 
 SELECT COUNT (*)
 FROM   [PDR].[Tier1].[KS4_Pupil2_MasterView]
 WHERE ATT8 IS NULL;

  SELECT COUNT (*)
 FROM   [PDR].[Tier1].[KS4_Pupil2_MasterView]
 WHERE ATT8 IS NOT NULL;

 --LIKE AND NOT LIKE

 --you'll want to search for a pattern rather than a specific text string

SELECT x
FROM x
WHERE x LIKE 'x%';

--will return anything that has x at the start so 'xlab', 'xes'

SELECT name
FROM companies
WHERE name LIKE 'DataC_mp';

--will retun anythinbg like 'DataCamp, 'DataComp'

SELECT *
FROM  [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE ATT8 LIKE '%1'

SELECT *
FROM  [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE GENDER NOT LIKE '%F'


--##Aggregate functions

--(SUM, AVG, MAX, MIN)

--get the highest ATT8 score

SELECT MAX (ATT8)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--what's the  avg ATT8 score?

SELECT AVG (ATT8)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--and the lowest?

SELECT min (ATT8)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--What's the sum of ATT8

SELECT SUM (att8)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--##Combining aggregate functions with WHERE

SELECT SUM (ATT8)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
WHERE GENDER = 'M'

--##Aliasing

--assigning a temp name to something

SELECT MAX(ATT8) AS max_att8,
       MAX([P8SCORE]) AS max_p8
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

SELECT (MAX(ATT8) - MIN(Att8)) / 10.0
AS ATt8_po
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]

--##ORDER BY

--order pupils by pupil ref number

SELECT [PDR].[Tier1].[KS4_Pupil2_MasterView]
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
ORDER BY [PDR].[Tier1].[KS4_Pupil2_MasterView]

--DESC

--To order results in descending order, you can put the keyword DESC after your ORDER BY

--order by highest ATT8 score

SELECT ATT8
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
ORDER BY Att8 DESC


--Sorting multiple columns

--ORDER BY can also be used to sort on multiple columns
--It will sort by the first column specified, then sort by the next, then the next, and so on

SELECT ATT8, P8SCORE
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
ORDER BY P8SCORE, ATT8


--## GROUP BY

--Commonly, GROUP BY is used with aggregate functions like COUNT() or MAX(). Note that GROUP BY always goes after the FROM clause!

SELECT GENDER, count (*)
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
GROUP BY GENDER


--having two variables in the GROUP BY clause

SELECT Gender, [P8SCORE], MAX(ATT8) AS max_a8
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
GROUP BY Gender, [P8SCORE]
ORDER BY Gender, [P8SCORE];

--so this shows that the max att8 score for female pupils with a P8score of -6.67 is 2.00


--##HAVING

--In SQL, aggregate functions can't be used in WHERE clauses. This is where HAVING comes in useful

SELECT Gender, [P8SCORE], MAX(ATT8) AS max_a8
FROM [PDR].[Tier1].[KS4_Pupil2_MasterView]
GROUP BY Gender, [P8SCORE]
HAVING COUNT([P8SCORE]) > 1;





