set serveroutput on;

CREATE OR REPLACE FUNCTION top_selling_product (
   p_start_date IN DATE,
   p_end_date IN DATE
) RETURN VARCHAR2 AS
   v_top_product VARCHAR2(200);
BEGIN
   SELECT 
      p.product_name 
   INTO 
      v_top_product 
   FROM 
      product p
      JOIN order_details od ON p.product_id = od.product_id
      JOIN customer_order co ON od.order_id = co.order_id
   WHERE 
      co.order_date BETWEEN p_start_date AND p_end_date
   GROUP BY 
      p.product_name,od.product_id
   ORDER BY 
      od.product_id DESC 
   FETCH FIRST 1 ROW ONLY;
   
   RETURN 'The top selling product between ' || p_start_date || ' and ' || p_end_date || ' is: ' || v_top_product;
END;
/
SELECT top_selling_product('01-JAN-2022', '31-DEC-2023') AS top_selling_product FROM dual;