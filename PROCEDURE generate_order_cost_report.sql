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