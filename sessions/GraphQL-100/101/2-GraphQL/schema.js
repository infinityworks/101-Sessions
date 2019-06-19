const { gql } = require("apollo-server");

const typeDefs = gql`
  type Query {
    getUsers: [User]!
    getUser(id: ID!): User
  }

  type User {
    id: ID!
    name: String
    image: String
    company: Company
    position: Position
    connections: [User]
  }

  type Company {
    id: ID!
    name: String
    website: String
    emailAddress: String
  }

  type Position {
    id: ID!
    name: String
  }
`;

module.exports = typeDefs;
