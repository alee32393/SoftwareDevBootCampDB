/*
							"CreateTables.sql"
	
	For: "Software Dev Bootcamp - DB Class #1 - Homework Assignment" Miles Technologies
	Date completed: 3/2/2019
	Creator: Ryan Veitenheimer
	Query 1 of 3 (Execute in order)

This query creates the database named "TavernDatabase" and the following tables: 
TavernInfo, EmployeeInfo, TavernSupplies, SuppliesReceived, TavernServices, TavernServiceStatus, TavernSales, TavernRats
*/

CREATE DATABASE TavernDatabase			--Creates a database called TavernDatabase     
GO

USE TavernDatabase						--Creates data in TavernDatabase

CREATE TABLE TavernInfo (				--Main parent container
	TavernID int PRIMARY KEY,
	TavernName varchar(255),
	TavernLocation varchar(255),
	TavernOwner varchar(255),
	NumberOfFloors int 
);

CREATE TABLE EmployeeInfo (				--Child of TavernInfo
	EmployeeID int PRIMARY KEY,
	EmployeeName varchar(255),
	EmployeeRole varchar(255),
	EmployeeRoleDescription varchar(500),
	TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

CREATE TABLE TavernSupplies (			--Child of TavernInfo
	SupplyID int PRIMARY KEY,
	NameOfItem varchar(255),
	ItemMeasuredUnit varchar(255),
	ItemCount int,
	DateOfLastUpdate date,
	TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

CREATE TABLE SuppliesReceived (			--Child of TavernSupplies. Child of TavernInfo
	InvoiceID int PRIMARY KEY,
	DateReceived date,
	SupplyID int FOREIGN KEY REFERENCES TavernSupplies(SupplyID),
	CostOfItem decimal,
	AmountOfItemReceived int,
	TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID),
);

CREATE TABLE TavernServices (			--Child of TavernInfo. Parent of TavernServiceStatus
	ServiceID int PRIMARY KEY,
	ServiceName varchar(255),
	TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

CREATE TABLE TavernServiceStatus (		--Child of TavernServices
	ServiceStatusID int PRIMARY KEY,
	StatusChoices varchar(255),
	ServiceID int FOREIGN KEY REFERENCES TavernServices(ServiceID)
);

CREATE TABLE TavernSales (				--Child of TavernInfo
	SalesID int PRIMARY KEY,
	DateOfPurchase date,
	TypeOfService varchar(255),
	PriceOfService decimal,
	AmountPurchased int,
	GuestName varchar(255),
	TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

CREATE TABLE TavernRats (				--Child of TavernInfo
	RatID int PRIMARY KEY,
	RatName varchar(255),
	TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);
