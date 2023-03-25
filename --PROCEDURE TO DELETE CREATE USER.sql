--PROCEDURE TO DELETE USERS
CREATE OR REPLACE PROCEDURE DELETE_USER
IS
    V_COUNTER NUMBER := 0;
    CURRENT_USER VARCHAR(10);
    EX_INCORRECT_USER EXCEPTION;
    EX_USER_NOT_DROPPED EXCEPTION;
BEGIN
    SELECT USER INTO CURRENT_USER FROM DUAL;
    IF (CURRENT_USER <> 'ADMIN') THEN
        RAISE EX_INCORRECT_USER;
    END IF;
    
        SELECT COUNT(*) INTO V_COUNTER FROM ALL_USERS WHERE USERNAME = 'APPCUST';
            IF V_COUNTER > 0 THEN  
            DBMS_OUTPUT.PUT_LINE('APPCUST dropped');
                EXECUTE IMMEDIATE 'DROP   USER   APPCUST   CASCADE'; 
            ELSE RAISE EX_USER_NOT_DROPPED;
            END IF; 
    
    COMMIT;
    
    EXCEPTION
    
    WHEN EX_INCORRECT_USER THEN
        DBMS_OUTPUT.PUT_LINE('YOU CANNOT PERFORM THIS ACTION, PLEASE CONTACT ADMIN');
    WHEN EX_USER_NOT_DROPPED THEN
        DBMS_OUTPUT.PUT_LINE('USER WAS NOT DELETED');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;
END;
/
    EXECUTE DELETE_USER;

CREATE USER APPCUST IDENTIFIED BY Customer123456;
ALTER USER APPCUST DEFAULT TABLESPACE DATA;
ALTER USER APPCUST QUOTA unlimited ON USERS;  
GRANT create session TO APPCUST;
grant select on customer to APPCUST;
grant select on  customer_address to APPCUST;
grant select on customer_order to APPCUST;
grant select on order_details to APPCUST;
grant select on product to APPCUST;
grant select on payment_type to APPCUST;
grant select on product_type to APPCUST;
grant select on order_delivery_status to APPCUST;
grant select on delivery_partner to APPCUST;
