--Test--

WITH FilteredSales AS (
    --Step 1--
  SELECT 
        soh.TerritoryID AS StoreID,
        sod.ProductID,
        sod.LineTotal,
        sod.OrderQty,
        sod.UnitPrice,
        YEAR(soh.OrderDate) AS OrderYear
    FROM 
        Sales.SalesOrderHeader soh
  --Step 2--  
  INNER JOIN 
        Sales.SalesOrderDetail sod
    ON 
       --step 3--
  soh.SalesOrderID = sod.SalesOrderID
    WHERE 
  --step 4--
        YEAR(soh.OrderDate) = YEAR(GETDATE()) -- Filter current year
),
  --step 5--
AggregatedSales AS (
    SELECT 
        StoreID,
        ProductID,
        SUM(LineTotal) AS TotalSalesAmount,
        SUM(OrderQty) AS TotalQuantity,
        AVG(UnitPrice) AS AvgPrice
    FROM 
        FilteredSales
    GROUP BY 
        StoreID, ProductID
),
--INSERT INTO Sales.ProductStoreSummary (StoreID, ProductID, TotalSalesAmount, TotalQuantity, AvgPrice)

RankedProducts AS (
    SELECT 
        StoreID,
        ProductID,
        SUM(LineTotal) AS TotalSalesAmount,
        RANK() OVER (PARTITION BY StoreID ORDER BY SUM(LineTotal) DESC) AS Rank
    FROM 
        FilteredSales
    GROUP BY 
        StoreID, ProductID
)
SELECT 
    StoreID, ProductID, Rank, TotalSalesAmount
FROM 
    RankedProducts
WHERE 
    Rank <= 5;
