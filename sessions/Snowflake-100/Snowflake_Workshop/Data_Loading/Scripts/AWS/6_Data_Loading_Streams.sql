--Data Preparation
CREATE OR REPLACE TABLE NATION
AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF100.NATION;

--Validating the Data
SELECT * FROM NATION;

--Standard Stream creation
CREATE OR REPLACE STREAM NATION_STREAM ON TABLE NATION;

--Append-only Stream creation
CREATE OR REPLACE STREAM NATION_INSERT_ONLY_STREAM ON TABLE NATION append_only=true;

--Verifying the stream to show the list of columns added
SELECT * FROM NATION_STREAM;

SELECT * FROM NATION_INSERT_ONLY_STREAM;


--Insert statement for new nation
INSERT INTO NATION
VALUES
(25, 'SRI LANKA', 2, 'Hello this is from Srilanka');

--Validate the changes in streams and show how it is getting tracked
SELECT * FROM NATION_STREAM;

SELECT * FROM NATION_INSERT_ONLY_STREAM;

--Update statement for a nation
UPDATE NATION
SET N_COMMENT = 'Hello This is from India'
WHERE N_NAME = 'INDIA';


--Validate and show the difference between the two type of streams
SELECT * FROM NATION_STREAM;

SELECT * FROM NATION_INSERT_ONLY_STREAM;

--Delete statements for a nation
DELETE FROM NATION WHERE N_NAME = 'UNITED KINGDOM';


--Show the differences between two type of streams
SELECT * FROM NATION_STREAM;

SELECT * FROM NATION_INSERT_ONLY_STREAM;