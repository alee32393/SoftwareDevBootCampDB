/*
					"DisplayTableQueryData.sql"
		
		3/7/2019 - In class lab
		Created for: "Software Dev Bootcamp - DB Class #3 - in class lab" Miles Technologies
		Created on: "Microsoft SQL Server Management Studio 17, Version 14.0.17289.0"
		Version Control: "Git, Version 2.9.2.windows.1"
		Created by: Ryan Veitenheimer
		
	The purpose of this project is to display the following fields from a "CREATE TABLE" query ("TestTable"): Table name, Partenthis (Left/right), ColumnNames, ColumnTypes, Semicolon

	Using data from INFORMATION_SCHEMA.COLUMNS, a variable is declared and assigned to each part of my "CREATE TABLE" query ("TestTable")
	Then the data are presented in order of the "CREATE TABLE" query using the UNION ALL function
*/

USE RVeitenheimer_2019;
GO

DROP TABLE IF EXISTS TestTable;
GO

CREATE TABLE TestTable    --"TestTable" used for creation of table data in INFORMATION_SCHEMA.COLUMNS
(
	Column1 INT,
	Column2 INT,
	Column3 VARCHAR(50)
);
GO

/*
				*VARIBLE DECLARATIONS*

Declaring variables is be assigned to values from INFORMATION_SCHEMA.COLUMNS, based on "TestTable" table
*/

DECLARE @TABLE_NAME VARCHAR(50);
DECLARE @PARENTHESIS_LEFT VARCHAR(50);
DECLARE @COLUMN_1_NAME VARCHAR(50);
DECLARE @COLUMN_2_NAME VARCHAR(50);
DECLARE @COLUMN_3_NAME VARCHAR(50);
DECLARE @COLUMN_1_TYPE VARCHAR(50);
DECLARE @COLUMN_2_TYPE VARCHAR(50);
DECLARE @COLUMN_3_TYPE VARCHAR(50);
DECLARE @PARENTHESIS_RIGHT VARCHAR(50);
DECLARE @SEMICOLON VARCHAR(50);

/*
				*VARIABLE ASSIGNMENTS*

The above delcared variables are assigned their repective data assignments from INFORMATION_SCHEMA.COLUMNS
"COLUMN_NAME" is found by the cell's respective "ORDINAL_POSITION" **Could be automated using a loop, for unknown amount of columns**
PARENTHESIS_(LEFT/RIGHT) and SEMICOLON left as string
*/

SELECT @TABLE_NAME = TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_Name = 'TestTable';
SELECT @PARENTHESIS_LEFT = '(';
SELECT @COLUMN_1_NAME = COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_Name = 'TestTable' AND ORDINAL_POSITION = 1;
SELECT @COLUMN_2_NAME = COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_Name = 'TestTable' AND ORDINAL_POSITION = 2;
SELECT @COLUMN_3_NAME = COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_Name = 'TestTable' AND ORDINAL_POSITION = 3;
SELECT @COLUMN_1_TYPE = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE table_Name = 'TestTable' AND ORDINAL_POSITION = 1;
SELECT @COLUMN_2_TYPE = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE table_Name = 'TestTable' AND ORDINAL_POSITION = 2;
SELECT @COLUMN_3_TYPE = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE table_Name = 'TestTable' AND ORDINAL_POSITION = 3;
SELECT @PARENTHESIS_RIGHT = ')';
SELECT @SEMICOLON = ';';

/*
				*DATA OUTPUT*

Variables are displayed one at a time, then combined to one output with UNION ALL
*/

SELECT @TABLE_NAME
UNION ALL
SELECT @PARENTHESIS_LEFT
UNION ALL
SELECT @COLUMN_1_NAME
UNION ALL
SELECT @COLUMN_2_NAME
UNION ALL
SELECT @COLUMN_3_NAME
UNION ALL
SELECT @COLUMN_1_TYPE
UNION ALL
SELECT @COLUMN_2_TYPE
UNION ALL
SELECT @COLUMN_3_TYPE
UNION ALL 
SELECT @PARENTHESIS_RIGHT
UNION ALL
SELECT @SEMICOLON

--END OF FILE
