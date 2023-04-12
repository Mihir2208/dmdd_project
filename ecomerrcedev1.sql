select * from product;
/*
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
    num_orders DESC;
*/

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


CREATE OR REPLACE PROCEDURE order_report
AS
   CURSOR order_cur IS
      SELECT co.Order_ID, c.Customer_FirstName, c.Customer_LastName, co.Order_date
      FROM customer_order co
      JOIN customer c ON co.CustomerID = c.CustomerID
      ORDER BY co.Order_date;

BEGIN
   DBMS_OUTPUT.PUT_LINE('-----------------------------------');
   DBMS_OUTPUT.PUT_LINE('      Order Report     ');
   DBMS_OUTPUT.PUT_LINE('-----------------------------------');
   DBMS_OUTPUT.PUT_LINE('Order ID | Customer Name | Order Date');
   FOR order_rec IN order_cur LOOP
      DBMS_OUTPUT.PUT_LINE(order_rec.Order_ID || ' | ' || order_rec.Customer_FirstName || ' ' || order_rec.Customer_LastName || ' | ' || order_rec.Order_date);
   END LOOP;
END;
/

EXEC order_report;


CREATE OR REPLACE TRIGGER trg_product_quantity_update
BEFORE UPDATE ON product
FOR EACH ROW
BEGIN
  IF :new.Product_quantity <= 0 THEN
    :new.Product_active := 'Out of Stock';
  END IF;
END;
/