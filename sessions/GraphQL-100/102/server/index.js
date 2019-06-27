const { ApolloServer } = require("apollo-server");

const typeDefs = require("./lib/schema");
const resolvers = require("./lib/resolvers");

const server = new ApolloServer({
  typeDefs,
  resolvers
});

server.listen().then(({ url }) => {
  console.log(`👉 server listening at ${url}`);
});
