USE [army]
GO

-- SELECT DATA
-- a. 2 queries with the union operation; use UNION [ALL] and OR;

-- find the ssn of the soldiers that have 90 or 120 pieces of one equipment and those that have finished a deployment
    SELECT [I].[ssn]
    FROM [inventories] I
    WHERE [I].[quantity] = 90 OR [I].[quantity] = 120
UNION ALL
    SELECT [S].[ssn]
    FROM [squads] S
    WHERE [S].[ded] IS NOT NULL

-- find the ssn of the top 3 persons that have a Medal of Honor or were born at location 2
    SELECT TOP 3
        [D].[ssn] AS [ID]
    FROM [decorations] D
    WHERE [D].[aid] = 1
UNION
    SELECT TOP 3
        [P].[ssn] AS [ID]
    FROM [persons] P
    WHERE [P].[pob] = 6


-- b. 2 queries with the intersection operation; use INTERSECT and IN;

-- find the ssn of the soldiers who have an M4A1 or an M240B
    SELECT [S].[ssn]
    FROM [soldiers] S
INTERSECT
    SELECT [I].[ssn]
    FROM [inventories] I
    WHERE [I].[eid] IN (3, 5)


-- find the ssn of the soldiers who were in at least one deployment
    SELECT [S].[ssn]
    FROM [soldiers] S
INTERSECT
    SELECT [D].[ssn]
    FROM [squads] D


-- c. 2 queries with the difference operation; use EXCEPT and NOT IN;

-- find the ssn of the soldiers who were never deployed
    SELECT [S].[ssn]
    FROM [soldiers] S
EXCEPT
    SELECT [D].[ssn]
    FROM [squads] D


-- find the ssn of the soldiers and exclude those that do not have their first name 'John' or 'Jane'
    SELECT [S].[ssn]
    FROM [soldiers] S
EXCEPT
    SELECT [P].[ssn]
    FROM [persons] P
    WHERE [P].[fname] NOT IN ('John', 'Jane')


-- d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); 
-- one query will join at least 3 tables, while another one will join at least two many-to-many relationships;

-- 2 m:n relations
-- show the inventories for every soldier for every dispute
SELECT [P].[ssn], [P].[fname], [P].[lname], [D].[disid], [I].eid, [I].[quantity]
FROM ((([persons] P
    INNER JOIN [soldiers] S
    ON [S].[ssn] = [P].[ssn])
    INNER JOIN [squads] D
    ON [D].[ssn] = [S].[ssn])
    INNER JOIN [inventories] I
    ON [I].[ssn] = [S].[ssn])


-- show the people born in every location
SELECT [L].[lid], [L].[desc], [P].[ssn]
FROM ([locations] L
    LEFT JOIN [persons] P
    ON [P].[pob] = [L].[lid])


-- show the rank of every person
SELECT [P].[ssn], [P].[fname], [P].[lname], [S].[rid]
FROM ([soldiers] S
    RIGHT JOIN [persons] P
    ON [P].[ssn] = [S].[ssn])


-- find the name and place of birth of the top 5 persons who have been in at least one deployment, ordered by name
SELECT DISTINCT TOP 5
    [P].[fname], [P].[lname], [L].[desc]
FROM ([persons] P
    FULL JOIN [squads] D
    ON [D].[ssn] = [P].[ssn]
    INNER JOIN [locations] L
    ON [L].[lid] = [P].[pob])
ORDER BY [P].[fname], [P].[lname]


-- e. 2 queries with the IN operator and a subquery in the WHERE clause; 
-- in at least one case, the subquery must include a subquery in its own WHERE clause;

-- find the name of the soldiers that have a rank that pays more than 1000
SELECT [S].[ssn], [P].[fname], [P].[lname]
FROM ([soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn])
WHERE [S].[rid] IN (
			SELECT [R].[rid]
FROM [ranks] R
WHERE [R].[salary] > 1000
			)


-- find the names of the soldiers that have one or more equipment in the same category as any Grenade
SELECT [S].[ssn], [P].[fname], [P].[lname]
FROM ([soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn])
WHERE [S].[ssn] IN (
			SELECT [I].[ssn]
FROM [inventories] I
WHERE [I].[quantity] >= 1 AND [I].[eid] IN (
        SELECT [EC].[eid]
    FROM [equipment] EC
    WHERE [EC].[desc] LIKE '%Grenade' 
        )
    )


-- f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;

-- find the names of the soldiers that are currently deployed
SELECT [S].[ssn], [P].[fname], [P].[lname]
FROM ([soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn])
WHERE EXISTS (
        SELECT *
FROM [squads] D
WHERE [D].[ssn] = [S].[ssn] and [D].[ded] IS NULL
        )


-- find the names of the soldiers that are squad sergeants in a dispute and have a weight between 70 and 80
SELECT [S].[ssn], [P].[fname], [P].[lname]
FROM ([soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn])
WHERE EXISTS ( 
		SELECT *
FROM [squads] D
WHERE [S].[ssn] = [D].[sergeant] AND ([P].[weight] BETWEEN 70 AND 80)
)

-- g. 2 queries with a subquery in the FROM clause;    

-- find all soldiers taller than 160 which are female 
SELECT [R].[fname], [R].[lname], [R].[height], [R].[weight]
FROM (
	  SELECT [P].[fname], [P].[lname], [P].[height], [P].[weight]
    FROM [soldiers] S
        INNER JOIN [persons] P
        ON [P].[ssn] = [S].[ssn]
    WHERE [P].[sex] = 'F'
	   ) AS R
WHERE [R].[height] >= 160


-- find the full name and salary of the soldiers that are deployed and have a salary greater than or equal to 600
SELECT [RR].[fname], [RR].[lname], [RR].[salary]
FROM (
	  SELECT [P].[fname], [P].[lname], [R].[salary]
    FROM [soldiers] S
        INNER JOIN [persons] P
        ON [P].[ssn] = [S].[ssn]
        INNER JOIN [ranks] R
        ON [R].[rid] = [S].[rid]
        RIGHT JOIN [squads] D
        ON [D].[ssn] = [S].[ssn]
    GROUP BY [P].[fname], [P].[lname], [R].[salary]
	   ) AS RR
WHERE [RR].[salary] >= 600


-- h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause;
-- use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

-- find the soldiers taller than 160 that have been deployed at least twice
SELECT [S].[ssn], [P].[fname], [P].[lname], [P].[height]
FROM ([soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn])
WHERE [P].[height] >= 160
GROUP BY [S].[ssn], [P].[fname], [P].[lname], [P].[height]
HAVING 2 <= (
			SELECT COUNT(*)
FROM [squads] D
WHERE [D].[ssn] = [S].[ssn]
			)


-- find the soldier with the most awards
SELECT [P].[ssn], [P].[fname], [P].[lname], COUNT(*) AS [number_of_awards]
FROM [decorations] A
    INNER JOIN [persons] P
    ON [P].[ssn] = [A].[ssn]
GROUP BY [P].[ssn], [P].[fname], [P].[lname]
HAVING COUNT(*) = (
					SELECT MAX([t].[C])
FROM (
						  SELECT COUNT(*) [C]
    FROM [soldiers] S
        INNER JOIN [persons] P
        ON [P].[ssn] = [S].[ssn]
        INNER JOIN [decorations] CS
        ON [P].[ssn] = [CS].[ssn]
    GROUP BY [P].[ssn], [P].[fname], [P].[lname]
					      ) [t]
		             )


-- find the salaries * 3 of the soldiers and for each salary the number of soldiers
SELECT [R].[salary] * 3, COUNT(*) as [number_of_soldiers]
FROM [soldiers] S
    INNER JOIN [ranks] R
    ON [R].[rid] = [S].[rid]
GROUP BY [R].[salary]


-- find the soldiers with more awards than average
SELECT [P].[ssn], [P].[fname], [P].[lname], COUNT(*) AS [number_of_awards]
FROM [decorations] A
    INNER JOIN [persons] P
    ON [P].[ssn] = [A].[ssn]
GROUP BY [P].[ssn], [P].[fname], [P].[lname]
HAVING COUNT(*) >= (
					 SELECT AVG([t].[C])
FROM (
					       SELECT COUNT(*) [C]
    FROM [soldiers] S
        INNER JOIN [persons] P
        ON [P].[ssn] = [S].[ssn]
        INNER JOIN [decorations] CS
        ON [P].[ssn] = [CS].[ssn]
    GROUP BY [P].[ssn], [P].[fname], [P].[lname]
					       ) [t]
					 )


-- i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); 
-- rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.

-- find then names of the persons born after the start date of all disputes
SELECT DISTINCT [P].[fname], [P].[lname]
FROM [persons] P
WHERE [P].[dob] > ALL (
    SELECT [D].[dsd]
FROM [disputes] D
WHERE [D].[ded] IS NULL
 )


-- find then names of the persons born after the start date of all disputes (aggregation operator)
SELECT DISTINCT [P].[fname], [P].[lname]
FROM [persons] P
WHERE [P].[dob] > (
    SELECT MAX([D].[dsd])
FROM [disputes] D
WHERE [D].[ded] IS NULL
 )


-- find the name and sex of the soldiers who have less of an item of equipment than the first entry over a quantity of 50
SELECT DISTINCT [P].[fname], [P].[lname], [P].[sex]
FROM [inventories] I
    INNER JOIN [persons] P
    ON [P].[ssn] = [I].[ssn]
WHERE [I].[quantity] < ANY (
	SELECT [I].[quantity]
FROM [inventories] I
WHERE [I].[quantity] >= 50
	)


-- find the name and sex of the soldiers who have less of an item of equipment than the first entry over a quantity of 50 (aggregation operator)
SELECT DISTINCT [P].[fname], [P].[lname], [P].[sex]
FROM [inventories] I
    INNER JOIN [persons] P
    ON [P].[ssn] = [I].[ssn]
WHERE [I].[quantity] < (
	SELECT MIN([I].[quantity])
FROM [inventories] I
WHERE [I].[quantity] >= 50
	)


-- find the ssn, name and salary + 1000 for all soldiers that weigh less than 70
SELECT [S].[ssn], [P].[fname], [P].[lname], [R].[salary] + 1000
FROM [soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn]
    INNER JOIN [ranks] R
    ON [R].[rid] = [S].[rid]
WHERE [R].[salary] <> ALL (
     SELECT [R].[salary]
FROM [ranks] R
WHERE [P].[weight] < 70
	 )


-- find the ssn, name and salary + 1000 for all soldiers that weigh less than 70 (not in)
SELECT [S].[ssn], [P].[fname], [P].[lname], [R].[salary] + 1000
FROM [soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn]
    INNER JOIN [ranks] R
    ON [R].[rid] = [S].[rid]
WHERE [R].[salary] NOT IN (
     SELECT [R].[salary]
FROM [ranks] R
WHERE [P].[weight] < 70
	 )


-- find the names of the soldiers were in at least one deployment and have a height greater than or equal to 180
SELECT [P].[fname], [P].[lname]
FROM [soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn]
WHERE [S].[ssn] = ANY (
     SELECT [D].[ssn]
FROM [squads] D
WHERE [p].[height] >= 180
	 )


-- find the names of the soldiers were in at least one deployment and have a height greater than or equal to 180 (in)
SELECT [P].[fname], [P].[lname]
FROM [soldiers] S
    INNER JOIN [persons] P
    ON [P].[ssn] = [S].[ssn]
WHERE [S].[ssn] IN (
     SELECT [D].[ssn]
FROM [squads] D
WHERE [p].[height] >= 180
	 )
