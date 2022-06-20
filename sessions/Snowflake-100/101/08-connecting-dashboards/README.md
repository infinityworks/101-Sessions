# Connecting analytics dashboards

For this section, you will require docker.

One of the most powerful uses of a data warehouse is to give others the ability to go fish for themselves. We want to empower people to run their own analysis and create reports, rather than relying on engineers to make these things.

As a simple 'up and running' example, we will use Docker to run a dashboard which is accessible from our localhost in browser.

In this example we will use Metabase; it is a simple, open source analytics platform which can be run out of a container. If you wish to productionize it, you can use services like AWS Elastic Beanstalk.

Follow the instructions on the Metabase page [here](https://www.metabase.com/docs/latest/operations-guide/running-metabase-on-docker.html).

By and large all you need to do is run the following command which will pull and load the image:

    docker run -d -p 3000:3000 --name metabase metabase/metabase

Then once it has instantiated, open your browser and enter:

     localhost:3000

 The following show the expected steps to create an account and run a query:

 ![](./assets/metabase-welcome.png)

 ![](./assets/metabase-language.png)

For the following screen where you're asked for connection details, you'll need to know your Snowflake Account Id. You can find that in the Classic Console UI as the identifier in bold in the middle of this drop-down menu.

 ![](./assets/snowflake-accountid.png)

IMPORTANT: The naming convention for Account Name is very particular [(see this table for more details)](https://docs.snowflake.com/en/user-guide/admin-account-identifier.html#non-vps-account-locator-formats-by-cloud-platform-and-region)

If you have any other issues with this config, see the [Metabase docs for Snowflake](https://www.metabase.com/docs/latest/administration-guide/databases/snowflake.html) for further support

 ![](./assets/metabase-details.png)

 ![](./assets/metabase-complete.png)

 ![](./assets/metabase-dashboard.png)

From this dashboard select New -> SQL Query, and pick the name you gave to your Snowflake integration.

 Run a query:

      SELECT FLATTENED_DATA.VALUE:PRODUCT_ID::VARCHAR AS PRODUCT_ID,
          SUM(1) AS FREQUENCY
      FROM RAW_DATA.SALES.TRANSACTIONS AS TRANSACTIONS,
          LATERAL FLATTEN(input => TRANSACTIONS.PAYLOAD, path => 'PRODUCTS_VIEWED') AS FLATTENED_DATA
      GROUP BY FLATTENED_DATA.VALUE:PRODUCT_ID
      ORDER BY FREQUENCY DESC
      
 ![](./assets/metabase-query.png)

 Select the "Visualization" button at the bottom left, and select "Pie" from the left to visualise the result set as a Pie Chart.

 ![](./assets/metabase-piechart.png)
