USE [army]
GO

-- a table with a single-column primary key and no foreign keys
CREATE OR ALTER PROCEDURE [addAwardTypes](@n INT)
AS
BEGIN
	DECLARE @i INT = 0
	WHILE @i < @n
	BEGIN
		INSERT INTO [award_type]
			([name])
		VALUES
			(CONCAT('Type ', @i))

		SET @i = @i + 1
	END
END
GO

CREATE OR ALTER PROCEDURE [deleteAwardTypes]
AS
BEGIN
	delete from [award_type] where [name] like 'Type %'
END
GO


-- a table with a single-column primary key and at least one foreign key
CREATE OR ALTER PROCEDURE [addAwards](@n INT)
AS
BEGIN
	DECLARE @type NVARCHAR(255) = (SELECT TOP 1
		[atid]
	FROM [award_type]
	WHERE [name] LIKE 'Type %')

	DECLARE @i INT = 0
	WHILE @i < @n
	BEGIN
		INSERT INTO [awards]
			([atid], [desc], [abbr])
		VALUES
			(@type, CONCAT('Award ', @i), CONCAT('AW', @i))

		SET @i = @i + 1
	END
END
GO

CREATE OR ALTER PROCEDURE [deleteAwards]
AS
BEGIN
	delete from [awards] where [desc] like 'Award %'
END
GO


-- a table with a multicolumn primary key
CREATE OR ALTER PROCEDURE [addDecorations](@n INT)
AS
BEGIN
	DECLARE @ssn INT
	DECLARE @aid INT

	DECLARE [addDecorationsCursor] CURSOR FOR SELECT [S].[ssn], [A].[aid]
	FROM
		(SELECT [aid]
		FROM [awards] [A]
		WHERE [desc] LIKE 'Award %') AS [A]
		CROSS JOIN [soldiers] [S]

	OPEN [addDecorationsCursor]

	DECLARE @i INT = 0
	WHILE @i < @n
	BEGIN
		FETCH NEXT FROM [addDecorationsCursor] INTO @ssn, @aid
		INSERT INTO [decorations]
			([ssn], [aid], [desc])
		VALUES
			(@ssn, @aid, CONCAT('Decoration ', @i))

		SET @i = @i + 1
	END

	CLOSE [addDecorationsCursor]
	DEALLOCATE [addDecorationsCursor]
END
GO

CREATE OR ALTER PROCEDURE [deleteDecorations]
AS
BEGIN
	delete from [decorations] where [desc] like 'Decoration %'
END
GO

-- EXECUTE [addAwardTypes] 3
-- SELECT *
-- FROM [award_type]

-- EXECUTE [addAwards] 10
-- SELECT *
-- FROM [awards]

-- -- 25 soldiers * 10 awards
-- EXECUTE [addDecorations] 250
-- SELECT *
-- FROM [decorations]

-- EXECUTE [deleteDecorations]
-- SELECT *
-- FROM [decorations]

-- EXECUTE [deleteAwards]
-- SELECT *
-- FROM [awards]

-- EXECUTE [deleteAwardTypes]
-- SELECT *
-- FROM [award_type]


-- a view with a SELECT statement operating on one table
CREATE OR ALTER VIEW [viewOne]
AS
	-- show all available awards
	SELECT [desc]
	FROM [awards]
GO

-- a view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator
CREATE OR ALTER VIEW [viewTwo]
AS
	-- show the rank of every person
	SELECT [P].[ssn], [P].[fname], [P].[lname], [S].[rid]
	FROM ([soldiers] S
		RIGHT JOIN [persons] P
		ON [P].[ssn] = [S].[ssn])
GO

-- a view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least one JOIN operator
CREATE OR ALTER VIEW [viewThree]
AS
	-- show the number of soldiers for each rank
	SELECT [S].[rid], COUNT([S].[rid]) AS [number_of_soldiers]
	FROM [soldiers] S
	GROUP BY [S].[rid]
GO


-- GENERIC RUN VIEW PROCEDURE
CREATE OR ALTER PROCEDURE [selectView]
	(@name NVARCHAR(255))
AS
BEGIN
	DECLARE @sql NVARCHAR(255) = 'SELECT * from ' + @name
	EXECUTE(@sql)
END
GO

-- EXECUTE [selectView] [ViewOne]
-- EXECUTE [selectView] [ViewTwo]
-- EXECUTE [selectView] [ViewThree]


-- ADD TEST INFORMATION
INSERT INTO [Tests]
	([Name])
VALUES
	('addAwardTypes'),
	('deleteAwardTypes'),
	('addAwards'),
	('deleteAwards'),
	('addDecorations'),
	('deleteDecorations'),
	('selectView')
INSERT INTO [Tables]
	([Name])
VALUES
	('award_types'),
	('awards'),
	('decorations')
INSERT INTO [Views]
	([Name])
VALUES
	('viewOne'),
	('viewTwo'),
	('viewThree')


INSERT INTO [TestViews]
	([TestID], [ViewID])
VALUES
	(7, 1),
	(7, 2),
	(7, 3)

-- Insertions
INSERT INTO [TestTables]
	([TestID], [TableID], [NoOfRows], [Position])
VALUES
	(1, 1, 10000, 1),
	(3, 2, 5000, 2),

	-- max 25 * 3rd value from above
	(5, 3, 2500, 3)
-- Deletions
INSERT INTO [TestTables]
	([TestID], [TableID], [NoOfRows], [Position])
VALUES
	(2, 1, -1, 3),
	(4, 2, -1, 2),
	(6, 3, -1, 1)
GO

--SELECT *
--FROM [Tables]
--SELECT *
--FROM [Tests]
--SELECT *
--FROM [TestTables]

--SELECT *
--FROM [Views]
--SELECT *
--FROM [TestViews]
--GO


-- CREATE TEST PROCEDURES
CREATE OR ALTER PROCEDURE [deleteTest](@testID INT)
AS
BEGIN
	DECLARE @tableID INT
	DECLARE @tableName NVARCHAR(255)

	DECLARE [deleteTestCursor] CURSOR
	FOR SELECT [TableID], [Name]
	FROM [Tests] INNER JOIN [TestTables] ON [Tests].[TestID] = [TestTables].[TestID]
	WHERE [Name] LIKE 'delete%'
	ORDER BY [Position]

	UPDATE [TestRuns]
	SET [StartAt] = GETDATE()
	WHERE [TestRunID] = @testID

	OPEN [deleteTestCursor]
	FETCH NEXT FROM [deleteTestCursor] INTO @tableID, @tableName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONCAT('Running ', @tableName)
		EXEC @tableName

		FETCH NEXT FROM [deleteTestCursor] INTO @tableID, @tableName
	END

	CLOSE [deleteTestCursor]
	DEALLOCATE [deleteTestCursor]
END
GO


CREATE OR ALTER PROCEDURE [insertTest](@testID INT)
AS
BEGIN
	DECLARE @noOfRows INT
	DECLARE @tableID INT
	DECLARE @tableName NVARCHAR(255)
	DECLARE @startTime DATETIME2
	DECLARE @endTime DATETIME2

	DECLARE [insertTestCursor] CURSOR
	FOR SELECT [TableID], [Name], [NoOfRows]
	FROM [Tests] INNER JOIN [TestTables] ON [Tests].[TestID] = [TestTables].[TestID]
	WHERE [Name] LIKE 'add%'
	ORDER BY [Position]

	OPEN [insertTestCursor]
	FETCH NEXT FROM [insertTestCursor] INTO @tableID, @tableName, @noOfRows

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONCAT('Running ', @tableName)

		SET @startTime = GETDATE()
		EXEC @tableName @noOfRows
		SET @endTime = GETDATE()

		INSERT INTO [TestRunTables]
			([TestRunID], [TableID], [StartAt], [EndAt])
		VALUES
			(@testID, @tableID, @startTime, @endTime)

		FETCH NEXT FROM [insertTestCursor] INTO @tableID, @tableName, @noOfRows
	end

	CLOSE [insertTestCursor]
	DEALLOCATE [insertTestCursor]
END
GO


CREATE OR ALTER PROCEDURE [viewsTest](@testID INT)
AS
BEGIN
	DECLARE @startTime DATETIME2
	DECLARE @endTime DATETIME2
	DECLARE @viewID INT
	DECLARE @viewName NVARCHAR(255)

	DECLARE [viewsTestCursor] CURSOR
	FOR SELECT [TestViews].[ViewID], [Name]
	FROM [Views] INNER JOIN [TestViews] ON [Views].[ViewID] = [TestViews].[ViewID]
	WHERE [Name] LIKE 'view%'
	ORDER BY [TestID]

	OPEN [viewsTestCursor]
	FETCH NEXT FROM [viewsTestCursor] INTO @viewID, @viewName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONCAT('Running view with name ', @viewName)

		SET @startTime = GETDATE()
		EXEC [selectView] @viewName
		SET @endTime = GETDATE()

		INSERT INTO [TestRunViews]
			([TestRunID], [ViewID], [StartAt], [EndAt])
		VALUES
			(@testID, @viewID, @startTime, @endTime)

		FETCH NEXT FROM [viewsTestCursor] INTO @viewID, @viewName
	END

	CLOSE [viewsTestCursor]
	DEALLOCATE [viewsTestCursor]

	UPDATE [TestRuns]
	SET [EndAt] = @endTime
	WHERE [TestRunID] = @testID
END
GO


CREATE OR ALTER PROCEDURE [mainTest]
AS
BEGIN
	INSERT INTO [TestRuns]
		([Description], [StartAt], [EndAt])
	VALUES
		('test -1', NULL, NULL)

	DECLARE @testID INT
	SET @testID = (SELECT MAX([TestRunID])
	FROM [TestRuns])

	UPDATE [TestRuns] 
   	SET [Description] = CONCAT('test ', @testID)
 	WHERE [TestRunID] = @testID

	PRINT CONCAT('Starting test ', @testID)

	-- deletion tests
	EXEC [deleteTest] @testID

	-- insertion tests
	EXEC [insertTest] @testID

	-- view tests
	EXEC [viewsTest] @testID
END
GO

-- RUN TESTS
EXEC mainTest

SELECT *
FROM [TestRunTables]

SELECT *
FROM [TestRunViews]

SELECT *
FROM [TestRuns]
