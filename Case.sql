-- 1
SELECT CarBrandOriginCountry, COUNT(DISTINCT rtd.CarID) AS [Times Rent]
FROM MsBrand mb JOIN MsCar mc ON mb.CarBrandID = mc.CarBrandID JOIN RentalTransactionDetail rtd ON rtd.CarID = mc.CarID JOIN RentalTransactionHeader rth ON rth.RentalTransactionID = rtd.RentalTransactionID
WHERE DATEPART(QUARTER, rth.StartRentalDate) = 2
GROUP BY CarBrandOriginCountry
ORDER BY COUNT(DISTINCT rtd.CarID)

-- 2
SELECT mm.MechanicID, MechanicName, REPLACE(MechanicEmail, 'mail.com', 'mecha.com') AS [Email], CONCAT('IDR ', SUM(ms.ServicePrice)) AS [Total Earning]
FROM MsMechanic mm JOIN ServiceTransactionHeader sth ON sth.MechanicID = mm.MechanicID JOIN ServiceTransactionDetail std ON std.ServiceTransactionID = sth.ServiceTransactionID JOIN MsService ms ON ms.ServiceID = std.ServiceID
WHERE ms.ServicePrice > 300000
GROUP BY mm.MechanicID, mm.MechanicName, mm.MechanicEmail
HAVING SUM(ms.ServicePrice) >  3000000

-- 3
SELECT TOP 5 rth.RentalTransactionID, SUM(rtd.CarDistanceTravelled) AS [Total Distance]
FROM RentalTransactionHeader rth JOIN RentalTransactionDetail rtd ON rth.RentalTransactionID = rtd.RentalTransactionID JOIN MsCar mc ON rtd.CarID = mc.CarID
WHERE DATEPART(YEAR, rth.StartRentalDate) = 2022 
GROUP BY rth.RentalTransactionID
HAVING COUNT(DISTINCT rtd.CarID) > 2

-- 4
SELECT mc.CarID, CONCAT(mb.CarBrandName, '.', mc.CarName) AS [Car], CONCAT(LEFT(mb.CarBrandOriginCountry, 1), RIGHT(mb.CarBrandOriginCountry, 1)) AS [Country Code], COUNT( rtd.CarID)  AS [Time Rent]
FROM MsCar mc JOIN MsBrand mb ON mc.CarBrandID = mb.CarBrandID JOIN RentalTransactionDetail rtd ON rtd.CarID = mc.CarID JOIN RentalTransactionHeader rth ON rth.RentalTransactionID = rtd.RentalTransactionID,

(
	SELECT AVG(EngineCapacity) 'Average Engine Capacity'
	FROM MsCar 
)subquery
WHERE mc.EngineCapacity > subquery.[Average Engine Capacity] 
GROUP BY mc.CarID, mb.CarBrandName,mc.CarName,  mb.CarBrandOriginCountry
HAVING COUNT(rtd.CarID)  > 1

-- 5
SELECT ServiceName, [Old Price] = ServicePrice, [New Price] = ServicePrice + (
 CASE 
        WHEN x.TotalTimes < 5 THEN (ServicePrice * 0.05)
        WHEN x.TotalTimes >= 5 AND TotalTimes < 10 THEN (ServicePrice * 0.1)
  WHEN x.TotalTimes >= 10 THEN (ServicePrice * 0.15)
 END
)
FROM MsService ms, (
 SELECT ServiceID,  COUNT(DISTINCT svh.ServiceTransactionID) 'TotalTimes'
 FROM ServiceTransactionHeader svh JOIN ServiceTransactionDetail svt ON svh.ServiceTransactionID = svt.ServiceTransactionID
 GROUP BY ServiceID, YEAR(svh.TransactionDate), DATEPART(WEEKDAY, svh.TransactionDate)
 HAVING YEAR(svh.TransactionDate) = 2022 AND DATEPART(WEEKDAY, svh.TransactionDate) IN (2,3,4,5,6)
)x
WHERE x.ServiceID = ms.ServiceID


-- 6
SELECT rth.RentalTransactionID, LOWER(mc.CustomerName) AS [Customer Name], FORMAT(rth.StartRentalDate, 'MM dd, yyyy') AS [Start Date], rtd.CarID, (rtd.CarDistanceTravelled * mca.CarPrice) AS [Transaction Price]
FROM RentalTransactionHeader rth JOIN MsCustomer mc ON rth.CustomerID = mc.CustomerID JOIN RentalTransactionDetail rtd ON rth.RentalTransactionID = rtd.RentalTransactionID JOIN MsCar mca ON rtd.CarID = mca.CarID,(
	SELECT AVG(rtd2.CarDistanceTravelled * mca2.CarPrice) 'AveragePrice'
	FROM RentalTransactionDetail rtd2 JOIN MsCar mca2 ON rtd2.CarID = mca2.CarID JOIN RentalTransactionHeader rth2 ON rth2.RentalTransactionID = rtd2.RentalTransactionID
	WHERE DATEDIFF(DAY, rth2.StartRentalDate, rth2.ReturnDate) < 7
)SubQuery
WHERE(rtd.CarDistanceTravelled * mca.CarPrice) > SubQuery.AveragePrice
GROUP BY rth.RentalTransactionID, mc.CustomerName, rth.StartRentalDate, rtd.CarID, rtd.CarDistanceTravelled, mca.CarPrice

-- 7
SELECT STUFF(ms.StaffID, 1, CHARINDEX('-', ms.StaffID, 0)-1, 'Employee')  AS [Staff ID], SUBSTRING(ms.StaffName, 1, CHARINDEX(' ', ms.StaffName, 1)) AS [First Name], COUNT(sth.ServiceTransactionID) AS [Total Handled Transaction] , SUM(x.ServiceFee) AS [Gained Service Fee]
FROM MsStaff ms JOIN ServiceTransactionHeader sth ON sth.StaffID = ms.StaffID JOIN ServiceTransactionDetail std ON std.ServiceTransactionID = sth.ServiceTransactionID,

(
	SELECT mss2.StaffID 'StaffID', 0.05 * ms2.ServicePrice'ServiceFee'
	FROM MsService ms2 JOIN  ServiceTransactionDetail std2 ON ms2.ServiceID = std2.ServiceID JOIN ServiceTransactionHeader sth2 ON sth2.ServiceTransactionID = std2.ServiceTransactionID JOIN MsStaff mss2 ON mss2.StaffID = sth2.StaffID

)x
WHERE ms.StaffID = x.StaffID AND ms.StaffGender = 'Male' 
GROUP BY ms.StaffID, ms.StaffName
HAVING  COUNT(sth.ServiceTransactionID) > 4


-- 8
SELECT CustomerName, REPLACE(CustomerPhoneNumber, '+62', 'IDN- ') AS [Customer Phone], 	 SUM(y.RentalTransactionPrice) AS [Total Spent], x.Max AS [Maximum Spent], (
	CASE 
        WHEN  SUM(y.RentalTransactionPrice) < 3000000 THEN 'Member'
        WHEN SUM(y.RentalTransactionPrice) >= 3000000 AND SUM(y.RentalTransactionPrice) < 5000000 THEN 'Silver Member'
		WHEN SUM(y.RentalTransactionPrice) >= 5000000 THEN 'Gold Member'
 END

)
FROM MsCustomer mc, (
	SELECT mcc2.CustomerID 'CustomerID', MAX(rdt2.CarDistanceTravelled * mc2.CarPrice) 'Max'
	FROM MsCar mc2 JOIN RentalTransactionDetail rdt2 ON mc2.CarID= rdt2.CarID JOIN RentalTransactionHeader rth2 ON rth2.RentalTransactionID = rdt2.RentalTransactionID  JOIN MsCustomer mcc2 ON mcc2.CustomerID = rth2.CustomerID
	GROUP BY mcc2.CustomerID, rdt2.CarDistanceTravelled, mc2.CarPrice
)x,(
	SELECT mcc2.CustomerID 'CustomerID', rdt2.CarDistanceTravelled * mc2.CarPrice 'RentalTransactionPrice'
	FROM MsCar mc2 JOIN RentalTransactionDetail rdt2 ON mc2.CarID= rdt2.CarID JOIN RentalTransactionHeader rth2 ON rth2.RentalTransactionID = rdt2.RentalTransactionID  JOIN MsCustomer mcc2 ON mcc2.CustomerID = rth2.CustomerID
	GROUP BY mcc2.CustomerID, rdt2.CarDistanceTravelled, mc2.CarPrice

)y
WHERE x.Max> 1500000 AND CustomerGender = 'Male' AND mc.CustomerID  = y.CustomerID AND mc.CustomerID = x.CustomerID



GROUP BY CustomerName, CustomerPhoneNumber, x.Max




-- 9
CREATE VIEW ViewMinAndMaxDistance
AS
SELECT CONCAT(x.Min, ' km') AS [Min Distance], CONCAT(y.Max, ' km') AS [Max Distance]
FROM (
	SELECT MIN(rtd.CarDistanceTravelled) 'Min'
	FROM RentalTransactionDetail rtd JOIN RentalTransactionHeader rth ON rth.RentalTransactionID = rtd.RentalTransactionID
	WHERE DATEPART(QUARTER, RTH.StartRentalDate) = 1 AND YEAR(rth.StartRentalDate) = 2022

)x,(
	SELECT MAX(rtd.CarDistanceTravelled) 'Max'
	FROM RentalTransactionDetail rtd JOIN RentalTransactionHeader rth ON rth.RentalTransactionID = rtd.RentalTransactionID
	WHERE DATEPART(QUARTER, RTH.StartRentalDate) = 1 AND YEAR(rth.StartRentalDate) = 2022

)y

-- 10
CREATE VIEW ViewAverageShortRentalEarning
AS
SELECT CONCAT('Rp. ', x.Average, '.-') AS [ViewAverageShortRentalEarning]
FROM (
	SELECT AVG(mc.CarPrice * rtd.CarDistanceTravelled) 'Average'
	FROM MsCar mc JOIN RentalTransactionDetail rtd ON mc.CarID = rtd.CarID JOIN MsBrand mb ON mc.CarBrandID = mb.CarBrandID JOIN RentalTransactionHeader rth ON rth.RentalTransactionID = rtd.RentalTransactionID,(
		SELECT MIN(DATEDIFF(DAY, rth2.StartRentalDate, rth2.ReturnDate))'Min'
		FROM RentalTransactionHeader rth2


	)y
	WHERE mb.CarBrandOriginCountry ='Japan' AND DATEDIFF(DAY, rth.StartRentalDate, rth.ReturnDate) <= y.Min+1

)x

