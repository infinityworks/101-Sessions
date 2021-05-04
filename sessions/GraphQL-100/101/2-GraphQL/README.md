# 101.2 Adding Resolvers

Although our GraphQL server runs and we've defined our schema, no data will be returned
when executing a query in the GraphQL playground.

This example introduces resolvers to return a list of users from our server to the client.

A resolver is a function that resolves a value for a type or field in a schema. Resolvers
can return objects or scalars like Strings, Numners and Booleans.

The below code returns a list of all users and a single user based on ID.

```
const resolvers = {
  Query: {
    getUser: (parent, args, context, info) =>
      users.find(user => user.id === parseInt(args.id)),
    getUsers: () => users
  }
};
```

As we're now introducing Resolvers we also need to tell our GraphQL server about them. We
do this by injecting a reference to our resolvers on the configuration object of ApolloServer
in server.js

`const server = new ApolloServer({ typeDefs, resolvers });`


## Query the server

Use the GraphQL Playground console to query the server

http://localhost:4000/

Return an array of users and include the id and name attributes
```
{
  getUsers {
    id name 
  }
}
```

```
{
  "data": {
    "getUsers": [
      {
        "id": "1",
        "name": "John"
      },
      {
        "id": "2",
        "name": "Mary"
      },
      {
        "id": "3",
        "name": "Matt"
      }
    ]
  }
}
```


Return an instace of a user
```
{
  getUser(id:1) {
    id image name 
  }
}
```

```
{
  "data": {
    "getUser": {
      "id": "1",
      "image": "http://place-puppy.com/300x300",
      "name": "John"
    }
  }
}
```

## Resolver type signature

Resolvers receive arguments, the full resolver function signature contains four arguments:
`parents, args, context, info`.

- `parent` the object that contains the result returned from the resolver on the parent field.

- `args` an object with the arguments passed into the field from the query.

- `context` used to contain per-request state, including auth info and anything else that should
  be taken into account when resolving. [Context](https://www.apollographql.com/docs/apollo-server/essentials/data/#context-argument)
  is a great read for understanding when and how to use the `context` argument.

`info` this arguments contains information about the execution state of the query, including such
info as the field name, the path to the field from the root, and more.
