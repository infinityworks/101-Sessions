# 101.1 Getting Started

This project bootstraps Apollo Server and injects schema.js into the `typeDefs`
property on the configuration object of `ApolloServer`.

## Defining a Schema

Our app needs to:

1. Fetch a list of users (query)
2. Fetch a single user (query)
3. Fetch a list of companies (query)
4. Fetch a single company (query)
5. Fetch a list of job positions within a company (query)
6. Fetch a single job position position within a company (mutation)
7. Receive real-time events of newly created users (subscription)

With the above requirements we can see that our a schema will have three
custom types: `User`, `Company` and `Position` aside from our three
`root types` of `Query`, `Mutation` and `Subscription`.

## gql

We wrap our schema inside `gql` which is a JavaScript template literal tag provided by
Apollo that parses GraphQL query strings into the standard GraphQL Abstract Syntax Tree.

More info: [GraphQL Tag](https://github.com/apollographql/graphql-tag)

## Setup

Install dependencies and run server.js using 
```
npm install
npm start
```

Open the GraphQL Playground to review the schema and docs

http://localhost:4000/

Although our GraphQL server runs and we've defined our schema, no data will be returned
when executing a query.