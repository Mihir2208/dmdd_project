-- Procedure for most sales in a zip code and least sales in a zipcode
set serveroutput on;
CREATE OR REPLACE PROCEDURE sales_by_zip_report (
  p_zip IN VARCHAR2
) IS
  v_count NUMBER(10);
  v_zip VARCHAR2(10);
  v_most_sales_prod_name VARCHAR2(100);
  v_least_sales_prod_name VARCHAR2(100);
  v_most_sales_count NUMBER(10);
  v_least_sales_count NUMBER(10);
  
  CURSOR sales_by_zip_cursor IS
    SELECT COUNT(*), p.Product_name, cadd.Zip
    FROM customer_order co
    INNER JOIN customer_address cadd ON co.CustomerID = cadd.CustomerID
    INNER JOIN order_details od ON co.Order_ID = od.Order_ID
    INNER JOIN product p ON od.Product_ID = p.Product_ID
    WHERE cadd.Zip = p_zip
    GROUP BY p.Product_name, cadd.Zip
    ORDER BY COUNT(*) DESC;
BEGIN
  v_zip := p_zip;
  
  -- Find most and least sold products in the given zip code
  OPEN sales_by_zip_cursor;
  FETCH sales_by_zip_cursor INTO v_count, v_most_sales_prod_name, v_zip;
  IF sales_by_zip_cursor%FOUND THEN
    v_most_sales_count := v_count;
  END IF;
  FETCH sales_by_zip_cursor INTO v_count, v_least_sales_prod_name, v_zip;
  IF sales_by_zip_cursor%FOUND THEN
    v_least_sales_count := v_count;
  END IF;
  CLOSE sales_by_zip_cursor;
  
  -- Output the results
  DBMS_OUTPUT.PUT_LINE('Most sales in ZIP code ' || v_zip || ': ' || v_most_sales_prod_name || ' (' || v_most_sales_count || ' sales)');
  DBMS_OUTPUT.PUT_LINE('Least sales in ZIP code ' || v_zip || ': ' || v_least_sales_prod_name || ' (' || v_least_sales_count || ' sales)');
END;


exec   sales_by_zip_report('38104');

-- Create a complex function to retrieve count of customers with orders within a date range
CREATE OR REPLACE FUNCTION get_customer_count_with_orders(p_start_date IN DATE, p_end_date IN DATE)
RETURN NUMBER
IS
  v_customer_count NUMBER := 0;
BEGIN
  SELECT COUNT(DISTINCT co.CustomerID) INTO v_customer_count
  FROM customer_order co
  WHERE co.Order_date BETWEEN p_start_date AND p_end_date;

  RETURN v_customer_count;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;
/

select get_customer_count_with_orders('01-JAN-2022','31-DEC-2022') from dual;

CREATE OR REPLACE FUNCTION calculate_order_total(order_id IN NUMBER)
RETURN NUMBER
IS
  total_cost NUMBER := 0;
BEGIN
  SELECT SUM(p.Product_cost * p.Product_quantity) INTO total_cost
  FROM order_details od
  INNER JOIN product p ON od.Product_ID = p.Product_ID
  WHERE od.Order_ID = order_id;

  RETURN total_cost;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;
/

-- Example SELECT statement to print the output of the function
DECLARE
  order_id NUMBER := 2; -- Replace with the desired order ID
  total_cost NUMBER;
BEGIN
  total_cost := calculate_order_total(order_id);
  DBMS_OUTPUT.PUT_LINE('Total Cost for Order ID ' || order_id || ': $' || total_cost);
END;
/
select calculate_order_total(6) from dual;

-- Function to retrieve all customers along with their addresses:

CREATE OR REPLACE FUNCTION get_customers_with_addresses
RETURN SYS_REFCURSOR
IS
  v_cur SYS_REFCURSOR;
BEGIN
  OPEN v_cur FOR
    SELECT c.*, ca.Street, ca.State, ca.City, ca.Zip
    FROM customer c
    LEFT JOIN customer_address ca ON c.CustomerID = ca.CustomerID;

  RETURN v_cur;
END;
/

select get_customers_with_addresses() from dual;