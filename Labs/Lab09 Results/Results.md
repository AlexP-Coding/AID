## Basics

11. 
Query:
```
SELECT [Measures].Members ON COLUMNS,
    [Customer].[Country].Members ON ROWS
FROM [Orders]
```
![Alt text](image.png)

Value of all available measures (Sales, Quantity, Fact Count) per country 

## Slicing

14. 
Query:
```
SELECT Measures.Members ON COLUMNS,
    Time.Year.Members ON ROWS
FROM Orders
WHERE Customer.Country.Italy
```
![Alt text](image-1.png)

Value of all available measures per year 

15. 
Query:
```
SELECT Measures.Members ON COLUMNS,
 Time.Year.Members ON ROWS
FROM Orders
WHERE (Customer.Country.Italy, Product.[Product Line].[Classic Cars])
```
![Alt text](image-2.png)

Value of all available measures per year, only for country italy and product line classic cars

16. 
Query:
```
SELECT Measures.Members ON COLUMNS,
 Time.Year.Members ON ROWS
FROM Orders
WHERE {(Customer.Country.Italy, Product.[Product Line].[Classic Cars]),
 (Customer.Country.France, Product.[Product Line].[Classic Cars])}
```
![Alt text](image-3.png)

Value of all available measures per year, only for countries italy + France and product line classic cars

17. 
Query:
```
SELECT Time.Year.Members ON COLUMNS,
 Customer.Country.Members ON ROWS
FROM Orders
WHERE (Measures.Sales, Product.[Product Line].[Classic Cars])
```
![Alt text](image-4.png)

Value of measure Sales on orders, per country, for every year, for product line classic cars

## Navigation

18. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
 Customer.Country.Members ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-5.png)

Value of measure Sales on orders, per country, for every direct sub-section (quarter) of year 2003

19. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
 {Customer.Country.France, Customer.Country.Italy} ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-6.png)

Value of measure Sales on orders, for only countries France and Italy, for every direct sub-section (quarter) of year 2003 

20. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
{Customer.Country.Germany.Children,
Customer.Country.Italy.Children} ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-7.png)

Value of measure Sales on orders, for only the direct sub-sections (city) of countries France and Italy, for every direct sub-section (quarter) of year 2003 

!!!
21. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
 {DRILLDOWNLEVEL(Customer.Country.Germany),
 DRILLDOWNLEVEL(Customer.Country.Italy)} ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-8.png)

Same as #20, but include the original section (country)

22. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
 DESCENDANTS(Customer.Italy, Customer.City, SELF) ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-9.png)

Value of measure Sales on orders, for only the direct descendants (city) of country Italy, for every direct sub-section (quarter) of year 2003 


23. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
 DESCENDANTS(Customer.Italy, Customer.City, BEFORE) ON ROWS
FROM Orders
WHERE Measures.Sales
```
- BEFORE
![Alt text](image-10.png)

Same as #20 but with the descendants of the sub-section before country Italy (which is country Italy itself)

- SELF_AND_BEFORE !!!

![Alt text](image-11.png)

Similar to #21 (Drill down)

- AFTER

![Alt text](image-12.png)


- SELF_AND_AFTER

![Alt text](image-13.png)


- BEFORE_AND_AFTER

![Alt text](image-14.png)


- SELF_BEFORE_AFTER

![Alt text](image-15.png)




24. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
 ASCENDANTS(Customer.City.Milan) ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-16.png)


25. 
Query:
```
SELECT Time.[2003].Children ON COLUMNS,
 ANCESTOR(Customer.City.Milan, Customer.Country) ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-17.png)



## Cross Join

26. 

27. 
Query:
```
SELECT Product.[Product Line].Members ON COLUMNS,
 CROSSJOIN(Customer.Country.Members, Time.Year.Members) ON ROWS
FROM Orders
WHERE Measures.Sales
```
```
SELECT Product.[Product Line].Members ON COLUMNS,
 Customer.Country.Members * Time.Year.Members ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Alt text](image-18.png)


## Calculated Members

28. 
Query:
```
WITH MEMBER Measures.SalesPerUnit AS (Measures.Sales / Measures.Quantity)
SELECT Measures.SalesPerUnit ON COLUMNS,
 Customer.Country.Members ON ROWS
FROM Orders
```
![Alt text](image-19.png)



29. 
Query:
```
WITH MEMBER Measures.SalesPerUnit AS (Measures.Sales / Measures.Quantity)
SELECT Measures.AllMembers ON COLUMNS,
 Customer.Country.Members ON ROWS
FROM Orders
```
![Alt text](image-20.png)


31. 

32. 
Query:
```
WITH MEMBER Measures.Cars AS Product.[Product Line].[Classic Cars] +
 Product.[Product Line].[Vintage Cars]
SELECT Time.Year.Members ON COLUMNS,
 Measures.Cars ON ROWS
FROM Orders
```
![Alt text](image-21.png)


- Measures.Cars AS Product.[Product Line].[Classic Cars]

![Alt text](image-22.png)



- Measures.Cars AS Product.[Product Line].[Vintage Cars]

![Alt text](image-23.png)



## Named Sets

33. 
Query:
```
WITH SET [Nordic Countries] AS {Customer.Country.Denmark,
 Customer.Country.Finland,
 Customer.Country.Norway, 
 Customer.Country.Sweden}
SELECT Time.Year.Members ON COLUMNS,
 [Nordic Countries] ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-24.png)


34. 
Query:
```
WITH SET TopCountries AS TOPCOUNT(Customer.Country.Members, 3, Measures.Sales)
SELECT Measures.Members ON COLUMNS,
 TopCountries ON ROWS
FROM Orders
```
![Alt text](image-25.png)


## Relative Navigation

35. 
Query:
```
WITH MEMBER Measures.PercentSales AS
 (Measures.Sales, Customer.Country.CurrentMember) /
 (Measures.Sales, Customer.Country.CurrentMember.Parent),
 FORMAT_STRING = '#0.00%'
SELECT {Measures.Sales, Measures.PercentSales} ON COLUMNS,
 Customer.Country.Members ON ROWS
FROM Orders
```
![Alt text](image-26.png)


36. 
Query:
```
SELECT Time.Year.Members ON COLUMNS,
 GENERATE({Customer.Country.Belgium, Customer.Country.France},
 DESCENDANTS(Customer.CurrentMember, Customer.City)) ON ROWS 
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-27.png)



37. 
Query:
```
WITH MEMBER Measures.[Previous Month] AS Time.Month.CurrentMember.PrevMember
MEMBER Measures.[Sales Growth] AS Measures.Sales -
Measures.[Previous Month]
SELECT {Measures.Sales,
Measures.[Previous Month],
Measures.[Sales Growth]} ON COLUMNS,
DESCENDANTS(Time.Year.[2004], Time.Month) ON ROWS
FROM Orders
```
![Alt text](image-28.png)


38. 
Query:
```
WITH MEMBER Measures.[Previous Year] AS PARALLELPERIOD(Time.Month, 12)
 MEMBER Measures.[Sales Growth] AS Measures.Sales -
 Measures.[Previous Year]
SELECT {Measures.Sales,
 Measures.[Previous Year],
 Measures.[Sales Growth]} ON COLUMNS,
 DESCENDANTS(Time.Year.[2004], Time.Month) ON ROWS
FROM Orders
```
![Alt text](image-29.png)



## Filtering

40. 
Query:
```
SELECT Measures.Members ON COLUMNS,
 FILTER(Customer.Country.Members, Measures.Sales > 1000000) ON ROWS
FROM Orders
```
![Alt text](image-30.png)



41. 
Query:
```
SELECT Time.Year.Members ON COLUMNS,
 FILTER(Customer.Country.Members,
 (Measures.Sales, Time.[2004]) > 250000) ON ROWS
FROM Orders
WHERE Measures.Sales
```
![Alt text](image-31.png)


42. 
Query:
```
SELECT Measures.Members ON COLUMNS,
 Customer.Country.Members ON ROWS
FROM Orders
```
![Alt text](image-32.png)



43. 
Query:
```
SELECT Measures.Members ON COLUMNS,
 ORDER(Customer.Country.Members, Measures.Sales, DESC) ON ROWS
FROM Orders
```
![Alt text](image-33.png)

44. 

45. 

46. 
Query:
```
SELECT Measures.Members ON COLUMNS,
 HEAD(ORDER(Customer.Country.Members, Measures.Sales, DESC), 3) ON ROWS
FROM Orders
```

```
SELECT Measures.Members ON COLUMNS,
 TOPCOUNT(Customer.Country.Members, 3, Measures.Sales) ON ROWS
FROM Orders
```

```
SELECT Measures.Members ON COLUMNS,
 TOPPERCENT(Customer.Country.Members, 50, Measures.Sales) ON ROWS
FROM Orders
```

![Alt text](image-34.png)
