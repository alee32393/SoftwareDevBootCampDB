/*
							"TableExamples.sql"
	
	For: "Software Dev Bootcamp - DB Class #1 - Homework Assignment" Miles Technologies
	Date completed: 3/2/2019
	Creator: Ryan Veitenheimer
	Query 3 of 3 (Execute in order)

This query shows the following tables: 
TavernInfo, EmployeeInfo, TavernSupplies, SuppliesReceived, TavernServices, TavernServiceStatus, TavernSales, TavernRats
*/

USE TavernDatabase				--Creates data in TavernDatabase

--Shows TavernInfo Table
SELECT TavernID, TavernName, TavernLocation, NumberOfFloors, TavernOwner		
FROM TavernInfo

--Shows EmployeeInfo Table
SELECT EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID
FROM EmployeeInfo

--Shows TavernSupplies Table
SELECT SupplyID, NameOfItem, ItemMeasuredUnit, ItemCount, DateOfLastUpdate, TavernID
FROM TavernSupplies

--Shows SuppliesReceived Table
SELECT InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID
FROM SuppliesReceived

--Shows TavernServices Table
SELECT ServiceID, ServiceName, TavernID
FROM TavernServices

--Shows TavernServiceStatus Table
SELECT ServiceStatusID, StatusChoices, ServiceID
FROM TavernServiceStatus

--Shows TavernSales Table
SELECT SalesID, DateOfPurchase, TypeOfService, PriceOfService, AmountPurchased, GuestName, TavernID
FROM TavernSales

--Shows TavernRats Table
SELECT RatID, RatName, TavernID
FROM TavernRats
