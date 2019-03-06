/*
							"TavernDatabase2.sql"
	
	Created for: "Software Dev Bootcamp - DB Class #2 - Homework Assignment" Miles Technologies
	Date completed: 3/5/2019
	Created on: "Microsoft SQL Server Management Studio 17, Version 14.0.17289.0"
	Edited on: "Notepad++, Version 7.5.9"
	Version Control: "Git, Version 2.9.2.windows.1"
	Created by: Ryan Veitenheimer

Drops all database named "TavernDatabase2"
Creates database named "TavernDatabase2"
Uses "TavernDatabase2"

Drops the following tables:
	TavernInfo, EmployeeInfo, EmployeeRole, SupplyStorage, SupplyReceived, TavernServices, TavernServiceStatus,
	GuestLevel, GuestClass, GuestStatus, TavernGuests, TavernSales
	
Creates the following tables: 
	TavernInfo, EmployeeInfo, EmployeeRole, SupplyStorage, SupplyReceived, TavernServices, TavernServiceStatus,
	GuestLevel, GuestClass, GuestStatus, TavernGuests, TavernSales
	
Alters the tables to define Primary and Foreign Keys of select tables:
	PK_EmployeeRole, PK_SupplyReceived, PK_TavernSales
	FK_EmployeeInfo_EmployeeRole, FK_SupplyReceived_SupplyStorage, FK_SupplyReceived_TavernInfo, FK_TavernSales_TavernGuests, FK_TavernSales_TavernInfo
	
Inserts data into the following tables: 
	TavernInfo, EmployeeInfo, EmployeeRole, SupplyStorage, SupplyReceived, TavernServices, TavernServiceStatus,
	GuestLevel, GuestClass, GuestStatus, TavernGuests, TavernSales
	
Opens all data from each table for viewing in order of table creation
*/

--DROP DATABASE IF EXISTS TavernDatabase2;   --Removes this database if already created (uncomment if needed)
--GO

--CREATE DATABASE TavernDatabase2;           --Creates the database used to contain tables (uncomment if needed)
--GO

USE TavernDatabase2;                         --Uses created database for table creation
GO

/*
					*DROP TABLES*
					
Drops all tables in order for new table of the same name to be created
Drop tables are in order of Foreign Key dependencies
*/

DROP TABLE IF EXISTS TavernSales;
DROP TABLE IF EXISTS TavernGuests;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS GuestClass;
DROP TABLE IF EXISTS GuestLevel;
DROP TABLE IF EXISTS TavernServiceStatus;
DROP TABLE IF EXISTS TavernServices;
DROP TABLE IF EXISTS SupplyReceived;
DROP TABLE IF EXISTS SupplyStorage;
DROP TABLE IF EXISTS EmployeeInfo;
DROP TABLE IF EXISTS EmployeeRole;
DROP TABLE IF EXISTS TavernInfo;
GO

/*
					*CREATE TABLES*

Creates the following tables: 
	TavernInfo, EmployeeInfo, EmployeeRole, SupplyStorage, SupplyReceived, TavernServices, TavernServiceStatus,
	GuestLevel, GuestClass, GuestStatus, TavernGuests, TavernSales

	**Not all Primary Keys and Foreign Keys are defined here, others defined at ALTER TABLES (as noted)**
*/

CREATE TABLE TavernInfo (															--"TavernInfo", Primary Key (TavernID), main table, no dependencies
	TavernID SMALLINT CONSTRAINT [PK_TavernInfo] PRIMARY KEY IDENTITY(1, 1),
	TavernName VARCHAR(50) NOT NULL,
	TavernLocation VARCHAR(100) NOT NULL,
	NumberOfFloors SMALLINT NULL DEFAULT 1,
	TavernOwner VARCHAR(50) NOT NULL
);

CREATE TABLE EmployeeInfo (															--"EmployeeInfo", Primary Key (EmployeeID), dependent on "TavernInfo" Foreign Key (TavernID), dependent on "EmployeeRole" Foreign Key (RoleID) **defined at ALTER TABLES**  
	EmployeeID SMALLINT CONSTRAINT [PK_EmployeeInfo] PRIMARY KEY IDENTITY(1, 1),
	EmployeeName VARCHAR(50) NOT NULL,
	TavernID SMALLINT CONSTRAINT [FK_EmployeeInfo_TavernInfo] FOREIGN KEY REFERENCES TavernInfo(TavernID),
	RoleID SMALLINT NOT NULL
);

CREATE TABLE EmployeeRole (															--"EmployeeRole", Primary Key (RoleID) **defined at ALTER TABLES**, no dependencies
	RoleID SMALLINT NOT NULL IDENTITY(1, 1),
	RoleName VARCHAR(50) NOT NULL,
	RoleDescription VARCHAR(500) NOT NULL
);

CREATE TABLE SupplyStorage (
	SupplyID SMALLINT CONSTRAINT [PK_SupplyStorage] PRIMARY KEY IDENTITY(1, 1),		--"SupplyStorage", Primary Key (SupplyID), no dependencies
	SupplyName VARCHAR(50) NOT NULL,
	SupplyUnit VARCHAR(50) NOT NULL,
	SupplyCount INT NULL DEFAULT 0
);

CREATE TABLE SupplyReceived (														--"SupplyReceived", Primary Key (InvoiceID) **defined at ALTER TABLES**, dependent on "SupplyStorage" Foreign Key (SupplyID) **defined at ALTER TABLES**, dependent on "TavernInfo" Foreign Key (TavernID) **defined at ALTER TABLES**
	InvoiceID SMALLINT NOT NULL IDENTITY(1, 1),
	SupplyCost SMALLMONEY NULL DEFAULT 0.00,
	AmountReceived INT NOT NULL,
	DateOfPurchase DATE NOT NULL,
	SupplyID SMALLINT NOT NULL,
	TavernID SMALLINT NOT NULL
);

CREATE TABLE TavernServices (														--"TavernServices", Primary Key (ServiceID), dependent on "TavernInfo" Foreign Key (TavernID)
	ServiceID SMALLINT CONSTRAINT [PK_TavernServices] PRIMARY KEY IDENTITY(1, 1),
	ServiceName VARCHAR(50) NOT NULL,
	TavernID SMALLINT CONSTRAINT [FK_TavernServices_TavernInfo] FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

CREATE TABLE TavernServiceStatus (													--"TavernServiceStatus", Primary Key (StatusID), dependent on "TavernServices" Foreign Key (ServiceID)
	StatusID SMALLINT CONSTRAINT [PK_TavernServiceStatus] PRIMARY KEY IDENTITY(1, 1),
	StatusOfService VARCHAR(50) NOT NULL,
	ServiceID SMALLINT CONSTRAINT [FK_TavernServiceStatus_TavernServices] FOREIGN KEY REFERENCES TavernServices(ServiceID)
);

CREATE TABLE GuestStatus (															--"GuestStatus", Primary Key (GuestStatusID), no dependencies
	GuestStatusID SMALLINT CONSTRAINT [PK_GuestStatus] PRIMARY KEY IDENTITY(1, 1),
	GuestStatus VARCHAR(50) NOT NULL
);

CREATE TABLE GuestLevel (															--"GuestLevel", Primary Key (GuestLevelID), no dependencies
	GuestLevelID SMALLINT CONSTRAINT [PK_GuestLevel] PRIMARY KEY IDENTITY(1, 1),
	GuestLevel INT NOT NULL
);

CREATE TABLE GuestClass (															--"GuestClass", Primary Key (GuestClassID), no dependencies
	GuestClassID SMALLINT CONSTRAINT [PK_GuestClass] PRIMARY KEY IDENTITY(1, 1),
	GuestClass VARCHAR(50) NOT NULL
);

CREATE TABLE TavernGuests (															--"TavernGuests", Primary Key (GuestID), dependent on "GuestStatus" Foreign Key (GuestStatusID), dependent on "GuestLevel" Foreign Key (GuestLevelID), dependent on "GuestClass" Foreign Key (GuestClassID)
	GuestID SMALLINT CONSTRAINT [PK_TavernGuests] PRIMARY KEY IDENTITY(1, 1),
	GuestName VARCHAR(50) NOT NULL,
	GuestNotes VARCHAR(100) NULL DEFAULT 'No notes about this guest',
	GuestBirthDay DATE NOT NULL,
	GuestCakeDay DATE NOT NULL,
	GuestStatusID SMALLINT CONSTRAINT [FK_TavernGuests_GuestStatus] FOREIGN KEY REFERENCES GuestStatus(GuestStatusID),
	GuestLevelID SMALLINT CONSTRAINT [FK_TavernGuests_GuestLevel] FOREIGN KEY REFERENCES GuestLevel(GuestLevelID),
	GuestClassID SMALLINT CONSTRAINT [FK_TavernGuests_GuestClass] FOREIGN KEY REFERENCES GuestClass(GuestClassID)
);

CREATE TABLE TavernSales (															--"TavernSales", Primary Key (SalesID) **defined at ALTER TABLES**, dependent on "TavernGuests" Foreign Key (GuestID) **defined at ALTER TABLES**, dependent on "TavernInfo" Foreign Key (TavernID) **defined at ALTER TABLES**
	SalesID SMALLINT NOT NULL IDENTITY(1, 1),
	TypeOfService VARCHAR(50) NOT NULL,
	PriceOfService SMALLMONEY NOT NULL DEFAULT 0.00,
	DatePurchased DATE NOT NULL,
	AmountPurchased INT NOT NULL DEFAULT 0,
	GuestID SMALLINT NOT NULL,
	TavernID SMALLINT NOT NULL
);
GO

/* 
					*ALTER TABLES*

Alter tables to define the following primary keys:
	PK_EmployeeRole, PK_SupplyReceived, PK_TavernSales

Alter tables to define the following foreign keys:
	FK_EmployeeInfo_EmployeeRole, FK_SupplyReceived_SupplyStorage, FK_SupplyReceived_TavernInfo, FK_TavernSales_TavernGuests, FK_TavernSales_TavernInfo
					
*/

ALTER TABLE EmployeeRole ADD CONSTRAINT [PK_EmployeeRole] PRIMARY KEY (RoleID);
ALTER TABLE EmployeeInfo ADD CONSTRAINT [FK_EmployeeInfo_EmployeeRole] FOREIGN KEY (RoleID) REFERENCES EmployeeRole(RoleID);
ALTER TABLE SupplyReceived ADD CONSTRAINT [PK_SupplyReceived] PRIMARY KEY (InvoiceID);
ALTER TABLE SupplyReceived ADD CONSTRAINT [FK_SupplyReceived_SupplyStorage] FOREIGN KEY (SupplyID) REFERENCES SupplyStorage(SupplyID);
ALTER TABLE SupplyReceived ADD CONSTRAINT [FK_SupplyReceived_TavernInfo] FOREIGN KEY (TavernID) REFERENCES TavernInfo(TavernID);
ALTER TABLE TavernSales ADD CONSTRAINT [PK_TavernSales] PRIMARY KEY (SalesID);
ALTER TABLE TavernSales ADD CONSTRAINT [FK_TavernSales_TavernGuests] FOREIGN KEY (GuestID) REFERENCES TavernGuests(GuestID);
ALTER TABLE TavernSales ADD CONSTRAINT [FK_TavernSales_TavernInfo] FOREIGN KEY (TavernID) REFERENCES TavernInfo(TavernID);
GO

/*
					*INSERT DATA*

Inserts data into the following tables: 
	TavernInfo, EmployeeInfo, EmployeeRole, SupplyStorage, SupplyReceived, TavernServices, TavernServiceStatus,
	GuestLevel, GuestClass, GuestStatus, TavernGuests, TavernSales
*/

INSERT INTO TavernInfo					--"TavernInfo" Attributes: (TavernID (SMALLINT AUTO PK), TavernName (VARCHAR(50)), TavernLocation (VARCHAR (100)), NumberOfFloors (SMALLINT NULL DEFAULT 1), TavernOwner (VARCHAR(50)) 
VALUES 
('The Pathetic Lord', 'Atlantic City, NJ', 2, 'Jacki Wade'),
('The Wrong Butterfly Tavern', 'Atlantic City, NJ', 2, 'Jacki Wade'),
('The Oceanic Whale Inn', 'Atlantic City, NJ', 3, 'Daria Cedillo'),
('The Devilish Plate Tavern', 'Newark, NJ', 1, 'Hilda Talor'),
('The Filthy Lettuce Bar', 'Newark, NJ', 3, 'Leena Dungan'),
('The Oceanic Whale Inn', 'Riverton, NJ', 2, 'Daria Cedillo'),
('The Solid Cliff Pub', 'Lumberton, NJ', 3, 'Kali Carrick'),
('The Talented Carrot Tavern', 'Palmyra, NJ', 1, 'Stanley Bosch');

INSERT INTO EmployeeRole				--"EmployeeRole" Attributes: (RoleID (SMALLINT AUTO PK), RoleName (VARCHAR(50)), RoleDescription (VARCHAR(500)))
VALUES
('Bartender', 'Makes drinks'),
('Server', 'Takes food orders'),
('Cook', 'Makes food'),
('Dish Washer', 'Washes dishes'),
('Manager', 'Manages shift');

INSERT INTO EmployeeInfo				--"EmployeeInfo" Attributes: (EmployeeID (SMALLINT AUTO PK), EmployeeName (VARCHAR(50)), TavernID (SMALLINT FK), RoleID (SMALLINT FK))
VALUES
('Lana Vu', 1, 1),
('Nadine Dempster', 2, 2),
('Troy Mustafa', 3, 3),
('Nona Leggio', 4, 4),
('Leigh Panton', 5, 5),
('Tabitha Bombard', 6, 5),
('Micaela Goudeau', 7, 4),
('Reggie Paden', 8, 2),
('Myrtle Dorr', 1, 1),
('Darlena Boyce', 2, 3),
('Marguerite Leath', 3, 5),
('Pedro Thorpe', 4, 4),
('Concetta Knop', 5, 2),
('Lynda Calahan', 6, 2),
('Isaac Baca', 7, 1),
('Magan Madkins', 8, 5),
('Kesha Alberson', 1, 1),
('Karissa Hartley', 2, 5),
('Ike Vidaurri', 3, 3),
('Amee Adan', 4, 4),
('Tomas Escamilla', 5, 2),
('Carrie Harrigan', 6, 1),
('Lorrie Paskett', 7, 4),
('Karon Settles', 8, 1);

INSERT INTO SupplyStorage 				--"SupplyStorage" Attributes: (SupplyID (SMALLINT AUTO PK), SupplyName (VARCHAR(50)), SupplyUnit (VARCHAR(50)), SupplyCount (INT NULL DEFAULT 0))
VALUES
('Beer', 'Pint', 5000),
('Vodka', 'Gallon', 1000),
('Gin', 'Gallon', 1000),
('Whiskey', 'Gallon', 1000),
('Rum', 'Gallon', 1000),
('Tequila', 'Gallon', 1000);

INSERT INTO SupplyReceived				--"SupplyReceived" Attributes: (InvoiceID (SMALLINT AUTO PK), SupplyCost (SMALLMONEY NULL DEFAULT 0.00), AmountReceived (INT), DateOfPurchase (DATE), SupplyID (SMALLINT FK), TavernID (SMALLINT FK))
VALUES
(50.00, 100, '2019-01-13', 1, 1),
(50.00, 100, '2019-01-13', 1, 2),
(50.00, 100, '2019-02-01', 2, 3),
(50.00, 100, '2019-03-15', 2, 4),
(50.00, 100, '2019-02-04', 1, 5),
(50.00, 100, '2019-01-15', 1, 6),
(50.00, 100, '2019-02-17', 1, 7),
(50.00, 100, '2019-03-15', 4, 7);

INSERT INTO TavernServices				--"TavernServices" Attributes: (ServiceID (SMALLINT AUTO PK), ServiceName (VARCHAR(50)), TavernID (SMALLINT FK))
VALUES
('Shoe Shining', 1),
('Shoe Shining', 2),
('Shoe Shining', 3),
('Poker', 4),
('Poker', 5),
('Blackjack', 6),
('Arm Wrestling', 7);

INSERT INTO TavernServiceStatus			--"TavernServiceStatus" Attributes: (StatusID (SMALLINT AUTO PK), StatusOfService (VARCHAR(50)), ServiceID (SMALLINT FK))
VALUES
('Active', 1),
('Inactive', 2),
('Active', 3),
('Active', 4),
('Active', 5),
('Active', 6),
('Inactive', 7);

INSERT INTO GuestStatus					--"GuestStatus" Attributes: (GuestStatusID (SMALLINT AUTO PK), GuestStatus (VARCHAR(50)))
VALUES 
('Happy'),
('Hungry'),
('Angry'),
('Hangry'),
('Sick'),
('Fine');

INSERT INTO GuestLevel					--"GuestLevel" Attributes: (GuestLevelID (SMALLINT AUTO PK), GuestLevel (INT))
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

INSERT INTO GuestClass					--"GuestClass" Attributes: (GuestClassID (SMALLINT AUTO PK), GuestClass (VARCHAR(50)))
VALUES
('Mage'),
('Warrior'),
('Fighter'),
('Wizard'),
('Bard'),
('Drunk'),
('Necromancer'),
('Archer');

INSERT INTO TavernGuests 				--"TavernGuests" Attributes: (GuestID (SMALLINT AUTO PK), GuestName (VARCHAR(50)), GuestNotes (VARCHAR(100)), GuestBirthDay (DATE), GuestCakeDay (DATE), GuestStatusID (SMALLINT FK), GuestLevelID (SMALLINT FK), GuestClassID (SMALLINT FK))
VALUES
('Alicia Moncayo', 'Likes beer', '1990-09-03', '2019-09-03', 1, 1, 1),
('Vada Getman', 'Likes vodka', '1989-08-02', '2019-08-02', 1, 10, 2),
('Crystle Farnes', 'Starts trouble', '1988-04-03', '2019-04-03', 2, 11, 3),
('Nisha Dobbin', 'Lightweight drinker', '1978-11-15', '2019-11-15', 1, 2, 4),
('Doreatha Pfeiffer', 'Tips well', '1990-11-02', '2019-11-02', 3, 15, 5),
('Sabra Newman', 'Likes whiskey', '1993-02-14', '2019-02-14', 4, 20, 6),
('Crissy Davisson', 'Likes beer', '1995-12-20', '2019-12-20', 5, 19, 7),
('Sabina Modlin', 'Doesn''t tip', '1990-09-03', '2019-09-03', 6, 3, 8),
('Edmond Osborne', 'Talks too much', '1980-04-05', '2019-04-05', 5, 12, 8),
('Azucena Smit', 'Tips well', '1991-06-14', '2019-06-14', 6, 12, 1),
('Adrianne Wheaton', 'Starts trouble', '1979-01-12', '2019-01-12', 2, 13, 3),
('Ramiro Sagucio', 'Likes beer', '1990-03-27', '2019-03-27', 3, 5, 5),
('Tatum Byard', 'Likes gin', '1990-04-19', '2019-04-19', 4, 5, 3),
('Wilber Shira', 'Likes beer', '1989-09-03', '2019-09-03', 4, 11, 7),
('Evelynn Massingale', 'Likes vodka', '1987-07-07', '2019-07-07', 6, 1, 6);

INSERT INTO TavernSales					--"TavernSales" Attributes: (SalesID (SMALLINT AUTO PK), TypeOfService (VARCHAR(50)), PriceOfService (SMALLMONEY), DatePurchased (DATE), AmountPurchased (INT), GuestID (SMALLINT FK), TavernID (SMALLINT FK))
VALUES
('Food', 12.00, '2019-01-01', 1, 1, 1),
('Drinks', 15.00, '2019-01-02', 12, 3, 2),
('Food', 11.09, '2019-01-03', 1, 4, 3),
('Drinks', 12.12, '2019-01-02', 11, 2, 4),
('Food', 17.20, '2019-02-01', 1, 5, 5),
('Food', 20.25, '2019-02-11', 3, 6, 6),
('Drinks', 15.00, '2019-02-12', 13, 1, 7),
('Food', 11.00, '2019-03-01', 2, 3, 5),
('Food', 9.50, '2019-03-02', 1, 7, 1);
GO

/*
					*VIEW TABLES*
				
Opens all data from each table for viewing in order of table creation
*/

SELECT * FROM TavernInfo;
SELECT * FROM EmployeeInfo;
SELECT * FROM EmployeeRole;
SELECT * FROM SupplyStorage;
SELECT * FROM SupplyReceived;
SELECT * FROM TavernServices;
SELECT * FROM TavernServiceStatus;
SELECT * FROM GuestStatus;
SELECT * FROM GuestLevel;
SELECT * FROM GuestClass;
SELECT * FROM TavernGuests;
SELECT * FROM TavernSales;
GO

--End Of File