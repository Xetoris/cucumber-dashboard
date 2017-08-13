Revitalizing this old project.

# Cucumber Dashboard

## Goal
To create an API and Dashboard for serving / recording test run information and displaying it in a useful manor.

## Data Objects

#### Scenario 
Represents the individual tests inside of a feature file.

Field Name    | Field Description 
---           | ---               
Feature Name  | Name of the containing feature.
File Name     | Name of the file.
Id            | Entity Id
Name          | Name of the Scenario.
Relative Path | Path to the feature file relative to the features/ dir.
Step Count    | Number of steps in the scenario.
Tags          | The matching tags for this scenario.

#### Run
Holds the information about an execution of a scenario.

Filed Name        |  Field Description
---               | ---
Build Name        | Name of the build project (on your build server) that executed the test.
Build Id          | Unique id of the build that ran this scenario.
Build Url         | Full url to the build.
Duration          | Time it took to execute the run, in seconds.
End Time          | Time stamp of when the scenario finished.
Error File Name   | Full path the file where the error originated from.
Error Type        | Ruby class that threw the error.
Error Line Number | Line number the error came from.
Error Message     | The error's message contents.
Error Stack Trace | Stack Trace for the error.
Id                | Entity Id
Scenario Id       | Id of the scenario.
Start Time        | Time stamp of when the scenario started.
Status            | Id of the status.
State Name        | Name of the status. 


## API Functionality

Request Type | Route           | Description
---          | ---             | ---
GET          | /               | 200 Landing Page
GET          | /runs           | Collection of scenario executions.
POST         | /runs           | Creates a new run.
GET          | /runs/{id}      | Detail record of a specific run.
PUT          | /runs/{id}      | Updates a run record's information.
GET          | /scenarios      | Collection of scenarios.
POST         | /scenarios      | Create a scenario.
GET          | /scenarios/{id} | Detail record of a specific scenario.
PUT          | /scenarios/{id} | Update scenario details.
DELETE       | /scenarios/{id} | Archives the scenario.

## Utilized Technologies
- [Hanami](https://github.com/hanami/hanami)
- [MongoDB](https://www.mongodb.com/)

My hopes is that this will be simple enough that could share around or act as an example for those considering ways of solving similar problems.

###Work In Progress