CREATE TABLE Staff(
	StaffID CHAR(6) PRIMARY KEY,
	StaffName VARCHAR(50) NOT NULL,
	StaffEmail VARCHAR (50) NOT NULL,
	StaffGender VARCHAR(6) NOT NULL,
	StaffAddress VARCHAR(128) NOT NULL,
	StaffPhone VARCHAR(16) NOT NULL
);

ALTER TABLE Staff
ADD CONSTRAINT CHK_StaffID
CHECK (StaffID LIKE 'SF-[0-9][0-9][0-9]');

ALTER TABLE Staff
ADD CONSTRAINT CHK_StaffGender
CHECK (StaffGender IN ('Male', 'Female'));

ALTER TABLE Staff
ADD CONSTRAINT CHK_StaffEmail 
CHECK (StaffEmail LIKE '%@%');

ALTER TABLE Staff
ADD CONSTRAINT CHK_StaffName_Length
CHECK (LEN(StaffName) BETWEEN 5 AND 50);


CREATE TABLE Customer(
	CustomerID CHAR(6) PRIMARY KEY,
	CustomerName VARCHAR(50) NOT NULL,
	CustomerEmail VARCHAR (50) NOT NULL,
	CustomerGender VARCHAR(6) NOT NULL,
	CustomerAddress VARCHAR(128) NOT NULL,
	CustomerPhone VARCHAR(16) NOT NULL
);

ALTER TABLE Customer
ADD CONSTRAINT CHK_CustomerID_PK
CHECK (CustomerID LIKE 'CS-[0-9][0-9][0-9]');

ALTER TABLE Customer
ADD CONSTRAINT CHK_CustomerGender
CHECK (CustomerGender IN ('Male', 'Female'));

ALTER TABLE Customer
ADD CONSTRAINT CHK_CustomerEmail 
CHECK (CustomerEmail LIKE '%@%');

ALTER TABLE Customer
ADD CONSTRAINT CHK_CustomerName_Length
CHECK (LEN(CustomerName) BETWEEN 5 AND 50);

CREATE TABLE Mechanic(
	MechanicID CHAR(6) PRIMARY KEY,
	MechanicName VARCHAR(32) NOT NULL,
	MechanicEmail VARCHAR(32) NOT NULL,
	MechanicAddress VARCHAR(128) NOT NULL,
	MechanicPhoneNumber VARCHAR(16) NOT NULL
);

ALTER TABLE Mechanic
ADD CONSTRAINT CHK_MechanicName_Length
CHECK (LEN(MechanicName) BETWEEN 5 AND 50);

ALTER TABLE Mechanic
ADD CONSTRAINT CHK_MechanicID_PK
CHECK (MechanicID LIKE 'MC-[0-9][0-9][0-9]');

ALTER TABLE Mechanic
ADD CONSTRAINT CHK_MechanicEmail 
CHECK (MechanicEmail LIKE '%@%');

ALTER TABLE Mechanic
ADD CONSTRAINT CHK_MechanicAddress
CHECK (RIGHT(MechanicAddress, 6) = 'street');


CREATE TABLE CarBrand(
	CarBrandID CHAR(6) PRIMARY KEY,
	CarBrandName VARCHAR(32) NOT NULL,
	CarBrandOriginCountry VARCHAR(16) NOT NULL 
);

ALTER TABLE CarBrand
ADD CONSTRAINT CHK_CarBrand_ID 
CHECK (CarBrandID LIKE 'CB-[0-9][0-9][0-9]');

ALTER TABLE CarBrand
ADD CONSTRAINT CHK_CarBrandOriginCountry 
CHECK (CarBrandOriginCountry IN ('Japan', 'German', 'United States'));


CREATE TABLE Car(
	CarID CHAR(6) PRIMARY KEY,
	CarBrandID CHAR(6) NOT NULL CHECK (CarBrandID LIKE 'CB-[0-9][0-9][0-9]'),
	CarName CHAR(32) NOT NULL ,
	CarPrice INT NOT NULL,
	SeatCapacity INT NOT NULL,
	EngineCapacity INT NOT NULL,
	AvailabilityStatus INT NOT NULL

	FOREIGN KEY (CarBrandID) REFERENCES CarBrand(CarBrandID)
);

ALTER TABLE Car
ADD CONSTRAINT CHK_Car_ID 
CHECK (CarID LIKE 'CR-[0-9][0-9][0-9]');

ALTER TABLE Car
ADD CONSTRAINT CHK_CarName 
CHECK (LEN(CarName) > 0);

ALTER TABLE Car
ADD CONSTRAINT CHK_CarPrice 
CHECK (CarPrice BETWEEN 2000 AND 4000);

ALTER TABLE Car
ADD CONSTRAINT CHK_CarCapacity 
CHECK(SeatCapacity BETWEEN 1 AND 6);

ALTER TABLE Car
ADD CONSTRAINT CHK_CarEngineCapacity
CHECK (EngineCapacity BETWEEN 1000 AND 3000);

ALTER TABLE Car
ADD CONSTRAINT CHK_CarAvailbility
CHECK (AvailabilityStatus IN (0, 1));



CREATE TABLE Service (
    ServiceID CHAR(6) PRIMARY KEY,
    ServiceName VARCHAR(50) NOT NULL,
    ServicePrice INT NOT NULL
);

ALTER TABLE Service
ADD CONSTRAINT CHK_ServiceID
CHECK (ServiceID LIKE 'SV-[0-9][0-9][0-9]');

ALTER TABLE Service
ADD CONSTRAINT CHK_ServicePrice
CHECK (ServicePrice BETWEEN 100000 AND 1000000);


CREATE TABLE RentalTransaction (
    RentalTransactionID CHAR(6) PRIMARY KEY,
    StaffID CHAR(6) NOT NULL CHECK (StaffID LIKE 'SF-[0-9][0-9][0-9]'),
    CustomerID CHAR(6) NOT NULL CHECK (CustomerID LIKE 'CS-[0-9][0-9][0-9]'),
    RentalStartDate DATE NOT NULL,
    RentalReturnDate DATE NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
ALTER TABLE RentalTransaction
ADD CONSTRAINT CHK_RentalTransactionID
CHECK (RentalTransactionID LIKE 'TR-[0-9][0-9][0-9]');

ALTER TABLE RentalTransaction
ADD CONSTRAINT CHK_RentalReturnDate
CHECK (RentalReturnDate >= RentalStartDate);


CREATE TABLE RentalTransactionDetail (
    RentalTransactionID CHAR(6) NOT NULL CHECK (RentalTransactionID LIKE 'TR-[0-9][0-9][0-9]'),
    CarID CHAR(6) NOT NULL CHECK (CarID LIKE 'CR-[0-9][0-9][0-9]'),
    DistanceTraveled INT NOT NULL,
    FOREIGN KEY (RentalTransactionID) REFERENCES RentalTransaction(RentalTransactionID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

ALTER TABLE RentalTransactionDetail
ADD CONSTRAINT CHK_DistanceTraveled
CHECK (DistanceTraveled > 0);


CREATE TABLE ServiceTransaction (
    ServiceTransactionID CHAR(6) PRIMARY KEY,
    StaffID CHAR(6) NOT NULL CHECK (StaffID LIKE 'SF-[0-9][0-9][0-9]'),
	CustomerID CHAR(6) NOT NULL CHECK (CustomerID LIKE 'CS-[0-9][0-9][0-9]'),
    MechanicID CHAR(6) NOT NULL CHECK (MechanicID LIKE 'MC-[0-9][0-9][0-9]'),
	CarID CHAR(6) NOT NULL CHECK (CarID LIKE 'CR-[0-9][0-9][0-9]'),
    ServiceTransactionDate DATE NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (MechanicID) REFERENCES Mechanic(MechanicID)
);

ALTER TABLE ServiceTransaction
ADD CONSTRAINT CHK_ServiceTransactionID
CHECK (ServiceTransactionID LIKE 'TS-[0-9][0-9][0-9]');

ALTER TABLE ServiceTransaction
ADD CONSTRAINT CHK_ServiceTransactionDate
CHECK (ServiceTransactionDate >= GETDATE());


CREATE TABLE ServiceTransactionDetail (
    ServiceTransactionID CHAR(6) NOT NULL CHECK (ServiceTransactionID LIKE 'TS-[0-9][0-9][0-9]'),
    ServiceID CHAR(6) NOT NULL CHECK (ServiceID LIKE 'SV-[0-9][0-9][0-9]'),
    FOREIGN KEY (ServiceTransactionID) REFERENCES ServiceTransaction(ServiceTransactionID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID)
);


