--Standard Warehouse Creation

create or replace warehouse xsmall_wh
warehouse_size = 'xsmall'
warehouse_type = 'standard'
auto_suspend = 60
auto_resume = true
INITIALLY_SUSPENDED = TRUE;

--Multicluster warehouse creation
create warehouse xsmall_multicluster_wh 
warehouse_size = 'xsmall'
warehouse_type = 'standard'
min_cluster_count = 2
max_cluster_count = 4
auto_suspend = 60
auto_resume = true
INITIALLY_SUSPENDED = TRUE;