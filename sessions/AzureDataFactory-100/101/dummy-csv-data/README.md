## Dummy .CSV Files for Azure Data Factory 101

The following data files have been created for use in this course so the learners have some simple data to move through their pipelines. These data files are themed around a fictional company called "Historical Sites" and were created for the first session in which the course was run to provide training to a small team at the National Trust. Alternate data could easily be created to suit your group of learners using Google sheets and downloading .csv files, as I did to create these.

### historical-sites-members.csv
This is the only one of the files used in the first part of the course. It contains ten rows, each of which holds the member id, name and address of a fiction member of Historical Sites. This file is also used again in the second part of the course.

### historical-sites-locations.csv
This file only contains five rows, each containing a fake historical location. This file should be given to the learners when they start the data pipeline creation activity in the second part of the course. The file has deliberately had the member_id column removed so it will create an error when the pipeline is eventually debugged. This is the first of two errors that the learners will need to track down. When they have identified the problem, give them the next file.

### historical-sites-locations-update.csv
This version of the file has all of the required columns (location_id, location_name and location_postcode) but one of the entries in the members_id column is the wrong data type. This will also create an error when the pipeline is debugged. When the learners have identified the problem with this file, give them the final file.

### historical-sites-locations-final.csv
This is a complete version of the Historical Sites locations data which shouldn't create any errors in the learners' pipelines.