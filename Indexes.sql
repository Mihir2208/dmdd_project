-- Index on order_details table for Product_ID and Order_ID columns
CREATE INDEX idx_order_details_product_id_order_id ON order_details(Product_ID, Order_ID);

-- Index on order_delivery_status table for Order_ID and Delivery_partner_ID columns
CREATE INDEX idx_order_delivery_status_order_id_partner_id ON order_delivery_status(Order_ID, Delivery_partner_ID);

-- Index on customer_order table for Payment_type_ID and CustomerID columns
CREATE INDEX idx_customer_order_payment_customer_id ON customer_order(Payment_type_ID, CustomerID);


-- Index on distributor table for Product_ID and Product_manufacturer_ID columns
CREATE INDEX idx_distributor_product_id_manufacturer_id ON distributor(Product_ID, Product_manufacturer_ID);

-- Index on product_manufacturer table for Distributor_ID column
CREATE INDEX idx_product_manufacturer_distributor_id ON product_manufacturer(Distributor_ID);

-- Index on customer table for Customer_FirstName and Customer_LastName columns
CREATE INDEX idx_customer_name ON customer(Customer_FirstName, Customer_LastName);

-- Index on customer_address table for CustomerID column
CREATE INDEX idx_customer_address_customer_id ON customer_address(CustomerID);

-- Index on product_type table for Product_type_name column
CREATE INDEX idx_product_type_name ON product_type(Product_type_name);

-- Index on product table for Product_type_ID column
CREATE INDEX idx_product_product_type_id ON product(Product_type_ID);
