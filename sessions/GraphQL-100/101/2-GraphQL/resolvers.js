const users = [
  {
    id: 1,
    name: "John",
    image: "http://place-puppy.com/300x300"
  },
  {
    id: 2,
    name: "Mary",
    image: "http://place-puppy.com/300x300"
  },
  {
    id: 3,
    name: "Matt",
    image: "http://place-puppy.com/300x300"
  }
];

const resolvers = {
  Query: {
    getUser: (parent, args, context, info) =>
      users.find(user => user.id === parseInt(args.id)),
    getUsers: () => users
  }
};

module.exports = resolvers;
