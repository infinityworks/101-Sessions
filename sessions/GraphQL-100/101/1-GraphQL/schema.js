const { gql } = require("apollo-server");

const typeDefs = gql`
  type Query {
    users: [User]!
    user(id: ID!): User
    me: User
  }

  type User {
    id: ID!
    name: String
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
