-- Accessing data from s3 bucket (external source)
DROP STAGE IF EXISTS harshini_stage_instacart;

create stage harshini_stage_instacart
URL = "s3://harshini-snowflake-dw-instacart/instacart/"
CREDENTIALS = (AWS_KEY_ID = 'AWS_ACCESS_KEY_ID' AWS_SECRET_KEY = 'AWS_SECRET_KEY_ID');

-- Now snowflake has an access to AWS account
-- Now we need to tell snowflake on which file formats are we gonna work

CREATE OR REPLACE FILE FORMAT csv_file_format
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'

-- Now let's load data from s3 to our tables

-- create and load into aisles table
create table aisles(
    aisle_id integer primary key,
    aisle varchar
)

-- we gonna load the data into the aisles table from s3 using copy command
COPY INTO aisles (aisle_id, aisle)
FROM @harshini_stage_instacart/aisles.csv
FILE_FORMAT = (FORMAT_NAME = 'csv_file_format')

select * from aisles;

-- create and load into departments
create table departments(
    department_id integer primary key,
    department varchar
)

COPY INTO departments (department_id, department)
FROM @harshini_stage_instacart/departments.csv
FILE_FORMAT = (FORMAT_NAME = 'csv_file_format')

-- create and load into products
create or replace table products(
    product_id integer primary key,
    product_name varchar,
    aisle_id integer,
    department_id integer
);

COPY INTO products (product_id, product_name, aisle_id, department_id)
FROM @harshini_stage_instacart/products.csv
FILE_FORMAT = (FORMAT_NAME = 'csv_file_format')

-- create and load into orders
create or replace table orders (
    order_id integer primary key,
    user_id integer,
    eval_set string,
    order_number integer,
    order_dow integer,
    order_hour_of_day integer,
    days_since_prior_order integer
)

COPY INTO orders (order_id, user_id, eval_set, order_number, order_dow, order_hour_of_day, days_since_prior_order)
FROM @harshini_stage_instacart/orders.csv
FILE_FORMAT = (FORMAT_NAME = 'csv_file_format')

select * from orders limit 10;

-- create and load into order_products
create table order_products(
    order_id integer,
    product_id integer,
    add_to_cart integer,
    reordered integer,
    primary key(order_id, product_id)
)

COPY INTO order_products(order_id, product_id, add_to_cart, reordered)
FROM @harshini_stage_instacart/order_products.csv
FILE_FORMAT = (FORMAT_NAME = 'csv_file_format')

select count(*) from order_products;
select * from order_products limit 10;

-- We have loaded the data into the tables and will now perform dimensional modeling to convert them into fact and dimension tables, focusing on the grain at the order level.
