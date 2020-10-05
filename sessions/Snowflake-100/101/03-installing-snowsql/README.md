# Installing the SnowSQL CLI
For the next sections you'll need [Snowflake's CLI](https://docs.snowflake.com/en/user-guide/snowsql-install-config.html#installing-snowsql), snowsql; download it from their website or use a package manager.

If you're a Mac user and use Homebrew:

    brew cask install snowflake-snowsql

This will also create a config file in `~/.snowsql/config` used for authentication and setting default values such as `role` and `warehouse`.

Edit the file and create a Snowflake profile (connections is the default profile), e.g:

    [connections]
    accountname = myAccout
    region = eu-west-1
    username = YourUserName
    password = YourPass

If you are using multiple Snowflake accounts or users, you can create additional profiles in this file using the same structure:

    [connections.demo]
    accountname = infinityworkspartner
    region = eu-west-1
    username = YourUserName
    password = YourPassword

Now you've configured your CLI profiles, enter the CLI in the terminal using your default profile with:

    snowsql

or to select another profile, for example with the name `connections.demo`:

    snowsql -c demo

You should now have access to Snowflake via the CLI:

![Snowsql CLI](./assets/snowsql_cli.png "Snowflake console")
