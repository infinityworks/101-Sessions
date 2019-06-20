// Import the ApolloServer class from apollo-server
const { ApolloServer } = require("apollo-server");
const { makeExecutableSchema } = require("graphql-tools");

// Import our schema from schema.js
const typeDefs = require("./schema");
const resolvers = require("./resolvers");

// Create a new instance of ApolloServer with our schema
// passed to the typeDefs property on the configuration object
const server = new ApolloServer({ typeDefs, resolvers });

// Run the GraphQL server
server.listen().then(({ url }) => {
  console.log(`👉 Server listening at ${url}`);
});
