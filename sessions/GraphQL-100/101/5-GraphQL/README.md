# 101.5 Subscriptions

It's not uncommon for modern web applications to require real-time functionality. GraphQL offers this functionality in the form of Subscriptions.

## graphql-subscriptions

The GraphQL subscriptions package lets us wire up GraphQL with a pubsub system, to install run:

`yarn add graphql-subscriptions --save`

## Getting Started

To begin with GraphQL Subscriptions, you start by defining a `Subscription` in the schema as a root type:

```
type Subscription {
  someAction: Result
}

type Result {
  output: String
}
```

Construct an instance of `PubSub` to handle subscription topics before we define our resolvers:

```
const { PubSub } = require('graphql-subscriptions');

const pubSub = new PubSub();

const resolvers = {
  ...
};
```

Now, implement your Subscriptions type resolver using the `pubsub.asyncIterator` to map the event you need:

```
const resolvers = {
  Subscription: {
    someAction: {
      subscribe: () => pubsub.asyncIterator(<TOPIC>),


    }
  }
}
```

In the Mutations we want to listen to changes for, add:

`pubsub.publish(<TOPIC>, { someAction: args } )`

Notice how our key is the same name of our subscription.


## Playground example

Subscribe to `userCreated`
```
subscription {
  userCreated {
    id, name, image
  }
}
```

Add new user (new query)
```
mutation { 
  newUser(
    name: "George", 
    image: "https://example.com/image", 
    companyName: "1"
  ),
  {
    id, name, image
  }
}
```

Subscription `userCreated` response
```
{
  "data": {
    "userCreated": {
      "id": "5",
      "name": "George",
      "image": "https://example.com/image"
    }
  }
}
```
