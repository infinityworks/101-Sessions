# 101.3 Nested Queries

We can use GraphQL to resolve nested types. Our schema defines that a `User` returns a type of
`Company` and `Position`.

When our server receives the request below, the query will call
the `Query.getUser` resolver first and pass it's result to `getUser.company`. The query result
will contain the return value of `getUser.books` nested under `data.getUser.company`

```
{
  getUser(id: 1) {
    name
    company {
      name, website
    }
  }
}
```


```
{
  "data": {
    "getUser": {
      "name": "John",
      "company": {
        "name": "Infinity Works",
        "website": "https://www.infinityworks.com"
      }
    }
  }
}
```