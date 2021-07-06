from users import session_users
from snowflake_class import Snowflake
from dotenv import load_dotenv
from operator import itemgetter
import os


load_dotenv()
user, password, account = itemgetter("snowflake_user", "snowflake_password", "snowflake_account")(os.environ)
snowflake_object = Snowflake(user, password, account)


def create_session_user(snowflake_object, username):
    print(f"creating user: {username}")
    role_name = f"{username}_role"
    warehouse = f"{username}_wh"
    snowflake_object.execute_query(f"create role {role_name}")
    snowflake_object.execute_query(f"create user {username} password='dbt_password' default_role={role_name}")
    snowflake_object.execute_query(f"grant role {role_name} to user {username}")
    snowflake_object.execute_query(f"create or replace warehouse {warehouse} with warehouse_size='X-SMALL'")
    snowflake_object.execute_query(f"grant usage on warehouse {warehouse} to role {role_name}")
    snowflake_object.execute_query(f"grant operate on warehouse {warehouse} to role {role_name}")
    snowflake_object.execute_query(f"grant usage on database dbt_100 to role {role_name}")
    snowflake_object.execute_query(f"grant usage on schema dbt_100.raw_data to role {role_name}")
    snowflake_object.execute_query(f"grant select on all tables in schema dbt_100.raw_data to role {role_name}")
    snowflake_object.execute_query(f"create database if not exists {username}_db")
    snowflake_object.execute_query(f"grant ownership on database {username}_db to role {role_name}")
    snowflake_object.execute_query(f"grant ownership on schema {username}_db.public to role {role_name}")


session_users = [
    {"username": "JacobBonney"}
    ]

for user in session_users:
    create_session_user(snowflake_object, user["username"])
