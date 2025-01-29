# Coffee_Sales
*project task was culled from HNG Tech Internship Cohort 11 for Data Analysts*

## Project Title: Coffee Bean Sales & Distribution- Analysis & Optimization
### Company: Global Coffee Supplies Ltd

### Scenario:
Global Coffee Supplies Ltd. operates as a wholesaler of coffee beans, catering to various coffee shops and retailers. The company aims to optimize its sales and distribution strategy and to improve profitability and customer satisfaction. The sales department has provided raw transaction data for analysis.

### Project Goals:
- Sales Analysis: Identify high-performing coffee bean types and understand their contribution to total revenue.
- Customer Insights: Analyze customer order patterns to recommend targeted promotional strategies.
- Pricing Strategy: Evaluate the impact of pricing on sales volume
- Inventory Optimization: Provide recommendations for inventory turnover improvement.

### Dataset Overview:
Source: Coffee Bean Sales Raw Dataset [KAGGLE](https://www.kaggle.com/datasets/saadharoon27/coffee-bean-sales-raw-dataset)

### Fields:
- Order ID: Unique identifier for each order.
- Bean Type: Type of coffee bean sold.
- Price: Unit price of the bean.
- Quantity: Amount of beans sold in kilogram.
- Customer ID: Identifier for the customer placing the order.
- Region: Geographic location of the customer.

### Tasks and Tools:

### Excel Tasks:
- Use pivot tables to summarize sales by region and bean type.
- Perform trend analysis on sales data over time.
- Create a regression model to assess pricing impact on quantity sold.
### Power BI Tasks:
- Build a dashboard to visualize sales distribution by region and bean type.
- Include KPIs for revenue, average price by kilogram, orders, sales volume, and profit.
### SQL Tasks:
- Load the data to MySQL workbench as a database.
- Write queries to extract top-performing regions and bean types.
- Use aggregations to calculate average revenue per customer.

### Deliverables:
- Excel File: Cleaned data and insights via pivot tables.
- Power BI Dashboard: Visual representation of sales performance.
- SQL Scripts: A script file with all queries used for analysis.
- Final Report: A PowerPoint report summarizing findings and recommendations.
--- 
## Data Exploration & Cleaning

1. The dataset covers the 4 years (2nd January 2019 to 19th August 2022)
2. There are 1,000 unique Orders (No Duplicates)
3. Orders tab dataset was sorted in ascending order by Order_Date column using the "custom sort"
4. A helper column was created for the Order ID column and "LEN()" function was used to confirm that there was no spaces in any of the Order IDs. Output of LEN() was 13 for all Order IDs.
5. A helper column was created for the Order ID column and "TEXT(value,"###-#####-###")" function was used to ensure the text format was the same for all Order IDs.
6. Steps 4 & 5 were repeated for the Customer ID column in orders tab dataset. "LEN()" function gave 14 for all Customer ID.
7. There are 1,000 unique Customers (No Duplicates)
8. Steps 4 & 5 were repeated for the Customer ID column in the customers tab dataset. "LEN()" function gave 14 for all Customer ID.
9. The PROPER(CLEAN(TRIM(B2))) functions was used to remove trailing spaces and convert every Customer Name to the Proper case
10. The LEFT(B2,SEARCH(" ",B2)-1) functions was used to extract the First Name from Customer Name
11. The RIGHT(B2,LEN(B2)-SEARCH(" ",B2)) functions were used to extract Surname fro Customer Name
12. The IF(ISNUMBER(SEARCH("' ",D2)),SUBSTITUTE(D2,"' ","'"),D2) functions were used to remove space found after ' string in the Surname Column
13. A helper column was created for the Customer Name and the CONCATENATE(D2," ",G2) function was used to merge the First Name in step 10 with Surname in step 12
14. The customers table has 204 empty Emails. This value was confirmed with COUNTBLANK() FUNCTION
15. Each email in the custumers table have a pattern of concatenated first letter in the First Name (ie. First Name Initials), Surname, "@" string, and domain name.
16. A helper column was created for First Name column and LEFT(C2,LEN(C2)-(LEN(C2)-1)) functions were used to make the First Name Initials
17. A helper column was created for the Email Column and the LOWER(IF(G2="",CONCATENATE(D2,F2,"@","gmail.com"),G2)) functions were used to create new emails addresses for blank emails and to repeat existing email addresses.
18. A helper column was created for the Address Line 1 to extract the number(s) that preceeded the Address names. LEFT(K2,SEARCH(" ",K2)-1) functions was used, and the helper column called Address Numbers. Each address in the Address Line 1 was preceeded by number(s)
19. A helper column was created for the Address Line 1 to extract the Address Name. MID(K2,SEARCH(" ",K2)+1,LEN(K2)-SEARCH(" ",K2)) function was used and the helper column labeled Address Name
20. A helper column was created for the Address Line 1 to merge Address Number to Address Name with a comma separation using CONCATENATE(L2,", ",M2) function
21. A helper column was created for Phone Number. 130 empty phone numbers were found using COUNTBLANK() function. Blank cells were replaced with NONE string using  IF(F2="","NONE",F2) function
22. The Customer Name, Email, and Country columns  of the orders table were populated from the customers table using VLOOKUP() function where the lookup value is the Customer ID in the orders table
23. The Coffee Type, Roast Type, Size , and Unit Price of the orders table were populated from the product table using VLOOKUP() function where the lookup value is the Product ID in the orders table.
24. The Sales column values were calculated as PRODUCT(F2,M2) where F2 is Quantity, and M2 is Unit Price
25. The order dataset was selected with CTRL + T and converted to table and named Order_Table

## Found a Typo? Want to Contribute?
- If you find any error in this project, please feel free to make a pull request by:
  - Forking the repo
  - Making any changes
  - Submitting a pull request.







