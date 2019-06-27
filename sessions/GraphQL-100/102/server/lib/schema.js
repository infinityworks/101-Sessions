const { gql } = require("apollo-server");

const schema = gql`
  type Query {
    getOrders: [Order]!
    getProducts: [Product]!
    getProduct(sku: Int): Product!
  }

  type Mutation {
    createOrder(productSku: Int): Order
  }

  type Product {
    id: ID!
    inStock: Boolean
    name: String!
    price: Float!
    image: String
    unitsAvailable: Int
    sku: Int
  }

  type Order {
    id: ID!
    orderDate: String
    product: Product
  }

  type Category {
    id: ID!
    name: String!
    product: [Product]
  }
`;

module.exports = schema;
