# The Jaffle Shop Project

## Setting up the project

### The project structure

```bash
$ tree -L 2                        
.
├── README.md
└── requirements.txt
```

### The content of requirements.txt

```bash
dbt-snowflake>=1.4.2
```

### Setting up the python environment

```bash
python -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install -r requirements.txt
```

### Checking the installation

```bash
$ dbt --version
Core:
  - installed: 1.4.5
  - latest:    1.4.5 - Up to date!

Plugins:
  - snowflake: 1.4.2 - Up to date!
```

### Setting up the dbt project

```bash
dbt init 
```

### Answer the prompted questions

```bash
Project: jaffleshop
Database: snowflake
Account: INFINITYWORKSPARTNER.eu-west-1
User: <your snowflake username>
Authentication Type: password
Password: <your snowflake password>
role: SYSADMIN
warehouse: LOAD_WH
Default database: DBT_WORKSHOP_ANALYTICS
Default schema: PUBLIC
threads: 1
Happy modeling!
```

### Test the connection

```bash
dbt debug
```

## The Jaffle Shop

### Entity Relationship Diagram (ERD)

![jaffle shop ERD](./assets/jaffle_shop_erd.png)
