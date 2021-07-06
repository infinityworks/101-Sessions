## The dbt profile:

The dbt profile specifies the warehouse you intend to work with. The dbt profile file is created outside of your dbt project to prevent sensitive information such as secrets ending up in version control.

```
default:
  target: dev
  outputs:
    dev:
      type: redshift
      threads: [1 or more]
      host: [host]
      port: [port]
      user: [dev_username]
      pass: [dev_password]
      dbname: [dbname]
      schema: [dev_schema]

    prod:
      type: redshift
      method: iam
      cluster_id: [cluster_id]
      threads: [1 or more]
      host: [host]
      port: [port]
      user: [prod_user]
      dbname: [dbname]
      schema: [prod_schema]
```

A dbt profile consists of `targets`. Each `target` specifies:
* The type of warehouse you're connecting to.
* The warehouse credentials.
* The default database and schema dbt will build object in.

A profile can have multiple targets to encourage the use of separate dev and prod environments.
The default profile above has a dev and prod target pointing to different databases. 

#### Navigate back to README [here](README.md)
