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

