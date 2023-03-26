--Insert Data into Delivery Partner Table

insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (1, 'Benton Hurdedge', '2914802627', 'bhurdedge0@globo.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (2, 'Yevette Tremblet', '5629934033', 'ytremblet1@skyrock.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (3, 'Martyn Summerlie', '8806861058', 'msummerlie2@wunderground.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (4, 'Tirrell Annwyl', '6252777929', 'tannwyl3@washington.edu');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (5, 'Laryssa Hassell', '7492449872', 'lhassell4@chicagotribune.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (6, 'Star Durtnel', '9432148907', 'sdurtnel5@nyu.edu');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (7, 'Panchito Stolze', '4553461210', 'pstolze6@comcast.net');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (8, 'Phyllys Lempenny', '4882402681', 'plempenny7@plala.or.jp');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (9, 'Kamilah Bullent', '6448883809', 'kbullent8@usgs.gov');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (10, 'Delmar Hinsche', '4395142702', 'dhinsche9@mtv.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (11, 'Mitzi Redmille', '9239928898', 'mredmillea@illinois.edu');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (12, 'Noemi Aleswell', '3323132147', 'naleswellb@comcast.net');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (13, 'Westbrook Wathall', '9178412151', 'wwathallc@marketwatch.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (14, 'Hermon Steere', '8553042354', 'hsteered@a8.net');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (15, 'Durand Alexsandrev', '7143038957', 'dalexsandreve@howstuffworks.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (16, 'Doroteya Plank', '4094344369', 'dplankf@google.ca');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (17, 'Karlan Gothup', '7106212990', 'kgothupg@simplemachines.org');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (18, 'Modesta D''Avaux', '6759934645', 'mdavauxh@reuters.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (19, 'Denis Mingaye', '6049811300', 'dmingayei@drupal.org');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (20, 'Renie Baumert', '1814811972', 'rbaumertj@tripod.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (21, 'Chic Perrins', '2429696730', 'cperrinsk@nymag.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (22, 'Cindy O''Geaney', '3522130005', 'cogeaneyl@un.org');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (23, 'Griselda Colloby', '3744468222', 'gcollobym@feedburner.com');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (24, 'Deeanne Hemeret', '2023842831', 'dhemeretn@nasa.gov');
insert into delivery_partner (Delivery_partner_ID, Delivery_partner_Name, Delivery_partner_PhoneNo, Deliver_partner_Email) values (25, 'Cointon Grubey', '7205991546', 'cgrubeyo@accuweather.com');

--Insert Data into order_delivery_status Table
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (1, 'Order Received', 36, 22);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (2, 'Order processing', 145, 8);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (3, 'Order Received', 25, 17);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (4, 'Order Shipped', 72, 22);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (5, 'Order Received', 17, 15);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (6, 'Order Delivered', 117, 22);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (7, 'Order Shipped', 142, 22);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (8, 'Order processing', 36, 15);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (9, 'Order Delivered', 68, 18);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (10, 'Order Received', 135, 11);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (11, 'Order Received', 16, 10);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (12, 'Order Received', 9, 4);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (13, 'Order Received', 49, 5);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (14, 'Order Received', 21, 15);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (15, 'Order processing', 1, 21);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (16, 'Order Received', 41, 14);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (17, 'Order Received', 146, 24);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (18, 'Order Delivered', 23, 11);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (19, 'Order Shipped', 7, 13);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (20, 'Order processing', 14, 24);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (21, 'Order Received', 72, 21);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (22, 'Order Delivered', 56, 8);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (23, 'Order processing', 117, 17);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (24, 'Order Received', 8, 6);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (25, 'Order processing', 143, 5);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (26, 'Order processing', 91, 16);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (27, 'Order processing', 100, 25);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (28, 'Order Delivered', 55, 15);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (29, 'Order Received', 150, 12);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (30, 'Order processing', 60, 25);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (31, 'Order Shipped', 145, 25);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (32, 'Order Shipped', 45, 20);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (33, 'Order Delivered', 49, 4);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (34, 'Order processing', 62, 17);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (35, 'Order processing', 145, 11);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (36, 'Order Received', 73, 7);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (37, 'Order Shipped', 90, 23);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (38, 'Order Delivered', 128, 2);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (39, 'Order processing', 18, 18);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (40, 'Order processing', 119, 10);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (41, 'Order Received', 51, 1);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (42, 'Order Received', 4, 14);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (43, 'Order Delivered', 66, 21);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (44, 'Order processing', 38, 5);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (45, 'Order Shipped', 18, 3);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (46, 'Order processing', 96, 11);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (47, 'Order Received', 51, 21);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (48, 'Order Delivered', 34, 7);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (49, 'Order Shipped', 17, 18);
insert into order_delivery_status (Order_delivery_status_ID, Order_delivery_status_Name, Order_ID, Delivery_partner_ID) values (50, 'Order Received', 71, 4);