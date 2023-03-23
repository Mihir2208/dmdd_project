Insert into PRODUCT_TYPE(Product_Type_ID, Product_Type_Name, Product_Description) values (
1234, 'Headphones', 'The Perfect Headphones for Low-Noise High-Frequency Hi-Res Testing');

Insert into PRODUCT_TYPE(Product_Type_ID, Product_Type_Name, Product_Description) values (
2345, 'MobilePhones', 'Shop through a wide selection of Mobilephones Free shipping and free returns avaialble on eligible items');

Insert into PRODUCT_TYPE(Product_Type_ID, Product_Type_Name, Product_Description) values (
3456, 'Books', 'Online shopping from a great selection at Books Store');

Insert into PRODUCT_TYPE(Product_Type_ID, Product_Type_Name, Product_Description) values (
4567, 'Shampoos', 'Shop shampoo products with sustainability certifications Free Shipping Available');



Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
1,1234, 'Sony Headset', '599', 'Yes','500');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
20,1234, 'JBL Headset', '999', 'Yes','340');


Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
3,2345, 'Apple iPhone', '50999', 'Yes','450');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
4,2345, 'Samsung ', '25000', 'Yes','200');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
5,2345, 'Sony', '16999', 'Yes','575');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
6,2345, 'Oneplus', '30000', 'Yes','270');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
7,3456, 'The Untethered Soul', '400', 'Yes','350');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
8,3456, 'Trilogy of Shiva', '549', 'Yes','400');


Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
9,3456, 'A Promised Land', '1000', 'NO','0');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
10,3456, 'Becoming', '399', 'Yes','800');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
11,3456, 'How to be a Bawse', '199', 'Yes','1000');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
12,4567, 'Head and Shoulders shampoo', '299', 'Yes','600');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
13,4567, 'Pantene', '349', 'Yes','470');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
14,4567, 'Bath and Body Works', '569', 'No','0');

Insert into PRODUCT(Product_Id,Product_Type_ID, Product_Name,Product_Cost, Product_Active, Product_Quantity) values (
15,4567, 'Meera', '189', 'Yes','756');

Insert into PRODUCT_MANUFACTURER(Product_Manufacturer_Id, Distributor_ID) values (
1, 1);

select * from PRODUCT;
