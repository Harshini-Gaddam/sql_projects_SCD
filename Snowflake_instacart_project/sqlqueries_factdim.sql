-- Query to find Total products ordered per department

select dd.department, count(*) as total_products_ordered
from fact_order_products fop 
join dim_departments dd on fop.department_id = dd.department_id
group by dd.department

-- Query to find the top 5 aisles with the highest number of reordered products

select da.aisle, count(*) as total_reordered 
from fact_order_products fop 
join dim_aisles da on fop.aisle_id = da.aisle_id
where fop.reordered = 1
group by da.aisle
order by total_reordered desc
limit 5;
