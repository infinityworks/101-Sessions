# 101.4 Mutations

Applications need some way of making changes to the data that’s stored in the backend
Mutations

Mutations follow the same syntactical structure as queries but they always need to start with the mutation keyword
server interprets arguments

To form a mutation, you must specify three things:

- Mutation name: the type of modification you want to perform
- Input object: the data you want to send to the server, composed of input fields.
- Payload object: the data you want to return from the server

## Getting Started

Add a `Mutation` type to your schema to add a new user. The mutation will accept name, image and
companyName as arguments:

```
type Mutation {
  newUser(name: String, image: String, companyName: String): User
}
```

Add a resolver for our Mutation:

```
Mutation: {
  newUser: (parents, args, context, info) => {
    const { name, image, companyName } = args;
    const user = {
      id: users.length + 1,
      name
    };
    users.push(user);
    return user;
  }
}
```

The resolver will add a new user to our list of users and return the new user that has
just been created.
