create table customer(
CustomerID number(10),
FirstName varchar2(10),
LastName varchar2(10));

desc customer;

SELECT
  table_name, owner
FROM
  all_tables
ORDER BY
  owner, table_name;
  
SELECT object_name,created FROM user_objects
WHERE object_name LIKE  'CUSTOMER'
AND object_type = 'TABLE'; 

DROP TABLE customer;