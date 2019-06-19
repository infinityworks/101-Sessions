const { gql } = require("apollo-server");

const typeDefs = gql`
  type Query {
    getUsers: [User]!
    getUser(id: ID!): User
    getCompanies: [Company]!
    getCompany(id: ID!): Company
  }

  type User {
    id: ID!
    name: String!
    image: String!
    company: Company!
    position: Position!
    employed: Boolean!
  }

  type Company {
    id: ID!
    name: String
    website: String
    emailAddress: String
    employees: [User]
  }

  type Position {
    id: ID!
    title: String
    division: String
  }
`;

module.exports = typeDefs;
