# README

The following tasks give you exposure to working with graphql on the server side using Apollo.

Nodemon is required:

`npm install -g nodemon`

Tasks:

Note: for the resolvers we are resolving local data, no db connectivity will be required.

1. Define a Product Type with the following fields:
   `id, inStock, name, price, image, unitsAvailable, sku`

2. Define an Order Type with the following fields:
   `id, orderDate, product`

3. Define queries that will get all products, get a single product and get all orders.

4. Define a mutation that will create a new order, taking `productSku` as an argument.

5. Create resolvers for your queries/mutations that will fetch the requested data and test these queries in the playground.
