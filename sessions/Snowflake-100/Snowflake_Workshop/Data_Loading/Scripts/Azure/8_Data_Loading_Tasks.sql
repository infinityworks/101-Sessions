/*----------------Tasks Hands-on----------------
1) Create Tasks
2) Understand how tasks work
----------------------------------------------*/
-- Set context
USE WAREHOUSE COMPUTE_WH;
USE ROLE ACCOUNTADMIN;

-- Create Database
CREATE OR REPLACE TRANSIENT DATABASE TASK_DB;

--Create a Table for task
CREATE OR REPLACE TABLE DEMO_TASK_TABLE(
    task_name varchar(10),
    date_and_time timestamp(9)
);

--Create Task 1
CREATE OR REPLACE TASK DEMO_TASK_1
  SCHEDULE = '1 MINUTE'    -- CRON expressions can we used ex: 'USING CRON 0 5,17 * * * UTC'
  WAREHOUSE = COMPUTE_WH
  AS
  INSERT INTO DEMO_TASK_TABLE
  VALUES ('DemoTask1', CURRENT_TIMESTAMP());

--Create Task 2
CREATE OR REPLACE TASK DEMO_TASK_2
  WAREHOUSE = COMPUTE_WH
  AFTER DEMO_TASK_1
  AS
  INSERT INTO DEMO_TASK_TABLE
  VALUES ('DemoTask2', CURRENT_TIMESTAMP());

--List all tasks
SHOW TASKS;

--Resuming tasks to enable them to run as per schedule
ALTER TASK DEMO_TASK_1 RESUME;
ALTER TASK DEMO_TASK_2 RESUME;

--Manually initiate the tasks
EXECUTE TASK DEMO_TASK_1;

--Validate data in table
SELECT * FROM DEMO_TASK_TABLE;

--Suspend tasks ; won't use resources anymore
ALTER TASK DEMO_TASK_1 SUSPEND;
ALTER TASK DEMO_TASK_2 SUSPEND;
