/*
							"GenerateInfo.sql"
	
	For: "Software Dev Bootcamp - DB Class #1 - Homework Assignment" Miles Technologies
	Date completed: 3/2/2019
	Creator: Ryan Veitenheimer
	Query 2 of 3 (Execute in order)

This query generates data into the tables created on "CreateTables.sql". 
The data inserts are in the same order as the table creation queries.

**Execute this query only once or duplicate entries will be made.**
*/

USE TavernDatabase			--Creates data in TavernDatabase
			
			--TavernInfo table data

INSERT INTO TavernInfo (TavernID, TavernName, TavernLocation, NumberOfFloors, TavernOwner)
	VALUES (1, 'Mollys Pub', 'Moorestown, NJ', 3, 'Molly Poppins');
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocation, NumberOfFloors, TavernOwner)
	VALUES (2, 'Bills Ale House', 'Mount Laurel, NJ', 2, 'Bill Ale');
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocation, NumberOfFloors, TavernOwner)
	VALUES (3, 'Uncle Bobs Den', 'Moorestown, NJ', 3, 'Bob Bobbers');
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocation, NumberOfFloors, TavernOwner)
	VALUES (4, 'Drunkards', 'Lumberton, NJ', 1, 'Mila Kunis');
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocation, NumberOfFloors, TavernOwner)
	VALUES (5, 'The Broken Turtle', 'Cinnaminson, NJ', 3, 'Turt Ellis');
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocation, NumberOfFloors, TavernOwner)
	VALUES (6, 'The White Eagle', 'Riverside, NJ', 2, 'Eagle Beagle');

			--EmployeeInfo table data

INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (1, 'John Smith', 'Dish Washer', 'Washes dishes', 1)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (2, 'Julia Rogers', 'Cook', 'Cooks food', 4)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (3, 'William Burns', 'Server', 'Takes food orders', 1)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (4, 'Jeffrey Jefferson', 'Server', 'Takes food orders', 6)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (5, 'Michael Jackson', 'Cook', 'Cooks food', 5)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (6, 'Maria Mariason', 'Dish Washer', 'Washes dishes', 3)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (7, 'Charile Chapman', 'Server', 'Takes food orders', 5)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (8, 'Billy Bonkers', 'Cook', 'Cooks food', 1)
INSERT INTO EmployeeInfo (EmployeeID, EmployeeName, EmployeeRole, EmployeeRoleDescription, TavernID)
	VALUES (9, 'Yannie Yonkers', 'Server', 'Takes food orders', 2)

			--TavernSupplies table data

INSERT INTO TavernSupplies (SupplyID, NameOfItem, ItemMeasuredUnit, ItemCount, DateOfLastUpdate, TavernID)
	VALUES (1, 'Beer', 'Pint', 100, '2017-01-03', 3)
INSERT INTO TavernSupplies (SupplyID, NameOfItem, ItemMeasuredUnit, ItemCount, DateOfLastUpdate, TavernID)
	VALUES (2, 'Vodka', 'Gallon', 100, '2017-03-14', 1)
INSERT INTO TavernSupplies (SupplyID, NameOfItem, ItemMeasuredUnit, ItemCount, DateOfLastUpdate, TavernID)
	VALUES (3, 'Beer', 'Pint', 100, '2017-01-03', 1)
INSERT INTO TavernSupplies (SupplyID, NameOfItem, ItemMeasuredUnit, ItemCount, DateOfLastUpdate, TavernID)
	VALUES (4, 'Gin', 'Gallon', 50, '2017-05-15', 2)
INSERT INTO TavernSupplies (SupplyID, NameOfItem, ItemMeasuredUnit, ItemCount, DateOfLastUpdate, TavernID)
	VALUES (5, 'Beer', 'Pint', 100, '2017-06-04', 5)
INSERT INTO TavernSupplies (SupplyID, NameOfItem, ItemMeasuredUnit, ItemCount, DateOfLastUpdate, TavernID)
	VALUES (6, 'Beer', 'Pint', 100, '2017-07-23', 6)

			--SuppliesReceived table data

INSERT INTO SuppliesReceived (InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID)
	VALUES (1, '2018-04-21', 1, 10, 3)
INSERT INTO SuppliesReceived (InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID)
	VALUES (2, '2018-04-25', 2, 15, 1)
INSERT INTO SuppliesReceived (InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID)
	VALUES (3, '2018-05-01', 3, 10, 1)
INSERT INTO SuppliesReceived (InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID)
	VALUES (4, '2018-05-15', 3, 30, 1)
INSERT INTO SuppliesReceived (InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID)
	VALUES (5, '2018-05-21', 4, 10, 2)
INSERT INTO SuppliesReceived (InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID)
	VALUES (6, '2018-06-11', 5, 48, 5)
INSERT INTO SuppliesReceived (InvoiceID, DateReceived, SupplyID, AmountOfItemReceived, TavernID)
	VALUES (7, '2018-07-21', 6, 35, 6)

			--TavernServices table data

INSERT INTO TavernServices (ServiceID, ServiceName, TavernID)	
	VALUES (1, 'Shoe Shining', 1)	
INSERT INTO TavernServices (ServiceID, ServiceName, TavernID)	
	VALUES (2, 'Beer pong', 2)
INSERT INTO TavernServices (ServiceID, ServiceName, TavernID)	
	VALUES (3, 'Arm Westling', 3)
INSERT INTO TavernServices (ServiceID, ServiceName, TavernID)	
	VALUES (4, 'Poker', 3)
INSERT INTO TavernServices (ServiceID, ServiceName, TavernID)	
	VALUES (5, 'BlackJack', 6)

			--TavernServiceStatus table data

INSERT INTO TavernServiceStatus (ServiceStatusID, StatusChoices, ServiceID)
	VALUES (1, 'Active', 1)
INSERT INTO TavernServiceStatus (ServiceStatusID, StatusChoices, ServiceID)
	VALUES (2, 'Active', 2)
INSERT INTO TavernServiceStatus (ServiceStatusID, StatusChoices, ServiceID)
	VALUES (3, 'Active', 3)
INSERT INTO TavernServiceStatus (ServiceStatusID, StatusChoices, ServiceID)
	VALUES (4, 'Active', 4)
INSERT INTO TavernServiceStatus (ServiceStatusID, StatusChoices, ServiceID)
	VALUES (5, 'Inactive', 5)

			--TavernSales table data

INSERT INTO TavernSales (SalesID, DateOfPurchase, TypeOfService, PriceOfService, AmountPurchased, GuestName, TavernID)
	VALUES (1, '2018-01-05', 'Shoe shining', 10.00, 1, 'Ronald McDonald', 1)
INSERT INTO TavernSales (SalesID, DateOfPurchase, TypeOfService, PriceOfService, AmountPurchased, GuestName, TavernID)
	VALUES (2, '2018-04-13', 'Beer pong', 25.00, 1, 'Frank Sanatra', 2)
INSERT INTO TavernSales (SalesID, DateOfPurchase, TypeOfService, PriceOfService, AmountPurchased, GuestName, TavernID)
	VALUES (3, '2018-04-14', 'Beer pong', 25.35, 1, 'James Bond', 2)
INSERT INTO TavernSales (SalesID, DateOfPurchase, TypeOfService, PriceOfService, AmountPurchased, GuestName, TavernID)
	VALUES (4, '2018-05-16', 'Arm wrestling', 13.65, 1, 'James Bond', 2)
INSERT INTO TavernSales (SalesID, DateOfPurchase, TypeOfService, PriceOfService, AmountPurchased, GuestName, TavernID)
	VALUES (5, '2018-06-02', 'Poker', 15.00, 5, 'Cards McDealin', 3)

			--TavernRats table data

INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (1, 'Charlie', 1)
INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (2, 'Bob', 2)
INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (3, 'Rocky', 1)
INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (4, 'Bongo', 6)
INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (5, 'Icarus', 3)
INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (6, 'Cheesers', 4)
INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (7, 'Ratty', 5)
INSERT INTO TavernRats (RatID, RatName, TavernID)
	VALUES (8, 'Yonkers', 3)
