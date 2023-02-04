USE [army]
GO

-- UPDATE DATA
-- update the currency of the ranks that have 'EUR' or 'CAD' to 'USD'
SELECT *
FROM [ranks]

UPDATE [ranks]  
   SET [currency] = 'USD' 
 WHERE [currency] = 'EUR' OR [currency] = 'CAD'

SELECT *
FROM [ranks]


-- increase the weight by 3 for people who weigh between 70 and 80
SELECT *
FROM [persons]

UPDATE [persons]  
   SET [weight] = [weight] + 3
 WHERE [weight] BETWEEN 70 AND 80

SELECT *
FROM [persons]


-- double the salary for all ranks that have a salary less than or equal to 300
SELECT *
FROM [ranks]

UPDATE [ranks]  
   SET [salary] = [salary] * 2
 WHERE [salary] <= 300

SELECT *
FROM [ranks]


-- increase the quantity of equipment by 1 in all the inventories where the quantity is 2 or 4
SELECT *
FROM [inventories]

UPDATE [inventories]
   SET [quantity] = [quantity] + 1
 WHERE [quantity] IN (2, 4)

SELECT *
FROM [inventories]


-- DELETE DATA
-- delete all people with a height greater than or equal to 190
SELECT *
FROM [persons]

DELETE  
  FROM [persons]  
 WHERE [height] >= 190

SELECT *
FROM [persons]


-- delete all awards that have 'Overseas' in their description
SELECT *
FROM [awards]

DELETE  
  FROM [awards]  
 WHERE [desc] LIKE '%Overseas%'

SELECT *
FROM [awards]


-- delete all disputes that have an end date
SELECT *
FROM [disputes]

DELETE  
  FROM [disputes]  
 WHERE [ded] IS NOT NULL

SELECT *
FROM [disputes]
