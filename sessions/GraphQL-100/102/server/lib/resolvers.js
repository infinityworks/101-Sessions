const products = require("./products.json");

let orders = [];

const resolvers = {
  Query: {
    getProduct: (parent, args) =>
      products.find(product => product.sku === args.sku),
    getProducts: () => products,
    getOrders: () => orders
  },

  Mutation: {
    createOrder: (parent, args) => {
      const product = products.find(product => product.sku === args.productSku);

      const order = {
        id: orders.length++,
        orderDate: Date.now(),
        product
      };

      // Save new order
      orders.push(order);

      return order;
    }
  },

  Product: {
    inStock: parent => (parent.unitsAvailable > 0 ? true : false)
  }
};

module.exports = resolvers;
