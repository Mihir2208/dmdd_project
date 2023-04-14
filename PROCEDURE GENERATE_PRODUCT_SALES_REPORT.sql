CREATE OR REPLACE PROCEDURE generate_product_sales_report
IS
  CURSOR c_product_sales IS
    SELECT p.Product_name,
           SUM(p.Product_quantity) AS total_quantity,
           SUM(p.Product_quantity * p.Product_cost) AS total_cost
      FROM product p
      JOIN order_details od ON p.Product_ID = od.Product_ID
      JOIN customer_order co ON od.Order_ID = co.Order_ID
      GROUP BY p.Product_name;
           
  v_product_name product.Product_name%TYPE;
  v_total_quantity NUMBER;
  v_total_cost NUMBER;
BEGIN
  -- Print report header
  DBMS_OUTPUT.PUT_LINE('Product Sales Report');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Product Name | Total Quantity | Total Cost');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
  
  -- Loop through the cursor and display report data
  FOR r_product_sales IN c_product_sales LOOP
    v_product_name := r_product_sales.Product_name;
    v_total_quantity := r_product_sales.total_quantity;
    v_total_cost := r_product_sales.total_cost;
    
    -- Print report row
    DBMS_OUTPUT.PUT_LINE(
      RPAD(v_product_name, 20) ||
      RPAD(v_total_quantity, 15) ||
      RPAD(v_total_cost, 15)
    );
  END LOOP;
  
  -- Print report footer
  DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
END;
/


exec GENERATE_PRODUCT_SALES_REPORT;