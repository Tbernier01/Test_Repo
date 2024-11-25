
```mermaid
erDiagram
    %% Table definitions with colors for keys
    SalesOrderHeader {
        int SalesOrderID PK
        int TerritoryID
        date OrderDate
    }
    SalesOrderDetail {
        int SalesOrderDetailID PK
        int SalesOrderID FK
        int ProductID FK
        int OrderQty
        decimal LineTotal
        decimal UnitPrice
    }
    ProductStoreSummary {
        int StoreID PK
        int ProductID FK
        decimal TotalSalesAmount
        int TotalQuantity
        decimal AvgPrice
    }
   

    %% Relationships between tables with Foreign Keys
    SalesOrderHeader ||--o| SalesOrderDetail: "Has"
    SalesOrderDetail ||--o| ProductStoreSummary: "Aggregates"
