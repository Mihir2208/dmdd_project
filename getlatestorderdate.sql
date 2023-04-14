
set SERVEROUTPUT on

CREATE OR REPLACE FUNCTION get_latest_order_date(p_customer_id IN NUMBER)
RETURN DATE
IS
  v_latest_order_date DATE;
BEGIN
  SELECT MAX(Order_date) INTO v_latest_order_date
  FROM customer_order
  WHERE CustomerID = p_customer_id;

  RETURN v_latest_order_date;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;
/

select get_latest_order_date(10) from dual;


