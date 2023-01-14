-- CREATED BY 'davidcristian' FOR:
-- Microsoft SQL Server 2019 (RTM-CU18) (KB5017593) - 15.0.4261.1 (X64)
--			Sep 12 2022 15:07:06
--			Copyright (C) 2019 Microsoft Corporation
--			Developer Edition (64-bit) on Linux (Ubuntu 20.04.5 LTS) <X64>

-- -------------------------

-- FLOAT(24) => float  in C# (faster on 32-bit builds)
-- FLOAT(53) => double in C# (faster on 64-bit builds)

-- NVARCHAR: UNICODE
--  VARCHAR: ASCII
-- There is no point in using (N)VARCHAR lengths less than 255 because
-- they will all be stored in 1 byte. Using 255 allows for easy conversion
-- to C-style strings (255 + NULL char = 256) without sacrificing storage.

-- -------------------------

-- TODO:
-- - 
-- - 
-- - 

-- -------------------------

-- CREATE DATABASE
USE [master]
GO

ALTER DATABASE [army] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE IF EXISTS [army]
CREATE DATABASE [army]
GO

USE [army]
GO

-- -------------------------

-- CREATE TABLES
-- START 'SIMPLE' TABLES
CREATE TABLE [locations]
(
	[lid] INT PRIMARY KEY IDENTITY,
	-- if set to false, it means that only the country/city is valid
	-- example usage: 'persons' place of birth or place of death
	--[precise] NCHAR(1) NOT NULL CHECK([precise] IN('Y', 'N')),
	[precise] BIT NOT NULL,

	[latitude] FLOAT(24) NOT NULL,
	[longitude] FLOAT(24) NOT NULL,

	-- contains information like street, city/state, country, etc
	-- can be NULL for 'precise' locations like 'deployments'
	[desc] NVARCHAR(255)
)

CREATE TABLE [ranks]
(
	[rid] INT PRIMARY KEY IDENTITY,
	[name] NVARCHAR(255) NOT NULL,
	[abbr] NVARCHAR(255) NOT NULL,

	[salary] FLOAT(24) NOT NULL,
	[currency] NVARCHAR(255) NOT NULL
)

-- START 'ENUMS'
CREATE TABLE [award_type]
(
	[atid] INT PRIMARY KEY IDENTITY,
	[name] NVARCHAR(255) NOT NULL
)

CREATE TABLE [equipment_category]
(
	[ecid] INT PRIMARY KEY IDENTITY,
	[name] NVARCHAR(255) NOT NULL
)
-- END 'ENUMS'
-- END 'SIMPLE' TABLES

-- -------------------------

-- START 'ONE TO MANY' TABLES (LINK CATEGORIES)
CREATE TABLE [awards]
(
	[aid] INT PRIMARY KEY IDENTITY,
	[atid] INT NOT NULL FOREIGN KEY REFERENCES [award_type]([atid]),

	[desc] NVARCHAR(255) NOT NULL,
	[abbr] NVARCHAR(255) NOT NULL
)

CREATE TABLE [equipment]
(
	[eid] INT PRIMARY KEY IDENTITY,
	[ecid] INT NOT NULL FOREIGN KEY REFERENCES [equipment_category]([ecid]),

	[desc] NVARCHAR(255) NOT NULL
)

CREATE TABLE [disputes]
(
	[disid] INT PRIMARY KEY IDENTITY,
	[lid] INT NOT NULL FOREIGN KEY REFERENCES [locations]([lid]),

	-- dispute start date
	[dsd] DATETIME2 NOT NULL,
	-- dispute end date (NULL if active)
	[ded] DATETIME2,

	[desc] NVARCHAR(255) NOT NULL
)
-- END 'ONE TO MANY' TABLES (LINK CATEGORIES)

-- -------------------------

-- START 'ONE TO ONE' AND 'ONE TO MANY' TABLES
CREATE TABLE [persons]
(
	-- not IDENTITY, generated before inserting
	[ssn] INT PRIMARY KEY,

	[fname] NVARCHAR(255) NOT NULL,
	[lname] NVARCHAR(255) NOT NULL,

	--[sex] BIT NOT NULL,		-- 0 for male, 1 for female
	[sex] NCHAR(1) NOT NULL CHECK(sex IN('M', 'F', 'O')),
	-- more inclusive
	[height] FLOAT(24) NOT NULL,
	[weight] FLOAT(24) NOT NULL,

	-- place of birth
	[pob] INT NOT NULL FOREIGN KEY REFERENCES [locations]([lid]),
	-- date of birth
	[dob] DATETIME2 NOT NULL,

	-- place of death (NULL if alive)
	[pod] INT FOREIGN KEY REFERENCES [locations]([lid]),
	-- date of death (NULL if alive)
	[dod] DATETIME2
)

CREATE TABLE [soldiers]
(
	[ssn] INT NOT NULL FOREIGN KEY REFERENCES [persons]([ssn]),
	CONSTRAINT [PK_Soldiers] PRIMARY KEY([ssn]),

	[rid] INT NOT NULL FOREIGN KEY REFERENCES [ranks]([rid]),

	-- start of service
	[sos] DATETIME2 NOT NULL,
	-- end of service (NULL if still active)
	[eos] DATETIME2,
)
-- END 'ONE TO ONE' AND 'ONE TO MANY' TABLES

-- -------------------------

-- START 'MANY TO MANY' TABLES
CREATE TABLE [decorations]
(
	[ssn] INT NOT NULL FOREIGN KEY REFERENCES [soldiers]([ssn]),
	[aid] INT NOT NULL FOREIGN KEY REFERENCES [awards]([aid]),
	CONSTRAINT [PK_Decorations] PRIMARY KEY([ssn], [aid]),

	[desc] NVARCHAR(255) NOT NULL DEFAULT ''
)

CREATE TABLE [inventories]
(
	[ssn] INT NOT NULL FOREIGN KEY REFERENCES [soldiers]([ssn]),
	[eid] INT NOT NULL FOREIGN KEY REFERENCES [equipment]([eid]),
	CONSTRAINT [PK_Inventories] PRIMARY KEY([ssn], [eid]),

	[quantity] INT NOT NULL DEFAULT 1
)

CREATE TABLE [squads] -- AKA deployments
(
	[ssn] INT NOT NULL FOREIGN KEY REFERENCES [soldiers]([ssn]),
	[disid] INT NOT NULL FOREIGN KEY REFERENCES [disputes]([disid]),
	CONSTRAINT [PK_Squads] PRIMARY KEY([ssn], [disid]),

	-- deployment start date
	[dsd] DATETIME2 NOT NULL,
	-- deployment end date (NULL if still active)
	[ded] DATETIME2,

	-- Squad Sergeant
	[sergeant] INT NOT NULL FOREIGN KEY REFERENCES [soldiers]([ssn])
)
-- END 'MANY TO MANY' TABLES
