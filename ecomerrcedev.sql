--CLEANUP SCRIPT
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
             
      execute immediate 'alter table DISTRIBUTOR drop column Product_manufacturer_ID';
      execute immediate 'alter table PRODUCT_MANUFACTURER drop column Distributor_ID';
      
      
   for i in (select 'CUSTOMER_ADDRESS' table_name from dual union all
             select 'ORDER_DELIVERY_STATUS' table_name from dual union all
             select 'ORDER_DETAILS' table_name from dual union all
             select 'CUSTOMER_ORDER' table_name from dual union all
             select 'PAYMENT_TYPE' table_name from dual union all
             select 'CUSTOMER' table_name from dual union all
             select 'PRODUCT_MANUFACTURER' table_name from dual union all
             select 'DISTRIBUTOR' table_name from dual union all
             select 'PRODUCT' table_name from dual union all
             select 'PRODUCT_TYPE' table_name from dual union all
             select 'DELIVERY_PARTNER' table_name from dual
   )
   loop
   dbms_output.put_line('....Drop table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name;
       execute immediate v_sql;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/

--CREATE TABLES AS PER DATA MODEL


create table customer(
CustomerID number(38) PRIMARY KEY,
Customer_FirstName varchar2(50),
Customer_LastName varchar2(20),
Customer_DOB date,
Customer_PhoneNo varchar2(20),
Customer_Email varchar2(100)
)
/

create table customer_address(
CustomerAdd_ID number(38) PRIMARY KEY,
CustomerID number(38) REFERENCES customer (CustomerID),
Street varchar2(200),
State varchar2(200),
City varchar2(50),
Zip number(38)
)

/

create table payment_type(
Payment_type_ID number(38) PRIMARY KEY,
Payment_type_name varchar2(50))
/

create table product_type(
Product_type_ID number(38) PRIMARY KEY,
Product_type_name varchar(50),
Product_Description varchar(500))
/

create table product(
Product_ID number(38) PRIMARY KEY,
Product_type_ID number(38) REFERENCES product_type (Product_type_ID),
Product_name varchar2(200),
Product_cost number(38),
Product_active varchar2(20),
Product_quantity number(38))
/

create table distributor(
Distributor_ID number (38) PRIMARY KEY,
Product_ID number(38),
Product_manufacturer_ID number(38),
Product_Quantity number(38),
CONSTRAINT FK_Product_ID FOREIGN KEY (Product_ID) REFERENCES product(Product_ID))
/

create table product_manufacturer(
Product_manufacturer_ID number(38) PRIMARY KEY,
Distributor_ID number(38),
CONSTRAINT FK_Distributor_ID FOREIGN KEY (Distributor_ID) REFERENCES distributor(Distributor_ID))
/

alter table distributor add CONSTRAINT FK_Product_manufacturer_ID FOREIGN KEY (Product_manufacturer_ID) REFERENCES product_manufacturer(Product_manufacturer_ID);

create table customer_order(
Order_ID number(38) PRIMARY KEY,
Order_date date,
Payment_type_ID number(38) REFERENCES payment_type (Payment_type_ID),
CustomerID number(38) REFERENCES customer (CustomerID))
/

create table order_details(
Order_details_ID number(38) PRIMARY KEY,
Product_ID number(38) REFERENCES product (Product_ID),
Order_ID number(38) REFERENCES customer_order (Order_ID))
/

create table delivery_partner(
Delivery_partner_ID number(38) PRIMARY KEY,
Delivery_partner_Name varchar2(50),
Delivery_partner_PhoneNo varchar2(20),
Deliver_partner_Email varchar2(100))
/

create table order_delivery_status(
Order_delivery_status_ID number(38) PRIMARY KEY,
Order_delivery_status_Name varchar2(50),
Order_ID number(38) REFERENCES customer_order (Order_ID),
Delivery_partner_ID number(38) REFERENCES delivery_partner (Delivery_partner_ID)
)
/