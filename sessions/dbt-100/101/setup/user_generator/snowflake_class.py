import snowflake.connector

class Snowflake:

    def __init__(self, user, password, account):
        self.user = user
        self.password = password
        self.account = account
        self.get_connection()

    def get_connection(self):
        connection = snowflake.connector.connect(
            user=self.user,
            password=self.password,
            account=self.account,
            role='accountadmin'
        )
        self.connection = connection

    def execute_query(self, query):
        cursor = self.connection.cursor(snowflake.connector.DictCursor)
        cursor.execute(query)
        response = cursor.fetchall()
        cursor.close()
        return response