--Create a random table to demonstrate tasks

CREATE OR REPLACE TABLE Demo_Task(
    task_name varchar(10),
    date_and_time timestamp(9)
);

--Task creation according to DAG
CREATE OR REPLACE TASK task1
  SCHEDULE = 'USING CRON 0 5,17 * * * UTC'
  USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
AS
Insert into Demo_Task
values ('task1', CURRENT_TIMESTAMP()); 

CREATE OR REPLACE TASK task2
  USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
  AFTER task1
AS
Insert into Demo_Task
values ('task2', CURRENT_TIMESTAMP()); 

CREATE TASK task3
  USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
  AFTER task1
AS
Insert into Demo_Task
values ('task3', CURRENT_TIMESTAMP());

CREATE TASK task4
  USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
  AFTER task2,task3
AS
Insert into Demo_Task
values ('task4', CURRENT_TIMESTAMP());

--Displaying the list of tasks
SHOW TASKS;

--Resuming the tasks will enable the tasks to be scheduled according to the time
ALTER TASK task4 RESUME;
ALTER TASK task3 RESUME;
ALTER TASK task2 RESUME;
ALTER TASK task1 RESUME;

--Manually initiate the tasks
EXECUTE TASK TASK1;

--Validate the task works
SELECT * FROM DEMO_TASK;

--Suspend the tasks so it will not use any more resources from now on
ALTER TASK task1 SUSPEND;
ALTER TASK task2 SUSPEND;
ALTER TASK task3 SUSPEND;
ALTER TASK task4 SUSPEND;