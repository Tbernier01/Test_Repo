```mermaid
graph TD
    %% Extract Phase
    subgraph Extract [Extract Phase]
        Step01[Step-01: Extract SalesOrderHeader] 
        Step02[Step-02: Extract SalesOrderDetail] 
    end

    %% Transform Phase
    subgraph Transform [Transform Phase]
        Step03[Step-03: Join SalesOrderHeader and SalesOrderDetail]
        Step04[Step-04: Filter Current Year Sales]
        Step05[Step-05: Aggregate Metrics: TotalSalesAmount, TotalQuantity, AvgPrice]
    end

    %% Load Phase
    subgraph Load [Load Phase]
        Step06[Step-06: Load into ProductStoreSummary]
    end

    %% Defining dependencies
    Step01 --> Step03
    Step02 --> Step03
    Step03 --> Step04
    Step04 --> Step05
    Step05 --> Step06
