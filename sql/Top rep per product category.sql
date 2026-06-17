WITH RepProfit AS (
    SELECT
        Prod,
        Rep,
        SUM(Sale - Cost) AS TotalProfit
    FROM Sales_Data
    GROUP BY Prod, Rep
),
Ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Prod
               ORDER BY TotalProfit DESC
           ) AS rn
    FROM RepProfit
)

SELECT
    Prod,
    Rep,
    TotalProfit
FROM Ranked
WHERE rn = 1;