let users = [
  {
    id: 1,
    name: "John",
    image: "http://place-puppy.com/300x300",
    company: "Infinity Works",
    position: 1
  },
  {
    id: 2,
    name: "Mary",
    image: "http://place-puppy.com/300x300",
    company: "Apple",
    position: 2
  },
  {
    id: 3,
    name: "Matt",
    image: "http://place-puppy.com/300x300",
    company: "Infinity Works",
    position: 2
  },
  {
    id: 4,
    name: "Jeff",
    image: "http://place-puppy.com/300x300",
    company: null,
    position: null
  }
];

let companies = [
  {
    id: 1,
    name: "Infinity Works",
    website: "https://www.infinityworks.com",
    emailAddress: "jobs@infinityworks.com"
  },
  {
    id: 2,
    name: "Google",
    website: "https://www.google.com",
    emailAddress: "jobs@google.com"
  },
  {
    id: 3,
    name: "Apple",
    website: "https://www.apple.com",
    emailAddress: "jobs@apple.com"
  }
];

let positions = [
  {
    id: 1,
    title: "Web Developer",
    division: "Tech"
  },
  {
    id: 2,
    title: "HR Manager",
    division: "People Ops"
  }
];

const resolvers = {
  Query: {
    getUser: (parent, args, context, info) =>
      users.find(user => user.id === parseInt(args.id)),

    getUsers: () => users,

    getCompany: (parent, args, context, info) =>
      companies.find(company => company.id === parseInt(args.id)),

    getCompanies: () => companies
  },

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
  },

  User: {
    company({ id }) {
      return companies.find(company => company.id === parseInt(id));
    },

    position({ id }) {
      return positions.find(position => position.id === parseInt(id));
    },

    employed(parent) {
      return parent.company !== null ? true : false;
    }
  },

  Company: {
    employees({ name }) {
      return users.filter(user => user.company === name);
    }
  }
};

module.exports = resolvers;
