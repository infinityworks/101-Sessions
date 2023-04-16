SHOW FILE FORMATS;

--Create a stage to unload a file. you dont need separate stage if you want to paste in sub folders you can use existing one
CREATE OR REPLACE STAGE AWS_UNLOAD_STAGE
  STORAGE_INTEGRATION = s3_int
  URL = 's3://bala-snowflake-workshop-20230308/unload/'
  FILE_FORMAT = CSV_WITH_PIPE;

--List AWS Stage
LIST @AWS_UNLOAD_STAGE;

--Copy statement to copy the content to AWS location
COPY INTO @AWS_UNLOAD_STAGE/Unload.csv.gz 
FROM (SELECT * FROM Regions)
single = true --Option if you want to create it as single files. By default it will be split into small files
header = true;-- If you want to create the files with Header