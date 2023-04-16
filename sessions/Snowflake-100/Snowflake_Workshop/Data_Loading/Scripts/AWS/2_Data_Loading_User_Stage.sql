--place the file into table stage using "put file:///<path to file>/subcategory.csv @~/staged;"

--Listing the Empty User Stages
LIST @~/staged;

--Copying the files into Table from User Stage
COPY INTO SUBCATEGORY FROM @~/staged
FILE_FORMAT = (FORMAT_NAME = 'CSV_WITH_COMMAS');

--Verifying the records in the table
SELECT * FROM SUBCATEGORY;

--Listing Table Stage to verify it is not staged in Table Staged
LIST @%SUBCATEGORY;