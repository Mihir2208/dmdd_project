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