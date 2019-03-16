/*
							"TavernDatabase5.sql"
	
	Created for: "Software Dev Bootcamp - DB Class #5 - Homework Assignment" Miles Technologies
	Date completed: 3/16/2019
	Created on: "Microsoft SQL Server Management Studio 17, Version 14.0.17289.0"
	Version Control: "Git, Version 2.9.2.windows.1"
	Created by: Ryan Veitenheimer

PROCEDURE:

DROPS/CREATES database named TavernDatabase3
DROPS all tables if they already exists
CREATES all tables and defines all CONSTRAINTS (PRIMARY KEYS, FOREIGN KEYS, UNIQUE, DEFAULT)
INSERTS all data into columns
ANSWERS TO PROBLEMS 1-7
*/

--DROP DATABASE IF EXISTS TavernDatabase5;
--CREATE DATABASE TavernDatabase5;           --Creates the database used to contain tables (uncomment if needed)
--GO

USE TavernDatabase5;                       
GO

/*
					*DROP TABLES*
					
Drops all tables in order for new table of the same name to be created
Drop tables are in order of Foreign Key dependencies
*/

DROP TABLE IF EXISTS RoomSales;
DROP TABLE IF EXISTS InnRooms;
DROP TABLE IF EXISTS InnRoomStatus;
DROP TABLE IF EXISTS TavernSales;
DROP TABLE IF EXISTS TavernServices;
DROP TABLE IF EXISTS TypesOfSevices;
DROP TABLE IF EXISTS TavernServiceStatus;
DROP TABLE IF EXISTS SupplyReceived;
DROP TABLE IF EXISTS SupplyStorage;
DROP TABLE IF EXISTS GuestClassLevel;
DROP TABLE IF EXISTS ClassTypes;
DROP TABLE IF EXISTS TavernGuests;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS GuestNotes;
DROP TABLE IF EXISTS EmployeeInfo;
DROP TABLE IF EXISTS EmployeeRole;
DROP TABLE IF EXISTS TavernInfo;
DROP TABLE IF EXISTS TavernLocation;
GO

/*
					*CREATE TABLES*

Creates the following tables: 
ClassTypes, EmployeeInfo, EmployeeRole, GuestClassLevel, GuestNotes, GuestStatus, InnRooms, InnRoomStatus, RoomSales,
SupplyReceived, SupplyStorage, TavernGuests, TavernInfo, TavernLocation, TavernSales, TavernServices, TavernServiceStatus, TypesOfSevices

Defines all CONSTRAINTS (PRIMARY KEYS, FOREIGN KEYS, UNIQUE, DEFAULT)
*/

CREATE TABLE TavernLocation (				--"TavernLocation": [PRIMARY KEY (locationId), no dependencies]
	locationId INT CONSTRAINT [PK_TavernLocation] PRIMARY KEY IDENTITY(1,1),
	locationName VARCHAR(100) NOT NULL CONSTRAINT [UQ_TavernLocation_locationName] UNIQUE(locationName)
);

CREATE TABLE TavernInfo (					--"TavernInfo": [PRIMARY KEY (tavernID), dependent on "TavernLocation" FOREIGN KEY (locationId)]						
	tavernId INT CONSTRAINT [PK_TavernInfo] PRIMARY KEY IDENTITY(1,1),
	tavernName VARCHAR(100) NOT NULL,
	tavernOwner VARCHAR(100) NOT NULL,
	numberOfFloors TINYINT NOT NULL CONSTRAINT [DF_TavernInfo_numberOfFloors] DEFAULT 1,													
	tavernLocation INT NOT NULL CONSTRAINT [FK_TavernInfo_TavernLocation] FOREIGN KEY (tavernLocation) REFERENCES TavernLocation(locationId)
);

CREATE TABLE EmployeeRole (					--"EmployeeRole": [PRIMARY KEY (roleId), no dependencies]
	roleId INT CONSTRAINT [PK_EmployeeRole] PRIMARY KEY IDENTITY(1,1),
	roleName VARCHAR(100) NOT NULL CONSTRAINT [UQ_EmployeeRole_roleName] UNIQUE(roleName),
	roleDescription VARCHAR(500) NOT NULL
);

CREATE TABLE EmployeeInfo (					--"EmployeeInfo": [PRIMARY KEY (employeeId), dependent on "EmployeeRole" FOREIGN KEY (roleId), dependent on "TavernInfo" FOREIGN KEY (tavernId)]
	employeeId INT CONSTRAINT [PK_EmployeeInfo] PRIMARY KEY IDENTITY(1,1),
	employeeName VARCHAR(100) NOT NULL,
	employeeRole INT NOT NULL CONSTRAINT [FK_EmployeeInfo_EmployeeRole] FOREIGN KEY (employeeRole) REFERENCES EmployeeRole(roleId),
	tavernEmployed INT NOT NULL CONSTRAINT [FK_EmployeeInfo_TavernInfo] FOREIGN KEY (tavernEmployed) REFERENCES TavernInfo(tavernId)
);

CREATE TABLE GuestNotes (					--"GuestNotes": [PRIMARY KEY (noteId), no dependencies]
	noteId INT CONSTRAINT [PK_GuestNotes] PRIMARY KEY IDENTITY(1,1),
	note VARCHAR(500) NOT NULL CONSTRAINT [UQ_GuestNotes_note] UNIQUE(note)
);

CREATE TABLE GuestStatus (					--"GuestStatus": [PRIMARY KEY (guestStatusId), no dependencies]
	guestStatusId INT CONSTRAINT [PK_GuestStatus] PRIMARY KEY IDENTITY(1,1),
	guestStatusDescription VARCHAR(50) NOT NULL CONSTRAINT [UQ_GuestStatus_guestStatusDescription] UNIQUE(guestStatusDescription)
);

CREATE TABLE ClassTypes (					--"ClassTypes": [PRIMARY KEY (classId), no dependencies]
	classId INT CONSTRAINT [PK_ClassTypes] PRIMARY KEY IDENTITY(1,1),
	className VARCHAR(100) NOT NULL CONSTRAINT [UQ_ClassTypes_className] UNIQUE(className)
);

CREATE TABLE TavernGuests (					--"TavernGuests": [PRIMARY KEY (guestId), dependent on "GuestNotes" FOREIGN KEY (noteId), dependent on "GuestStatus" FOREIGN KEY (guestStatusId)]
	guestId INT CONSTRAINT [PK_TavernGuests] PRIMARY KEY IDENTITY(1,1),
	guestName VARCHAR(100) NOT NULL,
	guestNote INT NULL CONSTRAINT [FK_TavernGuests_GuestNotes] FOREIGN KEY (guestNote) REFERENCES GuestNotes(noteId),
	guestBirthDay DATE NOT NULL,
	guestCakeDay DATE NULL,
	guestStatus INT NULL CONSTRAINT [FK_TavernGuests_GuestStatus] FOREIGN KEY (guestStatus) REFERENCES GuestStatus(guestStatusId)
);

CREATE TABLE GuestClassLevel (				--"GuestClassLevel": [PRIMARY KEY (classLevelId), dependent on "TavernGuests" FORREIGN KEY (guestId), dependent on "ClassTypes" FORREIGN KEY (classId)]
	classLevelId INT CONSTRAINT [PK_GuestClassLevel] PRIMARY KEY IDENTITY(1,1),
	guestId INT NOT NULL CONSTRAINT [FK_GuestClassLevel_TavernGuests] FOREIGN KEY (guestId) REFERENCES TavernGuests(guestId),
	classId INT NOT NULL CONSTRAINT [FK_GuestClassLevel_ClassTypes] FOREIGN KEY (classId) REFERENCES ClassTypes(classId),
	guestLevel INT NOT NULL
);

CREATE TABLE SupplyStorage (				--"SupplyStorage": [PRIMARY KEY (supplyId), no dependencies]
	supplyId INT CONSTRAINT [PK_SupplyStorage] PRIMARY KEY IDENTITY(1,1),
	dateOfUpdate DATE NOT NULL,
	supplyName VARCHAR(50) NOT NULL CONSTRAINT [UQ_SupplyStorage_SsupplyName] UNIQUE(supplyName),
	supplyUnit VARCHAR(50) NOT NULL,
	supplyCount INT NULL CONSTRAINT [DF_SupplyStorage_supplyCount] DEFAULT 0
);

CREATE TABLE SupplyReceived (				--"SupplyReceived": [PRIMARY KEY (invoiceId), dependent on "TavernInfo" FORREIGN KEY (tavernId), dependent on "SupplyStorage" FORREIGN KEY (supplyId)]
	invoiceId INT CONSTRAINT [PK_SupplyReceived] PRIMARY KEY IDENTITY(1,1),
	dateOfPurchase DATE NOT NULL,
	tavernId INT NOT NULL CONSTRAINT [FK_SupplyReceived_TavernInfo] FOREIGN KEY (tavernId) REFERENCES TavernInfo(tavernId),
	supplyId INT NOT NULL CONSTRAINT [FK_SupplyReceived_SupplyStorage] FOREIGN KEY (supplyId) REFERENCES SupplyStorage(supplyId),
	supplyCost SMALLMONEY NOT NULL CONSTRAINT [DF_SupplyReceived_supplyCost] DEFAULT 0.00,
	amountReceived INT NOT NULL
);

CREATE TABLE TavernServiceStatus (			--"TavernServiceStatus": [PRIMARY KEY (serviceStatusId), no dependencies]
	serviceStatusId INT CONSTRAINT [PK_TavernServiceStatus] PRIMARY KEY IDENTITY(1,1),
	serviceStatus VARCHAR(50) NOT NULL CONSTRAINT [UQ_TavernServiceStatus_serviceStatus] UNIQUE(serviceStatus)
);

CREATE TABLE TypesOfSevices (				--"TypesOfSevices": [PRIMARY KEY (serviceNameId), no dependencies]
	serviceNameId INT CONSTRAINT [PK_serviceNameId] PRIMARY KEY IDENTITY(1,1),
	serviceName VARCHAR(100) NOT NULL CONSTRAINT [UQ_TypesOfSevices_serviceName] UNIQUE(serviceName)
);

CREATE TABLE TavernServices (				--"TavernServices": [PRIMARY KEY (serviceId), dependent on "TypesOfSevices" FORREIGN KEY (serviceNameId), dependent on "TavernServiceStatus" FORREIGN KEY (serviceStatusId), dependent on "TavernInfo" FORREIGN KEY (tavernId)]
	serviceId INT CONSTRAINT [PK_TavernServices] PRIMARY KEY IDENTITY(1,1),
	serviceNameId INT NOT NULL CONSTRAINT [FK_TavernServices_TypesOfSevices] FOREIGN KEY (serviceNameId) REFERENCES TypesOfSevices(serviceNameId),
	serviceStatus INT NOT NULL CONSTRAINT [FK_TavernServices_TavernServiceStatus] FOREIGN KEY (serviceStatus) REFERENCES TavernServiceStatus(serviceStatusId),
	tavernId INT NOT NULL CONSTRAINT [FK_TavernServices_TavernInfo] FOREIGN KEY (tavernId) REFERENCES TavernInfo(tavernId)
);

CREATE TABLE TavernSales (					--"TavernSales": [PRIMARY KEY (saleId), dependent on "TavernInfo" FORREIGN KEY (tavernId), dependent on "TavernGuests" FORREIGN KEY (guestId), dependent on "TypesOfSevices" FORREIGN KEY (serviceNameId)]
	saleId INT CONSTRAINT [PK_TavernSales] PRIMARY KEY IDENTITY(1,1),
	datePurchased DATE NOT NULL,
	tavernId INT NOT NULL CONSTRAINT [FK_TavernSales_TavernInfo] FOREIGN KEY (tavernId) REFERENCES TavernInfo(tavernId),
	guestId INT NOT NULL CONSTRAINT [FK_TavernSales_TavernGuests] FOREIGN KEY (guestId) REFERENCES TavernGuests(guestId),
	serviceType INT NOT NULL CONSTRAINT [FK_TavernSales_TypesOfSevices] FOREIGN KEY (serviceType) REFERENCES TypesOfSevices(serviceNameId),
	priceOfService SMALLMONEY NOT NULL CONSTRAINT [DF_TavernSales_priceOfService] DEFAULT 0.00,
	amountPurchased INT NOT NULL CONSTRAINT [DF_TavernSales_amountPurchased] DEFAULT 0
);


CREATE TABLE InnRoomStatus (				--"InnRoomStatus": [PRIMARY KEY (roomStatusId), no dependencies]
	roomStatusId INT CONSTRAINT [PK_InnRoomStatus] PRIMARY KEY IDENTITY(1,1),
	roomStatus VARCHAR(100) NOT NULL CONSTRAINT [UQ_InnRoomStatus_roomStatus] UNIQUE(roomStatus)
);

CREATE TABLE InnRooms (						--"InnRooms": [PRIMARY KEY (roomId), dependent on "InnRoomStatus" FORREIGN KEY (roomStatusId), dependent on "TavernInfo" FORREIGN KEY (tavernId)]
	roomId INT CONSTRAINT [PK_InnRooms] PRIMARY KEY IDENTITY(1,1),
	roomCost INT NOT NULL, --paid in gold
	roomStatusId INT NOT NULL CONSTRAINT [FK_InnRooms_InnRoomStatus] FOREIGN KEY (roomStatusId) REFERENCES InnRoomStatus(roomStatusId),
	tavernId INT NOT NULL CONSTRAINT [FK_InnRooms_TavernInfo] FOREIGN KEY (tavernId) REFERENCES TavernInfo(tavernId)
);

CREATE TABLE RoomSales (					--"RoomSales": [PRIMARY KEY (roomSaleId), dependent on "InnRooms" FORREIGN KEY (roomId), dependent on "TavernGuests" FORREIGN KEY (guestId)]
	roomSaleId INT CONSTRAINT [PK_RoomSales] PRIMARY KEY IDENTITY(1,1),
	dateOfStay DATE NOT NULL,
	roomId INT NOT NULL CONSTRAINT [FK_RoomSales_InnRooms] FOREIGN KEY (roomId) REFERENCES InnRooms(roomId),
	guestId INT NOT NULL CONSTRAINT [FK_RoomSales_TavernGuests] FOREIGN KEY (guestId) REFERENCES TavernGuests(guestId)
);
GO

/*
					*INSERT DATA*

Inserts data into the following tables: 
ClassTypes, EmployeeInfo, EmployeeRole, GuestClassLevel, GuestNotes, GuestStatus, InnRooms, InnRoomStatus, RoomSales,
SupplyReceived, SupplyStorage, TavernGuests, TavernInfo, TavernLocation, TavernSales, TavernServices, TavernServiceStatus, TypesOfSevices
	
*/

INSERT INTO TavernLocation					--"TavernLocation" Attributes: [locationId (INT AUTO PK), locationName (VARCHAR)]
VALUES
('Atlantic City, NJ'),
('Palmyra, NJ'),
('Lumberton, NJ'),
('Moorestown, NJ'),
('Mount Laurel, NJ');

INSERT INTO TavernInfo						--"TavernInfo" Attributes: [tavernID (INT AUTO PK), tavernName (VARCHAR), tavernOwner (VARCHAR), NumberOfFloors (TINYINT), TavernLocation (INT)]
VALUES 
('The Pathetic Lord', 'Jacki Wade', 1, 3),
('The Wrong Butterfly Tavern', 'Jacki Wade', 2, 1),
('The Oceanic Whale Inn', 'Daria Cedillo', 3, 1),
('The Devilish Plate Tavern', 'Hilda Talor', 4, 3),
('The Filthy Lettuce Bar', 'Leena Dungan', 5, 5),
('The Oceanic Whale Inn', 'Daria Cedillo', 2, 4),
('The Solid Cliff Pub', 'Kali Carrick', 3, 1),
('The Talented Carrot Tavern', 'Stanley Bosch', 4, 1);

INSERT INTO EmployeeRole					--"EmployeeRole" Attributes: [roleId (INT AUTO PK), roleName (VARCHAR), roleDescription (VARCHAR)]
VALUES
('Bartender', 'Makes drinks'),
('Server', 'Takes food orders'),
('Cook', 'Makes food'),
('Dish Washer', 'Washes dishes'),
('Admin', 'Manages network'),
('Manager', 'Manages shift');

INSERT INTO EmployeeInfo					--"EmployeeInfo" Attributes: [employeeId (INT AUTO PK), employeeName (VARCHAR), employeeRole (INT FK), tavernEmployed (INT FK)]
VALUES
('Lana Vu', 1, 1),
('Nadine Dempster', 2, 2),
('Troy Mustafa', 3, 3),
('Nona Leggio', 4, 4),
('Leigh Panton', 5, 5),
('Tabitha Bombard', 3, 6),
('Micaela Goudeau', 2, 4),
('Reggie Paden', 5, 2),
('Myrtle Dorr', 1, 1),
('Darlena Boyce', 2, 3),
('Marguerite Leath', 3, 7),
('Pedro Thorpe', 4, 4),
('Concetta Knop', 5, 8),
('Lynda Calahan', 3, 2),
('Isaac Baca', 1, 1),
('Magan Madkins', 2, 5),
('Kesha Alberson', 2, 1),
('Karissa Hartley', 2, 8),
('Ike Vidaurri', 3, 3),
('Amee Adan', 4, 4),
('Tomas Escamilla', 5, 2),
('Carrie Harrigan', 1, 7),
('Lorrie Paskett', 2, 4),
('Karon Settles', 5, 6);

INSERT INTO GuestNotes						--"GuestNotes" Attributes: [noteId (INT AUTO PK), note (VARCHAR)]
VALUES
('Tips well'),
('Doesn''t tip'),
('Starts trouble'),
('Lightweight drinker'),
('Argumentive');

INSERT INTO GuestStatus						--"GuestStatus" Attributes: [guestStatusId (INT AUTO PK), guestStatusDescription (VARCHAR)]
VALUES
('Happy'),
('Hungry'),
('Angry'),
('Hangry'),
('Sick'),
('Fine');

INSERT INTO ClassTypes						--"ClassTypes" Attributes: [classId (INT AUTO PK), className (VARCHAR)]
VALUES
('Mage'),
('Warrior'),
('Fighter'),
('Wizard'),
('Bard'),
('Drunk'),
('Necromancer'),
('Archer');

INSERT INTO TavernGuests					--"TavernGuests" Attributes: [guestId (INT AUTO PK), guestName (VARCHAR), guestNote (INT FK), guestBirthDay (DATE), guestCakeDay (DATE), guestStatus (INT FK)]
VALUES
('Alicia Moncayo', 1, '1990-09-03', '2019-09-03', 1),
('Vada Getman', 2, '1989-08-02', '2019-08-02', 2),
('Crystle Farnes', 3, '1988-04-03', '2019-04-03', 3),
('Nisha Dobbin', 4, '1978-11-15', '2019-11-15', 4),
('Doreatha Pfeiffer', 5, '1990-11-02', '2019-11-02', 5),
('Sabra Newman', 1, '1993-02-14', '2019-02-14', 6),
('Crissy Davisson', 2, '1995-12-20', '2019-12-20', 5),
('Sabina Modlin', 2, '1990-09-03', '2019-09-03', 3),
('Edmond Osborne', 3, '1980-04-05', '2019-04-05', 2),
('Azucena Smit', 4, '1991-06-14', '2019-06-14', 1),
('Adrianne Wheaton', 5, '1979-01-12', '2019-01-12', 4),
('Ramiro Sagucio', 4, '1990-03-27', '2019-03-27', 6),
('Tatum Byard', 5, '1990-04-19', '2019-04-19', 2),
('Wilber Shira', 2, '1989-09-03', '2019-09-03', 1),
('Evelynn Massingale', 3, '1987-07-07', '2019-07-07', 3);

INSERT INTO GuestClassLevel					--"GuestClassLevel" Attributes: [classLevelId (INT AUTO PK), guestId (INT FK), classId (INT FK), guestLevel (INT)]
VALUES
(1, 1, 10),
(1, 2, 6),
(2, 2, 11),
(3, 3, 20),
(4, 4, 14),
(5, 5, 30),
(6, 6, 15),
(7, 7, 22),
(8, 8, 2),
(9, 3, 1),
(8, 2, 13),
(11, 4, 29),
(12, 5, 17),
(13, 4, 11),
(14, 8, 22),
(15, 2, 23),
(10, 1, 20);

INSERT INTO SupplyStorage					--"SupplyStorage" Attributes: [supplyId (INT AUTO PK), dateOfUpdate (DATE), supplyName (VARCHAR), supplyUnit (VARCHAR), supplyCount (INT)]
VALUES
('2019-01-01', 'Beer', 'Pint', 5000),
('2019-01-02', 'Vodka', 'Gallon', 1000),
('2019-01-02', 'Gin', 'Gallon', 1000),
('2019-01-02', 'Whiskey', 'Gallon', 1000),
('2019-01-02', 'Rum', 'Gallon', 1000),
('2019-01-02', 'Tequila', 'Gallon', 1000);

INSERT INTO SupplyReceived					--"SupplyReceived" Attributes: [invoiceId (INT AUTO PK), dateOfPurchase (DATE), tavernId (INT FK), supplyId (INT FK), supplyCost (SMALLMONEY), amountReceived (INT)]
VALUES
('2018-01-01', 1, 1, 50.00, 100),
('2018-02-01', 2, 2, 50.00, 100),
('2018-03-01', 3, 3, 50.00, 100),
('2018-03-02', 4, 4, 50.00, 100),
('2018-03-05', 5, 5, 50.00, 100),
('2018-06-01', 6, 6, 50.00, 100),
('2018-06-11', 7, 1, 50.00, 100),
('2018-06-11', 8, 1, 50.00, 100);

INSERT INTO TavernServiceStatus				--"TavernServiceStatus" Attributes: [serviceStatusId (INT AUTO PK), serviceStatus (VARCHAR)]
VALUES
('Active'),
('Inactive');

INSERT INTO TypesOfSevices					--"TypesOfSevices" Attributes: [serviceNameId (INT AUTO PK), serviceName (VARCHAR)]
VALUES
('Shoe shining'),
('Arm wrestling'),
('Blackjack'),
('Poker'),
('Craps');

INSERT INTO TavernServices					--"TavernServices" Attributes: [serviceId (INT AUTO PK), serviceNameId (INT FK), serviceStatus (INT FK), tavernId (INT FK)]
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(1, 1, 6),
(3, 2, 7),
(3, 1, 8),
(2, 2, 1);

INSERT INTO TavernSales						--"TavernSales" Attributes: [saleId (INT AUTO PK), datePurchased (DATE), tavernId (INT FK), guestId (INT FK), serviceType (INT FK), priceOfService (SMALLMONEY), amountPurchased (INT)]
VALUES
('2018-01-01', 1, 1, 1, 4.00, 1),
('2018-01-02', 2, 12, 2, 55.00, 2),
('2018-01-03', 3, 3, 4, 10.00, 1),
('2018-01-04', 4, 5, 3, 20.00, 3),
('2018-01-05', 5, 7, 5, 70.00, 1),
('2018-01-06', 6, 4, 3, 10.00, 1),
('2018-01-07', 7, 14, 1, 90.00, 1),
('2018-01-08', 8, 13, 2, 12.00, 1),
('2018-01-09', 2, 11, 2, 22.00, 1),
('2018-01-10', 3, 1, 2, 44.00, 1),
('2018-01-11', 4, 3, 2, 60.00, 1),
('2018-01-12', 5, 4, 2, 35.00, 1),
('2018-01-13', 6, 1, 2, 12.00, 1),
('2018-01-14', 8, 4, 2, 2.00, 1);

INSERT INTO InnRoomStatus					--"InnRoomStatus" Attributes: [roomStatusId (INT AUTO PK), roomStatus (VARCHAR)]
VALUES
('In service'),
('Out of service');

INSERT INTO InnRooms						--"InnRooms" Attributes: [roomId (INT AUTO PK), roomCost (INT), roomStatusId (INT FK), tavernId (INT FK)]
VALUES
(120, 1, 1),
(130, 1, 2),
(140, 1, 3),
(100, 1, 4),
(50, 1, 5),
(100, 1, 6),
(50, 1, 7),
(50, 1, 8),
(100, 2, 4),
(150, 2, 3),
(200, 1, 1),
(100, 2, 6);

INSERT INTO RoomSales						--"RoomSales" Attributes: [roomSaleId (INT AUTO PK), dateOfStay (DATE), roomId (INT FK), guestId (INT FK)]
VALUES
('2018-01-01', 1, 1),
('2018-01-11', 2, 11),
('2018-01-01', 3, 2),
('2018-02-01', 4, 3),
('2018-02-13', 5, 4),
('2018-03-22', 6, 11),
('2018-04-10', 7, 6),
('2018-05-01', 8, 7);
GO

/*
			ANSWERS TO PROBLEMS

Answers to problems 1-7 are here
*/

/*
1. Write a query to return a “report” of all users and their roles 
*/

SELECT employeeName, roleName FROM EmployeeInfo
JOIN EmployeeRole ON EmployeeInfo.employeeRole = EmployeeRole.roleId
ORDER BY employeeName ASC;
GO

/*
2. Write a query to return all classes and the count of guests that hold those classes 
*/

SELECT className, COUNT(guestId) AS NumberOfGuestsWithClass FROM ClassTypes 
JOIN GuestClassLevel ON ClassTypes.classId = GuestClassLevel.classId 
GROUP BY className;
GO

/*
3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
*/

SELECT guestName, guestLevel, className, CASE
WHEN GuestClassLevel.guestLevel BETWEEN 0 AND 5 THEN 'Beginner'
WHEN GuestClassLevel.guestLevel BETWEEN 5 AND 10 THEN 'Intermediate'
WHEN GuestClassLevel.guestLevel >= 11 THEN 'Expert'
ELSE NULL END
AS guestExperience FROM TavernGuests
JOIN GuestClassLevel ON TavernGuests.guestId = GuestClassLevel.guestId
JOIN ClassTypes ON GuestClassLevel.classId = ClassTypes.classId
ORDER BY guestName ASC
GO

/*
4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)
*/

IF OBJECT_ID (N'dbo.levelGrouping', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.levelGrouping; 
GO

CREATE FUNCTION dbo.levelGrouping(@guestLevel INT)
	RETURNS VARCHAR(50)
	AS 
	BEGIN
		RETURN
			CASE
				WHEN @guestLevel BETWEEN 0 AND 5 THEN 'Beginner'
				WHEN @guestLevel BETWEEN 5 AND 10 THEN 'Intermediate'
				WHEN @guestLevel >= 11 THEN 'Expert'
				ELSE NULL END
END
GO

SELECT dbo.levelGrouping(121)
GO

/*
5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 
*/

IF OBJECT_ID (N'dbo.checkAvailableRooms', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.checkAvailableRooms; 
GO

CREATE FUNCTION dbo.checkAvailableRooms(@dateCheck DATE)
RETURNS TABLE
AS
RETURN
(
SELECT InnRooms.roomId, tavernName FROM RoomSales
JOIN InnRooms ON RoomSales.roomId = InnRooms.roomId
JOIN TavernInfo ON InnRooms.tavernId = TavernInfo.tavernId
WHERE dateOfStay != @dateCheck
);
GO

SELECT *  FROM dbo.checkAvailableRooms('2018-01-01')
GO

/*
6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
*/

IF OBJECT_ID (N'dbo.checkPriceRanges', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.checkPriceRanges; 
GO

CREATE FUNCTION dbo.checkPriceRanges(@minPrice INT, @maxPrice INT)
RETURNS TABLE
AS
RETURN
(
SELECT InnRooms.roomId, roomCost, tavernName FROM RoomSales
JOIN InnRooms ON RoomSales.roomId = InnRooms.roomId
JOIN TavernInfo ON InnRooms.tavernId = TavernInfo.tavernId
WHERE InnRooms.roomCost BETWEEN @minPrice AND @maxPrice
);
GO

SELECT *  FROM dbo.checkPriceRanges(120, 140)
GO

/*
7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one
Nice and short ;D
*/

		--Attempt 3 at Problem #7 - Able to add a new room to the list of rooms using a variable based on @minRoomCost - 1. It would be better if I could do this within a function.

DECLARE @minRoomCost INT;
	SELECT @minRoomCost = min(roomCost) FROM dbo.checkPriceRanges(120, 140)

INSERT INTO InnRooms VALUES (@minRoomCost - 1, 1, 1)  --roomCost (INT), roomStatusId (INT FK), tavernId (INT FK)

SELECT * FROM InnRooms

		--Attempt 2 at problem #7 cannot figure out how to insert into using a function 
/*
IF OBJECT_ID (N'dbo.undercutTavern', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.undercutTavern; 
GO

CREATE FUNCTION dbo.undercutTavern(@minPrice INT, @maxPrice INT)
RETURNS @NewRoom TABLE(roomCost INT)
AS
BEGIN
	DECLARE @minRoomCost INT;
	SELECT @minRoomCost = min(roomCost) FROM dbo.checkPriceRanges(@minPrice, @maxPrice)
	--INSERT INTO InnRooms VALUES (@minRoomCost)

RETURN
END


SELECT * FROM dbo.undercutTavern(100, 120)
GO
*/

		--Attempt 1 at problem #7 unable to declare variable in this type of function 
/*
IF OBJECT_ID (N'dbo.undercutTavern', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.undercutTavern; 
GO

CREATE FUNCTION dbo.undercutTavern(@minPrice INT, @maxPrice INT)
RETURNS TABLE
AS
RETURN
(
SELECT min(roomCost) AS minRoomCost FROM dbo.checkPriceRanges(@minPrice, @maxPrice)
);
GO
*/

--END OF FILE