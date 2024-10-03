-- We first create the database
create database harshini_iphone
go

-- Modify the name of the database
ALTER DATABASE harshini_iphone MODIFY NAME = Harshini_Iphone;

create schema Iphone_analysis
go

SELECT TOP (1000) [Product_Name]
      ,[Product_URL]
      ,[Brand]
      ,[Sale_Price]
      ,[Mrp]
      ,[Discount_Percentage]
      ,[Number_Of_Ratings]
      ,[Number_Of_Reviews]
      ,[Upc]
      ,[Star_Rating]
      ,[Ram]
  FROM [DataVidhya].[Iphone_analysis].[apple_products]

select * from [Iphone_analysis].[apple_products]

select count(*) from [Iphone_analysis].[apple_products]

select avg(mrp) as avg_mrp from Iphone_analysis.apple_products
select max(mrp) as max_mrp from Iphone_analysis.apple_products
select min(mrp) as min_mrp from Iphone_analysis.apple_products

select * from Iphone_analysis.apple_products
where Ram > '4 GB' and star_rating >4.5

-- Creating new column to store iphone versions
alter table Iphone_analysis.apple_products
add iphone_version varchar(30)

select charindex('(', product_name) as start_paren
from Iphone_analysis.apple_products

update Iphone_analysis.apple_products
set iphone_version = substring(product_name, 1, charindex('(', product_name)-1)

select * from [Iphone_analysis].[apple_products]

-- creating a column for memory_storage
alter table [Iphone_analysis].[apple_products]
add memory_space varchar(20)

select charindex(',', product_name) as start_comma
from Iphone_analysis.apple_products

select SUBSTRING(product_name, 
                      CHARINDEX(',', product_name) + 1, 
                      CHARINDEX('GB', product_name) - CHARINDEX(',', product_name) + 1)
from [Iphone_analysis].[apple_products]

update Iphone_analysis.apple_products
set memory_space = substring(product_name, charindex(',', product_name)+1, CHARINDEX('GB', product_name) - CHARINDEX(',', product_name) + 1) 

select * from [Iphone_analysis].[apple_products]










