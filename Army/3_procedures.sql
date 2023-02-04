USE [army]
GO

-- create a versioning mechanism that allows you to easily switch between database versions

-- modify the type of a column 

-- do
CREATE OR ALTER PROCEDURE [setRankSalaryDouble]
AS
ALTER TABLE [ranks] ALTER COLUMN [salary] FLOAT(53)
GO

-- undo
CREATE OR ALTER PROCEDURE [setRankSalaryFloat]
AS
ALTER TABLE [ranks] ALTER COLUMN [salary] FLOAT(24)
GO


-- add/remove a column

-- do
CREATE OR ALTER PROCEDURE [addPersonMiddleName]
AS
ALTER TABLE [persons] ADD [mname] NVARCHAR(255)
GO

-- undo
CREATE OR ALTER PROCEDURE [removePersonMiddleName]
AS
ALTER TABLE [persons] DROP COLUMN [mname]
GO


-- add/remove a default constraint

-- do
CREATE OR ALTER PROCEDURE [addLocationsDefaultConstraint]
AS
ALTER TABLE [locations] ADD CONSTRAINT [DEFAULT_PRECISE] DEFAULT 1 FOR [precise]
GO

-- undo
CREATE OR ALTER PROCEDURE [removeLocationsDefaultConstraint]
AS
ALTER TABLE [locations] DROP CONSTRAINT [DEFAULT_PRECISE]
GO


-- create/drop table

-- do
CREATE OR ALTER PROCEDURE [addSoldierHistoryTable]
AS
CREATE TABLE [soldier_history]
(
    [ssn] INT NOT NULL FOREIGN KEY REFERENCES [soldiers]([ssn]),
    CONSTRAINT [PK_Soldier_History] PRIMARY KEY([ssn]),
    [disid] INT NOT NULL,

    [date] DATETIME2 NOT NULL,
    [desc] NVARCHAR(255) NOT NULL,
)
GO

-- undo
CREATE OR ALTER PROCEDURE [dropSoldierHistoryTable]
AS
DROP TABLE [soldier_history]
GO


-- add/remove primary key

-- do
CREATE OR ALTER PROCEDURE [addDatePrimaryKeyToSoldierHistory]
AS
ALTER TABLE [soldier_history]
		DROP CONSTRAINT [PK_Soldier_History]

ALTER TABLE [soldier_history]
		ADD CONSTRAINT [PK_Soldier_History] PRIMARY KEY([ssn], [date])
GO

-- undo
CREATE OR ALTER PROCEDURE [removeDatePrimaryKeyFromSoldierHistory]
AS
ALTER TABLE [soldier_history]
		DROP CONSTRAINT [PK_Soldier_History]

ALTER TABLE [soldier_history]
		ADD CONSTRAINT [PK_Soldier_History] PRIMARY KEY([ssn])
GO


-- add/remove a candidate key

-- do
CREATE OR ALTER PROCEDURE [addCandidateKeyToPersons]
AS
ALTER TABLE [persons]
		ADD CONSTRAINT [CK_Persons] UNIQUE([fname], [lname])
GO

-- undo
CREATE OR ALTER PROCEDURE [removeCandidateKeyFromPersons]
AS
ALTER TABLE [persons]
		DROP CONSTRAINT [CK_Persons]
GO


-- add/remove a foreign key

-- do
CREATE OR ALTER PROCEDURE [addForeignKeyToSoldierHistory]
AS
ALTER TABLE [soldier_history]
		ADD CONSTRAINT [FK_Soldier_History] FOREIGN KEY([disid]) REFERENCES [disputes]([disid]) 
GO

-- undo
CREATE OR ALTER PROCEDURE [removeForeignKeyFromSoldierHistory]
AS
ALTER TABLE [soldier_history]
		DROP CONSTRAINT [FK_Soldier_History]
GO


-- create a table that contains the current version of the database

CREATE TABLE [version_table]
(
    [version] INT NOT NULL
)


-- insert into version_table the initial version

INSERT INTO [version_table]
VALUES
    (1)


-- create a table that contains the initial version, the version after the execution of the procedure 
-- and the name of the procedure that was called to modify the table 

CREATE TABLE [procedures]
(
    [from_version] INT NOT NULL,
    [to_version] INT NOT NULL,
    CONSTRAINT [PK_Procedures] PRIMARY KEY([from_version], [to_version]),

    [name] NVARCHAR(255)
)


INSERT INTO [procedures]
VALUES
    (1, 2, 'setRankSalaryDouble'),
    (2, 1, 'setRankSalaryFloat'),
    (2, 3, 'addPersonMiddleName'),
    (3, 2, 'removePersonMiddleName'),
    (3, 4, 'addLocationsDefaultConstraint'),
    (4, 3, 'removeLocationsDefaultConstraint'),
    (4, 5, 'addSoldierHistoryTable'),
    (5, 4, 'dropSoldierHistoryTable'),
    (5, 6, 'addDatePrimaryKeyToSoldierHistory'),
    (6, 5, 'removeDatePrimaryKeyFromSoldierHistory'),
    (6, 7, 'addCandidateKeyToPersons'),
    (7, 6, 'removeCandidateKeyFromPersons'),
    (7, 8, 'addForeignKeyToSoldierHistory'),
    (8, 7, 'removeForeignKeyFromSoldierHistory')
GO

-- main procedure to switch between database versions

-- START PROCEDURE
GO
CREATE OR ALTER PROCEDURE [goToVersion](@new_version INT)
AS
DECLARE @current_version INT
DECLARE @name VARCHAR(MAX)
SELECT @current_version = [version]
FROM [version_table]

IF (@new_version > (SELECT MAX([to_version])
    FROM [procedures]) OR @new_version < 1)
	BEGIN
    PRINT('Invalid version!')
    RETURN
END

IF @new_version = @current_version
		PRINT('You are already on this version!')
	ELSE
	BEGIN
    WHILE @new_version < @current_version 
		BEGIN
        SELECT @name = [name]
        FROM [procedures]
        WHERE [from_version] = @current_version AND [to_version] = @current_version - 1

        PRINT('Executing ' + @name)
        EXECUTE(@name)
        SET @current_version = @current_version - 1
    END

    WHILE @new_version > @current_version 
		BEGIN
        SELECT @name = [name]
        FROM [procedures]
        WHERE [from_version] = @current_version AND [to_version] = @current_version + 1

        PRINT('Executing ' + @name)
        EXECUTE(@name)
        SET @current_version = @current_version + 1
    END
END

UPDATE [version_table] 
	   SET [version] = @new_version
GO
-- END PROCEDURE


SELECT *
FROM [procedures]


SELECT *
FROM [version_table]


EXECUTE [goToVersion] 1
EXECUTE [goToVersion] 2
EXECUTE [goToVersion] 3
EXECUTE [goToVersion] 4
EXECUTE [goToVersion] 5
EXECUTE [goToVersion] 6
EXECUTE [goToVersion] 7
EXECUTE [goToVersion] 8


SELECT *
FROM [version_table]
