-- creating dimension tables from the star schema which we created using ER MODEL
-- when loading fact and dimension tables, we can use CTAS (create table as)
create or replace table dim_users as (
    select user_id from orders
);

create or replace table dim_products as (
    select product_id, product_name from products
);

create or replace table dim_asiles as (
    select aisle_id, aisle from aisles
);

create or replace table dim_departments as (
    select department_id, department from departments
);

create or replace table dim_orders as (
    select order_id, order_number, order_dow, order_hour_of_day, days_since_prior_order
    from orders
)

-- Creating fact table

create or replace table fact_order_products as (
    select op.order_id, op.product_id, o.user_id, p.aisle_id, p.department_id, op.add_to_cart, op.reordered
    from order_products op 
    join orders o on op.order_id = o.order_id
    join products p on op.product_id = p.product_id
)

-- select * from fact_order_products limit 10;