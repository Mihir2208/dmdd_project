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