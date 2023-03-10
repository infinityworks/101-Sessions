-- PARSING SEMI-STRUCTURED DATA
use role accountadmin;
create database if not exists parsing_semi_structured;
create schema if not exists parsing_semi_structured.parsing_semi_structured;

-- create some data
CREATE OR REPLACE TABLE parsing_semi_structured.parsing_semi_structured.car_sales
(
  src variant
)
AS
SELECT PARSE_JSON(column1) AS src
FROM VALUES
('{
    "date" : "2017-04-28",
    "dealership" : "Valley View Auto Sales",
    "salesperson" : {
      "id": "55",
      "name": "Frank Beasley"
    },
    "customer" : [
      {"name": "Joyce Ridgely", "phone": "16504378889", "address": "San Francisco, CA"}
    ],
    "vehicle" : [
      {"make": "Honda", "model": "Civic", "year": "2017", "price": "20275", "extras":["ext warranty", "paint protection"]}
    ]
}'),
('{
    "date" : "2017-04-28",
    "dealership" : "Tindel Toyota",
    "salesperson" : {
      "id": "274",
      "name": "Greg Northrup"
    },
    "customer" : [
      {"name": "Bradley Greenbloom", "phone": "12127593751", "address": "New York, NY"}
    ],
    "vehicle" : [
      {"make": "Toyota", "model": "Camry", "year": "2017", "price": "23500", "extras":["ext warranty", "rust proofing", "fabric protection"]}
    ]
}') v;

select * from parsing_semi_structured.parsing_semi_structured.car_sales;

--you can get any first level element inserting a colon between the VARIANT column and the first element <column>:<level1_element>
select src:dealership from parsing_semi_structured.parsing_semi_structured.car_sales;

-- you can traverse the path of a semi-structured object using the dot notation
select src:salesperson.name from parsing_semi_structured.parsing_semi_structured.car_sales;

-- you can achieve the same using the bracket notation
select src['salesperson']['name'] from parsing_semi_structured.parsing_semi_structured.car_sales;

-- retrieve a single instance of a repeating element
select src:customer[0].name, src:vehicle[0] from parsing_semi_structured.parsing_semi_structured.car_sales;

-- you can further traverse the path and the price value. Note that the price is a STRING
select src:customer[0].name, src:vehicle[0].price from parsing_semi_structured.parsing_semi_structured.car_sales;

-- values in a VARIANT column are by default surrounded by double quotes. Using a double colon :: you can cast these values
select src:customer[0].name, src:vehicle[0].price::NUMBER from parsing_semi_structured.parsing_semi_structured.car_sales;


-- you can produce a laterla view of a VARIANT column with the FLATTEN function. The function returns a row for each object, and the LATERAL modifier joins the data with any information outside of the object.
SELECT
  value:name::string as "Customer Name",
  value:address::string as "Address"
  FROM
    parsing_semi_structured.parsing_semi_structured.car_sales
  , LATERAL FLATTEN(INPUT => SRC:customer);

-- you can nest the FLATTEN function to access deeper elements
SELECT
  vm.value:make::string as make,
  vm.value:model::string as model,
  ve.value::string as "Extras Purchased"
  FROM
    parsing_semi_structured.parsing_semi_structured.car_sales
    , LATERAL FLATTEN(INPUT => SRC:vehicle) vm
    , LATERAL FLATTEN(INPUT => vm.value:extras) ve;

-- you can use the GET function to access any element of an array
CREATE OR replace TABLE parsing_semi_structured.parsing_semi_structured.colors (v variant);

INSERT INTO
   parsing_semi_structured.parsing_semi_structured.colors
   SELECT
      parse_json(column1) AS v
   FROM
   VALUES
     ('[{r:255,g:12,b:0},{r:0,g:255,b:0},{r:0,g:0,b:255}]'),
     ('[{c:0,m:1,y:1,k:0},{c:1,m:0,y:1,k:0},{c:1,m:1,y:0,k:0}]')
    v;

select * from  parsing_semi_structured.parsing_semi_structured.colors;


SELECT *
, GET(v, 0) -- get the first element
, GET(v, ARRAY_SIZE(v)-1) -- get the last element
FROM parsing_semi_structured.parsing_semi_structured.colors;



-- Exercise
-- parse the data in the below table to obtain a flat view of: order_id, product_name, price, quantity, salutation, category_1, category_2
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| ORDER_ID | PRODUCT_NAME | PRICE | QUANTITY | SALUTATION | CATEGORY_1 | CATEGORY_2            |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 1        | T-shirt      | 20    | 2        | Mr         | Menswear   | T-shirts & Tops       |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 1        | Hoodie       | 40    | 1        | Mr         | Menswear   | Hoodies & Sweatshirts |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 2        | Jeans        | 35    | 1        | Mr         | Menswear   | Trousers              |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 2        | Shorts       | 20    | 1        | Mr         | Menswear   | Trousers              |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 3        | Socks        | 5     | 3        | Miss       | Womenswear | Socks & Tights        |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 3        | Tights       | 10    | 1        | Miss       | Womenswear | Socks & Tights        |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 3        | Pyjama       | 15    | 1        | Miss       | Womenswear | Nightware             |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
--| 4        | Skirt        | 25    | 1        | Mr         | Womenswear | Skirts                |
--+----------+--------------+-------+----------+------------+------------+-----------------------+
use role accountadmin;
CREATE OR REPLACE TABLE parsing_semi_structured.parsing_semi_structured.orders
(
  src variant
)
AS
SELECT PARSE_JSON(column1) AS src
FROM VALUES
  ('{
    "order_id": 1,
    "order_date": "2023-01-13",
    "customer_info": {"salutation": "Mr", "first_name": "Benito", "last_name": "Kay"},
    "items": [
    {"product_name": "T-shirt", "product_category": {"category1":"Menswear", "category2":"T-shirts & Tops"},"price": 19.99, "quantity": 2},
    {"product_name": "Hoodie", "product_category": {"category1":"Menswear", "category2":"Hoodies & Sweatshirts"},"price": 39.99,  "quantity": 1}],
    "order_total":79.97
  }'),

 ('{
    "order_id": 2,
    "order_date": "2023-02-01",
    "customer_info": {"salutation": "Mr", "first_name": "Fahid", "last_name": "Talukdar"},
    "items": [
    {"product_name": "Jeans", "product_category": {"category1":"Menswear", "category2":"Trousers"},"price": 34.99, "quantity": 1},
    {"product_name": "Shorts", "product_category": {"category1":"Menswear", "category2":"Trousers"},"price": 19.99,  "quantity": 1}],
    "order_total":53.98
  }'),

 ('{
    "order_id": 3,
    "order_date": "2023-02-12",
    "customer_info": {"salutation": "Miss", "first_name": "Pooja", "last_name": "Shah"},
    "items": [
    {"product_name": "Socks", "product_category": {"category1":"Womenswear", "category2":"Socks & Tights"},"price": 4.99, "quantity": 3},
    {"product_name": "Tights", "product_category": {"category1":"Womenswear", "category2":"Socks & Tights"},"price": 9.99,  "quantity": 1},
    {"product_name": "Pyjama", "product_category": {"category1":"Womenswear", "category2":"Nightware"},"price": 14.99,  "quantity": 1}],
    "order_total":39.95
  }'),

 ('{
    "order_id": 4,
    "order_date": "2023-03-01",
    "customer_info": {"salutation": "Mr", "first_name": "Gheorghita", "last_name": "Luca"},
    "items": [
    {"product_name": "Skirt", "product_category": {"category1":"Womenswear", "category2":"Skirts"},"price": 24.99, "quantity": 1}],
    "order_total":24.99
  }')
  v;

-- start here:

