USE [army]
GO

DROP TABLE IF EXISTS [locker]
DROP TABLE IF EXISTS [magazine]
DROP TABLE IF EXISTS [weapon]
GO

-- CREATE TABLES
CREATE TABLE [weapon]
(
    [wid] INT PRIMARY KEY,
    [serial] INT UNIQUE,
    [ammo] INT
)

CREATE TABLE [magazine]
(
    [mid] INT PRIMARY KEY,
    [capacity] INT
)

CREATE TABLE [locker]
(
    [lid] INT PRIMARY KEY,
    [wid] INT FOREIGN KEY REFERENCES [weapon]([wid]),
    [mid] INT FOREIGN KEY REFERENCES [magazine]([mid])
)
GO

-- CREATE PROCEDURES TO INSERT DATA
CREATE OR ALTER PROCEDURE generateWeapons(@rows INT)
AS
BEGIN
    DECLARE @val INT
    SET @val = @rows * 2 + 250

    WHILE @rows > 0
	BEGIN
        INSERT INTO [weapon]
            ([wid], [serial], [ammo])
        VALUES
            (@rows, @val, @val % 250)

        SET @rows = @rows - 1
        SET @val = @val - 2
    END
END
GO

CREATE OR ALTER PROCEDURE generateMagazines(@rows INT)
AS
BEGIN
    WHILE @rows > 0 
	BEGIN
        INSERT INTO [magazine]
            ([mid], [capacity])
        VALUES(@rows, @rows % 500)

        SET @rows = @rows - 1
    END
END
GO

CREATE OR ALTER PROCEDURE generateLockers(@rows INT)
AS
BEGIN
    DECLARE @aid INT
    DECLARE @bid INT

    WHILE @rows > 0
	BEGIN
        SET @aid = (SELECT TOP 1 [wid]
        FROM [weapon]
        ORDER BY NEWID())

        SET @bid = (SELECT TOP 1 [mid]
        FROM [magazine]
        ORDER BY NEWID())

        INSERT INTO [locker]
            ([lid], [wid], [mid])
        VALUES(@rows, @aid, @bid)

        SET @rows = @rows - 1
    END
END
GO

-- RUN PROCEDURES
EXEC generateWeapons 5000
EXEC generateMagazines 10000
EXEC generateLockers 2500
GO

SELECT *
FROM [weapon]

SELECT *
FROM [magazine]

SELECT *
FROM [locker]
GO

/* 
- We have a clustered index automatically created for the [wid] column from [weapon]
- We have a nonclustered index automatically created for the [serial] column from [weapon]
- We have a clustered index automatically created for the [mid] column from [magazine]
- We have a clustered index automatically created for the [lid] column from [locker]
*/

-- a) Write queries on [weapon] such that their execution plans contain the following operators:
-- clustered index scan - scan the entire table 
-- Cost: 0.0176709
SELECT *
FROM [weapon]

-- clustered index seek - return a specific subset of rows from a clustered index
-- Cost: 0.0034459
SELECT *
FROM [weapon]
WHERE [wid] < 150

-- nonclustered index scan - scan the entire nonclustered index
-- Cost: 0.0147079
SELECT [serial]
FROM [weapon]
ORDER BY [serial]

-- nonclustered index seek - return a specific subset of rows from a nonclustered index
-- Cost: 0.0032963
SELECT [serial]
FROM [weapon]
WHERE [serial] BETWEEN 250 AND 275

-- key lookup - nonclustered index seek + key lookup - the data is found in a nonclustered index, but additional data is needed
-- Cost: 0.0065704
SELECT [ammo], [serial]
FROM [weapon]
WHERE [serial] = 450
GO

-- b) Write a query on table [magazine] with a WHERE clause of the form WHERE [capacity] = value and analyze its execution plan. Create a nonclustered index that can speed up the query. Examine the execution plan again.
-- Before creating a nonclustered index we have a clustered index scan with the cost: 0.0298376
-- After creating the nonclustered index on [capacity], we have a noclustered index seek with the cost: 0.003304
SET NOCOUNT ON
GO
SET SHOWPLAN_ALL ON
GO

SELECT *
FROM [magazine]
WHERE [capacity] = 150
GO

SET SHOWPLAN_ALL OFF
GO

-- c) Create a view that joins at least 2 tables. Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.
-- Automatically created indexes: 0.173374
-- Automatically created indexes + nonclustered index on [capacity]: 0.143982
-- When adding a nonclustered index on [ammo] to the existing indexes: 0.134197
-- Automatically created indexes + nonclustered index on [capacity] + nonclustered index on [ammo] + nonclustered index on ([wid], [mid]) from [locker]: 0.133456
CREATE OR ALTER VIEW [ViewOne]
AS
    SELECT A.[wid], B.[mid], C.[lid]
    FROM [locker] C
        INNER JOIN [weapon] A ON A.[wid] = C.[wid]
        INNER JOIN [magazine] B ON B.[mid] = C.[mid]
    WHERE B.[capacity] > 450 AND A.[ammo] < 150
GO

SELECT *
FROM [ViewOne]
GO

IF EXISTS (SELECT [NAME] FROM sys.indexes WHERE [name]='N_idx_Weapon_ammo')
DROP INDEX [N_idx_Weapon_ammo] ON [weapon]
CREATE NONCLUSTERED INDEX [N_idx_Weapon_ammo] ON [weapon]([ammo])

IF EXISTS (SELECT [NAME] FROM sys.indexes WHERE [name]='N_idx_Magazine_capacity')
DROP INDEX [N_idx_Magazine_capacity] ON [magazine]
CREATE NONCLUSTERED INDEX [N_idx_Magazine_capacity] ON [magazine]([capacity])

IF EXISTS (SELECT [NAME] FROM sys.indexes WHERE [name]='N_idx_Locker_wid_mid')
DROP INDEX [N_idx_Locker_wid_mid] ON [locker]
CREATE NONCLUSTERED INDEX [N_idx_Locker_wid_mid] ON [locker]([wid], [mid])
GO
