--CUSTOMER TABLE

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
1,
'Mihir',
'Makwana',
TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'8572945059',
'makwana.mi@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
2,
'Pratik',
'Poojari',
TO_DATE('2004/06/01 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9845429674',
'poojari.pr.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
3,
'Sai',
'Pravalika',
TO_DATE('2001/03/07 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9821348196',
'sai.pravlikka.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
4,
'Uday',
'Shelke',
TO_DATE('2009/08/02 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9930695004',
'uday.shelke.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
5,
'John',
'Doe',
TO_DATE('2010/06/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9821458165',
'john.doe.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
6,
'John ',
'Cena',
TO_DATE('2014/12/11 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'8564324568',
'cena.john.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
7,
'Ram',
'Swamy',
TO_DATE('2012/05/12 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9345678687',
'swamy.ram.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
8,
'Arun',
'Kumar',
TO_DATE('2016/03/05 11:02:49', 'yyyy/mm/dd hh24:mi:ss'),
'9345623456',
'arunkumar.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
9,
'Meghna',
'Kumar',
TO_DATE('2020/03/02 09:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9845673465',
'kumar.meghna.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
10,
'Shreeram',
'Kumar',
TO_DATE('2017/05/11 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9457385473',
'shreeram.kumar.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
11,
'Vinit',
'Yadav',
TO_DATE('2015/12/23 11:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9475473757',
'yadav.vinit.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
12,
'Akshit',
'Saxena',
TO_DATE('2006/10/11 22:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9457395473',
'saxena.akshit.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
13,
'Himanshu',
'Mal',
TO_DATE('2002/02/23 11:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'9457295748',
'mal.himanshu.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
14,
'Shanti',
'Kumari',
TO_DATE('2012/09/12 12:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'8453256765',
'kumari.shanti.@northeastern.edu'
);

Insert into customer(CustomerID, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_PhoneNo, Customer_Email) values (
15,
'Saketh',
'Shetty',
TO_DATE('2002/03/12 13:02:44', 'yyyy/mm/dd hh24:mi:ss'),
'7438574856',
'shetty.saketh.@northeastern.edu'
);

select * from customer;



--CUSTOMER ADDRESS TABLE

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
1,
1,
'LMA STREET',
'BOSTON',
02120);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
2,
1,
'DNA 102 STREET',
'BRIGHAM',
02110);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
3,
2,
'LBS STREET',
'BOSTON',
02120);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
4,
3,
'BIGHWAYSTREET',
'BROOKLYN',
02120);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
5,
4,
'HIGHWAY STREET',
'QUEENSIDE',
21030);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
6,
5,
'ALLWAY STREET',
'NYC',
320423);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
7,
6,
'QUEENSWAY STREET',
'OTARIO',
930403);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
8,
7,
'RAMESHWARAM STREET',
'CHICAGO',
435949);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
8,
6,
'QUEENSWAY STREET',
'OTARIO',
930403);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
9,
7,
'WEEKEEND STREET',
'DALLAS',
342757);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
10,
8,
'QUICKIN STREET',
'BOSTON',
930403);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
11,
9,
'QUEENSWAY STREET',
'OTARIO',
930403);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
12,
10,
'ALLSION STREET',
'BOSTON',
459045);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
13,
11,
'ALLISTON STREET',
'BOSTON',
02120);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
14,
12,
'LONGWOOD STREET',
'BSOTN',
023463);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
15,
13,
'NEU STREET',
'BOSTON',
023543);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
16,
14,
'JAMAICA  PLAIN',
'STORROW BRIDGE',
023542);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
17,
15,
'CROSSWAY STREET',
'MICHIGAN',
037847);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
18,
15,
'QUEENSWAY STREET',
'BOSTON',
045848);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
19,
8,
'QUEENSWAY STREET',
'BOSTON',
045848);

Insert into CUSTOMER_ADDRESS(CUSTOMERADD_ID,  CUSTOMERID, STREET, CITY, ZIP) values (
20,
10,
'WINSTRIM STREET',
'BOSTON',
904868);

SELECT * FROM CUSTOMER_ADDRESS;



--DISTRIBUTOR TABLE

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
1,
1,
1,
330);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
2,
2,
2,
150);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
3,
3,
3,
160);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
4,
4,
4,
200);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
5,
5,
5,
130);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
6,
6,
6,
500);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
7,
7,
7,
830);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
8,
8,
8,
930);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
9,
9,
9,
0);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
10,
10,
10,
730);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
11,
11,
11,
540);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
12,
12,
12,
390);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
13,
13,
13,
890);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
14,
14,
14,
0);

Insert into distributor(DISTRIBUTOR_ID, PRODUCT_ID, PRODUCT_MANUFACTURER_ID, PRODUCT_QUANTITY) values (
15,
15,
15,
230);

select * from distributor;



