## The dbt project:
```
.
├── README.md
├── analysis
├── data
├── dbt_project.yml
├── macros
├── models
│   └── example
│       ├── my_first_dbt_model.sql
│       ├── my_second_dbt_model.sql
│       └── schema.yml
├── snapshots
└── tests
```

### README.md
Project readme
### analysis
An empty directory for queries not suited to a dbt model. These queries are rendered by dbt and can be copy and pasted into your BI tool of choice.

### data
An empty directory designated for ‘seed’ data. Essentially, a directory where you can store CSV files which can be uploaded directly to your data warehouse.

### dbt_project.yml
The dbt_project.yml file tells dbt that this directory is a dbt project. It also contains important information that tells dbt how to operate on your project.
### macros
dbt macros make it possible to abstract reusable SQL snippets using Jinja templates. They are comparable to functions in other programming languages.
### models
Models are select statements which dbt will build in your warehouse following a ‘run’ command. dbt does this by wrapping the statements in either a ‘create view or create table’ statement.  
### snapshots
dbt snapshots offer a mechanism to detect and record changes in mutable table data. (Status changes over time).
### tests
Tests are assertions you can make against your models. If a test fails, the entire dbt build will fail.

#### Navigate back to README [here](README.md)