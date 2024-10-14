CREATE TABLE customer (
customer_id INT,
customer_name VARCHAR(50),
customer_email VARCHAR(50),
customer_phone VARCHAR(15),
load_date DATE,
customer_address VARCHAR(255)
);


INSERT INTO customer VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', '2022-01-01', '123 Main St'),
(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210', '2022-01-01', '456 Elm St'),
(3, 'Bob Smith', 'bob.smith@example.com', '555-555-5555', '2022-01-01', '789 Oak St');

select * from customer;

-- SLOWLY CHANGING DIMENSIONS
-- SCD 1 (Overwriting the existing value)
update customer
set customer_address = '1234 Maple Street'
where customer_id = 2

-- SCD 2 (storing historic values as well using date range)

-- adding new columns to store historic value
ALTER TABLE CUSTOMER ADD COLUMN customer_segment VARCHAR(20);
ALTER TABLE CUSTOMER ADD COLUMN start_date DATE;
ALTER TABLE CUSTOMER ADD COLUMN end_date DATE;
ALTER TABLE CUSTOMER ADD COLUMN version INT DEFAULT 1; 

select * from customer;

UPDATE customer SET customer_segment = 'Gold', start_date = '2022-02-01', end_date = '9999-12-
31' WHERE customer_id = 2;

-- inserting an updated row into customer table after customer_segment getting changed to platinum from gold 
INSERT INTO CUSTOMER
select customer_id, customer_name, customer_email, customer_phone, load_date, customer_address, 
'platinum', '2022-03-01', '9999-12-31', version+1
from customer
where customer_id = 2;

-- updating the end date of the version 1
UPDATE CUSTOMER 
SET END_DATE = '2022-02-28'
WHERE CUSTOMER_ID=2 AND VERSION=1

select * from customer where customer_id=2;

-- SCD 3 (Storing present and previous values in the same record but within different columns)

-- adding new column to store previous value
ALTER TABLE CUSTOMER ADD COLUMN prev_segment varchar(255);

-- Let's say we have a new segment 'Silver'.

INSERT INTO CUSTOMER
select customer_id, 
        customer_name, 
        customer_email, 
        customer_phone, 
        load_date, 
        customer_address, 
        'silver', 
        '2022-04-01', 
        '9999-12-31', 
        version+1,
        customer_segment
from customer
where customer_id = 2 and version =2; 

update customer
set end_date = '2022-03-31'
where customer_id =2 and version =2;

select * from customer where customer_id=2;