SELECT * FROM Staff

SELECT ServiceTransactionID, STD.ServiceID, ServiceName, ServicePrice
FROM ServiceTransactionDetail STD
JOIN Service S
ON STD.ServiceID = S.ServiceID

--1.	Display CarBrandCountry and 
--Times Rent (obtained from the total number of different car is rented in one transaction) 
--and ordered in descending by Time Rent for every rental transaction 
--that starts in quarter 2 of 2022.
SELECT CarBrandOriginCountry,
COUNT(DISTINCT RTD.CarID) AS [TIMES RENT]
FROM CarBrand CB 
JOIN
Car C
ON CB.CarBrandID = C.CarBrandID
JOIN 
RentalTransactionDetail RTD
ON RTD.CarID = C.CarID
JOIN
RentalTransaction RT 
ON RT.RentalTransactionID = RTD.RentalTransactionID 
WHERE DATEPART(QUARTER, rt.RentalStartDate) = 2
GROUP BY CarBrandOriginCountry
ORDER BY COUNT(DISTINCT rtd.CarID)


--2.Display MechanicId, MechanicName, 
--Email (obtained by replacing ‘mail.com’ with ‘mecha.com’), 
--and Total Earning (obtained by adding ‘IDR ’ in front of the sum 
--of the CarServicePrice) for every car service price that 
--is greater than 300000 and the sum of car service price  
--is greater than 3000000.


SELECT M.MechanicID, MechanicName, 
REPLACE(MechanicEmail, '@email.com', '@mecha.com')AS Email,
CONCAT ('IDR ', SUM(s.ServicePrice)) AS [TotalEarnings]
FROM Mechanic M JOIN ServiceTransaction ST
ON M.MechanicID = ST.MechanicID
JOIN ServiceTransactionDetail STD
ON STD.ServiceTransactionID = ST.ServiceTransactionID
JOIN Service S 
ON S.ServiceID = STD.ServiceID
--WHERE SUM(s.ServicePrice) > 300000
GROUP BY M.MechanicID, M.MechanicName, M.MechanicEmail
HAVING SUM(S.ServicePrice) > 300000
AND SUM(S.ServicePrice) > 3000000
ORDER BY TotalEarnings ASC;

--3.Display top 5 TransactionId and Total Distance 
--(obtained from sum of distance) in descending for 
--every rental transaction that starts in 2022 
--and have 2 different cars rent.

SELECT TOP(5) RTD.RentalTransactionID,
SUM(RTD.DistanceTraveled) AS TotalDistance
FROM RentalTransaction RT 
JOIN RentalTransactionDetail RTD
ON RTD.RentalTransactionID = RT.RentalTransactionID
WHERE DATEPART(YEAR, rt.RentalStartDate) = 2024
GROUP BY RTD.RentalTransactionID
HAVING COUNT(DISTINCT rtd.CarID) > 2


--4.Display CarId, 
--Car (obtained by adding “.” between CarBrandName and CarName), 
--Country Code (obtained by adding the first and the last character of CarBrandCountry),
--and Time Rent (obtained from the total number of different car rented in one transaction) 
--for every car that has a higher engine capacity 
--than the average engine capacity of every car and Time Rent more than one. 

SELECT C.CarID,
CONCAT(CarBrandName,' . ',CarName) AS CAR,
CONCAT(LEFT(CarBrandOriginCountry,1),RIGHT(CarBrandOriginCountry,1)) AS CountryCode,
COUNT(RTD.CarID) AS TimeRent
FROM Car C
JOIN CarBrand CB 
ON C.CarBrandID = CB.CarBrandID
JOIN RentalTransactionDetail RTD
ON RTD.CarID = C.CarID,
(
	SELECT AVG(EngineCapacity) AS AverageEngine
	FROM Car
)subquery
WHERE c.EngineCapacity > subquery.AverageEngine
GROUP BY C.CarID, CarBrandName,CarName, CarBrandOriginCountry, RTD.CarID

--5.Display CarServiceName, 
--Old Price (obtained from CarServicePrice), 
--and New Price (obtained from CarServicePrice + AdditionalPrice). 
--Additional price is determined by how many times a service is used on weekdays of 2022. 
--Show the data by the biggest price increase in descending.
--(alias subquery)
SELECT ServiceName, 
ServicePrice AS OldPrice, 
ServicePrice + (
CASE
	WHEN X.TotalTimes < 5 THEN (ServicePrice * 0.05)
	WHEN X.TotalTimes >= 5 AND TotalTimes < 10 THEN (ServicePrice * 0.10)
	WHEN X.TotalTimes >=10 THEN (ServicePrice * 0.15)
END 
) AS NewPrice
FROM Service S,
(
	SELECT STD.ServiceID, COUNT(*) AS TotalTimes
	FROM ServiceTransaction ST
	JOIN ServiceTransactionDetail STD
	ON ST.ServiceTransactionID = STD.ServiceTransactionID
	WHERE YEAR(ST.ServiceTransactionDate) = 2024 
	AND DATEPART(WEEKDAY, ST.ServiceTransactionDate) IN (2,3,4,5,6)
	GROUP BY STD.ServiceID
)X
WHERE X.ServiceID = S.ServiceID
ORDER BY 
(ServicePrice +(
CASE
	WHEN X.TotalTimes < 5 THEN (ServicePrice * 0.05)
	WHEN X.TotalTimes >= 5 AND TotalTimes < 10 THEN (ServicePrice * 0.10)
	WHEN X.TotalTimes >=10 THEN (ServicePrice * 0.15)
END
)) - ServicePrice DESC;

-----------------ALTERNATIVE ANSWER NO.5------------------------------------------
SELECT
    ServiceName,
    OldPrice,
    NewPrice
FROM (
    SELECT
        S.ServiceName AS ServiceName,
        S.ServicePrice AS OldPrice,
        S.ServicePrice + (
            CASE
                WHEN X.TotalTimes < 5 THEN (S.ServicePrice * 0.05)
                WHEN X.TotalTimes >= 5 AND X.TotalTimes < 10 THEN (S.ServicePrice * 0.10)
                WHEN X.TotalTimes >= 10 THEN (S.ServicePrice * 0.15)
            END
        ) AS NewPrice
    FROM Service AS S
    JOIN (
        SELECT
            STD.ServiceID,
            COUNT(*) AS TotalTimes
        FROM ServiceTransaction AS ST
        JOIN ServiceTransactionDetail AS STD ON ST.ServiceTransactionID = STD.ServiceTransactionID
        WHERE YEAR(ST.ServiceTransactionDate) = 2024 
        AND DATEPART(WEEKDAY, ST.ServiceTransactionDate) IN (2, 3, 4, 5, 6)
        GROUP BY STD.ServiceID
    ) AS X ON S.ServiceID = X.ServiceID
) AS Result
ORDER BY (NewPrice - OldPrice) DESC;
-----------------END ALTERNATIVE ANSWER NO.5------------------------------------------

--6.Display TransactionId, 
--Customer Name (obtained from CustomerName in lowercase format), 
--Start Date (obtained from StartDate in “mm dd, yyyy” format), 
--CarId, and Transaction Price (obtained from total price multiply by distance) 
--for every transaction that has a higher Transaction Price 
--than the average Transaction Price of each car that is returned within 7 days.
--(alias subquery)

SELECT RT.RentalTransactionID, 
LOWER(CustomerName) AS CustomerName,
FORMAT(RentalStartDate,'dd-MM-yyyy') AS StartDate,
RTD.CarID,
(RTD.DistanceTraveled * CA.CarPrice) AS TransactionPrice
FROM RentalTransaction RT
JOIN Customer C 
ON RT.CustomerID = C.CustomerID
JOIN RentalTransactionDetail RTD
ON RT.RentalTransactionID = RTD.RentalTransactionID
JOIN Car CA
ON CA.CarID = RTD.CarID,
(
	SELECT AVG(RTD2.DistanceTraveled * CA2.CarPrice) AS AveragePrice
	FROM RentalTransactionDetail rtd2 
	JOIN Car CA2 
	ON CA2.CarID = rtd2.CarID
	JOIN RentalTransaction RT2
	ON RT2.RentalTransactionID = rtd2.RentalTransactionID
	WHERE DATEDIFF(DAY,RT2.RentalStartDate, RT2.RentalReturnDate)<7
)X
WHERE (RTD.DistanceTraveled*CA.CarPrice) > X.AveragePrice
GROUP BY RT.RentalTransactionID, C.CustomerName, RT.RentalStartDate, 
RTD.CarID,RTD.DistanceTraveled, CA.CarPrice

--7. Display Staff ID (obtained by replacing characters before ‘-‘ 
--with “Employee”), 
--First Name (obtained from the first word before space in StaffName), 
--Total Handled Transaction (obtained from total number of service transactions), 
--and Gained Service Fee (obtained from the sum of service fee per transaction 
--(Transaction service fee is gained from the sum of 5% CarServicePrice)) 
--for every staff whose gender is male and has handled at least 4 service transactions. 
--(alias subquery)

SELECT DISTINCT REPLACE(S.StaffID,LEFT(S.StaffID,2),'Employee') AS Employee,
SUBSTRING(StaffName,1,CHARINDEX(' ',StaffName)-1) AS FirstName,
COUNT(ST.ServiceTransactionID) AS TotalHandleTransaction,
SUM(X.ServiceCommission) as GainedServiceFee
FROM Staff S
JOIN ServiceTransaction ST
ON S.StaffID = ST.StaffID,
(
	SELECT ST2.StaffID , 0.05 * Se.ServicePrice AS ServiceCommission
	FROM ServiceTransaction ST2
	JOIN ServiceTransactionDetail STD2
	ON ST2.ServiceTransactionID = STD2.ServiceTransactionID
	JOIN Service Se
	ON Se.ServiceID = STD2.ServiceID
	JOIN Staff S2
	ON S2.StaffID = ST2.StaffID
)X
WHERE S.StaffID = X.StaffID AND S.StaffGender = 'Male'
GROUP BY S.StaffID, S.StaffName, ST.ServiceTransactionID

--8.Display CustomerName, 
--Customer Phone (obtained by replacing “+62” with “IDN - ”), 
--Total Spent (obtained from the sum of rental transaction price 
--(rental transaction price obtained by multiplying car price and distance)), 
--Maximum Spent in 1 Transaction (obtained from the highest rental transaction price 
--(rental transaction price obtained by multiplying car price and distance)), 
--and Membership Status for every male customer 
--who has a highest rental transaction price higher than 1500000. 
--(alias subquery)

SELECT CustomerName,
REPLACE(CustomerPhone,'+62','IDN - ') AS CustomerPhone,
X.TotalSpent AS TotalSpent,
X.MaxSpent,
(
	CASE
		WHEN X.TotalSpent < 3000000 THEN 'Member'
		WHEN X.TotalSpent >= 3000000 AND X.TotalSpent < 5000000THEN 'Silver Member'
		WHEN X.TotalSpent >= 5000000 THEN 'Gold Member'
	END
) AS MembershipStatus
FROM Customer C
JOIN RentalTransaction RT
ON RT.CustomerID = C.CustomerID
JOIN RentalTransactionDetail RTD
ON RTD.RentalTransactionID = RT.RentalTransactionID,
(
SELECT 
RT2.CustomerID,SUM(CarPrice * DistanceTraveled) AS TotalSpent, 
MAX(CarPrice * DistanceTraveled) AS MaxSpent
FROM Car C2 
JOIN RentalTransactionDetail RTD2
ON C2.CarID = RTD2.CarID
JOIN RentalTransaction RT2
ON RT2.RentalTransactionID = RTD2.RentalTransactionID
GROUP BY RT2.CustomerID
)X
WHERE X.CustomerID = RT.CustomerID AND CustomerGender = 'Male' AND X.MaxSpent > 1500000
GROUP BY CustomerName, CustomerPhone, X.TotalSpent, X.MaxSpent


--9.Create a view named ViewMinAndMaxDistance that shows 
--Min Distance (obtained from adding “ km”  after the minimum distance traveled in a rental transaction), 
--Max Distance (obtained from adding “ km”  after the maximum distance traveled in a rental transaction) 
--for rental transaction that starts in the first quarter of 2022.
CREATE VIEW [ViewMinAndMaxDistance] AS
SELECT CONCAT('KM',MIN(DistanceTraveled)) AS MinDistance,
CONCAT('KM',MAX(DistanceTraveled)) AS MaxDistance
FROM RentalTransaction RT 
JOIN RentalTransactionDetail RTD
ON RT.RentalTransactionID = RTD.RentalTransactionID
WHERE DATEPART(QUARTER,RT.RentalStartDate) = 1
GO

--10.Create a view named ViewAverageShortRentalEarning that display 
--Average Earning (obtained by adding “Rp. ” before the average of rental price multiply by quantity and “.-”
--after the average rental price) for every car that originates from Japan 
--and has a rental duration less than equals to the minimum rental duration added by one 
--in rental transaction.
CREATE VIEW [ViewAverageShortRentalEarning] AS
SELECT CONCAT('Rp ', x.Average, '.-') AS ViewAverageShortRentalEarning
FROM
(
SELECT AVG(DistanceTraveled*CarPrice) AS Average
FROM RentalTransactionDetail RTD
JOIN Car C ON
RTD.CarID = C.CarID
JOIN CarBrand CB
ON CB.CarBrandID = C.CarBrandID
JOIN RentalTransaction RT
ON RT.RentalTransactionID = RTD.RentalTransactionID,
	(
		SELECT MIN(DATEDIFF(DAY, RT2.RentalStartDate, RT2.RentalReturnDate)) AS Minimal
		FROM RentalTransaction RT2
	)y
WHERE CB.CarBrandOriginCountry = 'JAPAN' AND DATEDIFF(DAY,RT.RentalStartDate, RT.RentalReturnDate) <= Y.Minimal+1
)x


