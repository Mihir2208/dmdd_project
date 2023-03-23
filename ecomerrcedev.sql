DROP TABLE customer_address;
DROP TABLE order_delivery_status;
DROP TABLE order_details;
DROP TABLE customer_order;
DROP TABLE payment_type;
DROP TABLE customer;
alter table distributor drop COLUMN Product_manufacturer_ID;
alter table product_manufacturer drop COLUMN Distributor_ID;
DROP TABLE product_manufacturer;
DROP TABLE distributor;
DROP TABLE product;
DROP TABLE product_type;
DROP TABLE delivery_partner;


--Create Customer Table
create table customer(
CustomerID number(38) PRIMARY KEY,
Customer_FirstName varchar2(50),
Customer_LastName varchar2(20),
Customer_DOB date,
Customer_PhoneNo varchar2(20),
Customer_Email varchar2(100));

--desc customer;

--Create Customer Address Table
create table customer_address(
CustomerAdd_ID number(38) PRIMARY KEY,
CustomerID number(38) REFERENCES customer (CustomerID),
Street varchar2(200),
City varchar2(50),
Zip number(38));

--desc customer_address;

--Create Payment Type
create table payment_type(
Payment_type_ID number(38) PRIMARY KEY,
Payment_type_name varchar2(50));

--desc payment_type;

--Create ProductType Table
create table product_type(
Product_type_ID number(38) PRIMARY KEY,
Product_type_name varchar(50),
Product_Description varchar(500));

--desc product_type;

--Create Product Table
create table product(
Product_ID number(38) PRIMARY KEY,
Product_type_ID number(38) REFERENCES product_type (Product_type_ID),
Product_name varchar2(200),
Product_cost number(38),
Product_active varchar2(20),
Product_quantity number(38));

--desc product;


--Create Distributor Table
create table distributor(
Distributor_ID number (38) PRIMARY KEY,
Product_ID number(38),
Product_manufacturer_ID number(38),
Product_Quantity number(38),
CONSTRAINT FK_Product_ID FOREIGN KEY (Product_ID) REFERENCES product(Product_ID));

--desc distributor;


--Create Product Manufacturer Table
create table product_manufacturer(
Product_manufacturer_ID number(38) PRIMARY KEY,
Distributor_ID number(38),
CONSTRAINT FK_Distributor_ID FOREIGN KEY (Distributor_ID) REFERENCES distributor(Distributor_ID));

alter table distributor add CONSTRAINT FK_Product_manufacturer_ID FOREIGN KEY (Product_manufacturer_ID) REFERENCES product_manufacturer(Product_manufacturer_ID);

--Create Customer Order Table 
create table customer_order(
Order_ID number(38) PRIMARY KEY,
Order_date date,
Payment_type_ID number(38) REFERENCES payment_type (Payment_type_ID),
CustomerID number(38) REFERENCES customer (CustomerID));

--desc customer_order;

--Create Order Details Table
create table order_details(
Order_details_ID number(38) PRIMARY KEY,
Product_ID number(38) REFERENCES product (Product_ID),
Order_ID number(38) REFERENCES customer_order (Order_ID));

--desc order_details;

--Create Order Delivery Partner
create table delivery_partner(
Delivery_partner_ID number(38) PRIMARY KEY,
Delivery_partner_Name varchar2(50),
Delivery_partner_PhoneNo varchar2(20),
Deliver_partner_Email varchar2(100));

--desc delivery_partner;

create table order_delivery_status(
Order_delivery_status_ID number(38) PRIMARY KEY,
Order_delivery_status_Name varchar2(50),
Order_ID number(38) REFERENCES customer_order (Order_ID),
Delivery_partner_ID number(38) REFERENCES delivery_partner (Delivery_partner_ID)
);