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


-- 1) Procedure product_distributor_report
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


--3   A procedure that takes in a product type ID and returns a list of all distributors who carry that product type, along with the total quantity of that product type each distributor has in stock.
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

exec product_distributor_report(10);
*/


--4  A Procedure that takes in a date range and returns a list of all orders placed during that time, along with the total cost of each order.
/*
set serveroutput on;
CREATE OR REPLACE PROCEDURE order_cost_report(p_start_date IN DATE, p_end_date IN DATE) IS
  CURSOR order_cursor IS
    SELECT o.Order_ID, o.Order_date, SUM(p.Product_cost * p.Product_quantity) AS total_cost
    FROM customer_order o
    JOIN order_details od ON o.Order_ID = od.Order_ID
    JOIN product p ON od.Product_ID = p.Product_ID
    WHERE o.Order_date BETWEEN p_start_date AND p_end_date
    GROUP BY o.Order_ID, o.Order_date;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Order ID | Order Date | Total Cost');
  FOR order_rec IN order_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(order_rec.Order_ID || ' | ' || order_rec.Order_date || ' | ' || order_rec.total_cost);
  END LOOP;
END;

exec order_cost_report('01-JAN-2022','01-JAN-2023');
*/


--5 Procedure for Product Sales Report by Month
/*
set serveroutput on;
CREATE OR REPLACE PROCEDURE product_sales_report_by_month IS
BEGIN
  FOR month IN 1..12 LOOP
    DBMS_OUTPUT.PUT_LINE('Month ' || month || ' Product Sales Report:');
    DBMS_OUTPUT.PUT_LINE('Product Name | Total Sales');
    FOR product_sale IN (SELECT p.Product_name, SUM(p.Product_quantity * p.Product_cost) as Total_Sales
                         FROM product p
                         INNER JOIN order_details od ON p.Product_ID = od.Product_ID
                         INNER JOIN customer_order co ON od.Order_ID = co.Order_ID
                         WHERE EXTRACT(MONTH FROM co.Order_date) = month
                         GROUP BY p.Product_name) LOOP
      DBMS_OUTPUT.PUT_LINE(product_sale.Product_name || ' | ' || product_sale.Total_Sales);
    END LOOP;
  END LOOP;
END;

exec product_sales_report_by_month;
*/

--Procedure will generate a report that shows the order history of a specific customer.
/*
set serveroutput on;
CREATE OR REPLACE PROCEDURE customer_order_history(
  p_customer_id IN NUMBER
) IS
BEGIN
  FOR order_history IN (SELECT co.Order_ID, co.Order_date, p.Product_name, p.Product_quantity, od.Order_details_ID, ods.Order_delivery_status_Name, dp.Delivery_partner_Name
                        FROM customer_order co
                        INNER JOIN order_details od ON co.Order_ID = od.Order_ID
                        INNER JOIN product p ON od.Product_ID = p.Product_ID
                        INNER JOIN order_delivery_status ods ON co.Order_ID = ods.Order_ID
                        INNER JOIN delivery_partner dp ON ods.delivery_partner_id = dp.delivery_partner_id
                        WHERE co.CustomerID = p_customer_id) LOOP
    DBMS_OUTPUT.PUT_LINE('Order ID: ' || order_history.Order_ID || ' | Order Date: ' || order_history.Order_date || ' | Product Name: ' || order_history.Product_name || ' | Quantity: ' || order_history.Product_quantity || ' | Order Details ID: ' || order_history.Order_details_ID || ' | Delivery Status: ' || order_history.Order_delivery_status_Name || ' | Delivery Partner Name: ' || order_history.Delivery_partner_Name);
  END LOOP;
END;

exec customer_order_history(10);
*/





--8) Procedure takes a product type name as input and generates a report of the total sales for that product type
/*
set serveroutput on;
CREATE OR REPLACE PROCEDURE product_sales_report (
    p_product_type_name IN VARCHAR2
) IS
    l_product_type_id NUMBER(38);
    l_total_sales NUMBER(38);
    l_report_date DATE := SYSDATE;
BEGIN
    -- Get the product type ID for the given product type name
    SELECT Product_type_ID INTO l_product_type_id
    FROM product_type
    WHERE Product_type_name = p_product_type_name;

    -- Get the total sales for the given product type
    SELECT SUM(Product_cost * Product_quantity) INTO l_total_sales
    FROM product
    WHERE Product_type_ID = l_product_type_id;

    -- Generate the sales report
    DBMS_OUTPUT.PUT_LINE('Product Type Sales Report');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    DBMS_OUTPUT.PUT_LINE('Report Date: ' || l_report_date);
    DBMS_OUTPUT.PUT_LINE('Product Type: ' || p_product_type_name);
    DBMS_OUTPUT.PUT_LINE('Total Sales: $' || l_total_sales);
END;


exec product_sales_report('Computer');
*/

/*
CREATE OR REPLACE PROCEDURE generate_order_amount_report
IS
   CURSOR order_cursor
   IS
      SELECT o.Order_ID,
             o.Order_date,
             c.Customer_FirstName || ' ' || c.Customer_LastName AS Customer_Name,
             p.Product_name,
             p.Product_quantity,
             p.Product_cost,
             p.Product_cost * p.Product_quantity AS Order_Amount
        FROM customer_order o
        JOIN customer c ON o.CustomerID = c.CustomerID
        JOIN order_details od ON o.Order_ID = od.Order_ID
        JOIN product p ON od.Product_ID = p.Product_ID;

   v_order_id          customer_order.Order_ID%TYPE;
   v_order_date        customer_order.Order_date%TYPE;
   v_customer_name     VARCHAR2(100);
   v_product_name      product.Product_name%TYPE;
   v_product_quantity  product.Product_quantity%TYPE;
   v_product_cost      product.Product_cost%TYPE;
   v_order_amount      NUMBER;
   v_total_order_amount NUMBER := 0;
BEGIN
   DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('ORDER AMOUNT REPORT');
   DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Order ID | Order Date | Customer Name | Product Name | Product Quantity | Product Cost | Order Amount');
   DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------------');

   FOR order_rec IN order_cursor LOOP
      v_order_id := order_rec.Order_ID;
      v_order_date := order_rec.Order_date;
      v_customer_name := order_rec.Customer_Name;
      v_product_name := order_rec.Product_name;
      v_product_quantity := order_rec.Product_quantity;
      v_product_cost := order_rec.Product_cost;
      v_order_amount := order_rec.Order_Amount;

      v_total_order_amount := v_total_order_amount + v_order_amount;

      DBMS_OUTPUT.PUT_LINE(v_order_id || ' | ' || v_order_date || ' | ' || v_customer_name || ' | ' || v_product_name || ' | ' || v_product_quantity || ' | ' || v_product_cost || ' | ' || v_order_amount);
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Total Order Amount: ' || v_total_order_amount);
   DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------------');
END;
/

exec GENERATE_ORDER_AMOUNT_REPORT;
*/


-- Full Delivery Status Report
/*
CREATE OR REPLACE PROCEDURE GENERATE_DELIVERY_STATUS_REPORT AS
    CURSOR c_orders IS
        SELECT o.Order_ID, o.Order_date, od.Product_ID, p.Product_name, os.Order_delivery_status_Name,
               dp.Delivery_partner_Name
        FROM customer_order o
        JOIN order_details od ON o.Order_ID = od.Order_ID
        JOIN product p ON od.Product_ID = p.Product_ID
        JOIN order_delivery_status os ON o.Order_ID = os.Order_ID
        JOIN delivery_partner dp ON os.Delivery_partner_ID = dp.Delivery_partner_ID;
BEGIN
    DBMS_OUTPUT.PUT_LINE('DELIVERY STATUS REPORT');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Order ID | Order Date | Product ID | Product Name | Delivery Status | Delivery Partner');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');

    FOR order_rec IN c_orders LOOP
        DBMS_OUTPUT.PUT_LINE(
            order_rec.Order_ID || ' | ' ||
            TO_CHAR(order_rec.Order_date, 'DD-MON-YYYY') || ' | ' ||
            order_rec.Product_ID || ' | ' ||
            order_rec.Product_name || ' | ' ||
            order_rec.Order_delivery_status_Name || ' | ' ||
            order_rec.Delivery_partner_Name
        );
    END LOOP;
END;
/


exec GENERATE_DELIVERY_STATUS_REPORT;
*/

/*
CREATE OR REPLACE PROCEDURE generate_order_cost_report(p_customer_id IN customer.CustomerID%TYPE)
AS
  CURSOR c_orders IS
    SELECT o.Order_ID, o.Order_date, SUM(p.Product_cost * p.Product_quantity) AS Total_Order_Cost
    FROM customer_order o
    INNER JOIN order_details od ON o.Order_ID = od.Order_ID
    INNER JOIN product p ON od.Product_ID = p.Product_ID
    WHERE o.CustomerID = p_customer_id
    GROUP BY o.Order_ID, o.Order_date;
  
  v_order_id customer_order.Order_ID%TYPE;
  v_order_date customer_order.Order_date%TYPE;
  v_total_order_cost NUMBER;
BEGIN
  -- Open cursor and fetch data
  OPEN c_orders;
  LOOP
    FETCH c_orders INTO v_order_id, v_order_date, v_total_order_cost;
    EXIT WHEN c_orders%NOTFOUND;
    
    -- Display report
    DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_order_id);
    DBMS_OUTPUT.PUT_LINE('Order Date: ' || v_order_date);
    DBMS_OUTPUT.PUT_LINE('Total Order Cost: $' || v_total_order_cost);
    DBMS_OUTPUT.PUT_LINE('--------------------------');
  END LOOP;
  
  -- Close cursor
  CLOSE c_orders;
END;
/

exec GENERATE_ORDER_COST_REPORT('16');
*/

--9) Procedure joins several tables to get the necessary information about the order delivery status, delivery partner, and associated orders and products. It then groups the results by delivery partner and order delivery status and calculates the total number of orders and revenue for each combination. 
/*
set serveroutput on;
CREATE OR REPLACE PROCEDURE order_delivery_status_report AS
  CURSOR order_delivery_cursor IS
    SELECT ods.Order_ID, ods.Order_delivery_status_Name, ods.Delivery_partner_ID, dp.Delivery_partner_Name, COUNT(*) AS Total_orders, SUM(p.Product_cost) AS Total_revenue
    FROM order_delivery_status ods
    INNER JOIN delivery_partner dp ON ods.Delivery_partner_ID = dp.Delivery_partner_ID
    INNER JOIN customer_order co ON ods.Order_ID = co.Order_ID
    INNER JOIN order_details od ON co.Order_ID = od.Order_ID
    INNER JOIN product p ON od.Product_ID = p.Product_ID
    GROUP BY ods.Order_ID, ods.Order_delivery_status_Name, ods.Delivery_partner_ID, dp.Delivery_partner_Name
    ORDER BY dp.Delivery_partner_Name;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Delivery Partner Name | Order Delivery Status | Total Orders | Total Revenue');
  FOR order_delivery IN order_delivery_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(order_delivery.Delivery_partner_Name || ' | ' || order_delivery.Order_delivery_status_Name || ' | ' || order_delivery.Total_orders || ' | $' || order_delivery.Total_revenue);
  END LOOP;
END;

exec order_delivery_status_report;
*/

--10) Procedure that generates a report on the most in-demand and least in-demand products based on the number of orders they've received:
/*
set serveroutput on;
CREATE OR REPLACE PROCEDURE in_demand_report IS
  CURSOR most_in_demand_cursor IS
    SELECT p.Product_name, COUNT(od.Order_details_ID) AS order_count
    FROM order_details od
    INNER JOIN product p ON od.Product_ID = p.Product_ID
    GROUP BY p.Product_name
    ORDER BY order_count DESC;
    
  CURSOR least_in_demand_cursor IS
    SELECT p.Product_name, COUNT(od.Order_details_ID) AS order_count
    FROM order_details od
    INNER JOIN product p ON od.Product_ID = p.Product_ID
    GROUP BY p.Product_name
    ORDER BY order_count ASC;
    
BEGIN
  DBMS_OUTPUT.PUT_LINE('Most In-Demand Products');
  DBMS_OUTPUT.PUT_LINE('Product Name | Order Count');
  
  FOR product IN most_in_demand_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(product.Product_name || ' | ' || product.order_count);
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Least In-Demand Products');
  DBMS_OUTPUT.PUT_LINE('Product Name | Order Count');
  
  FOR product IN least_in_demand_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(product.Product_name || ' | ' || product.order_count);
  END LOOP;
END;

exec in_demand_report;
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

-- 2) trigger to log changes to the customer_order table
/*
CREATE OR REPLACE TRIGGER customer_order_changes
AFTER INSERT OR UPDATE OR DELETE ON customer_order
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('New customer order inserted: ' || :NEW.order_id);
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Customer order updated: ' || :OLD.order_id);
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Customer order deleted: ' || :OLD.order_id);
  END IF;
END;
*/


-- 3)trigger to log changes to the order_details table
/*
CREATE OR REPLACE TRIGGER order_details_changes
AFTER INSERT OR UPDATE OR DELETE ON order_details
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('New order details inserted for order ' || :NEW.order_id);
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Order details updated for order ' || :NEW.order_id);
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Order details deleted for order ' || :OLD.order_id);
  END IF;
END;

*/


-- Function Top selling Product

/*

CREATE OR REPLACE FUNCTION top_selling_product (
   p_start_date IN DATE,
   p_end_date IN DATE
) RETURN VARCHAR2 AS
   v_top_product VARCHAR2(200);
BEGIN
   SELECT 
      p.product_name 
   INTO 
      v_top_product 
   FROM 
      product p
      JOIN order_details od ON p.product_id = od.product_id
      JOIN customer_order co ON od.order_id = co.order_id
   WHERE 
      co.order_date BETWEEN p_start_date AND p_end_date
   GROUP BY 
      p.product_name,od.product_id
   ORDER BY 
      od.product_id DESC 
   FETCH FIRST 1 ROW ONLY;
   
   RETURN 'The top selling product between ' || p_start_date || ' and ' || p_end_date || ' is: ' || v_top_product;
END;
/
SELECT top_selling_product('01-JAN-2022', '31-DEC-2023') AS top_selling_product FROM dual;

*/

--Function for getting Category Revenues
/*
CREATE OR REPLACE FUNCTION get_category_revenues
RETURN SYS_REFCURSOR
IS
  category_revenues SYS_REFCURSOR;
BEGIN
  OPEN category_revenues FOR
    SELECT c.Product_Type_Name, SUM(p.Product_Cost * p.Product_Quantity) AS Total_Revenue
    FROM Order_Details o
    JOIN Product p ON o.Product_ID = p.Product_ID
    JOIN Product_Type c ON p.Product_Type_Id = c.Product_Type_Id
    GROUP BY c.Product_Type_Name;



  RETURN category_revenues;
END;

select get_category_revenues from dual;

*/
