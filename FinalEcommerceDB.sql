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
