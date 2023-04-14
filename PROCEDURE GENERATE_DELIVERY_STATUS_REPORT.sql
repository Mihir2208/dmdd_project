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