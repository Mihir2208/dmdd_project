-- 1) max_purchases_report
/*
set serveroutput on;
CREATE OR REPLACE PROCEDURE max_purchases_report
IS
BEGIN
    BEGIN
        FOR r IN (
            SELECT 
                c.Customer_FirstName, 
                c.Customer_LastName, 
                COUNT(o.Order_ID) AS num_orders
            FROM 
                customer c
                JOIN customer_order o ON c.CustomerID = o.CustomerID
            GROUP BY 
                c.CustomerID, 
                c.Customer_FirstName, 
                c.Customer_LastName
            ORDER BY 
                num_orders DESC
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(r.Customer_FirstName || ' ' || r.Customer_LastName || ' - ' || r.num_orders || ' orders');
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    END;
END max_purchases_report;

EXEC max_purchases_report;
*/
--SHOW ERRORS max_purchases_report;


--2) zip_wise_sale_report
/*
set serveroutput on;

CREATE OR REPLACE PROCEDURE zip_wise_sale_report IS
BEGIN
    FOR rec IN (SELECT c.CustomerID, ca.Zip, SUM(p.Product_cost * p.Product_quantity) AS Total_Sales
                FROM customer c
                JOIN customer_address ca ON c.CustomerID = ca.CustomerID
                JOIN customer_order co ON c.CustomerID = co.CustomerID
                JOIN order_details od ON co.Order_ID = od.Order_ID
                JOIN product p ON od.Product_ID = p.Product_ID
                GROUP BY c.CustomerID, ca.Zip
                ORDER BY c.CustomerID, ca.Zip)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || rec.CustomerID || ' Zip Code: ' || rec.Zip || ' Total Sales: ' || rec.Total_Sales);
    END LOOP;
END;
/

EXEC zip_wise_sale_report;
*/



--3) Insert Data in customer table 
/*
DECLARE
    v_customer_id number(38);
BEGIN
    insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email)
    values (101, 'John', 'Doe', TO_DATE('01-JAN-2000', 'DD-MON-YYYY'), '1234567890', 'johndoe@email.com');
    v_customer_id := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Customer inserted with ID: ' || v_customer_id);
END;
*/


-- 1) Package - Full customer report
/*
CREATE OR REPLACE PACKAGE customer_report_pkg AS
  PROCEDURE full_customer_delivery_report;
END customer_report_pkg;
/

CREATE OR REPLACE PACKAGE BODY customer_report_pkg AS
  PROCEDURE full_customer_delivery_report IS
    CURSOR customer_order_cursor IS
      SELECT co.Order_ID, c.Customer_FirstName, c.Customer_LastName, c.Customer_PhoneNo, c.Customer_Email, cadd.Street, cadd.State, cadd.City, cadd.Zip, co.Order_date, pt.Payment_type_name, p.Product_name, od.Product_ID, od.Order_details_ID, ods.Order_delivery_status_Name, dp.Delivery_partner_Name, dp.Delivery_partner_PhoneNo
      FROM customer_order co
      INNER JOIN customer c ON co.CustomerID = c.CustomerID
      INNER JOIN customer_address cadd ON co.CustomerID = cadd.CustomerID
      INNER JOIN payment_type pt ON co.Payment_type_ID = pt.Payment_type_ID
      INNER JOIN order_details od ON co.Order_ID = od.Order_ID
      INNER JOIN product p ON od.Product_ID = p.Product_ID
      INNER JOIN order_delivery_status ods ON co.Order_ID = ods.Order_ID
      INNER JOIN delivery_partner dp ON ods.delivery_partner_id = dp.delivery_partner_id
      ORDER BY od.Order_ID asc;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('Order ID | Customer Name | Customer Phone | Customer Email | Street | State | City | Zip | Order Date | Payment Type | Product Name | Product ID | Order Details ID | Delivery Status | Delivery Partner Name | Delivery Partner Phone');
      FOR cust_order IN customer_order_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(cust_order.Order_ID || ' | ' || cust_order.Customer_FirstName || ' ' || cust_order.Customer_LastName || ' | ' || cust_order.Customer_PhoneNo || ' | ' || cust_order.Customer_Email || ' | ' || cust_order.Street || ' | ' || cust_order.State || ' | ' || cust_order.City || ' | ' || cust_order.Zip || ' | ' || cust_order.Order_date || ' | ' || cust_order.Payment_type_name || ' | ' || cust_order.Product_name || ' | ' || cust_order.Product_ID || ' | ' || cust_order.Order_details_ID || ' | ' || cust_order.Order_delivery_status_Name || ' | ' || cust_order.Delivery_partner_Name || ' | ' || cust_order.Delivery_partner_PhoneNo);
      END LOOP;
    END full_customer_delivery_report;
END customer_report_pkg;
/


BEGIN
  customer_report_pkg.full_customer_delivery_report;
END;
/


*/


/*

set serveroutput on;
CREATE OR REPLACE PROCEDURE product_distributor_report(p_product_type_id IN NUMBER) IS
  CURSOR distributor_cursor IS
    SELECT d.Distributor_ID, pm.Product_manufacturer_ID, SUM(d.Product_Quantity) AS total_quantity
    FROM distributor d
    JOIN product p ON d.Product_ID = p.Product_ID
    JOIN product_type pt ON p.Product_type_ID = pt.Product_type_ID
    JOIN product_manufacturer pm ON d.Product_manufacturer_ID = pm.Product_manufacturer_ID
    WHERE pt.Product_type_ID = p_product_type_id
    GROUP BY d.Distributor_ID, pm.Product_manufacturer_ID;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Distributor ID | Product Manufacturer ID | Total Quantity');
  FOR distributor_rec IN distributor_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(distributor_rec.Distributor_ID || ' | ' || distributor_rec.Product_manufacturer_ID || ' | ' || distributor_rec.total_quantity);
  END LOOP;
END;

exec product_distributor_report(3);


*/



-- 1) trg_product_quantity_update - trigger
/*
CREATE OR REPLACE TRIGGER trg_product_quantity_update
BEFORE UPDATE ON product
FOR EACH ROW
BEGIN
  IF :new.Product_quantity <= 0 THEN
    :new.Product_active := 'Out of Stock';
  END IF;
END;
/
*/



