create database coffee_sales;
use coffee_sales;
create table orders (
Order_ID varchar(15) not null,
Order_Date date not null,
Customer_ID varchar(15) not null,
Product_ID varchar(10) not null,
Quantity_Kg int not null,
Unit_Price decimal(4,2) not null,
Sales decimal(5,2) not null,
Cost_per_Kg decimal(4,2) not null,
Profit_per_Kg decimal(3,2) not null,
Loyalty_Card int not null
);
select *
from orders;

desc orders;

alter table orders
add fact_ID int auto_increment primary key;

alter table orders
add constraint foreign key (Order_ID) references calender(Order_ID),
add constraint foreign key (Customer_ID) references customers(customer_ID),
add constraint foreign key (Product_ID) references products(product_ID);

drop table orders;

create table customers (
Customer_ID varchar(15) not null primary key,
Customer_Name varchar(30) not null,
First_Name varchar(15) not null,
Surname varchar(15) not null,
Email varchar(40) not null,
Phone_Number varchar(20) not null
); 

select *
from customers;

create table products (
Product_ID varchar(7) not null primary key,
Coffee_Type char(3) not null,
Roast_Type char(1) not null,
Size decimal(2,1) not null
);
drop table products;

select *
from products;

create table Calender (
Order_ID varchar(15) primary key not null,
Order_Date date not null
);

drop table Calender;

select *
from Calender;

create table Geo (
Customer_ID  varchar(15) not null,
Address_Number varchar(5) not null,
Address_Name varchar(25) not null,
City varchar(25) not null,
Country varchar(15) not null
);

alter table Geo
add constraint foreign key (Customer_ID) references customers(Customer_ID);

describe Geo;

drop table Geo;

select *
from Geo;

create table Geo_Postcode (
Customer_ID varchar(15) not null,
Postcode varchar(6) not null,
Postcode_Type_ID varchar(7) not null
);

alter table Geo_Postcode
add constraint foreign key (customer_ID) references customers(Customer_ID),
add constraint foreign key (postcode_type_ID) references postcode_type(postcode_type_id);

select *
from Geo_Postcode;

desc Geo_Postcode;

create table Postcode_Type (
Postcode_Type_ID varchar(7) not null,
Postcode_Name varchar (17) not null
);

alter table postcode_type
add constraint primary key (postcode_type_id);

desc postcode_type;

select *
from Postcode_Type;

drop table Postcode_Type;

create table Customers_PhoneNum (
Customer_ID varchar(15) not null,
Phone_Number varchar(20) not null,
PhoneNum_Type_ID varchar(7) not null
);

drop table Customers_PhoneNum;

desc Customers_PhoneNum;

/*Bottleneck:
Errors at first.
Cause of Error: PN_US had cleaning issue on customers_phoneNum table where it is a foreingn key. LEN() showed 6 instead of 5, 
meaning there was a leading or trailing space. Because it conflicted with the correct one of phoneNum_Type table where it is a 
primary key, all PN_US of customers_phoneNum were not imported. PN_UK and PN_IREL were however imported in the 
customers_phoneNum table.
Solution:
1) create table PhoneNum_Type (
PhoneNum_Type_ID varchar(7) not null,
PhoneNum_Name varchar(20) not null
);
2) alter table PhoneNum_Type
add constraint primary key (PhoneNum_Type_ID);

3) Imported PhoneNum_Type table using Table Data Import Wizard

4) Deactivated MySQL safe mode by: Edit>Preferences>SQL Editor>Uncheck "Safe Updates" check box

5) Shut down My SQL workbench, and relogin

6) update phonenum_type
set phonenum_type_id=trim(phonenum_type_id);

7) create table Customers_PhoneNum (
Customer_ID varchar(15) not null,
Phone_Number varchar(20) not null,
PhoneNum_Type_ID varchar(7) not null
);
8) Imported Customers_PhoneNum table using Table Data Import Wizard

9) update customers_phonenum
set PhoneNum_Type_ID=trim(PhoneNum_Type_ID);

10) alter table Customers_PhoneNum
add constraint foreign key (Customer_ID) references customers(Customer_ID);

11) alter table Customers_PhoneNum
add constraint foreign key (PhoneNum_Type_ID) references PhoneNum_Type(PhoneNum_Type_ID);

*/

update customers_phonenum
set PhoneNum_Type_ID=trim(PhoneNum_Type_ID);

alter table Customers_PhoneNum
add constraint foreign key (Customer_ID) references customers(Customer_ID);

alter table Customers_PhoneNum
add constraint foreign key (PhoneNum_Type_ID) references PhoneNum_Type(PhoneNum_Type_ID);

select *
from Customers_PhoneNum;

create table PhoneNum_Type (
PhoneNum_Type_ID varchar(7) not null,
PhoneNum_Name varchar(20) not null
);

drop table PhoneNum_Type;

desc PhoneNum_Type;

alter table PhoneNum_Type
add constraint primary key (PhoneNum_Type_ID);

select *
from PhoneNum_Type;

update phonenum_type
set phonenum_type_id=trim(phonenum_type_id);

-- TOP PERFORMING REGION
--       order by "sales" will not sort. Don't use aliase to sort. Use the actual column name and aggregation if necessary.

-- United States
select g.country, g.city, sum(o.sales) "sales"
from orders o
join geo g on o.customer_ID=g.customer_ID 
where g.country='united states'
group by g.city
order by sum(o.sales) desc
limit 10;

-- Ireland
select g.country, g.city, sum(o.sales) "sales"
from orders o
join geo g on o.customer_ID=g.customer_ID 
where g.country='ireland'
group by g.city
order by sum(o.sales) desc
limit 10;

-- United Kingdom
select g.country, g.city, sum(o.sales) "sales"
from orders o
join geo g on o.customer_ID=g.customer_ID 
where g.country='united kingdom'
group by g.city
order by sum(o.sales) desc
limit 10;

-- TOP PERFORMING BEAN TYPES

-- by sales
select pr.coffee_type, sum(o.sales) "sales"
from orders o
join products pr on o.product_id=pr.product_id
group by pr.coffee_type
order by sum(o.sales) desc;

-- by quantity_kg
select pr.coffee_type, sum(o.quantity_kg) "quantity_kg"
from orders o
join products pr on o.product_id=pr.product_id
group by pr.coffee_type
order by sum(o.quantity_kg) desc;

-- by quantity_kg in United States
select pr.coffee_type, sum(o.quantity_kg) "quantity_kg"
from orders o
join products pr on o.product_id=pr.product_id
join geo g on o.customer_id=g.customer_id
where g.country='united states'
group by pr.coffee_type
order by sum(o.quantity_kg) desc;

-- by quantity_kg in Ireland
select pr.coffee_type, sum(o.quantity_kg) "quantity_kg"
from orders o
join products pr on o.product_id=pr.product_id
join geo g on o.customer_id=g.customer_id
where g.country='ireland'
group by pr.coffee_type
order by sum(o.quantity_kg) desc;

-- by quantity_kg in UnitedKingdom
create view `Top Performing Bean Types by Quantity Kg in the United Kingdom` as
select pr.coffee_type, sum(o.quantity_kg) "quantity_kg"
from orders o
join products pr on o.product_id=pr.product_id
join geo g on o.customer_id=g.customer_id
where g.country='united kingdom'
group by pr.coffee_type
order by sum(o.quantity_kg) desc;

/* where there are three tables(ie. two joins), group by is as a result of aggregation function in the select statement and 
as a resut of the first join, while where is as a result of a column in the select statement and as result of the second join.
*/
-- by quantity_kg in UnitedKingdom
select pr.coffee_type, sum(o.quantity_kg) "quantity_kg", g.country
from orders o
join products pr on o.product_id=pr.product_id
join geo g on o.customer_id=g.customer_id
where g.country='united kingdom'
group by pr.coffee_type
order by sum(o.quantity_kg) desc;


-- AVERAGE REVENUE PER CUSTOMER
create view `Average Revenue Per Customer` as
select c.customer_name "customer", avg(o.sales) "average_revenue"
from orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_name
order by avg(o.sales) desc;


