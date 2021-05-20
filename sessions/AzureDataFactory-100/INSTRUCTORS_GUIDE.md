# Azure Data Factory 101 - Instructors Guide

## Pre-session Checks

Ensure that each learner has a Microsoft Azure Portal login. If you are going to use a Snowflake database as the pipeline's Sink, then each learner will also need access to a Snowflake account with permissions to create and update tables. 

It is advisable to use secure training environments within Azure and Snowflake to remove the risk of data loss to real development or production systems.

It should be possible to complete the two parts of the 101 course within four hours per session, even with novice learners. It is advisable to host the sessions on separate days, to allow the learners time to digest the information from part 1, but it is possible to run the course in a single day.

Although the creation of data pipelines and databases can be done using code, this course focuses solely on Data Factory and Snowflake's web UIs. There is a small amount of SQL used to create the Snowflake table at the beginning and again to check the data has been moved at the end, but these commands are shown on the slides and can be given to the learners to copy and paste.

This course has been created using the format and branding of the Neil Jennings Academy lessons. To make the data-factory-101.md file display as a slide presentation in your browser, you will need to have NodeJS, VSCode (with the VSCode Reveal extension added) and RevealJS installed on your computer. You can then launch a new browser window or tab with the presentation displaying in it. The presentation can be navigated using the arrows in the bottom right corner of the browser window or the arrow keys on your keyboard. When the presentation is open in your browser, press 's' to open a separate window showing the presenter view, where you have visibility of the slide notes. The presentation can also be navigated from the presenter view window. It is advisable to run the session with at least two monitors, so you can have the presenter view open on one and the other, containing browser windows containing the presentation, Azure and Snowflake, visible to the learners.