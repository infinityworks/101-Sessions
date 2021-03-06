# SOLUTION

## ProductList.js

Fetch all products from the graphql server
```
  <Query
    query={gql`
      query { 
        getProducts {
  	      inStock, name, price, image, unitsAvailable, sku
        }
      }
    `}
  >
```


## ProductPage.js

Fetch a product from the graphql server
```
const GET_PRODUCT = gql`
  query($sku: Int!) { 
    getProduct(sku:$sku) {
      inStock, name, price, image, unitsAvailable, sku
	  }
  }
`;
```


Create an Order
```
const CREATE_ORDER = gql`
  mutation($sku: Int!) { 
    createOrder(productSku: $sku) {
      id, orderDate, product {name, inStock} 
    }  
  }
`;
```


## OrdersPage.js

Retrieve orders array
```
const GET_ORDERS = gql`
  query {
    getOrders {
	    id, orderDate, product {name}
    }
  }
`;
```