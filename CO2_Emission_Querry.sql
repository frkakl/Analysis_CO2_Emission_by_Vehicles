SELECT *
FROM Vehicles_CO2_Emission..CO2_Emissions
ORDER BY 12 DESC


----------------------------------------------------------------------------------------------------------------------------------------------------

-- Delete useless columns
ALTER TABLE Vehicles_CO2_Emission..CO2_Emissions 
DROP COLUMN [Fuel Consumption Comb (mpg)];
GO

ALTER TABLE Vehicles_CO2_Emission..CO2_Emissions 
DROP COLUMN [Vehicle Class];
GO

SELECT *
FROM Vehicles_CO2_Emission..CO2_Emissions
ORDER BY 10 DESC

----------------------------------------------------------------------------------------------------------------------------------------------------

-- Brand - Model - Engine Size - Fuel Consumption - Emission
SELECT Brand, model, [Engine Size(L)], [Fuel Consumption - Combined (L/100 km)], [CO2 Emissions(g/km)]
FROM Vehicles_CO2_Emission..CO2_Emissions
ORDER BY 5 DESC

----------------------------------------------------------------------------------------------------------------------------------------------------

-- Change X,Z,etc to Gasoline, Diesel, etc in Fuel Type
SELECT DISTINCT [Fuel Type], COUNT([Fuel Type]) AS 'COUNT'
FROM Vehicles_CO2_Emission..CO2_Emissions
GROUP BY [Fuel Type]
ORDER BY 2 DESC

UPDATE Vehicles_CO2_Emission..CO2_Emissions
SET [Fuel Type] = CASE WHEN [Fuel Type] = 'X' THEN 'Regular Gasoline'
						WHEN [Fuel Type] = 'Z' THEN 'Premium Gasoline'
						WHEN [Fuel Type] = 'E' THEN 'Ethanol (E85)'
						WHEN [Fuel Type] = 'D' THEN 'Diesel'
						WHEN [Fuel Type] = 'N' THEN 'Natural Gas'
						ELSE [Fuel Type] 
						END

----------------------------------------------------------------------------------------------------------------------------------------------------

-- Change AM6, AM7, etc to Automatic, Automated Manual, etc in Fuel Type
SELECT DISTINCT Transmission, COUNT(Transmission) AS 'COUNT'
FROM Vehicles_CO2_Emission..CO2_Emissions
GROUP BY Transmission
ORDER BY 2 DESC

UPDATE Vehicles_CO2_Emission..CO2_Emissions
SET Transmission = CASE WHEN Transmission = 'AS6' THEN 'Auto Select Shift 6 Gears'						
						WHEN Transmission = 'AS8' THEN 'Auto Select Shift 8 Gears'
						WHEN Transmission = 'M6' THEN 'Manual 6 Gears'
						WHEN Transmission = 'A6' THEN 'Automatic 6 Gears'
						WHEN Transmission = 'A8' THEN 'Automatic 8 Gears'						
						WHEN Transmission = 'AM7' THEN 'Automated Manual 7 Gears'
						WHEN Transmission = 'A9' THEN 'Automatic 9 Gears'
						WHEN Transmission = 'AS7' THEN 'Auto Select Shift 7 Gears'
						WHEN Transmission = 'AV' THEN 'CVT'
						WHEN Transmission = 'M5' THEN 'Manual 5 Gears'						
						WHEN Transmission = 'AS10' THEN 'Auto Select Shift 10 Gears'
						WHEN Transmission = 'AM6' THEN 'Automated Manual 6 Gears'
						WHEN Transmission = 'AV7' THEN 'CVT 7 Gears'
						WHEN Transmission = 'AV6' THEN 'CVT 6 Gears'						
						WHEN Transmission = 'M7' THEN 'Manual 7 Gears'
						WHEN Transmission = 'A5' THEN 'Automatic 5 Gears'
						WHEN Transmission = 'AS9' THEN 'Auto Select Shift 9 Gears'
						WHEN Transmission = 'A4' THEN 'Automatic 4 Gears'
						WHEN Transmission = 'AM8' THEN 'Automated Manual 8 Gears'						
						WHEN Transmission = 'A7' THEN 'Automatic 7 Gears'
						WHEN Transmission = 'AV8' THEN 'CVT 8 Gears'
						WHEN Transmission = 'A10' THEN 'Automatic 10 Gears'
						WHEN Transmission = 'AS5' THEN 'Auto Select Shift 5 Gears'						
						WHEN Transmission = 'AV10' THEN 'CVT 10 Gears'
						WHEN Transmission = 'AM5' THEN 'Automated Manual 5 Gears'
						WHEN Transmission = 'AM9' THEN 'Automated Manual 9 Gears'
						WHEN Transmission = 'AS4' THEN 'Auto Select Shift 4 Gears'
						ELSE Transmission 
						END
----------------------------------------------------------------------------------------------------------------------------------------------------

-- Delete Duplicates
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY Brand,
				 Model
				 ORDER BY Brand
				 ) row_num

From Vehicles_CO2_Emission..CO2_Emissions
)

DELETE
--SELECT *
From RowNumCTE
Where row_num > 1
--Order by [CO2 Emissions(g/km)] DESC

SELECT *
FROM Vehicles_CO2_Emission..CO2_Emissions
ORDER BY [CO2 Emissions(g/km)] DESC