# Downloading data from Snowflake

Now you have some interesting insights you wish to share with the team and your stake holders, we need to export it into a common format.

There are a number of ways to export data; one could use the programmatic connectors, the SnowSQL CLI but the simplest is to export via the web UI after running your query.

Let's start by querying the view we made:

    SELECT * FROM "RAW_DATA"."SALES"."TOP_10_PRODUCTS";

Next hit the download button.

![Download](./assets/unload.png "Download")

You'll be presented with a few options to configure the delimiter (what separates the columns in the file) and file name. One of the most common file formats to consume is a `.csv`; this can be opened by a vast number of applications, including Microsoft Excel.

![Export options](./assets/export_options.png "Export options")


Congratulations, you've exported your data!!

![View export](./assets/view_export.png "Export View export")
