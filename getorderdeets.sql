
set SERVEROUTPUT on

CREATE OR REPLACE FUNCTION get_order_details(p_order_id IN NUMBER)
RETURN VARCHAR2
IS
  v_result VARCHAR2(500);
BEGIN
  SELECT 'Order ID: ' || co.Order_ID || ', Order Date: ' || TO_CHAR(co.Order_date, 'DD-MON-YYYY') ||
         ', Customer Name: ' || c.Customer_FirstName || ' ' || c.Customer_LastName ||
         ', Payment Type: ' || pt.Payment_type_name ||
         ', Product Name: ' || p.Product_name || ', Product Cost: $' || TO_CHAR(p.Product_cost, '9999.99') ||
         ', Product Quantity: ' || p.Product_quantity ||
         ', Delivery Status: ' || ods.Order_delivery_status_Name ||
         ', Delivery Partner: ' || dp.Delivery_partner_Name || ' (' || dp.Delivery_partner_PhoneNo || ')' INTO v_result
  FROM customer_order co
  INNER JOIN customer c ON co.CustomerID = c.CustomerID
  INNER JOIN payment_type pt ON co.Payment_type_ID = pt.Payment_type_ID
  INNER JOIN order_details od ON co.Order_ID = od.Order_ID
  INNER JOIN product p ON od.Product_ID = p.Product_ID
  INNER JOIN order_delivery_status ods ON co.Order_ID = ods.Order_ID
  INNER JOIN delivery_partner dp ON ods.Delivery_partner_ID = dp.Delivery_partner_ID
  WHERE co.Order_ID = p_order_id;

  RETURN v_result;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Order not found';
  WHEN OTHERS THEN
    RAISE;
END;
/

SELECT get_order_details(1) AS order_details
FROM dual;


