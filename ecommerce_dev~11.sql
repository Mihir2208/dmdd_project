CREATE OR REPLACE PROCEDURE full_customer_delivery_report IS
  CURSOR customer_order_cursor IS
    SELECT co.Order_ID, c.Customer_FirstName, c.Customer_LastName, c.Customer_PhoneNo, c.Customer_Email, cadd.Street, cadd.State, cadd.City, cadd.Zip, co.Order_date, pt.Payment_type_name, p.Product_name, od.Product_ID, od.Order_details_ID, ods.Order_delivery_status_Name, dp.Delivery_partner_Name, dp.Delivery_partner_PhoneNo
    FROM customer_order co
    INNER JOIN customer c ON co.CustomerID = c.CustomerID
    INNER JOIN customer_address cadd ON co.CustomerID = cadd.CustomerID
    INNER JOIN payment_type pt ON co.Payment_type_ID = pt.Payment_type_ID
    INNER JOIN order_details od ON co.Order_ID = od.Order_ID
    INNER JOIN product p ON od.Product_ID = p.Product_ID
    INNER JOIN order_delivery_status ods ON co.Order_ID = ods.Order_ID
    INNER JOIN delivery_partner dp ON ods.delivery_partner_id = dp.delivery_partner_id;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Order ID | Customer Name | Customer Phone | Customer Email | Street | State | City | Zip | Order Date | Payment Type | Product Name | Product ID | Order Details ID | Delivery Status | Delivery Partner Name | Delivery Partner Phone');
  FOR cust_order IN customer_order_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(cust_order.Order_ID || ' | ' || cust_order.Customer_FirstName || ' ' || cust_order.Customer_LastName || ' | ' || cust_order.Customer_PhoneNo || ' | ' || cust_order.Customer_Email || ' | ' || cust_order.Street || ' | ' || cust_order.State || ' | ' || cust_order.City || ' | ' || cust_order.Zip || ' | ' || cust_order.Order_date || ' | ' || cust_order.Payment_type_name || ' | ' || cust_order.Product_name || ' | ' || cust_order.Product_ID || ' | ' || cust_order.Order_details_ID || ' | ' || cust_order.Order_delivery_status_Name || ' | ' || cust_order.Delivery_partner_Name || ' | ' || cust_order.Delivery_partner_PhoneNo);
  END LOOP;
END;
/

EXEC full_customer_delivery_report;