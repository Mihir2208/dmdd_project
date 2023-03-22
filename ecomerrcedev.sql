

DROP TABLE customer_address;
DROP TABLE payment_type;
DROP TABLE customer;

--Create Customer Table
create table customer(
CustomerID number(38) PRIMARY KEY,
Customer_FirstName varchar2(50),
Customer_LastName varchar2(20),
Customer_DOB date,
Customer_PhoneNo varchar2(20),
Customer_Email varchar2(100));

desc customer;

--Create Customer Address Table
create table customer_address(
CustomerAdd_ID number(38) PRIMARY KEY,
CustomerID number(38) REFERENCES customer (CustomerID),
Street varchar2(200),
City varchar2(50),
Zip number(38));

desc customer_address;

--Create Payment Type
create table payment_type(
Payment_type_ID number(38) PRIMARY KEY,
Payment_type_name varchar2(50));

desc payment_type;