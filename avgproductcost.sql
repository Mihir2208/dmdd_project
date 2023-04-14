
set SERVEROUTPUT on

--Function to retrieve the average product cost for a given product type:

CREATE OR REPLACE FUNCTION get_average_product_cost(p_product_type_id IN NUMBER)
RETURN NUMBER
IS
  v_average_product_cost NUMBER;
BEGIN
  SELECT AVG(Product_cost) INTO v_average_product_cost
  FROM product
  WHERE Product_type_ID = p_product_type_id;

  RETURN v_average_product_cost;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;
/
select get_average_product_cost(3) from dual;


