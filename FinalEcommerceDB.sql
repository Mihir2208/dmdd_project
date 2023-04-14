-- 1 Create a trigger to log changes to the customer_order table
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
/


-- 2 Create a trigger to log changes to the order_details table
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

--3   A procedure that takes in a product type ID and returns a list of all distributors who carry that product type, along with the total quantity of that product type each distributor has in stock.

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



--4  A Procedure that takes in a date range and returns a list of all orders placed during that time, along with the total cost of each order.
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

--5 Procedure for Product Sales Report by Month
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

--6 Procedure will generate a report that shows the order history of a specific customer.
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

--7 Procedure will generate a report that shows the current inventory of each product by distributor.
set serveroutput on;
CREATE OR REPLACE PROCEDURE distributor_inventory_report IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Distributor Inventory Report:');
  DBMS_OUTPUT.PUT_LINE('Distributor ID | Product Name | Product Quantity');
  FOR distributor_inventory IN (SELECT d.Distributor_ID, p.Product_name, d.Product_Quantity
                                 FROM distributor d
                                 INNER JOIN product p ON d.Product_ID = p.Product_ID
                                 INNER JOIN product_manufacturer pm ON d.Product_manufacturer_ID = pm.Product_manufacturer_ID) LOOP
    DBMS_OUTPUT.PUT_LINE(distributor_inventory.Distributor_ID || ' | ' || distributor_inventory.Product_name || ' | ' || distributor_inventory.Product_Quantity);
  END LOOP;
END;

exec distributor_inventory_report;


--8 Procedure for CustomerReport of orders placed between a specific date
set serveroutput on;
CREATE OR REPLACE PROCEDURE customer_order_report(
    p_customer_id IN customer.CustomerID%TYPE,
    p_start_date IN customer_order.Order_date%TYPE,
    p_end_date IN customer_order.Order_date%TYPE,
    p_product_type_id IN product_type.Product_type_ID%TYPE DEFAULT NULL
) AS
    CURSOR customer_order_cursor IS
        SELECT co.Order_ID, c.Customer_FirstName, c.Customer_LastName, c.Customer_PhoneNo, c.Customer_Email,
               cadd.Street, cadd.State, cadd.City, cadd.Zip, co.Order_date, pt.Payment_type_name,
               p.Product_name, p.Product_cost, od.Product_ID, od.Order_details_ID, ods.Order_delivery_status_Name,
               dp.Delivery_partner_Name, dp.Delivery_partner_PhoneNo
        FROM customer_order co
        INNER JOIN customer c ON co.CustomerID = c.CustomerID
        INNER JOIN customer_address cadd ON co.CustomerID = cadd.CustomerID
        INNER JOIN payment_type pt ON co.Payment_type_ID = pt.Payment_type_ID
        INNER JOIN order_details od ON co.Order_ID = od.Order_ID
        INNER JOIN product p ON od.Product_ID = p.Product_ID
        INNER JOIN product_type pt2 ON p.Product_type_ID = pt2.Product_type_ID
        INNER JOIN order_delivery_status ods ON co.Order_ID = ods.Order_ID
        INNER JOIN delivery_partner dp ON ods.delivery_partner_id = dp.delivery_partner_id
        WHERE c.CustomerID = p_customer_id
          AND co.Order_date >= p_start_date
          AND co.Order_date <= p_end_date
          AND (p_product_type_id IS NULL OR p_product_type_id = pt2.Product_type_ID)
        ORDER BY co.Order_date DESC;

    v_total_cost NUMBER(38,2) := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Order ID | Customer Name | Customer Phone | Customer Email | Street | State | City | Zip | Order Date | Payment Type | Product Name | Product Cost | Product ID | Order Details ID | Delivery Status | Delivery Partner Name | Delivery Partner Phone');

    FOR cust_order IN customer_order_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(cust_order.Order_ID || ' | ' || cust_order.Customer_FirstName || ' ' || cust_order.Customer_LastName || ' | ' || cust_order.Customer_PhoneNo || ' | ' || cust_order.Customer_Email || ' | ' || cust_order.Street || ' | ' || cust_order.State || ' | ' || cust_order.City || ' | ' || cust_order.Zip || ' | ' || cust_order.Order_date || ' | ' || cust_order.Payment_type_name || ' | ' || cust_order.Product_name || ' | ' || cust_order.Product_cost || ' | ' || cust_order.Product_ID || ' | ' || cust_order.Order_details_ID || ' | ' || cust_order.Order_delivery_status_Name || ' | ' || cust_order.Delivery_partner_Name || ' | ' || cust_order.Delivery_partner_PhoneNo);

        v_total_cost := v_total_cost + cust_order.Product_cost;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total cost for orders: ' || v_total_cost);
END;

exec customer_order_report(1, '01-JAN-2022','01-JAN-2023');


--9  Procedure takes a product type name as input and generates a report of the total sales for that product type
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


