WITH MonthlyProfit AS (
    SELECT
        City,
        DATEFROMPARTS(YEAR(Date), MONTH(Date), 1) AS YearMonth,
        SUM(Sale - Cost) AS MonthlyProfit
    FROM Sales_Data
    GROUP BY
        City,
        DATEFROMPARTS(YEAR(Date), MONTH(Date), 1)
),

WithLag AS (
    SELECT *,
           LAG(MonthlyProfit) OVER (
               PARTITION BY City
               ORDER BY YearMonth
           ) AS PrevMonthProfit
    FROM MonthlyProfit
)

SELECT
    City,
    YearMonth,
    MonthlyProfit,
    PrevMonthProfit,
    CASE
        WHEN PrevMonthProfit IS NULL THEN NULL
        ELSE (MonthlyProfit - PrevMonthProfit) * 1.0 / NULLIF(PrevMonthProfit, 0)
    END AS MoMGrowthPct
FROM WithLag
WHERE PrevMonthProfit IS NOT NULL;