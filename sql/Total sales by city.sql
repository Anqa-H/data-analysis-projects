SELECT
    City,
    SUM(Sale) AS TotalSales,
    SUM(Sale - Cost) AS TotalProfit
FROM Sales_Data
GROUP BY City
ORDER BY TotalProfit DESC;