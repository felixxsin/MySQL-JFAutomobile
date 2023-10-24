-- Inserting staff data
BEGIN TRAN 
INSERT INTO Staff (StaffID, StaffName, StaffEmail, StaffGender, StaffAddress, StaffPhone)
VALUES
('SF-001', 'John Doe', 'john.doe@email.com', 'Male', '123 Main St', '123-456-7890'),
('SF-002', 'Jane Smith', 'jane.smith@email.com', 'Female', '456 Elm St', '987-654-3210'),
('SF-003', 'Robert Johnson', 'robert.johnson@email.com', 'Male', '789 Oak St', '555-123-4567'),
('SF-004', 'Maria Garcia', 'maria.garcia@email.com', 'Female', '321 Pine St', '222-333-4444'),
('SF-005', 'Michael Brown', 'michael.brown@email.com', 'Male', '555 Cedar St', '111-222-3333'),
('SF-006', 'Sarah Davis', 'sarah.davis@email.com', 'Female', '777 Walnut St', '444-555-6666'),
('SF-007', 'James Wilson', 'james.wilson@email.com', 'Male', '888 Birch St', '777-888-9999'),
('SF-008', 'Linda Jackson', 'linda.jackson@email.com', 'Female', '999 Willow St', '666-777-8888'),
('SF-009', 'William Taylor', 'william.taylor@email.com', 'Male', '1010 Maple St', '123-456-7890'),
('SF-010', 'Patricia Harris', 'patricia.harris@email.com', 'Female', '1111 Oak St', '987-654-3210');


-- Inserting customer data
BEGIN TRAN 
INSERT INTO Customer (CustomerID, CustomerName, CustomerEmail, CustomerGender, CustomerAddress, CustomerPhone)
VALUES
('CS-001', 'Alice Johnson', 'alice.johnson@email.com', 'Female', '123 Elm St', '+62823-456-7890'),
('CS-002', 'Bob Smith', 'bob.smith@email.com', 'Male', '456 Oak St', '+62887-654-3210'),
('CS-003', 'Charlie Brown', 'charlie.brown@email.com', 'Male', '789 Cedar St', '+62855-123-4567'),
('CS-004', 'Diana Garcia', 'diana.garcia@email.com', 'Female', '321 Birch St', '+62822-333-4444'),
('CS-005', 'Eva Davis', 'eva.davis@email.com', 'Female', '555 Pine St', '+62811-222-3333'),
('CS-006', 'Frank Wilson', 'frank.wilson@email.com', 'Male', '777 Willow St', '+62844-555-6666'),
('CS-007', 'Grace Taylor', 'grace.taylor@email.com', 'Female', '888 Maple St', '+62877-888-9999'),
('CS-008', 'Henry Jackson', 'henry.jackson@email.com', 'Male', '999 Main St', '+62866-777-8888'),
('CS-009', 'Isabel Harris', 'isabel.harris@email.com', 'Female', '1010 Elm St', '+62823-456-7890'),
('CS-010', 'Jack Martin', 'jack.martin@email.com', 'Male', '1111 Oak St', '+62887-654-3210');

-- Inserting mechanic data
BEGIN TRAN 
INSERT INTO Mechanic (MechanicID, MechanicName, MechanicEmail, MechanicAddress, MechanicPhoneNumber)
VALUES
('MC-001', 'John Mechanic', 'john.mechanic@email.com', '123 Elm Street', '123-456-7890'),
('MC-002', 'Jane Smith', 'jane.smith@email.com', '456 Oak Street', '987-654-3210'),
('MC-003', 'Robert Johnson', 'robert.johnson@email.com', '789 Cedar Street', '555-123-4567'),
('MC-004', 'Maria Garcia', 'maria.garcia@email.com', '321 Birch Street', '222-333-4444'),
('MC-005', 'Michael Brown', 'michael.brown@email.com', '555 Pine Street', '111-222-3333'),
('MC-006', 'LeBron Mechanic', 'lebron.mechanic@email.com', '777 Willow Street', '444-555-6666'),
('MC-007', 'Michael Jordan', 'michael.jordan@email.com', '888 Maple Street', '777-888-9999'),
('MC-008', 'Kobe Bryant', 'kobe.bryant@email.com', '999 Main Street', '666-777-8888'),
('MC-009', 'Larry Bird', 'larry.bird@email.com', '1010 Elm Street', '123-456-7890'),
('MC-010', 'Shaquille ONeal', 'shaquille.oneal@email.com', '1111 Oak Street', '987-654-3210');

-- Inserting car brand data
BEGIN TRAN 
INSERT INTO CarBrand (CarBrandID, CarBrandName, CarBrandOriginCountry)
VALUES
('CB-001', 'Toyota', 'Japan'),
('CB-002', 'BMW', 'German'),
('CB-003', 'Ford', 'United States'),
('CB-004', 'Honda', 'Japan'),
('CB-005', 'Mercedes-Benz', 'German'),
('CB-006', 'Volkswagen', 'German'),
('CB-007', 'Chevrolet', 'United States'),
('CB-008', 'Nissan', 'Japan'),
('CB-009', 'Audi', 'German'),
('CB-010', 'Hyundai', 'Japan'),
('CB-011', 'Mazda', 'Japan'),
('CB-012', 'Kia', 'Japan');

-- Inserting car data
BEGIN TRAN 
INSERT INTO Car 
(CarID, CarBrandID, CarName, CarPrice, SeatCapacity, EngineCapacity, AvailabilityStatus)
VALUES
('CR-001', 'CB-001', 'Toyota Corolla', 2500, 5, 1600, 1),
('CR-002', 'CB-002', 'BMW 3 Series', 3500, 4, 1700, 1),
('CR-003', 'CB-003', 'Ford Focus', 3200, 5, 1500, 1),
('CR-004', 'CB-004', 'Honda Civic', 2300, 4, 1550, 1),
('CR-005', 'CB-005', 'Mercedes-Benz C-Class', 3900, 2, 1850, 1),
('CR-006', 'CB-006', 'Volkswagen Golf', 2600, 4, 1600, 0),
('CR-007', 'CB-007', 'Chevrolet Malibu', 2400, 5, 1600, 1),
('CR-008', 'CB-008', 'Nissan Altima', 2300, 5, 1600, 0),
('CR-009', 'CB-009', 'Audi A4', 3000, 2, 1700, 1),
('CR-010', 'CB-010', 'Hyundai Elantra', 2200, 6, 1550, 0),
('CR-011', 'CB-011', 'Mazda3', 3200, 4, 1600, 1),
('CR-012', 'CB-012', 'Kia Forte', 2200, 6, 1550, 0),
('CR-013', 'CB-001', 'Toyota Camry', 2700, 4, 1650, 1),
('CR-014', 'CB-002', 'BMW 5 Series', 3800, 2, 1800, 0),
('CR-015', 'CB-003', 'Ford Fusion', 2400, 6, 1550, 1),
('CR-016', 'CB-004', 'Honda Accord', 2500, 6, 1600, 1),
('CR-017', 'CB-005', 'Mercedes-Benz E-Class', 3200, 2, 1750, 0),
('CR-018', 'CB-006', 'Volkswagen Passat', 2800, 4, 1700, 1),
('CR-019', 'CB-007', 'Chevrolet Impala', 2600, 6, 1650, 1),
('CR-020', 'CB-008', 'Nissan Maxima', 2600, 6, 1650, 0);



-- Inserting service data
BEGIN TRAN 
INSERT INTO Service (ServiceID, ServiceName, ServicePrice)
VALUES
('SV-001', 'Oil Change', 300000),
('SV-002', 'Brake Inspection', 500000),
('SV-003', 'Tire Rotation', 900000),
('SV-004', 'Transmission Service', 280000),
('SV-005', 'Air Conditioning Repair', 950000),
('SV-006', 'Engine Tune-up', 1000000),
('SV-007', 'Car Detailing', 1000000),
('SV-008', 'Wheel Alignment', 1000000),
('SV-009', 'Radiator Flush', 1000000),
('SV-010', 'Exhaust System Repair', 1000000);

-- Inserting rental transaction data
BEGIN TRAN 
INSERT INTO RentalTransaction (RentalTransactionID, StaffID, CustomerID, RentalStartDate, RentalReturnDate)
VALUES
('TR-001', 'SF-001', 'CS-001', '2024-02-01', '2024-02-05'),
('TR-002', 'SF-002', 'CS-002', '2024-02-02', '2024-02-06'),
('TR-003', 'SF-003', 'CS-003', '2024-02-03', '2024-02-07'),
('TR-004', 'SF-004', 'CS-004', '2024-02-04', '2024-02-08'),
('TR-005', 'SF-005', 'CS-005', '2024-03-05', '2024-03-09'),
('TR-006', 'SF-006', 'CS-006', '2024-03-06', '2024-03-09'),
('TR-007', 'SF-006', 'CS-007', '2024-03-07', '2024-03-10'),
('TR-008', 'SF-007', 'CS-008', '2024-04-08', '2024-04-09'),
('TR-009', 'SF-007', 'CS-009', '2024-04-09', '2024-04-12'),
('TR-010', 'SF-008', 'CS-010', '2024-05-09', '2024-05-13'),
('TR-011', 'SF-008', 'CS-009', '2024-06-09', '2024-06-15'),
('TR-012', 'SF-008', 'CS-010', '2024-07-10', '2024-07-15'),
('TR-013', 'SF-009', 'CS-002', '2024-07-10', '2024-07-16'),
('TR-014', 'SF-009', 'CS-003', '2024-07-10', '2024-07-15'),
('TR-015', 'SF-009', 'CS-005', '2024-07-11', '2024-07-14'),
('TR-016', 'SF-009', 'CS-008', '2024-07-11', '2024-07-13'),
('TR-017', 'SF-009', 'CS-009', '2024-08-11', '2024-08-12'),
('TR-018', 'SF-009', 'CS-007', '2024-08-11', '2024-08-13'),
('TR-019', 'SF-010', 'CS-006', '2024-09-12', '2024-09-15'),
('TR-020', 'SF-010', 'CS-005', '2024-09-12', '2024-09-16'),
('TR-021', 'SF-001', 'CS-004', '2024-10-13', '2024-10-18'),
('TR-022', 'SF-002', 'CS-002', '2024-10-13', '2024-10-15'),
('TR-023', 'SF-003', 'CS-008', '2024-11-14', '2024-11-16'),
('TR-024', 'SF-004', 'CS-007', '2024-12-14', '2024-12-17'),
('TR-025', 'SF-005', 'CS-006', '2024-12-15', '2024-12-19');


-- Inserting rental transaction details
BEGIN TRAN 
INSERT INTO RentalTransactionDetail (RentalTransactionID, CarID, DistanceTraveled)
VALUES
('TR-001', 'CR-001', 300),
('TR-001', 'CR-003', 600),
('TR-001', 'CR-008', 800),
('TR-002', 'CR-002', 250),
('TR-003', 'CR-003', 400),
('TR-004', 'CR-006', 450),
('TR-005', 'CR-005', 600),
('TR-006', 'CR-004', 300),
('TR-007', 'CR-008', 150),
('TR-008', 'CR-012', 200),
('TR-009', 'CR-010', 750),
('TR-009', 'CR-014', 650),
('TR-009', 'CR-016', 550),
('TR-010', 'CR-016', 300),
('TR-011', 'CR-018', 100),
('TR-012', 'CR-020', 650),
('TR-013', 'CR-015', 600),
('TR-014', 'CR-013', 450),
('TR-015', 'CR-011', 600),
('TR-016', 'CR-017', 400),
('TR-017', 'CR-008', 350),
('TR-018', 'CR-009', 700),
('TR-019', 'CR-010', 250),
('TR-020', 'CR-017', 100),
('TR-021', 'CR-012', 700),
('TR-022', 'CR-014', 650),
('TR-023', 'CR-002', 200),
('TR-024', 'CR-005', 150),
('TR-025', 'CR-004', 700);

-- Inserting service transaction data
BEGIN TRAN
INSERT INTO ServiceTransaction (ServiceTransactionID, StaffID, CustomerID, MechanicID, CarID, ServiceTransactionDate)
VALUES
('TS-001', 'SF-001', 'CS-001', 'MC-001', 'CR-001', '2024-01-24'),
('TS-002', 'SF-002', 'CS-002', 'MC-002', 'CR-001', '2024-02-24'),
('TS-003', 'SF-003', 'CS-003', 'MC-003', 'CR-001', '2024-03-25'),
('TS-004', 'SF-004', 'CS-004', 'MC-004', 'CR-001', '2024-04-25'),
('TS-005', 'SF-005', 'CS-005', 'MC-005', 'CR-001', '2024-04-27'),
('TS-006', 'SF-006', 'CS-004', 'MC-006', 'CR-001', '2024-05-28'),
('TS-007', 'SF-007', 'CS-007', 'MC-007', 'CR-001', '2024-05-29'),
('TS-008', 'SF-008', 'CS-008', 'MC-008', 'CR-001', '2024-06-30'),
('TS-009', 'SF-009', 'CS-010', 'MC-009', 'CR-001', '2024-07-25'),
('TS-010', 'SF-010', 'CS-006', 'MC-010', 'CR-001', '2024-08-27'),
('TS-011', 'SF-002', 'CS-002', 'MC-001', 'CR-001', '2024-09-28'),
('TS-012', 'SF-003', 'CS-006', 'MC-002', 'CR-002', '2024-09-29'),
('TS-013', 'SF-005', 'CS-007', 'MC-005', 'CR-002', '2024-09-29'),
('TS-014', 'SF-003', 'CS-006', 'MC-010', 'CR-002', '2024-09-29'),
('TS-015', 'SF-003', 'CS-002', 'MC-009', 'CR-002', '2024-10-30'),
('TS-016', 'SF-002', 'CS-002', 'MC-001', 'CR-002', '2024-10-28'),
('TS-017', 'SF-003', 'CS-006', 'MC-002', 'CR-003', '2024-10-29'),
('TS-018', 'SF-005', 'CS-007', 'MC-005', 'CR-003', '2024-11-29'),
('TS-019', 'SF-003', 'CS-006', 'MC-010', 'CR-003', '2024-12-29'),
('TS-020', 'SF-003', 'CS-002', 'MC-009', 'CR-003', '2024-12-30');

-- Inserting service transaction details
BEGIN TRAN
INSERT INTO ServiceTransactionDetail (ServiceTransactionID, ServiceID)
VALUES
('TS-001', 'SV-001'),
('TS-001', 'SV-002'),
('TS-001', 'SV-003'),

('TS-002', 'SV-001'),
('TS-002', 'SV-003'),
('TS-002', 'SV-004'),
('TS-002', 'SV-005'),
('TS-002', 'SV-007'),

('TS-003', 'SV-001'),
('TS-003', 'SV-002'),
('TS-003', 'SV-004'),
('TS-003', 'SV-005'),

('TS-004', 'SV-001'),
('TS-004', 'SV-003'),
('TS-004', 'SV-005'),
('TS-004', 'SV-007'),
('TS-004', 'SV-008'),
('TS-004', 'SV-009'),

('TS-005', 'SV-001'),
('TS-005', 'SV-002'),
('TS-005', 'SV-006'),
('TS-005', 'SV-008'),

('TS-006', 'SV-002'),
('TS-006', 'SV-003'),
('TS-006', 'SV-004'),

('TS-007', 'SV-007'),
('TS-007', 'SV-009'),
('TS-007', 'SV-010'),

('TS-008', 'SV-002'),
('TS-008', 'SV-003'),
('TS-008', 'SV-004'),
('TS-008', 'SV-005'),
('TS-008', 'SV-008'),

('TS-009', 'SV-003'),
('TS-009', 'SV-005'),
('TS-009', 'SV-008'),
('TS-009', 'SV-010'),

('TS-010', 'SV-002'),
('TS-010', 'SV-005'),
('TS-010', 'SV-006'),
('TS-010', 'SV-007'),
('TS-010', 'SV-008'),
('TS-010', 'SV-009'),

('TS-011', 'SV-001'),
('TS-011', 'SV-002'),
('TS-011', 'SV-004'),
('TS-011', 'SV-008'),

('TS-012', 'SV-001'),
('TS-012', 'SV-003'),
('TS-012', 'SV-008'),

('TS-013', 'SV-001'),
('TS-013', 'SV-006'),
('TS-013', 'SV-007'),

('TS-014', 'SV-001'),
('TS-014', 'SV-002'),
('TS-014', 'SV-003'),
('TS-014', 'SV-005'),
('TS-014', 'SV-010'),

('TS-015', 'SV-001'),
('TS-015', 'SV-002'),
('TS-015', 'SV-003'),
('TS-015', 'SV-006'),
('TS-015', 'SV-009'),

('TS-016', 'SV-001'),
('TS-016', 'SV-003'),
('TS-016', 'SV-008'),

('TS-017', 'SV-001'),
('TS-017', 'SV-006'),
('TS-017', 'SV-007'),

('TS-018', 'SV-001'),
('TS-018', 'SV-002'),
('TS-018', 'SV-003'),
('TS-018', 'SV-005'),
('TS-018', 'SV-010'),

('TS-019', 'SV-001'),
('TS-019', 'SV-002'),
('TS-019', 'SV-003'),
('TS-019', 'SV-006'),
('TS-019', 'SV-009'),

('TS-020', 'SV-006'),
('TS-020', 'SV-007'),
('TS-020', 'SV-001'),
('TS-020', 'SV-002'),
('TS-020', 'SV-003');


--DELETE FROM Customer
--DELETE FROM RentalTransaction
--DELETE FROM ServiceTransaction
--DELETE FROM RentalTransactionDetail
--DELETE FROM ServiceTransactionDetail
