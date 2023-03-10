-- PARSING SEMI-STRUCTURED DATA

use role sysadmin;
create schema advanced_features.semi_structured;
CREATE OR REPLACE TABLE advanced_features.semi_structured.orders
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

select
src:order_id::integer as order_id,
items.value:product_name::string as product_name,
items.value:price::number as price,
items.value:quantity::integer as quantity,
src:customer_info:salutation::string as salutation,
items.value:product_category:category1::string as category_1,
items.value:product_category:category2::string as category_2
from advanced_features.semi_structured.orders
, LATERAL FLATTEN(INPUT => SRC:items) items;