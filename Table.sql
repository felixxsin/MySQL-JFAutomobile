CREATE DATABASE JFAutomobile


CREATE TABLE MsStaff(
	StaffID CHAR(6) PRIMARY KEY CHECK (StaffID LIKE 'SF-[0-9][0-9][0-9]'),
	StaffName VARCHAR(32) NOT NULL,
	StaffEmail VARCHAR(32) NOT NULL CHECK (StaffEmail LIKE '%@%' AND LEN(StaffEmail) - LEN(REPLACE(StaffEmail, '@', '')) = 1),
	StaffGender VARCHAR(16) NOT NULL,
	StaffAddress VARCHAR(128) NOT NULL,
	StaffPhone VARCHAR(16) NOT NULL
)

CREATE TABLE MsCustomer(
	CustomerID CHAR(6) PRIMARY KEY CHECK (CustomerID LIKE 'CS-[0-9][0-9][0-9]'),
	CustomerName VARCHAR(32) NOT NULL CHECK (LEN(CustomerName) BETWEEN 5 AND 50),
	CustomerEmail VARCHAR(32) NOT NULL,
	CustomerGender VARCHAR(16) NOT NULL CHECK (CustomerGender IN ('Male', 'Female')),
	CustomerAddress VARCHAR(128) NOT NULL,
	CustomerPhoneNumber VARCHAR(16) NOT NULL
)

CREATE TABLE MsMechanic(
	MechanicID CHAR(6) PRIMARY KEY CHECK (MechanicID LIKE 'MC-[0-9][0-9][0-9]'),
	MechanicName VARCHAR(32) NOT NULL,
	MechanicEmail VARCHAR(32) NOT NULL,
	MechanicAddress VARCHAR(128) NOT NULL CHECK (MechanicAddress LIKE '% street'),
	MechanicPhoneNumber VARCHAR(16) NOT NULL
)

CREATE TABLE MsBrand(
	CarBrandID CHAR(6) PRIMARY KEY CHECK (CarBrandID LIKE 'CB-[0-9][0-9][0-9]'),
	CarBrandName VARCHAR(32) NOT NULL,
	CarBrandOriginCountry VARCHAR(16) NOT NULL CHECK (CarBrandOriginCountry IN ('Japan', 'German', 'United States'))
)

CREATE TABLE MsCar(
	CarID CHAR(6) PRIMARY KEY CHECK (CarID LIKE 'CR-[0-9][0-9][0-9]'),
	CarBrandID CHAR(6) NOT NULL CHECK (CarBrandID LIKE 'CB-[0-9][0-9][0-9]'),
	CarName CHAR(32) NOT NULL CHECK (LEN(CarName) > 0),
	CarPrice INT NOT NULL CHECK (CarPrice BETWEEN 2000 AND 4000),
	SeatCapacity INT NOT NULL CHECK(SeatCapacity BETWEEN 1 AND 6),
	EngineCapacity INT NOT NULL CHECK (EngineCapacity BETWEEN 1000 AND 3000),
	AvailabilityStatus INT NOT NULL CHECK (AvailabilityStatus IN (0, 1))

	FOREIGN KEY (CarBrandID) REFERENCES MsBrand(CarBrandID)
)

CREATE TABLE MsService(
	ServiceID CHAR(6) PRIMARY KEY CHECK (ServiceID LIKE 'SV-[0-9][0-9][0-9]'),
	ServiceName VARCHAR(32) NOT NULL,
	ServicePrice INT NOT NULL CHECK (ServicePrice BETWEEN 100000 AND 1000000)
)


CREATE TABLE RentalTransactionHeader(
	RentalTransactionID CHAR(6) PRIMARY KEY CHECK (RentalTransactionID LIKE 'TR-[0-9][0-9][0-9]'),
	StaffID CHAR(6) NOT NULL CHECK (StaffID LIKE 'SF-[0-9][0-9][0-9]'),
	CustomerID CHAR(6) NOT NULL CHECK (CustomerID LIKE 'CS-[0-9][0-9][0-9]'),
	StartRentalDate DATE NOT NULL,
	ReturnDate DATE CHECK (ReturnDate >= GETDATE())


	FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID),
	FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID)
)

CREATE TABLE RentalTransactionDetail(
	RentalTransactionID CHAR(6) NOT NULL CHECK (RentalTransactionID LIKE 'TR-[0-9][0-9][0-9]'),
	CarID CHAR(6) NOT NULL CHECK (CarID LIKE 'CR-[0-9][0-9][0-9]'),
	CarDistanceTravelled INT CHECK(CarDistanceTravelled > 0)




	FOREIGN KEY (RentalTransactionID) REFERENCES RentalTransactionHeader(RentalTransactionID),
	FOREIGN KEY (CarID) REFERENCES MsCar(CarID),


)

CREATE TABLE ServiceTransactionHeader(
	ServiceTransactionID CHAR(6) PRIMARY KEY CHECK (ServiceTransactionID LIKE 'TS-[0-9][0-9][0-9]'),
	StaffID CHAR(6) NOT NULL CHECK (StaffID LIKE 'SF-[0-9][0-9][0-9]'),
	MechanicID CHAR(6) NOT NULL CHECK (MechanicID LIKE 'MC-[0-9][0-9][0-9]'),
	CarID CHAR(6) NOT NULL  CHECK (CarID LIKE 'CR-[0-9][0-9][0-9]'),
	TransactionDate DATE NOT NULL CHECK (TransactionDate >= GETDATE()),

	FOREIGN KEY (CarID) REFERENCES MsCar(CarID),
	FOREIGN KEY (MechanicID) REFERENCES MsMechanic(MechanicID),
	FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID),


)

CREATE TABLE ServiceTransactionDetail(
	ServiceTransactionID CHAR(6) NOT NULL CHECK (ServiceTransactionID LIKE 'TS-[0-9][0-9][0-9]'),
	ServiceID CHAR(6) NOT NULL CHECK (ServiceID LIKE 'SV-[0-9][0-9][0-9]'),

	FOREIGN KEY (ServiceTransactionID) REFERENCES ServiceTransactionHeader(ServiceTransactionID),
	FOREIGN KEY (ServiceID) REFERENCES MsService(ServiceID),

)


